# Planning and implementing an IPv4 network

- Understanind IPv4
- Configuring an IPv4 Host
- Trobleshooting

> 0.0.0.0 || 1.1.1.1 || 127.0.0.1 || 169.254.x.x
here, all, loopback, apipa

`10.0.0.0` - `10.255.255.255` 
`172.16.0.0` - `172.31.255.255` 
`192.168.0.0` - `192.168.255.255` 

---

# IPv4

32bits, dotted decimal notation, 4*8bits, octet

network identification, network ID & host identification, hot ID
Subnet Mask, classless interdomain routing (CIDR)

> network, subnet, virtual local are network(VLAN)

IANA (Internet Assigned Numbers Authority) - ICANM (Internet Corporation for Assigned Names and Numbers)

## default gateway
usually point to router

> multiple internal networks > intranet

Remote network, inner route table

---

## Defining subnets

IPv4 address classes
A, B, C || D, E
| **IPv4 Class** | **First Octet Range** | **Subnet Mask**     | **Number of Networks** | **Number of Hosts per Network** | **Use Case**                                                       |
| -------------- | --------------------- | ------------------- | ---------------------- | ------------------------------- | ------------------------------------------------------------------ |
| **Class A**    | 0 - 127               | 255.0.0.0 (/8)      | 128                    | 16,777,214                      | Large networks, for example, large corporations or ISPs.           |
| **Class B**    | 128 - 191             | 255.255.0.0 (/16)   | 16,384                 | 65,534                          | Medium-sized networks, for example, universities or regional ISPs. |
| **Class C**    | 192 - 223             | 255.255.255.0 (/24) | 2,097,152              | 254                             | Small networks, for example, small businesses, home networks.      |

RFC 923

subnetting, classful, classless network
network hostID, broadcast address
simple IPv4 Networks, Complex IPv4 Networks, variable-length subnet masks

Determining subnet addresses, nof subnets & nof hosts
Creating supernets

---

## Public, Private, APIPA

IANA > RIR (Regional Internet Registries) > ISP (Internet Service Providers, ISP)

NAT (Network Address Translation)

| **Address Class** | **Private Address Range**         | **Subnet Mask**       | **Description**                                 |
| ----------------- | --------------------------------- | --------------------- | ----------------------------------------------- |
| **Class A**       | `10.0.0.0` - `10.255.255.255`     | `255.0.0.0` (/8)      | Large private networks (16 million hosts)       |
| **Class B**       | `172.16.0.0` - `172.31.255.255`   | `255.240.0.0` (/12)   | Medium-sized private networks (1 million hosts) |
| **Class C**       | `192.168.0.0` - `192.168.255.255` | `255.255.255.0` (/24) | Small private networks (254 hosts per subnet)   |

## Planning an IPv4 network

Scenario

---

# Configuring an IPv4 Host

static IP Adress, DHCP
IPv4 Address, Subnet Mask, (Defatult gateway, Domain Name System)

- Internet Protocal Version 4, TCP/IPv4
- netsh
- Winodws PowerShell

Settings or the network and Sharing Center, Settings app, Network and Sharing Center
configuring a Static IP Address by netsh, Local Area Connection
Configuring a Static IP Address using Windows PowerShell

TODO: My Script to Configureing Target IPv4
> $targetInterfaceAlias = (Get-NetIPInterface)[3].InterfaceAlias
> Get-NetIPAddress -InterfaceAlias $targetInterfaceAlias

Remove, Get, New, Set

---

# Troubleshooting

routing table, hops,
network desitnation, netmask, gateway, interface, metric

RIP (routing protocal), Routing information Protocal, OSPF(open shortest path first)

- ipconfig
- ping
- tracert
- pathping
- route
- telnet
- netstat
- resource monitor
- network diagnostics
- event viewer

TODO: My script to create scenario
TODO: My script to troubleshooting