# Security bulletins

This page lists security recommendations given by Yandex.Cloud experts.

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

