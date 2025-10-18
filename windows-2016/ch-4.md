# Lesson-1 Implementing DNS Servers

## What is DNS？

**DNS** stands for **Domain Name System**.
**DNS name resolution** is the **process of translating a domain name** (like `www.example.com`) into an **IP address** (like `93.184.216.34`) so that your computer can connect to the correct server on the internet.

### 🔄  How DNS Name Resolution Works

**DNS name resolution = "What's the IP address for this domain?"**
Your computer asks around until it gets the answer.

1. **You enter a domain** in your browser:
   → `www.example.com`

2. **Check local cache**:
   Your device checks if it already knows the IP address from a recent visit.

3. **Ask the DNS resolver** (usually from your ISP or configured manually):
   If it's not cached, your device sends a request to a **recursive DNS resolver**.

4. **Query root servers**:
   The resolver asks one of the **root DNS servers**, ==“Where can I find info about `.com` domains?”==

5. **Query TLD servers** (Top-Level Domain):
   The root server responds with the address of the **`.com` TLD server**, which handles `.com` domains.

6. **Query authoritative name server**:
   ==The resolver asks the TLD server where `example.com` is hosted.==
   The TLD replies with the **authoritative name server** for `example.com`.

7. **Final answer**:
   The resolver contacts the authoritative server, which responds with the **IP address** of `www.example.com`.

8. **Connect and cache**:
   Your computer connects to the IP, loads the website, ==and stores the result in memory to speed up future visits.==

> ==DNS is not case-sensitive==
---

## Name type

應用程式在辨識或連線到其他主機時，通常會使用兩種名稱型態之一：Hostname（如 DNS 名稱）或 NetBIOS 名稱（常見於區域網路環境）。

### 🌐 1. **Hostname**

A **hostname** is the **human-readable name of a device** on a network.

**✅ Examples:**

* `my-laptop`
* `server01`
* `web01.example.com`

### 🖧 2. **NetBIOS Name**

**NetBIOS** (Network Basic Input/Output System) name is an **older naming system** used mainly in **Windows-based local networks** for identifying computers and services.

**✅ Examples:**

* `DESKTOP123`
* `WORKGROUP-PC`
* `FILESERVER`

## 🆚 Hostname vs NetBIOS: Key Differences

| Feature           | **Hostname**                              | **NetBIOS Name**                          |
| ----------------- | ----------------------------------------- | ----------------------------------------- |
| **Max length**    | 255 characters (FQDN); ~63 per label      | 15 characters (plus 1 service byte)       |
| **Hierarchy**     | Supports domain hierarchy (`host.domain`) | Flat (no hierarchy)                       |
| **Used in**       | DNS, internet, most OSs                   | Legacy Windows networks                   |
| **Modern use?**   | Widely used                               | Legacy, still around in some Windows LANs |
| **Supports DNS?** | Yes                                       | No (but can resolve via WINS/NetBT)       |

---

## 📍 1. **Hostname**, FQDN, Alias（CNAME）

* A **hostname** is the **name assigned to a computer or device** on a network.
* A **Fully Qualified Domain Name** is the **complete domain name** for a specific host on the internet or a private network.
* An **alias** is another name that **points to a real hostname** using a **CNAME (Canonical Name) record** in DNS.

### 🔁 Summary Table

| Term         | Example                   | Description                                  |
| ------------ | ------------------------- | -------------------------------------------- |
| **Hostname** | `webserver1`              | Short name of a computer on a network        |
| **FQDN**     | `webserver1.example.com.` | Complete name that DNS uses to identify host |
| **Alias**    | `www.example.com`         | Alternate name pointing to a real FQDN       |

---

## 🔑 What is a **DNS domain**?

A **DNS domain** is a **human-readable name** (like `example.com`) that corresponds to one or more **IP addresses** and is used to access websites, send emails, and more.

### 🧱 Structure of a DNS Domain:

DNS domains are **hierarchical**, separated by dots (`.`). For example:

```
www.example.com.
```

* `.` → **Root domain** (at the top of the hierarchy)
* `com` → **Top-Level Domain (TLD)**
* `example` → **Second-Level Domain**
* `www` → **Subdomain**

So `www.example.com` is a **fully qualified domain name (FQDN)**.

### 💡 Types of DNS Domains:

| Type                 | Example             | Description                           |
| -------------------- | ------------------- | ------------------------------------- |
| **Root domain**      | `.`                 | The starting point of DNS hierarchy   |
| **Top-Level Domain** | `com`, `org`, `net` | Controlled by domain registries       |
| **Second-Level**     | `example.com`       | Registered by individuals/companies   |
| **Subdomain**        | `mail.example.com`  | Used to organize or separate services |
