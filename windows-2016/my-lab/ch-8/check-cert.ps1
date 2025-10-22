# * **Local Computer** certificates:

#   ```
#   Cert:\LocalMachine\
#   ```

# * **Current User** certificates:

#   ```
#   Cert:\CurrentUser\
#   ```

Get-ChildItem -Path Cert:\LocalMachine\My
Get-ChildItem -Path Cert:\CurrentUser\

Get-Certificate -Template "YourTemplate" -SubjectName "CN=rdgw.adatum.com" -CertStoreLocation "Cert:\LocalMachine\My"

