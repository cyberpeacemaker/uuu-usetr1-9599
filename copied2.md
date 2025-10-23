Perfect 😎 — let’s build this step by step!

We’ll write a **PowerShell script** that automates the whole DFS folder + target creation process, using your parameters.

---

## 🚀 Goal

Your script will:

1. Accept parameters:

   * `$DfsRootName` (e.g. `\\contoso.com\Shared`)
   * `$DfsFolderName` (e.g. `Projects`)
   * `$DfsFolderTarget` (e.g. `\\FS01\Projects`)
2. Parse the **target server name** and **share name** from `$DfsFolderTarget`.
3. Check if the **target folder path** exists on disk — if not, create it.
4. Check if the **SMB share** exists — if not, create it.
5. Check if the **DFS folder** exists — if not, create it.
6. Add the **DFS folder target** to the DFS namespace.

---

## 🧠 Example Usage

```powershell
.\New-DfsFolder.ps1 `
  -DfsRootName "\\contoso.com\Shared" `
  -DfsFolderName "Projects" `
  -DfsFolderTarget "\\FS01\Projects"
```

---

## 🧩 Full Script — `New-DfsFolder.ps1`

```powershell
param(
    [Parameter(Mandatory=$true)]
    [string]$DfsRootName,         # e.g. \\contoso.com\Shared
    [Parameter(Mandatory=$true)]
    [string]$DfsFolderName,       # e.g. Projects
    [Parameter(Mandatory=$true)]
    [string]$DfsFolderTarget      # e.g. \\FS01\Projects
)

# --- Helper: Extract server and share name from the target path
if ($DfsFolderTarget -match '\\\\([^\\]+)\\(.+)$') {
    $TargetServer = $matches[1]
    $ShareName = $matches[2]
} else {
    Write-Error "Invalid format for DfsFolderTarget: $DfsFolderTarget"
    exit 1
}

# --- Determine local folder path (assume standard path on target host)
$LocalFolderPath = "C:\DFSRoots\$ShareName"

Write-Host "🔹 DFS Root: $DfsRootName"
Write-Host "🔹 DFS Folder Name: $DfsFolderName"
Write-Host "🔹 DFS Target: $DfsFolderTarget"
Write-Host "🔹 Local Folder Path: $LocalFolderPath"
Write-Host ""

# --- Check if running on the target server
$CurrentHost = $env:COMPUTERNAME
if ($CurrentHost -ieq $TargetServer) {
    # --- Step 1. Ensure local folder exists
    if (-not (Test-Path $LocalFolderPath)) {
        Write-Host "📁 Creating local folder: $LocalFolderPath"
        New-Item -ItemType Directory -Path $LocalFolderPath -Force | Out-Null
    } else {
        Write-Host "✅ Local folder already exists."
    }

    # --- Step 2. Ensure SMB share exists
    $existingShare = Get-SmbShare -Name $ShareName -ErrorAction SilentlyContinue
    if (-not $existingShare) {
        Write-Host "🔗 Creating SMB share: \\$TargetServer\$ShareName"
        New-SmbShare -Name $ShareName -Path $LocalFolderPath -FullAccess "Domain Users" | Out-Null
    } else {
        Write-Host "✅ SMB share \\$TargetServer\$ShareName already exists."
    }
} else {
    Write-Host "⚠️ This script is running on $CurrentHost, but target is $TargetServer."
    Write-Host "    (Local folder and share creation skipped — run on target if needed.)"
}

# --- Step 3. Ensure DFS Folder exists
$DfsFolderPath = Join-Path $DfsRootName $DfsFolderName

$dfsFolder = Get-DfsnFolder -Path $DfsFolderPath -ErrorAction SilentlyContinue
if (-not $dfsFolder) {
    Write-Host "🗂️ Creating DFS folder: $DfsFolderPath"
    New-DfsnFolder -Path $DfsFolderPath -TargetPath $DfsFolderTarget -State Online -ErrorAction Stop
} else {
    Write-Host "✅ DFS folder already exists: $DfsFolderPath"
    # --- Step 4. Add DFS target if missing
    $existingTarget = Get-DfsnFolderTarget -Path $DfsFolderPath | Where-Object { $_.TargetPath -eq $DfsFolderTarget }
    if (-not $existingTarget) {
        Write-Host "➕ Adding DFS folder target: $DfsFolderTarget"
        New-DfsnFolderTarget -Path $DfsFolderPath -TargetPath $DfsFolderTarget
    } else {
        Write-Host "✅ DFS folder target already exists: $DfsFolderTarget"
    }
}

Write-Host ""
Write-Host "🎉 DFS folder setup complete!"
```

---

## ⚙️ Notes

* Run this script as **Administrator**.
* It uses built-in PowerShell DFSN (`DFSN`) and SMB cmdlets:

  * `New-SmbShare`
  * `New-DfsnFolder`
  * `New-DfsnFolderTarget`
  * `Get-DfsnFolder`
* Make sure the **DFS Management Tools** feature is installed:

  ```powershell
  Install-WindowsFeature RSAT-DFS-Mgmt-Con
  ```

---

## 💡 Bonus Idea

If you want this script to **remotely create the share** on the target server, you could easily extend it to use PowerShell Remoting:

```powershell
Invoke-Command -ComputerName $TargetServer -ScriptBlock {
    param($ShareName, $LocalFolderPath)
    if (-not (Test-Path $LocalFolderPath)) { New-Item -ItemType Directory -Path $LocalFolderPath -Force }
    if (-not (Get-SmbShare -Name $ShareName -ErrorAction SilentlyContinue)) {
        New-SmbShare -Name $ShareName -Path $LocalFolderPath -FullAccess "Domain Users"
    }
} -ArgumentList $ShareName, $LocalFolderPath
```

That makes it **fully automatic** even across servers.

---

Would you like me to enhance the script to **work fully remotely** (so you can run it from a management server instead of the DFS host)?
