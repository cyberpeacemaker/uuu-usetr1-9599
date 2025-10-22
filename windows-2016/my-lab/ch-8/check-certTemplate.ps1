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

# You're absolutely right to be suspicious — certutil -template does not return structured objects 
# (like those you could parse easily with PowerShell objects). 
# Instead, it returns formatted text output, which makes it harder to work with using key-property dot notation.

# PowerShell automatically uses the default Active Directory Enrollment Policy — which is the one your admin configured (the one you see in MMC).
Get-Certificate -Template "YourTemplate" -SubjectName "CN=rdgw.adatum.com" -CertStoreLocation "Cert:\LocalMachine\My"

