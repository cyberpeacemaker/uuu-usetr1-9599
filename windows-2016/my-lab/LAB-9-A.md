# Implementing DFS for branch offices

---

# Implementing DFS

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


TODO: 1.GUI Not Showing 2.


## Add the DataFiles folder to the BranchDocs namespace

## Create a folder target for Datafiles on TOR-SVR1

## Configure replication for the namespace

---

# Validating the deployment