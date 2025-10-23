# Configuring advanced Hyper-V networking features

devmgmt.msc
PowerShell Hyper-V https://learn.microsoft.com/en-us/powershell/module/hyper-v/?view=windowsserver2025-ps

---

# Creating and Using Hyper-V Virtual Switches

## 1. Verify Current Hyper-V Network Configuration

## 2. Create a Virtual Switch

## 3. Create a Virtual Network Adapter

## 4. Use the Hyper-V Virtual Switch

## 5. Add a NIC Team

---

# Configuring and Using the Advanced Features of a Virtual Switch

## 1. Configure Network Adapters with DHCP Guard

## 2. Configure and Use DHCP Guard

## 3. Configure and Use VLANs

## 4. Configure and Use Bandwidth Management


#Task 3: Create virtual network adapters

Add-VMNetworkAdapter -VMName 20741B-LON-SVR1 -Name "New Network Adapter"
Add-VMNetworkAdapter -VMName 20741B-LON-SVR1 -Name "New Network Adapter-1"
Connect-VMNetworkAdapter -VMName 20741B-LON-SVR1 -Name "New Network Adapter" -SwitchName "External Switch"
Connect-VMNetworkAdapter -VMName 20741B-LON-SVR1 -Name "New Network Adapter-1" -SwitchName "External Switch"
Set-VMNetworkAdapter -VMName 20741B-LON-SVR1 -AllowTeaming On


#Task 2: Configure and use DHCP guard

Set-VMNetworkAdapter -VMName 20741B-LON-DC1 -DhcpGuard On
Set-VMNetworkAdapter -VMName 20741B-LON-SVR1 -DhcpGuard Off


