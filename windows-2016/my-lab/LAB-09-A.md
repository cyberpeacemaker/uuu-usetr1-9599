# Implementing DFS for branch offices

---

# Implementing DFS

## 1. Install the DFS role on `LON-SVR1` and `TOR-SVR1`

> install-feature.ps1

## 2. Create the BranchDocs DFS Namespace

> new-DfsFolder.ps1

### GUI need manualy add namespace to display / Refresh

## 3. Add the DataFiles folder to the BranchDocs namespace

## 4. Create a folder target for Datafiles on `TOR-SVR1`

## 5. Configure replication for the namespace

---

# Validating the deployment

## 1. Verify DFSR functionality for `TOR-SVR1`