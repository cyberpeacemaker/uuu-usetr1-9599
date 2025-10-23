# ## 🔍 After Setup – Things to Check

# 1. **Network Interfaces**:

#    * Ensure the server has at least two NICs if you’re routing between networks.
#    * One interface will typically be for internal LAN, and the other for public/DMZ or VPN clients.

# 2. **VPN Protocols**:

#    * Configure allowed protocols (PPTP, L2TP/IPSec, SSTP) in RRAS > Ports.

# 3. **Firewall**:

#    * Ensure firewall rules allow VPN traffic (e.g., TCP 1723 for PPTP, UDP 500/4500 for IPsec/L2TP, TCP 443 for SSTP).
#    * Open NAT/port forwarding if behind a router.

# 4. **User Permissions**:

#    * Make sure user accounts have “Allow access” for dial-in permissions (in Active Directory or local user properties).

# Routing and Remote Access (RRAS) i
# Stop the RRAS service
Stop-Service RemoteAccess

```powershell
Install-WindowsFeature RemoteAccess -IncludeManagementTools
Install-WindowsFeature Routing

# Enable RRAS with VPN and LAN routing
Install-RemoteAccess -VpnType Vpn
```

# Note: This sets up VPN,
# but LAN routing setup via PowerShell is more involved and often easier via GUI unless you're automating.
# ENABLE LAN routing via PowweShell

