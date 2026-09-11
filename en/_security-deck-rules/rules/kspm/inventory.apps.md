### OS-level installed package inventory {#apps}

#|
|| **kind** | **severity** | **ID** ||
|| inventory | low | inventory.apps ||
|#

#### Description

This inventory rule collects data on installed packages across worker nodes using an inventory agent.

Queries:

installed. Shows changes in installed packages.

```SELECT os_version.name AS os_name, os_version.version AS os_version, os_version.major AS os_major, os_version.minor AS os_minor, os_version.platform AS os_platform, os_version.codename AS os_codename, deb_packages.name AS pkg_name, deb_packages.source AS pkg_source, deb_packages.version AS pkg_version, deb_packages.arch AS pkg_arch, deb_packages.status AS pkg_status FROM os_version JOIN deb_packages;```

installed_s. Shows all installed packages.

```SELECT os_version.name AS os_name, os_version.version AS os_version, os_version.major AS os_major, os_version.minor AS os_minor, os_version.platform AS os_platform, os_version.codename AS os_codename, deb_packages.name AS pkg_name, deb_packages.source AS pkg_source, deb_packages.version AS pkg_version, deb_packages.arch AS pkg_arch, deb_packages.status AS pkg_status FROM os_version JOIN deb_packages;```

You can analyze the results by exporting event data from [Audit Trails](https://yandex.cloud/ru/docs/security-deck/at-ref) to your SIEM or SOC system.

#### Instructions and solutions

This rule does not require guidance since it is informational and used to collect inventory events within Audit Trails.

You can configure [event collection for Security Deck](https://yandex.cloud/ru/docs/security-deck/at-ref) in Audit Trails and export the data to SIEM or SOC systems to analyze the inventory results.
