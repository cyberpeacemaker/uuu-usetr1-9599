# 1. Implementing VPN
## Prepare the Environment

LON-DC1

## Request a Certificate for EU-RTR

EU-RTR
```powershell
request-cert.ps1 -subjectNameSuffix '131.107.0.10'
```

## Modify the HTTPS Binding

EU-RTR

```powershell
new-binding.ps1
```

## Review the Default VPN Settings


## Configure Remote Access Policy

---

# 2. Validating the VPN Deployment

## Remove the Client Computer from the Domain

## Move LON-CL1 to the Internet

## Create a VPN Profile

## Export the Root CA Certificate

## Import the Root CA Certificate on the Client

## Connect to the VPN Using IKEv2 and SSTP

## Log On to the Domain Using VPN

---

# 3. Troubleshooting VPN Access

## Review the Help Desk Incident Log 'IN24578'

## Update the Action Plan Section in the Incident Log

## Try Connecting with 'A. Datum VPN' on Logan's Computer (LON-CL1)

## Apply the Fix and Test the Solution

