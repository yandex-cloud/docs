## June 23, 2026: Targeted data encryption attacks in the Linux infrastructure of Russian organizations {#targeted-linux-ransomware-attacks-2026}

### Original report {#original-report-linux-ransomware-2026}

* Kaspersky / Securelist. *How the Head Mare group's arsenal evolved in early 2026*: <https://securelist.ru/head-mare-phantomheart-and-phantomproxylite/114753/>.
* F6. *Bearlyfy release the genie: F6 analyzed the group's recent attacks*: <https://habr.com/ru/companies/F6/news/1014722/>.
* Positive Technologies. *Phantom pains: Large-scale cyber-espionage campaign and possible split in the PhantomCore APT group*: <https://habr.com/ru/companies/pt/articles/939942/>.
* Sansec. *Found defunct.dat on your site? You've got a problem*: <https://sansec.io/research/gsocket>.

### Summary {#brief-description-linux-ransomware-2026}

{{ yandex-cloud }} observes targeted data encryption attacks in the Linux infrastructure of Russian organizations. The described campaign involves the APT groups Bearlyfy (Labubu, Toy Ghouls) and Head Mare (PhantomCore). The attacks mostly target application service, virtualization, and database nodes.

A typical attack chain begins with publicly available interfaces of application services, vulnerable web applications, intercepted credentials, or VPN sessions. After gaining the initial foothold, the attackers quickly perform reconnaissance, hack database credentials, and escalate the Linux node's privileges using local LPE exploits, including `CVE-2026-31431`, `CVE-2026-43284`, `CVE-2026-43500`, `CVE-2026-21533`, etc. Next, the ransomware is executed on several nodes at once in a coordinated manner.

To manage the compromised infrastructure, the attackers use a gsocket implant over public relay `gs.thc.org`, `revsocks`, reverse SSH tunnels, as well as `GOST`, `rsocx`, `cloudflared`, and `localtonet`. Consolidation is achieved through `systemd` and `cron`. Processes are disguised as Linux kernel threads using `exec -a`. The implant can remain dormant for years, so the absence of current connections to `gs.thc.org` is no guarantee that the node had not been compromised earlier.

### Timeline {#timeline-disclosure-linux-ransomware-2026}

* Latest 2023: The Head Mare group's activity is publicly attributed.
* Latest January 2025: First records of the Bearlyfy group being publicly active.
* August 2025: TrueConf Server vulnerabilities `BDU:2025-10114`, `BDU:2025-10115`, `BDU:2025-10116` used as one of the entry points are patched.
* Latest March – April 2026: Bearlyfy switches to a proprietary ransomware family called GenieLocker.
* 2026: Bearlyfy and Head Mare appear very active exchanging their tools and infrastructure.
* June 23, 2026: {{ yandex-cloud }} bulletin is published.

### Affected technologies {#technologies-affected-linux-ransomware-2026}

* Publicly available interfaces of application services: administrative APIs, automation agent interfaces, video conferencing servers, vulnerable web applications.
* Linux nodes of application services, virtualization, and databases that permit local privilege escalation after initial access.
* Hidden control and consolidation tools: `gsocket`, `revsocks`, reverse SSH tunnels, `GOST`, `rsocx`, `cloudflared`, `localtonet`, `systemd`, and `cron`.
* Ransomware: GenieLocker (`hostd`) and a variant of Babuk for Linux/ESXi.

### Recommendations for vulnerability detection and supporting materials {#recommendations-for-vulnerability-detection-linux-ransomware-2026}

Pay attention to the following indicators of compromise:

* Connections to `gs.thc.org` and subdomains `g.gs.thc.org`, `y.gs.thc.org`, `q.gs.thc.org`, as well as to nodes `x.gs.thc.org`, `360nvidia[.]com`, `5.252.176[.]47`, `45.156.27[.]115`, and `45.87.246[.]40`.
* Files `defunct`, `hostd`, `revsocks`, `rev_socks`, `revsocks_linux_amd64`, and `fscan`, extension `.babyk`, log `/tmp/locker.log`.
* Processes named `[nm_percpu_wq]`, `[kswapd0]`, `[card0-crtc8]`, and `[slub_flushwq]`.
* Payload launched from `memfd`, strings `gsocket-engine.c`, `gsocket-ssl.c`, `_GSOCKET_INTERNAL`, `GS_connect` in binary files, cron tasks is a base64 wrapper.
* For TrueConf Server, the `the required argument for option '--Serial' is missing` string in logs.

