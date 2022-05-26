# Security bulletins

This page contains security recommendations from {{ yandex-cloud }} experts.

{% include [29.04.2022 — Redis](../../_includes/security/security-bulletins/cve-2022-24735-24736.md) %}

{%  include [06.04.2022 — GitLab Critical Security Release](../../_includes/security/security-bulletins/cve-2022-1162-gitlab.md) %}

{%  include [18.03.2022 — cr8escape](../../_includes/security/security-bulletins/cve-2022-0811-cr8escape.md) %}

{%  include [09.03.2022 — Dirty Pipe](../../_includes/security/security-bulletins/cve-2022-0847-dirty-pipe.md) %}

{% include [28.02.2022 — multiple-GitLab-vulnerabilities](../../_includes/security/security-bulletins/cve-2022-0735-0549-0751-0741-4191-0738-0489.md) %}

{% include [cve-2022-0185](../../_includes/security/security-bulletins/cve-2022-0185.md) %}

{% include [cve-2021-4034-polkit](../../_includes/security/security-bulletins/cve-2021-4034-polkit.md) %}

## 29.12.2021: CVE-2021-45105, CVE-2021-44832: Denial of Service and Remote code execution (Log4j) {#CVE-2021-45105-CVE-2021-44832}

### Description

Vulnerability CVE-2021-45105 is found in Apache Log4j versions 2.0-alpha through 2.16.0, excluding 2.12.3. The versions do not protect from uncontrolled recursion from self-referential lookups. This may result in a StackOverflowError and a DoS attack.

Vulnerability CVE-2021-44832 is found in Apache Log4j versions 2.0-beta7 through 2.17.0, excluding security fix releases 2.3.2 and 2.12.4. The versions are vulnerable to a remote code execution (RCE) attack where an attacker has permission to modify the logging configuration file.

