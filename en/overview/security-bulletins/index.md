# Security bulletins

This page lists security recommendations given by Yandex.Cloud experts.

## 03.03.2021 — CVE-2021-21309 — remote code execution in {{ RD }}

### Description

In affected versions of Redis an integer overflow bug in 32-bit Redis version 4.0 or newer could be exploited to corrupt the heap and potentially result with remote code execution.

### Impact on Yandex.Cloud services

{{ mrd-full-name }} uses the 64-bit version of {{ RD }} and is not vulnerable.

## 26.01.2021 — CVE-2021-3156 - privilege escalation via sudo

### Description

A number of [vulnerabilities](https://nvd.nist.gov/vuln/detail/CVE-2021-3156) in `sudo` utility allowed any unprivileged user to gain `root` privileges on the vulnerable host.

###  Impact on Yandex.Cloud services

The following Linux images have been updated:
* all images from the {{ yandex-cloud }} publisher available in the {{ marketplace-name }};
* the {{ coi }} image;
* node images for the {{ managed-k8s-short-name }};
* hosts images for managed databases clusters;
* host images for the {{ dataproc-short-name }} clusters.

### Additional Information

* [Buffer overflow in command line unescaping](https://www.sudo.ws/alerts/unescape_overflow.html)
* [CVE-2021-3156: Heap-Based Buffer Overflow in Sudo (Baron Samedit)](https://blog.qualys.com/vulnerabilities-research/2021/01/26/cve-2021-3156-heap-based-buffer-overflow-in-sudo-baron-samedit)%

## 24.12.2020 — CVE-2020-25695 - privilege escalation in PostgreSQL

### Description

A privilege escalation [vulnerability](https://nvd.nist.gov/vuln/detail/CVE-2020-25695) was found in PostgreSQL. The vulnerability allowed unprivileged users to perform SQL queries with identity of superuser under certain conditions.

###  Impact on Yandex.Cloud services

All PostgreSQL database management systems used in the Yandex Managed Service for PostgreSQL have been [updated](https://www.postgresql.org/about/news/postgresql-131-125-1110-1015-9620-and-9524-released-2111/). All new clusters are created with a patched version of PostgreSQL.

## 19.11.2020: Deprecation of outdated TLS protocols

### Description

To improve security of data transmission, {{ yandex-cloud }} recommends all users to migrate towards solutions that support [TLS 1.2](https://tools.ietf.org/html/rfc5246) protocol and higher.

### Impact on Yandex.Cloud services

All {{ yandex-cloud}} services support TLS 1.2 and higher. Support for outdated protocols will be phased out soon. We strongly recommend to switch all customer applications to higher TLS versions in advance.

## 20.09.2020: CVE-2020-1472 (aka Zerologon)

### Description

A flaw in Windows Netlogon Remote Protocol allows an unauthenticated attacker with network access to a domain controller to completely compromise all Active Directory identity services. 

Original report from Secura: [Zerologon](https://www.secura.com/whitepapers/zerologon-whitepaper).

Microsoft advisory: [CVE-2020-1472](https://portal.msrc.microsoft.com/en-US/security-guidance/advisory/CVE-2020-1472).

Microsoft guide on change management : [How to manage the changes in Netlogon secure channel connections associated with CVE-2020-1472](https://support.microsoft.com/en-us/help/4557222/how-to-manage-the-changes-in-netlogon-secure-channel-connections-assoc).

### Impact on Yandex.Cloud services

The OS images available to {{ compute-full-name }} are already contain all the necessary patches. However, the new VMs created in {{ compute-full-name }} are not vulnerable to those vulnerabilities.

### Mitigation Techniques

In addition to the patches you can implement and enforce network access control so that your DC is not accessible from untrusted networks. This can be achieved by:
* setting up Windows Firewall or Security Groups;
* putting your DC under a NAT-gateway.

## 15.06.2020: Special Register Buffer Data Sampling Attack (aka CrossTalk)

### Description

On certain Intel CPU models, VUSec [detected a new attack]( https://www.vusec.net/projects/crosstalk/) called Special Register Buffer Data Sampling Attack (or CrossTalk). During this attack, a malicious process can get the results returned by the RDRAND and RDSEED instructions from another process, even when the malicious and legitimate processes run on different physical CPU cores. The attack is assigned the ID [CVE-2020-0543](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-0543).

Intel's report: [Deep Dive: Special Register Buffer Data Sampling](https://software.intel.com/security-software-guidance/insights/deep-dive-special-register-buffer-data-sampling).

### Impact on Yandex.Cloud services

Yandex.Cloud uses CPU models that are **not vulnerable to** CrossTalk attacks.

## 28.08.2019: TCP SACK

### Description

Netflix experts found three vulnerabilities in the Linux kernel:

* [CVE-2019-11477](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11477)
* [CVE-2019-11478](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11478)
* [CVE-2019-11479](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11479)

Original report from Netflix: [NFLX-2019-001](https://github.com/Netflix/security-bulletins/blob/master/advisories/third-party/2019-001.md).

Vulnerability analysis from Red Hat: [TCP SACK PANIC](https://access.redhat.com/security/vulnerabilities/tcpsack).

### Impact on Yandex.Cloud services

* The Yandex.Cloud infrastructure was promptly protected and updated.
* The OS images available to Yandex Compute Cloud users were updated as soon as the appropriate fixes became available. Therefore, the new VMs created in Yandex Compute Cloud are not vulnerable to those vulnerabilities.

## 19.08.2019: Some Yandex Object Storage domains are included in the Public Suffix List

### Description

List of domains included in Public Suffix List:

* yandexcloud.net
* storage.yandexcloud.net
* website.yandexcloud.net

Domains in the Public Suffix List get the properties of top-level domains, such as .ru or .com:

* Browsers won't save the cookies set for the listed domains.
* Browsers won't let anyone change the page's `Origin` request headers to root domains.

For more information, see [our blog](https://cloud.yandex.ru/blog/posts/2019/08/storage-domains).

### Impact on Yandex.Cloud services

These changes will improve the security of Yandex.Cloud users.