To search for known artifacts, use these ready-made materials:

* Elastic YARA rule for `gsocket`: <https://github.com/elastic/protections-artifacts/blob/main/yara/rules/Multi_Hacktool_Gsocket.yar>.
* F6 DFIR repository with GenieLocker materials: <https://github.com/f6-dfir/Ransomware>.

To reduce the risk of attack, take the following measures:

* Isolate public interfaces of application services. Administrative APIs, DBMS, automation agent interfaces, and video conferencing servers should be accessible only from a dedicated segment, not from the internet. Use security groups in [{{ compute-full-name }}](../../../compute/) for filtering at the VM level, and [{{ sws-full-name }}](../../../smartwebsecurity/) for public web frontends.

* Use trust-based segmentation for your network. Separate databases and backup storages from application segments, VPN routes, and external entry points. Use separate [{{ vpc-full-name }}](../../../vpc/) networks or subnets with security groups of their own, [{{ interconnect-full-name }}](../../../interconnect/) for connectivity to the corporate network, and NAT Gateway to centralize outgoing traffic.

* Disable password authentication via SSH for service accounts. Use keys, MFA, and {{ oslogin }} for administrative access. This ties SSH access to {{ yandex-cloud }} accounts, allows centralized key storage, makes it impossible to use local `~/.ssh/authorized_keys` as a control point, and sends connection events to [{{ at-full-name }}](../../../audit-trails/).

* Move backups to immutable storage. Use [{{ objstorage-full-name }}](../../../storage/) with an object lock on top of a versioned bucket in Compliance mode or with permanent legal hold. Governance mode is not enough because a compromised account with the `storage.admin` role can remove this protection.

* Apply the principle of least privilege. Assign only the necessary IAM roles to service accounts, restrict access to specific buckets and operations, and avoid using excessive static keys. Store and rotate secrets in [{{ lockbox-full-name }}](../../../lockbox/).

* Monitor outgoing traffic from application nodes. Treat connections to non-standard ports and unknown external addresses as a high-priority signal. Keep logs to maximum available depth: due to implant stealth phase, retrospective analysis is more important than the current state. Use [{{ cloud-logging-full-name }}](../../../logging/) to centralize VM logs, [{{ at-full-name }}](../../../audit-trails/) for IAM and data plane events (including Flow and DNS logs), and [{{ ycdr-full-name }}](../../../ycdr/) for network visibility.

* Scan images and artifacts for vulnerabilities in [{{ cloud-registry-full-name }}](../../../cloud-registry/) prior to publication. This will help reduce the build chain side risk.

* Monitor the integrity of Linux node system folders: `/etc/cron.d/`, `/var/spool/cron/`, `/lib/systemd/system/`, `~/.ssh/`, `~/.config/`. Check for substitution of legitimate `systemd` units, cron commands with `pkill -0` and `exec -a`, processes masquerading as kernel threads, accounts without any traces of creation or interactive logins, and year-long gaps between `mtime` and `Birth time`.

* Use YARA rules to scan the file system and memory. Memory checks are especially important because `gsocket` can be executed from `memfd` without the file on the disk.

* If you detect a compromise, do not reboot or shut down the node before you take snapshots of the system disk and user disks, and if possible also a memory dump, with the help of [{{ compute-full-name }}](../../../compute/). Isolate the node via security groups without disconnecting the network interface, contact {{ yandex-cloud }} support, and rotate all credentials available to the compromised node. Pre-configured scheduled snapshots and [{{ backup-full-name }}](../../../backup/) make recovery simpler.

* Use built-in {{ yandex-cloud }} tools. With [{{ org-full-name }}](../../../organization/) and an identity federation, you can centralize administrative access with session lifetime of up to six hours. [{{ sd-full-name }}](../../../security-deck/) helps you identify excessive permissions, infrastructure and Kubernetes cluster configuration errors, and open secrets. [{{ ycdr-full-name }}](../../../ycdr/) helps you detect malicious network activities and monitor changes in IAM, while keeping audit data outside the customer's perimeter.
