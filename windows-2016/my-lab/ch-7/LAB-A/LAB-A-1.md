# Verifying Readiness for a DirectAccess Deployment

## Verify the IP address on LON-DC1


## Verify the network configuration on EU-RTR

    # London_Network adapter should have:
    #   IPv4 Address: 172.16.0.1
    # Internet adapter should have:
    #   IPv4 Address: 131.107.0.10

## Verify the network configuration on LON-CL1
script-1.ps1 London_Network

## Verify the network configuration on LON-SVR1
script-1.ps1 London_Network

## Verify the network configuration on INET1
script-1.ps1 internet
IPv4 should be: 131.107.0.100

## Verify the server readiness for DirecttAccess

#### **Group is Protected from Accidental Deletion**

* This is a common setting for important groups.

✅ **Fix**:

1. Right-click the group > **Properties**.
2. Go to the **Object** tab.
3. Uncheck **"Protect object from accidental deletion"**.
4. Try deleting again.

> 🔎 Note: If the **Object** tab isn't visible, go to the top menu:
> **View > Advanced Features** — then re-open the group’s properties.