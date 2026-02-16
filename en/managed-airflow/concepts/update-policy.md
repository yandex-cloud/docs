---
title: '{{ AF }} versioning policy'
description: In this tutorial, you will learn about the {{ AF }} versioning policy in {{ maf-full-name }}.
---

# {{ AF }} versioning policy

Each version in the {{ yandex-cloud }} infrastructure has [lifecycle stages](#version-lifecycle) assigned depending on its kernel release date. If the {{ AF }} version used in a {{ maf-name }} cluster becomes deprecated, it gets updated.

Upgrading to current versions allows you to get new features, patches, and security fixes, which improves the overall stability of the cluster.

{% note warning %}

In {{ maf-name }},the lifecycle rules for major {{ AF }} versions (2.x and 3.x) are different. This is due to major differences in the version support periods by the service kernel developers.

{% endnote %}

{{ maf-name }} uses two {{ AF }} version support strategies:

* **LTS** (Long-Term Support) versions.
* **Versions with regular updates**.

## Version lifecycle stages {#version-lifecycle}

### Versions 2.X {#v-2-x}

For versions 2.X, {{ AF }} adopts the LTS support strategy, as per its [official version support policy](https://airflow.apache.org/docs/apache-airflow/stable/installation/supported-versions.html):

* **Current versions**: 2.8, 2.10.
* **Target version**: 2.11 (LTS).
* **Python version**: 3.10, 3.12.

#### Update procedure

All clusters versions 2.8 and 2.10 will be updated to version 2.11. The forced update will not begin until February 2026.

Version 2.11 will be supported until the end of 2026.

### Versions 3.X {#v-3-x}

Versions 3.X follow the regular updates strategy. Kernel developers release new feature versions (3.X) approximately once every six months. {{ yandex-cloud }} makes efforts to make new versions promptly available for its customers.

**Python version**: currently, versions 3.X only support Python 3.12.

{% note info %}

More Python versions may be supported in future. Python 3.12, which is its current primary version, will remain in support until the end of 2028, as per the [Python kernel support policy](https://devguide.python.org/versions/).

{% endnote %}

Key stages based on version availability in {{ yandex-cloud }}:

| Version status | Description | Applies in (from the kernel release date) |
|:---|:---|:---|
| **Supported versions** |
| Availability in {{ maf-name }} | You can use this version to create and manage new clusters. | 0 to 1 months |
| Unavailable for new clusters | You cannot use this version to create new clusters, but the existing ones will continue to operate. You may be prompted to upgrade in the management console. | 6 months |
| **Unsupported versions** |
| Forced update | Existing clusters are focibly updated to the supported version. | 12 months |

{% note tip %}

We recommend updating clusters manually to the supported versions without waiting for an automatic update. This enables you to test compatibility of DAG files in advance.

{% endnote %}

## Version support schedule {#version-schedule}

### Versions 2.X {#v-2-x-schedule}

Available Python versions: 3.10, 3.12.

| Version | Current status | Forced update |
|:---|:---|:---|
| 2.8 | Unavailable for creating new clusters | February 2026 |
| 2.10 | Available | February 2026 |
| 2.11 (LTS) | Scheduled (February 2026) | Q4 2026 |

All versions 2.8 and 2.10 will be updated to the official open-source community-supported LTS version 2.11 no earlier than in February 2026.

### Versions 3.X {#v-3-x-schedule}

Available Python versions: 3.12 (more versions may be added).

| Version | Available in {{ maf-name }} | Unavailable for new clusters | Forced update |
|:---|:---|:---|:---|
| 3.0 | September 2025 | March 2026 | September 2026 |
| 3.1 | November 2025 | June 2026 | Q4 2026 |
| 3.X | TBD | TBD + 6 months | TBD + 12 months |

## Update policy {#update-policy}

Version updates within the same branch (e.g., from 3.0 to 3.1) take place as follows:

1. As soon as the version switches to **Forced update**, cluster update is initiated.
1. The cluster is updated to the nearest supported version within the major branch.

{% note warning "Update notifications" %}

The notification system provides the following notifications:

- **30 days** prior to a version’s transition to the **Forced update** status.
- **7 days** prior to the start of a version’s forced update.

{% endnote %}

### Specifics of switching from versions 2.X to 3.X {#v-2-x-to-v-3-x}

Due to architectural differences, automatic migration from versions 2.X to 3.X is not supported.

You need to upgrade to version 3.X manually. Proceed as follows:
1. Save DAG files in an external storage (S3 or git repository).
1. [Create](../operations/cluster-create.md) a new {{ maf-name }} version 3.X cluster.
1. Connect the repository with the DAG files to the cluster you created.

#### See also {#see-also}

[Versioning in {{ maf-name }}](versions.md)
