# The MMC step is not necessary for rolling in or managing certificates
# it's just a user-friendly way to view/manage certificates graphically.

# 📁 Certificate Store Names
# You can access these certificate stores in PowerShell using the `Cert:` drive. For example:

# * **Local Computer** certificates:

#   ```
#   Cert:\LocalMachine\
#   ```

# * **Current User** certificates:

#   ```
#   Cert:\CurrentUser\
#   ```


### 🛠️ Example PowerShell Commands
#### View certificates in Local Machine's Personal store

```powershell
Get-ChildItem -Path Cert:\LocalMachine\My
```

#### Import a certificate to the Local Machine's Personal store

```powershell
Import-PfxCertificate -FilePath "C:\path\to\yourcert.pfx" -CertStoreLocation "Cert:\LocalMachine\My" -Password (ConvertTo-SecureString -String 'yourPassword' -AsPlainText -Force)
```

#### Install a .CER file into Trusted Root Certification Authorities

```powershell
Import-Certificate -FilePath "C:\path\to\yourcert.cer" -CertStoreLocation "Cert:\LocalMachine\Root"
```


# PowerShell automatically uses the default Active Directory Enrollment Policy — which is the one your admin configured (the one you see in MMC).
Get-Certificate -Template "YourTemplate" -SubjectName "CN=rdgw.adatum.com" -CertStoreLocation "Cert:\LocalMachine\My"


adfswap.adatum.com

adfswap.adatum.com
rdgw.adatum.com
lon-svr1.adatum.com