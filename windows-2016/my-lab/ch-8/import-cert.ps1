
#### Import a certificate to the Local Machine's Personal store

```powershell
Import-PfxCertificate -FilePath "C:\path\to\yourcert.pfx" -CertStoreLocation "Cert:\LocalMachine\My" -Password (ConvertTo-SecureString -String 'yourPassword' -AsPlainText -Force)
```

#### Install a .CER file into Trusted Root Certification Authorities

```powershell
Import-Certificate -FilePath "C:\path\to\yourcert.cer" -CertStoreLocation "Cert:\LocalMachine\Root"
```