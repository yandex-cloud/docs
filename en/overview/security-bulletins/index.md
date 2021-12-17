# Security bulletins

TThis page contains security recommendations from {{ yandex-cloud }} experts.

## 17.12.2021 — CVE-2021-45046 – Remote code execution (Log4j) {#CVE-2021-45046}

### Description

Vulnerability [CVE-2021-45046](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-45046) is found in the Apache Log4j library, all versions from 2.0-beta9 to 2.15.0, excluding 2.12.2.

A detailed description of the exploit and this behavior is provided in a [Lunasec article](https://www.lunasec.io/docs/blog/log4j-zero-day-update-on-cve-2021-45046/).

Original report from logging.apache.org: [Fixed in Log4j 2.15.0](https://logging.apache.org/log4j/2.x/security.html).

Vulnerability description: [CVE-2021-44228](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-45046).

CVSSv3.1 rating: 9.0 (AV:N/AC:H/PR:N/UI:N/S:C/C:H/I:H/A:H)

### Impact

#### General impact

The Log4j library is included in almost all Apache Software Foundation enterprise solutions, such as Apache Struts, Apache Flink, Apache Druid, Apache Flume, Apache Solr, Apache Kafka, Apache Dubbo, and others.

The vulnerability likely impacts such open-source products as ElasticSearch, Elastic Logstash, the NSA's Ghidra, and so on.

#### Impact on {{ yandex-cloud }} services

Some {{ yandex-cloud }} services use the version of the library affected by the vulnerability. The most critical services impacted by the vulnerability: {{ mes-full-name }}, {{ dataproc-full-name }}, as well as a number of the basic platform services.

The critical services have undergone a successful update as recommended by the manufacturer. The rest of the services are currently being updated.

{{ yandex-cloud }} has collected information on users that have utilized these services, and appropriate alerts have gone out.

Currently, an effort is underway to identify additional services that may be vulnerable in order to update them.

An update to this bulletin will be rolled out based on the outcome of the final activities.

### Compensatory measures

#### Log4j 1.x 

Log4j 1.x is not impacted by this vulnerability.

#### Log4j 2.x

* Java 8 (or later) users should upgrade to release 2.16.0.
* Java 7 users should upgrade to release 2.12.2.
* Otherwise, in any release other than 2.16.0, you may remove the `JndiLookup` class from the classpath: `zip -q -d log4j-core-*.jar org/apache/logging/log4j/core/lookup/JndiLookup.class`

Users are advised not to enable JNDI in Log4j 2.16.0. If the JMS Appender is required, use Log4j 2.12.2.

Note that only the `log4j-core JAR` file is impacted by this vulnerability. Applications using only the `log4j-api JAR` file without the `log4j-core JAR` file are not impacted by this vulnerability.

Source: https://logging.apache.org/log4j/2.x/security.html

## 10.12.2021: CVE-2021-44228: Remote code execution (Log4Shell, Apache Log4j)

Updated 17.10.2021

### Description

Vulnerability [CVE-2021-44228](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-44228) is found in the Apache Log4j library, version 2.14.1 and lower.

A zero-day exploit was discovered that results in remote code execution (RCE) by having a certain line entered into a log.

An attacker that can control log messages or log message parameters can execute arbitrary code downloaded from LDAP servers when the `message lookup substitution` feature is active. Starting with log4j version 2.15.0, this behavior is disabled by default.

A detailed description of the exploit and this behavior is provided in a [Lunasec article](https://www.lunasec.io/docs/blog/log4j-zero-day/).

Original report from logging.apache.org: [Fixed in Log4j 2.15.0](https://logging.apache.org/log4j/2.x/security.html).

Vulnerability description: [CVE-2021-44228](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-44228).

CVSSv3.1 rating: 9.8 [CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:H/I:H/A:H/E:P/RL:O/RC:C] Learn more at https://www.securitylab.ru/vulnerability/527362.php

### Impact

#### General impact

The Log4j library is included in almost all Apache Software Foundation enterprise solutions, such as Apache Struts, Apache Flink, Apache Druid, Apache Flume, Apache Solr, Apache Kafka, Apache Dubbo, and others.

The vulnerability likely impacts such open-source products as ElasticSearch, Elastic Logstash, the NSA's Ghidra, and so on.

#### Impact on {{ yandex-cloud }} services

Some {{ yandex-cloud }} services use the version of the library affected by the vulnerability. The most critical services impacted by the vulnerability: {{ mes-full-name }}, {{ dataproc-full-name }}, as well as a number of the basic platform services.

The critical services have undergone a successful update as recommended by the manufacturer. The rest of the services are currently being updated.

{{ yandex-cloud }} has collected information on users that have utilized these services, and appropriate alerts have gone out.

Currently, an effort is underway to identify additional services that may be vulnerable in order to update them.

An update to this bulletin will be rolled out based on the outcome of the final activities.

### Compensatory measures

#### Log4j 1.x 

Log4j 1.x does not have Lookups so the risk is lower. Applications using Log4j 1.x are only vulnerable to this attack when they use JNDI in their configuration. A separate CVE (CVE-2021-4104) has been filed for this vulnerability. To mitigate: audit your logging configuration to ensure it has no JMSAppender configured. Log4j 1.x configurations without JMSAppender are not impacted by this vulnerability.

#### Log4j 2.x

•	Java 8 (or later) users should upgrade to release 2.16.0.
•	Users requiring Java 7 should upgrade to release 2.12.2 when it becomes available (work in progress, expected to be available soon).
•	Otherwise, remove the `JndiLookup` class from the classpath: `zip -q -d log4j-core-*.jar org/apache/logging/log4j/core/lookup/JndiLookup.class`

Note that only the `log4j-core JAR` file is impacted by this vulnerability. Applications using only the `log4j-api JAR` file without the `log4j-core JAR` file are not impacted by this vulnerability.

Source: https://logging.apache.org/log4j/2.x/security.html

## 12.10.2021 – CVE-2021-25741 – Symlink Exchange Can Allow Host Filesystem Access

### Description

A [security issue](https://github.com/kubernetes/kubernetes/issues/104980) in Kubernetes was discovered, whereby a user could create a container with subpath volume mounts to access files and directories outside of the volume, including on the host file system.

###  Impact on Yandex.Cloud services

{{ managed-k8s-full-name }} does not support anonymous access to the cluster and is not vulnerable to external attackers. 

### Compensatory measures

To eliminate potential attacks by an internal intruder, please update all existing clusters and node groups in the service to version 1.19 or higher. If your clusters and node groups have already been updated to version 1.19 or higher, update the revisions. An update that closes vulnerabilities is available in all release channels.

We also recommend:
* Automatically update clusters and node groups to the latest versions or revisions.
* Schedule manual updates at least once a month if you cannot apply automatic updates.
* Prohibit the root user from running pods for unverified downloads.

You can use the following tools to do so:
* [OPA Gatekeeper](https://github.com/open-policy-agent/gatekeeper-library/tree/master/library/pod-security-policy/users)
* [Kyverno](https://kyverno.io/policies/pod-security/restricted/require-run-as-nonroot/require-run-as-nonroot/)

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

