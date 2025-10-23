# Implementing DFS for branch offices

| Term               | Description                                | Example                          |
| ------------------ | ------------------------------------------ | -------------------------------- |
| **SMB**            | Protocol for network file/printer sharing  | Used by Windows File Sharing     |
| **SMB Network**    | A network using SMB to share resources     | Office LAN with shared drives    |
| **SMB Share Path** | The network location of a shared folder    | `\\Server\Share`                 |
| **UNC Path**       | The full standardized format for SMB paths | `\\Server\Share\Folder\File.txt` |

---

(1) Local path (on the actual server)
> C:\localpath\folder
(2) Network share path, UNC(Universal Naming Convention) path, SMB share path
> \\host\sharefolder
(3) DFS namespace path
> \\domain\dfsrootnamespace\dsffoldername

DFS Namespace (Logical Path)
     |
     --> \\domain\dfsrootnamespace\dsffoldername
             |
             +--> \\host1\sharefolder  (real SMB share)
             |         |
             |         +--> C:\localpath\folder  (actual data)
             |
             +--> \\host2\sharefolder  (replica, optional)
                       |
                       +--> D:\data\folder  (replicated copy)

- The local path is the physical storage.
- The network share path is how that local folder is shared over SMB.
- The DFS namespace path is the logical, user-facing name that abstracts the physical servers away.

### 🔹 Quick Example

Let’s say you have this setup:

| Server | Local Path             | Shared As      | DFS Target                   |
| ------ | ---------------------- | -------------- | ---------------------------- |
| FS01   | C:\Data\Projects       | \FS01\Projects | \contoso.com\Shared\Projects |
| FS02   | D:\Replicated\Projects | \FS02\Projects | \contoso.com\Shared\Projects |

Users access:

```
\\contoso.com\Shared\Projects
```

DFS automatically directs them to one of the physical shares — either:

```
\\FS01\Projects
```

or

```
\\FS02\Projects
```

which maps back to local paths:

```
C:\Data\Projects
D:\Replicated\Projects
```

---

# Implementing DFS

DFS works on top of SMB shares — it doesn’t create the shares itself.

## Install the DFS role on LON-SVR1 and TOR-SVR1

LON-SVR1, TOR-SVR1

```powershell
install-feature.ps1
```

(Lon-SVR2: The Distributed File System service is not installed on the server)

## Create the BranchDocs DFS Namespace

If you're building a DFS namespace:

* **Start with** `DfsnRoot`
* Then add **`DfsnRootTarget`** (namespace server's share)
* Inside it, create **`DfsnFolder`** (user-facing folders)
* Link them to real shares using **`DfsnFolderTarget`**

| Object Type            | Description                                                               | Example Path                  | Key Cmdlets                                    |
| ---------------------- | ------------------------------------------------------------------------- | ----------------------------- | ---------------------------------------------- |
| **`DfsnRoot`**         | The top-level DFS namespace (a virtual container in the domain or server) | `\\contoso.com\CorpShares`    | `Get-DfsnRoot`, `New-DfsnRoot`                 |
| **`DfsnRootTarget`**   | The **physical server and share** that hosts the namespace root           | `\\DFSServer1\CorpShares`     | `Get-DfsnRootTarget`, `Add-DfsnRootTarget`     |
| **`DfsnFolder`**       | A **virtual folder** inside a DFS namespace that points to target shares  | `\\contoso.com\CorpShares\HR` | `Get-DfsnFolder`, `New-DfsnFolder`             |
| **`DfsnFolderTarget`** | The **actual shared folder** that the DFS folder links to                 | `\\FileServer1\HRDocs`        | `Get-DfsnFolderTarget`, `Add-DfsnFolderTarget` |

\\contoso.com\CorpShares                      ← DFSNRoot
        |
        +--> Hosted on: \\DFSServer1\CorpShares      ← DFSNRootTarget
        |
        +--> HR                                  ← DFSNFolder
        |      |
        |      +--> Points to: \\FileServer1\HRDocs     ← DFSNFolderTarget
        |
        +--> IT                                  ← DFSNFolder
               |
               +--> Points to: \\FileServer2\ITDocs     ← DFSNFolderTarget

> new-DfsFolder.ps1

DFS works on top of SMB shares — it doesn’t create the shares itself.


If you're building a DFS namespace:

* **Start with** `DfsnRoot`
* Then add **`DfsnRootTarget`** (namespace server's share)
* Inside it, create **`DfsnFolder`** (user-facing folders)
* Link them to real shares using **`DfsnFolderTarget`**

| Object Type            | Description                                                               | Example Path                  | Key Cmdlets                                    |
| ---------------------- | ------------------------------------------------------------------------- | ----------------------------- | ---------------------------------------------- |
| **`DfsnRoot`**         | The top-level DFS namespace (a virtual container in the domain or server) | `\\contoso.com\CorpShares`    | `Get-DfsnRoot`, `New-DfsnRoot`                 |
| **`DfsnRootTarget`**   | The **physical server and share** that hosts the namespace root           | `\\DFSServer1\CorpShares`     | `Get-DfsnRootTarget`, `Add-DfsnRootTarget`     |
| **`DfsnFolder`**       | A **virtual folder** inside a DFS namespace that points to target shares  | `\\contoso.com\CorpShares\HR` | `Get-DfsnFolder`, `New-DfsnFolder`             |
| **`DfsnFolderTarget`** | The **actual shared folder** that the DFS folder links to                 | `\\FileServer1\HRDocs`        | `Get-DfsnFolderTarget`, `Add-DfsnFolderTarget` |

\\contoso.com\CorpShares                      ← DFSNRoot
        |
        +--> Hosted on: \\DFSServer1\CorpShares      ← DFSNRootTarget
        |
        +--> HR                                  ← DFSNFolder
        |      |
        |      +--> Points to: \\FileServer1\HRDocs     ← DFSNFolderTarget
        |
        +--> IT                                  ← DFSNFolder
               |
               +--> Points to: \\FileServer2\ITDocs     ← DFSNFolderTarget