Original report from [logging.apache.org](https://logging.apache.org/log4j/2.x/security.html).

Vulnerability description: [CVE-2021-45105](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-45105) and [CVE-2021-44832](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-44832).

CVSS rating:

* CVE-2021-45105 5.9 (AV:N/AC:H/PR:N/UI:N/S:U/C:N/I:N/A:H)
* CVE-2021-44832 6.6 (AV:N/AC:H/PR:H/UI:N/S:U/C:H/I:H/A:H)

### Impact

#### General impact

The Log4j library is included in almost all Apache Software Foundation enterprise solutions, such as Apache Struts, Apache Flink, Apache Druid, Apache Flume, Apache Solr, Apache Kafka, Apache Dubbo, and others.

For a complete list of software affected by the vulnerability, see:

* https://github.com/NCSC-NL/log4shell/tree/main/software
* https://gist.github.com/SwitHak/b66db3a06c2955a9cb71a8718970c592

#### Impact on {{ yandex-cloud }} services

Vulnerable versions of the library are not used in {{yandex-cloud}} services.

### Compensatory measures

If your infrastructure uses this library or the products listed in the "General Impact" section, follow the steps below.

#### Log4j 1.x 

Log4j 1.x is not affected by the vulnerability.

#### Log4j 2.x

* Java 6: Upgrade to Log4j 2.3.2.
* Java 7: Upgrade to Log4j 2.12.4.
* Java 8 (and later): Upgrade to Log4j 2.17.1.
* If you're still using prior releases, make sure that the JDBC Appender is not configured to use any protocol other than Java.

Note that only the log4j-core JAR file is affected by this vulnerability. Applications using only the log4j-api JAR file without the log4j-core JAR file are not affected by this vulnerability.

Also note that Apache Log4j is the only Logging Services subproject impacted by this vulnerability. Other projects like Log4net and Log4cxx are not impacted by this vulnerability.

Source: https://logging.apache.org/log4j/2.x/security.html

You can also use the following tools to scan your infrastructure for the log4j vulnerability:

* https://github.com/google/log4jscanner
* https://github.com/bi-zone/Log4j_Detector

## 17.12.2021: CVE-2021-45046: Remote code execution (Log4j) {#CVE-2021-45046}

### Description

Vulnerability [CVE-2021-45046](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-45046) is found in Apache Log4j versions from 2.0-beta9 through 2.15.0, excluding 2.12.2.

It was found that the fix to address the [CVE-2021-44228](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-44228) vulnerability in Apache Log4j 2.15.0 was incomplete in certain non-default configurations. Attackers can craft malicious input data using a JNDI Lookup pattern. This may result in an information leak and remote and local code execution.

A detailed description of the exploit and this behavior is provided in a [Lunasec article](https://www.lunasec.io/docs/blog/log4j-zero-day-update-on-cve-2021-45046/).

Original report from [logging.apache.org](https://logging.apache.org/log4j/2.x/security.html).

Vulnerability description: [CVE-2021-45046](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-45046).

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

If your infrastructure uses this library or the products listed in the "General Impact" section, follow the steps below.

#### Log4j 1.x 

Log4j 1.x is not affected by this vulnerability.

#### Log4j 2.x

* Java 8 (and later): Upgrade to Log4j 2.16.0.
* Java 7: Upgrade to Log4j 2.12.2.
* If you're still using previous versions, remove the `JndiLookup` class from the classpath: `zip -q -d log4j-core-*.jar org/apache/logging/log4j/core/lookup/JndiLookup.class`.

Users are advised not to enable JNDI in Log4j 2.16.0. If the JMS Appender is required, use Log4j 2.12.2.

Note that only the `log4j-core JAR` file is impacted by this vulnerability. Applications using only the `log4j-api JAR` file without the `log4j-core JAR` file are not impacted by this vulnerability.

Source: https://logging.apache.org/log4j/2.x/security.html

## 10.12.2021: CVE-2021-44228: Remote code execution (Log4Shell, Apache Log4j) {#CVE-2021-44228}

Updated on 22.12.2021

### Description

Vulnerability [CVE-2021-44228](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-44228) is found in the Apache Log4j library, version 2.14.1 and lower.

A zero-day exploit was discovered that results in remote code execution (RCE) by having a certain line entered into a log.

An attacker that can control log messages or log message parameters can execute arbitrary code downloaded from LDAP servers when the `message lookup substitution` feature is active. Starting with log4j version 2.15.0, this behavior is disabled by default.

A detailed description of the exploit and this behavior is provided in a [Lunasec article](https://www.lunasec.io/docs/blog/log4j-zero-day/).

Original report from logging.apache.org: [Fixed in Log4j 2.15.0](https://logging.apache.org/log4j/2.x/security.html).

Vulnerability description: [CVE-2021-44228](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-44228).

CVSSv3.1 rating: 10.0 [CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:H/I:H/A:H/E:P/RL:O/RC:C] 

Learn more at https://www.securitylab.ru/vulnerability/527362.php

### Impact

#### General impact

1. The Log4j library is included in almost all Apache Software Foundation enterprise solutions, such as Apache Struts, Apache Flink, Apache Druid, Apache Flume, Apache Solr, Apache Kafka, Apache Dubbo, and others.

2. The vulnerability impacts such open-source products as ElasticSearch, Elastic Logstash, the NSA's Ghidra, and so on.

3. Hystax products are vulnerable because they use a vulnerable version of Elasticsearch Logstash.
Hystax is working on new product releases.

#### Impact on {{ yandex-cloud }} services

Some {{ yandex-cloud }} services use the version of the library affected by the vulnerability. The most critical services impacted by the vulnerability: {{ mes-full-name }}, {{ dataproc-full-name }}, as well as a number of the basic platform services.

The critical services have undergone a successful update as recommended by the manufacturer. The rest of the services are currently being updated.

{{ yandex-cloud }} has collected information on users that have utilized these services, and appropriate alerts have gone out.

Currently, an effort is underway to identify additional services that may be vulnerable in order to update them.

An update to this bulletin will be rolled out based on the outcome of the final activities.

### Compensatory measures

If your infrastructure uses this library or the products listed in the "General Impact" section, follow the steps below.

#### Log4j 1.x 

Log4j 1.x does not have Lookups so the risk is lower. Applications using Log4j 1.x are only vulnerable to this attack when they use JNDI in their configuration. A separate CVE (CVE-2021-4104) has been filed for this vulnerability. To mitigate: audit your logging configuration to ensure it has no JMSAppender configured. Log4j 1.x configurations without JMSAppender are not impacted by this vulnerability.

#### Log4j 2.x

*	Java 8 (or later) users should upgrade to release 2.16.0.
*	Users requiring Java 7 should upgrade to release 2.12.2 when it becomes available (work in progress, expected to be available soon).
*	Otherwise, remove the `JndiLookup` class from the classpath: `zip -q -d log4j-core-*.jar org/apache/logging/log4j/core/lookup/JndiLookup.class`

Note that only the `log4j-core JAR` file is impacted by this vulnerability. Applications using only the `log4j-api JAR` file without the `log4j-core JAR` file are not impacted by this vulnerability.

Source: https://logging.apache.org/log4j/2.x/security.html

#### Hystax 

Hystax Acura controller (or respective Load Balancer in case of HA deployment): allow ingress traffic for UDP-port 12201 only for a list of known source IP ranges where replication agents work.

## 12.11.2021: CVE-2021-22205: Remote code execution via a vulnerability in {{ GL }}

### Description

In {{ GL }} versions starting from 11.9, a [security issue](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-22205) was discovered, which resulted in a remote command execution. An attack may be carried out by sending two requests that require no authentication.

The vulnerability is caused by not properly validating uploaded image files by an external file parser using the ExifTool library ([CVE-2021-22204](https://security-tracker.debian.org/tracker/CVE-2021-22204)).

The issue is fixed in {{ GL }} versions 13.10.3, 13.9.6, and 13.8.8.

### Impact on {{ yandex-cloud }} services

The vulnerability affects all {{ compute-full-name }} users using a deprecated {{ GL }} image from {{ marketplace-full-name }} or a custom image. These users need to upgrade {{ GL }} to the latest version.

To fix the issue on the {{ yandex-cloud }} side, the following measures were taken:

* The {{ GL }} image has temporarily been removed from {{ marketplace-full-name }} and will be updated to the current version.
* Notifications with update recommendations were sent to all users using a deprecated {{ GL }} image.

{{ mgl-full-name }} users are not affected by the vulnerability, since the service uses the current {{ GL }} version.

### Compensatory measures

If you're using a deprecated {{ GL }} image from {{ marketplace-full-name }} or a custom image, [update](https://about.gitlab.com/update) it to the latest version. If for some reason you can't update the {{ GL }} version, use a [hotpatch](https://forum.gitlab.com/t/cve-2021-22205-how-to-determine-if-a-self-managed-instance-has-been-impacted/60918/2).

### More information

* [Action needed by self-managed customers in response to CVE-2021-22205](https://about.gitlab.com/blog/2021/11/04/action-needed-in-response-to-cve2021-22205/)
* [GitLab CE CVE-2021-22205 in the wild](https://security.humanativaspa.it/gitlab-ce-cve-2021-22205-in-the-wild/)

## 12.10.2021: CVE-2021-25741: Risk of accessing a host's filesystem

### Description

A [security issue](https://github.com/kubernetes/kubernetes/issues/104980) was discovered in Kubernetes, which allows unauthorized access to a node's filesystem when a user logs in to a cluster.

### Impact on {{ yandex-cloud }} services

{{ managed-k8s-full-name }} does not provide anonymous cluster access and is not affected by the vulnerability from an external attacker.

### Compensatory measures

To remove the attack vector from an internal attacker, update all existing service clusters and node groups to version 1.19 or higher. If your clusters and node groups are already updated to version 1.19 or higher, update the revisions. An update that fixes the bug is available in all release channels.

We also recommend that you:

* Automatically update your clusters and node groups to the latest versions or revisions.
* Schedule manual updates at least once a month if you can't apply automatic updates.
* Disable running pods as root for untrusted uploads.

To do this, you can use the following tools:
* [OPA Gatekeeper](https://github.com/open-policy-agent/gatekeeper-library/tree/master/library/pod-security-policy/users)
* [Kyverno](https://kyverno.io/policies/pod-security/restricted/require-run-as-nonroot/require-run-as-nonroot/)

### More information

A checklist for a secure Kubernetes configuration is available [here](../security/domains/checklist#kubernetes-security).

## 03.03.2021: CVE-2021-21309: Remote code execution via a vulnerability in {{ RD }}

### Description

In 32-bit {{ RD }} versions 4.0 and higher, an integer overflow vulnerability was discovered, which, under certain conditions, may lead to a remote code execution.

### Impact on {{ yandex-cloud }} services

{{ mrd-full-name }} uses 64-bit {{ RD }} instances and is not affected by the vulnerability.

## 26.01.2021: CVE-2021-3156: Privilege escalation through vulnerabilities in sudo.

### Description

A number of [CVE-2021-3156](https://nvd.nist.gov/vuln/detail/CVE-2021-3156) vulnerabilities were discovered in `sudo`. They allow attackers to execute privilege escalation to `root`.

### Impact on {{ yandex-cloud }} services

The following Linux OS images were updated:

* All images from the {{ yandex-cloud }} publisher available in {{ marketplace-name }}.
* A {{ coi }}.
* An image that is used to create {{ managed-k8s-short-name }} nodes.
* Images that are used to create managed database clusters.
* An image that is used to create {{ dataproc-short-name }} clusters.

### More information

* [Buffer overflow in command line unescaping](https://www.sudo.ws/alerts/unescape_overflow.html)
* [CVE-2021-3156: Heap-Based Buffer Overflow in Sudo (Baron Samedit)](https://blog.qualys.com/vulnerabilities-research/2021/01/26/cve-2021-3156-heap-based-buffer-overflow-in-sudo-baron-samedit)

## 24.12.2020: CVE-2020-25695: Privilege escalation in PostgreSQL

### Description

The [CVE-2020-25695](https://nvd.nist.gov/vuln/detail/CVE-2020-25695) vulnerability was discovered in the PostgreSQL database management system, which allows an attacker having permission to create non-temporary objects to execute arbitrary SQL queries under the identity of a superuser.

### Impact on {{ yandex-cloud }} services

All PostgreSQL instances used in Yandex Managed Service for PostgreSQL were [updated](https://www.postgresql.org/about/news/postgresql-131-125-1110-1015-9620-and-9524-released-2111/).

## 19.11.2020: Discontinue support for deprecated TLS protocols {#discontinue-support-for-deprecated-tls}

### Description

To make data transmission more secure, {{ yandex-cloud }} recommends that all users switch to technologies that provide encryption via [TLS 1.2](https://tools.ietf.org/html/rfc5246) and higher.

### Impact on {{ yandex-cloud }} services

All {{ yandex-cloud }} services support TLS 1.2 and higher. Legacy protocols will gradually be discontinued. We recommend that you upgrade your applications to the latest TLS versions in advance.

## 20.09.2020: CVE-2020-1472 (aka Zerologon)

### Description

A Windows Netlogon Remote Protocol vulnerability that allows an unauthenticated attacker with network access permissions to a domain controller to compromise all Active Directory identification services.

Original report from Secura: [Zerologon](https://www.secura.com/whitepapers/zerologon-whitepaper).

Vulnerability description by Microsoft: [CVE-2020-1472](https://portal.msrc.microsoft.com/en-US/security-guidance/advisory/CVE-2020-1472).

Change management guide from Microsoft: [How to manage the changes in Netlogon secure channel connections associated with CVE-2020-1472](https://support.microsoft.com/en-us/help/4557222/how-to-manage-the-changes-in-netlogon-secure-channel-connections-assoc).

### Impact on {{ yandex-cloud }} services

OS images available to {{ compute-full-name }} users already contain updates that fix the vulnerability. All VMs created in {{ compute-full-name }} after the issue was reported are protected against the described attack.

### Compensatory measures

In addition to the updates, to restrict access to your domain controller from untrusted networks, use the following network access control systems:

* Windows Firewall or security groups.
* Moving the domain controller behind a NAT gateway.

## 15.06.2020: Special Register Buffer Data Sampling Attack (aka CrossTalk)

### Description

On certain Intel CPU models, VUSec [detected a new attack](https://www.vusec.net/projects/crosstalk/) called Special Register Buffer Data Sampling Attack (or CrossTalk). During this attack, a malicious process can get the results returned by the RDRAND and RDSEED instructions from another process, even when the malicious and legitimate processes run on different physical CPU cores. The attack is assigned the ID [CVE-2020-0543](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-0543).

Intel's report: [Deep Dive: Special Register Buffer Data Sampling](https://software.intel.com/security-software-guidance/insights/deep-dive-special-register-buffer-data-sampling).

### Impact on {{ yandex-cloud }} services

{{ yandex-cloud }} uses CPU models that are **not vulnerable to CrossTalk attacks**.

## 28.08.2019: TCP SACK

### Description

Netflix experts found three vulnerabilities in the Linux kernel:

* [CVE-2019-11477](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11477)
* [CVE-2019-11478](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11478)
* [CVE-2019-11479](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11479)

Original report from Netflix: [NFLX-2019-001](https://github.com/Netflix/security-bulletins/blob/master/advisories/third-party/2019-001.md).

Vulnerability analysis from Red Hat: [TCP SACK PANIC](https://access.redhat.com/security/vulnerabilities/tcpsack).

### Impact on {{ yandex-cloud }} services
* The {{ yandex-cloud }} infrastructure was promptly protected and updated.
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

### Impact on {{ yandex-cloud }} services

These changes will improve the security for {{ yandex-cloud }} users.
