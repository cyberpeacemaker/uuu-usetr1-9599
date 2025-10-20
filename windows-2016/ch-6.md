# Remote Access in Windows Server 2016

- Remote access
- Implementing Web Application Proxy

---

# Remote Access

VPN(virtual private network), DirectAccess, Routing, Web Application

A **Web Application Proxy (WAP)** is a **reverse proxy server** that provides **secure access to internal web applications** from outside your corporate network — without giving direct access to the internal network itself.

---

### 🔐 What a Web Application Proxy Does

It acts as a **gateway** between external users (e.g., remote employees, partners) and **on-premises web applications**, like:

* Outlook Web App
* SharePoint
* Intranet portals
* Custom internal apps

The WAP **authenticates** the user, often using modern methods (like **AD FS**, **MFA**, or **OAuth**), and only then forwards the request to the internal web server.

---

### 🧱 Key Features

| Feature                    | Description                                                    |
| -------------------------- | -------------------------------------------------------------- |
| 🔁 **Reverse proxy**       | Forwards external requests to internal web apps                |
| 🔐 **Pre-authentication**  | Integrates with AD FS (Active Directory Federation Services)   |
| 🔑 **MFA support**         | Can require multi-factor authentication before allowing access |
| 🔍 **Access control**      | Enforces conditional access policies                           |
| 🌐 **External publishing** | Securely publishes internal apps to the internet               |

---

### 🧭 Common Use Case

1. A user outside the corporate network tries to access a web app (e.g., `https://portal.company.com`).
2. The request hits the **Web Application Proxy** in the DMZ.
3. The WAP redirects the user to authenticate via **AD FS**.
4. Once authenticated, WAP **proxies** the request to the internal web server.
5. The user gets access — securely and without needing a VPN.

---

### 🛠 Technologies That Use WAP

* **Microsoft Web Application Proxy** (part of Windows Server)
* **Azure AD Application Proxy** (cloud version)
* **Reverse proxy appliances**: F5, Citrix, Palo Alto, etc.
* **NGINX / Apache** reverse proxies (in custom setups)

---

### 📌 Why Use a Web Application Proxy?

* Avoid giving direct access to your internal network
* Enhance security with **pre-authentication & MFA**
* No need for a VPN for basic web app access
* Enforce conditional access (based on user, device, location)
