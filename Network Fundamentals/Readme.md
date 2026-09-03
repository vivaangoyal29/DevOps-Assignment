# Networking Commands Practice

This document contains the execution outputs and explanations for fundamental networking commands as part of the devops-hero practice tasks. 

---

## 1. Ping Command

**Command Executed:**
```bash
ping -c 4 google.com
```

**Output:**
```text
PING google.com (142.250.206.110) 56(84) bytes of data.
64 bytes from lcboma-az-in-f14.1e100.net (142.250.206.110): icmp_seq=1 ttl=116 time=28.4 ms
64 bytes from lcboma-az-in-f14.1e100.net (142.250.206.110): icmp_seq=2 ttl=116 time=24.9 ms
64 bytes from lcboma-az-in-f14.1e100.net (142.250.206.110): icmp_seq=3 ttl=116 time=30.5 ms
64 bytes from lcboma-az-in-f14.1e100.net (142.250.206.110): icmp_seq=4 ttl=116 time=24.4 ms

--- google.com ping statistics ---
4 packets transmitted, 4 received, 0% packet loss, time 8121ms
rtt min/avg/max/mdev = 24.400/27.034/30.470/2.513 ms
```

**Explanation:**
The `ping` command is a fundamental diagnostic tool used to test the reachability of a host on an IP network. It works by sending ICMP (Internet Control Message Protocol) Echo Request packets to the target and waiting for an ICMP Echo Reply. The output shows whether the packets successfully reached the destination, if any packets were lost (packet loss), and how long it took for the round trip (latency/time).

---

## 2. Curl Command

**Command Executed:**
```bash
curl -I https://example.com
```
*(Using `-I` fetches only the HTTP headers for a cleaner output)*

**Output:**
```text
HTTP/2 200
date: Thu, 03 Sep 2026 13:24:25 GMT
content-type: text/html
server: cloudflare
last-modified: Wed, 02 Sep 2026 22:14:26 GMT
allow: GET, HEAD
accept-ranges: bytes
age: 3797
cf-cache-status: HIT
cf-ray: a355131a09ca2175-MAA
```

**Explanation:**
`curl` (Client URL) is a command-line tool used for transferring data to or from a server using various protocols (HTTP, HTTPS, FTP, etc.). It is heavily used in DevOps to test REST APIs, download files, or check if a web server is responding correctly. In this output, we successfully received a `200 OK` HTTP status code, confirming the web server is up and serving content.

---

## 3. Traceroute Command

**Command Executed:**
```bash
traceroute google.com
```

**Output:**
```text
traceroute to google.com (142.250.206.110), 30 hops max, 60 byte packets
 1  DESKTOP-QPP3AOS.mshome.net (172.31.112.1)  0.704 ms  0.681 ms  0.670 ms
 2  wifi.height8tech.com (100.129.160.1)  42.490 ms  32.785 ms  49.284 ms
 3  202.131.133.5.convergentindia.com (202.131.133.5)  34.462 ms  39.302 ms  49.285 ms
 4  115.117.125.189.static-mumbai.vsnl.net.in (115.117.125.189)  54.179 ms  35.234 ms  45.088 ms
 5  172.28.117.90 (172.28.117.90)  59.215 ms * *
 6  115.112.15.114.static-chennai.vsnl.net.in (115.112.15.114)  54.010 ms  52.212 ms  52.112 ms
 7  * * *
 8  142.251.55.62 (142.251.55.62)  45.834 ms 142.251.55.68 (142.251.55.68)  34.096 ms 142.251.55.224 (142.251.55.224)  17.396 ms
 9  142.250.208.152 (142.250.208.152)  32.631 ms 172.253.71.2 (172.253.71.2)  27.466 ms 142.250.62.66 (142.250.62.66)  33.426 ms
10  172.253.64.227 (172.253.64.227)  46.828 ms * 216.239.49.131 (216.239.49.131)  46.671 ms
11  192.178.254.220 (192.178.254.220)  43.828 ms 192.178.254.212 (192.178.254.212)  55.549 ms 192.178.254.210 (192.178.254.210)  68.332 ms
12  192.178.110.199 (192.178.110.199)  39.124 ms 72.14.232.79 (72.14.232.79)  43.103 ms 192.178.242.43 (192.178.242.43)  37.891 ms
13  142.250.210.183 (142.250.210.183)  40.856 ms  52.932 ms 142.250.212.171 (142.250.212.171)  52.888 ms
14  del11s20-in-f14.1e100.net (142.250.206.110)  32.664 ms  42.259 ms  40.740 ms
```

