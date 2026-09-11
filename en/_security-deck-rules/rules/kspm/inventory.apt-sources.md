### OS-level APT repository inventory {#apt-sources}

#|
|| **kind** | **severity** | **ID** ||
|| inventory | low | inventory.apt-sources ||
|#

#### Description

This inventory rule collects data on configured APT repositories across worker nodes using an inventory agent.

Queries:

all. All apt sources changes.

```SELECT name, release, source, base_uri, maintainer, components, architectures FROM apt_sources;```

all_s. All apt sources snapshot.

```SELECT name, release, source, base_uri, maintainer, components, architectures FROM apt_sources;```

external. External apt sources (non-Yandex or non-secure Yandex) changes.

```SELECT name, release, source, base_uri FROM apt_sources WHERE base_uri NOT IN ('http://common-secure.dist.yandex.ru/common','http://dist.yandex.ru/mdb-bionic-secure','http://dist.yandex.ru/mdb-jammy-secure','http://dist.yandex.ru/yandex-cloud-common-secure','http://dist.yandex.ru/yandex-cloud-secure','http://dist.yandex.ru/yandex-cloud-upstream-bionic-secure','http://yandex-cloud-common-focal-secure.dist.yandex.ru/yandex-cloud-common-focal-secure','http://yandex-cloud-common-secure.dist.yandex.ru/yandex-cloud-common-secure','http://yandex-cloud-focal-secure.dist.yandex.ru/yandex-cloud-focal-secure','http://yandex-cloud-secure.dist.yandex.ru/yandex-cloud-secure','http://yandex-cloud-secure.dist.yandex.ru/yandex-cloud','http://yandex-cloud-upstream-focal-secure.dist.yandex.ru/yandex-cloud-upstream-focal-secure','http://yandex-cloud-upstream-xenial-secure.dist.yandex.ru/yandex-cloud-upstream-xenial-secure','http://yandex-cloud-xenial-esm-secure.dist.yandex.ru/yandex-cloud-xenial-esm-secure','http://yandex-xenial-secure.dist.yandex.ru/yandex-xenial','https://common-secure.dist.yandex.ru/common','https://dist.yandex.ru/mdb-bionic-secure','https://dist.yandex.ru/mdb-jammy-secure','https://dist.yandex.ru/yandex-cloud-common-secure','https://dist.yandex.ru/yandex-cloud-secure','https://dist.yandex.ru/yandex-cloud-upstream-bionic-secure','https://yandex-cloud-common-focal-secure.dist.yandex.ru/yandex-cloud-common-focal-secure','https://yandex-cloud-common-secure.dist.yandex.ru/yandex-cloud-common-secure','https://yandex-cloud-focal-secure.dist.yandex.ru/yandex-cloud-focal-secure','https://yandex-cloud-secure.dist.yandex.ru/yandex-cloud-secure','https://yandex-cloud-secure.dist.yandex.ru/yandex-cloud','https://yandex-cloud-upstream-focal-secure.dist.yandex.ru/yandex-cloud-upstream-focal-secure','https://yandex-cloud-upstream-xenial-secure.dist.yandex.ru/yandex-cloud-upstream-xenial-secure','https://yandex-cloud-xenial-esm-secure.dist.yandex.ru/yandex-cloud-xenial-esm-secure','https://yandex-xenial-secure.dist.yandex.ru/yandex-xenial');```

external_s. External apt sources (non-Yandex or non-secure Yandex) snapshot.

```SELECT name, release, source, base_uri FROM apt_sources WHERE base_uri NOT IN ('http://common-secure.dist.yandex.ru/common','http://dist.yandex.ru/mdb-bionic-secure','http://dist.yandex.ru/mdb-jammy-secure','http://dist.yandex.ru/yandex-cloud-common-secure','http://dist.yandex.ru/yandex-cloud-secure','http://dist.yandex.ru/yandex-cloud-upstream-bionic-secure','http://yandex-cloud-common-focal-secure.dist.yandex.ru/yandex-cloud-common-focal-secure','http://yandex-cloud-common-secure.dist.yandex.ru/yandex-cloud-common-secure','http://yandex-cloud-focal-secure.dist.yandex.ru/yandex-cloud-focal-secure','http://yandex-cloud-secure.dist.yandex.ru/yandex-cloud-secure','http://yandex-cloud-secure.dist.yandex.ru/yandex-cloud','http://yandex-cloud-upstream-focal-secure.dist.yandex.ru/yandex-cloud-upstream-focal-secure','http://yandex-cloud-upstream-xenial-secure.dist.yandex.ru/yandex-cloud-upstream-xenial-secure','http://yandex-cloud-xenial-esm-secure.dist.yandex.ru/yandex-cloud-xenial-esm-secure','http://yandex-xenial-secure.dist.yandex.ru/yandex-xenial','https://common-secure.dist.yandex.ru/common','https://dist.yandex.ru/mdb-bionic-secure','https://dist.yandex.ru/mdb-jammy-secure','https://dist.yandex.ru/yandex-cloud-common-secure','https://dist.yandex.ru/yandex-cloud-secure','https://dist.yandex.ru/yandex-cloud-upstream-bionic-secure','https://yandex-cloud-common-focal-secure.dist.yandex.ru/yandex-cloud-common-focal-secure','https://yandex-cloud-common-secure.dist.yandex.ru/yandex-cloud-common-secure','https://yandex-cloud-focal-secure.dist.yandex.ru/yandex-cloud-focal-secure','https://yandex-cloud-secure.dist.yandex.ru/yandex-cloud-secure','https://yandex-cloud-secure.dist.yandex.ru/yandex-cloud','https://yandex-cloud-upstream-focal-secure.dist.yandex.ru/yandex-cloud-upstream-focal-secure','https://yandex-cloud-upstream-xenial-secure.dist.yandex.ru/yandex-cloud-upstream-xenial-secure','https://yandex-cloud-xenial-esm-secure.dist.yandex.ru/yandex-cloud-xenial-esm-secure','https://yandex-xenial-secure.dist.yandex.ru/yandex-xenial');```

You can analyze the results by exporting event data from [Audit Trails](https://yandex.cloud/ru/docs/security-deck/at-ref) to your SIEM or SOC system.

#### Instructions and solutions

This rule does not require guidance since it is informational and used to collect inventory events within Audit Trails.

You can configure [event collection for Security Deck](https://yandex.cloud/ru/docs/security-deck/at-ref) in Audit Trails and export the data to SIEM or SOC systems to analyze the inventory results.
