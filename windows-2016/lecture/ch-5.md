# Implementing and managing IPAM

- What is IPAM
- Deplying IPAM
- Managing IP Address spaces

---

# IPAM

**IPAM** stands for **IP Address Management**.

It refers to the **planning, tracking, and managing** of IP address spaces in a network. IPAM is a crucial part of network management, ==especially in medium to large enterprises or service provider environments, where thousands of IP addresses are used.==

Without IPAM, network administrators often rely on spreadsheets or manual documentation, which becomes error-prone and inefficient as networks grow.

IPAM systems help you:

* 📋 **Track IP address allocations** (which IPs are in use, free, or reserved)
* 🧠 **Avoid IP conflicts** (e.g., duplicate IP assignments)
* 🕵️‍♂️ **Audit IP usage** (who had what IP and when)
* 🛠️ **Integrate with DNS and DHCP** servers
* 📊 **Provide visibility** into network address usage over time

### 🔄 Typical Components:

* **IP address inventory** (IPv4 and IPv6)
* **Subnet management**
* **DHCP and DNS integration**
* **Role-based access control**
* **Automation features** (e.g., auto-assigning IPs)
* **Reporting and logging**

A **Group Policy Object (GPO)** is a feature in **Microsoft Windows** that allows administrators to centrally manage and configure **operating system settings, software, and user configurations** across computers in an **Active Directory** environment.

---

## 🧩 What Is a GPO?

A **GPO** is essentially ==a collection of **Group Policy settings** that are applied to users or computers.== These settings can include security rules, software installation, desktop configurations, login scripts, and much more.

### 🛠️ Common Uses of GPOs:

* Enforce **password policies** (complexity, length, expiration)
* Configure **desktop environments** (wallpaper, screen saver, taskbar)
* Deploy **software** to users or machines
* Map **network drives and printers**
* Set **Windows Update** rules
* Restrict access to certain **control panel settings**
* Enforce **firewall settings**

---

## RBAC & RBSG

A **Role-Based Security Group** is a group used in **Role-Based Access Control (RBAC)** to manage **user permissions** based on their **job role** within an organization.

Instead of assigning permissions to individual users, you assign them to **roles**, and users are added to groups that correspond to those roles. This makes permission management more **scalable, consistent, and secure**.

---

# Deploying

Install
Invoke

---

# Managing IP Address

IP Address Block, Range,

Importing and updating address spaces, csv