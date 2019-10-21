# Security bulletins

Below are security bulletins compiled by Yandex.Cloud engineers.


## 28.08.2019 — TCP SACK


### Description
There are three TCP vulnerabilities in Linux kernel disclosed by Netflix:
* [CVE-2019-11477](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11477)
* [CVE-2019-11478](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11478)
* [CVE-2019-11479](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11479)

Original Netflix report: [NFLX-2019-001](https://github.com/Netflix/security-bulletins/blob/master/advisories/third-party/2019-001.md).

Comprehensive vulnerabilities analysis by Red Hat: [TCP SACK PANIC](https://access.redhat.com/security/vulnerabilities/tcpsack).


### Yandex.Cloud services impact
* Yandex.Cloud infrastructure was patched immediately. 
* Public VM images available to Yandex Cloud Compute users were updated as soon as the corresponding fixes became available. New virtual machines created in Yandex Compute Cloud are not affected by the listed vulnerabilities.


## 19.08.2019 — Several Yandex.Cloud domains were added to the Public Suffix List


### Description

The following Yandex.Cloud domains were added to the Public Suffix List:
* yandexcloud.net
* storage.yandexcloud.net
* website.yandexcloud.net

Domains in the Public Suffix List gain properties of top-level domains such as .ru or .com:
* browsers don't set cookies on the listed domains,
* browsers don't allow changing the `Origin` header of the page to the root domains.

More information can be found in our [blog post](https://cloud.yandex.ru/blog/posts/2019/08/storage-domains) (in Russian).


### Yandex.Cloud services impact

This will improve security and isolation for Yandex Cloud customers. 