**Explanation:**
While `ping` tells you *if* a server is reachable, `traceroute` tells you *how* your traffic gets there. It maps the exact path (or routing hops) that a packet takes from your local machine to the destination server. It does this by gradually increasing the "Time to Live" (TTL) of packets. This is extremely useful for finding out exactly where a connection is failing or lagging across the internet.

---

## 4. Nslookup Command

**Command Executed:**
```bash
nslookup scaler.com
```

**Output:**
```text
Server:         10.255.255.254
Address:        10.255.255.254#53

Non-authoritative answer:
Name:   scaler.com
Address: 18.172.78.47
Name:   scaler.com
Address: 18.172.78.88
Name:   scaler.com
Address: 18.172.78.67
Name:   scaler.com
Address: 18.172.78.107
```

**Explanation:**
`nslookup` (Name Server Lookup) is a tool used to query the Domain Name System (DNS). It translates human-readable domain names into the IP addresses that computers use to communicate. The output shows the DNS server used to resolve the query and the resulting IP addresses for the requested domain.

---

## 5. Ifconfig Command

**Command Executed:**
```bash
ifconfig
```

**Output:**
```text
eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 172.31.127.127  netmask 255.255.240.0  broadcast 172.31.127.255
        inet6 fe80::215:5dff:fe03:1bac  prefixlen 64  scopeid 0x20<link>
        ether 00:15:5d:03:1b:ac  txqueuelen 1000  (Ethernet)
        RX packets 12121  bytes 50551754 (50.5 MB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 4668  bytes 397273 (397.2 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 242  bytes 32135 (32.1 KB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 242  bytes 32135 (32.1 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
```

**Explanation:**
`ifconfig` (Interface Configuration) displays the current network configuration of your system's network interfaces (like Wi-Fi or Ethernet cards). It shows crucial details such as the assigned local IP address, subnet mask, MAC address (`ether`), and statistics on transmitted/received packets. 

---

## 6. Netstat Command

**Command Executed:**
```bash
netstat -tuln
```

**Output:**
```text
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State
tcp        0      0 127.0.0.53:53           0.0.0.0:*               LISTEN
tcp        0      0 10.255.255.254:53       0.0.0.0:*               LISTEN
tcp        0      0 127.0.0.54:53           0.0.0.0:*               LISTEN
udp        0      0 127.0.0.54:53           0.0.0.0:*
udp        0      0 127.0.0.53:53           0.0.0.0:*
udp        0      0 10.255.255.254:53       0.0.0.0:*
udp        0      0 127.0.0.1:323           0.0.0.0:*
udp6       0      0 ::1:323                 :::*             
```

**Explanation:**
`netstat` (Network Statistics) provides detailed information about active network connections, routing tables, and listening ports. The flags `-tuln` are commonly used to show only listening (l) TCP (t) and UDP (u) ports in numerical (n) form. This is highly useful for verifying if a service (like a web server on port 80 or SSH on port 22) is actively running and accepting connections.

---

## 7. Route Command

**Command Executed:**
```bash
route -n
```

**Output:**
```text
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
0.0.0.0         172.31.112.1    0.0.0.0         UG    0      0        0 eth0
172.31.112.0    0.0.0.0         255.255.240.0   U     0      0        0 eth0
```

**Explanation:**
The `route` command allows you to view and manipulate the IP routing table of your operating system. The routing table determines where network traffic is directed based on its destination IP. In the output, the `0.0.0.0` destination represents the "default gateway" (`192.168.1.1`), which means any traffic not destined for the local network is sent to the router to be forwarded to the internet.

---

## 8. Hostname Command

**Command Executed:**
```bash
hostname
```

**Output:**
```text
DESKTOP-QPP3AOS
```

**Explanation:**
The `hostname` command simply displays (or sets) the network name of the current machine. This name is used to identify the device on a local network and is often utilized in logs, command prompts, and internal DNS resolution.

---

## 9. Dig Command

**Command Executed:**
```bash
dig scaler.com +short
```

**Output:**
```text
18.172.78.107
18.172.78.47
18.172.78.88
18.172.78.67
```

**Explanation:**
`dig` (Domain Information Groper) is a powerful, flexible command-line tool for interrogating DNS name servers. It performs DNS lookups and displays the answers returned from the queried name servers. While similar to `nslookup`, `dig` provides much more detailed output by default and is widely preferred by Linux system administrators for DNS troubleshooting. Using the `+short` flag strips the verbose metadata and returns only the resolved IP addresses.