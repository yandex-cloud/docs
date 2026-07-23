---
title: '{{ SD }} versioning policy'
description: In this article, you will learn about the DBMS versioning policy in {{ SD }}.
---

# {{ SD }} versioning policy

This document describes the lifecycle of major {{ SD }} versions.

{% note info %}

{{ SD }} is fully compatible with [MongoDB](https://en.wikipedia.org/wiki/MongoDB). For easier compatibility tracking, {{ SD }} versioning fully matches MongoDB versioning. For example, `{{ SD }} 7.0` is fully compatible with `MongoDB 7.0`.

{% endnote %}


## Terminology and lifecycle stages of {{ SD }} versions {#version-lifecycle}

In {{ SD }}, each major version has a lifecycle of **about five years** comprising the following stages (statuses):

| Version stage | Description and key [actions](#actions-available) | Approximate lifetime^1^                     |
|:------|:-------------|:----------------------------|
| `Supported`  | Version with active support. **Recommended for all new projects**. | Years 1 through 4 |
| `Deprecated` | Version approaching its end-of-life. Creating new clusters is blocked. The existing clusters operate normally. | Year 5 |
| `Legacy Extra Paid`^2^ | Version that has no official support. Clusters operate normally, but are billed at an increased rate. Technical support is limited. The service creates a forced cluster upgrade task. The customer can cancel it by [contacting]({{ link-console-support }}) support. | Year 6 |
| End of Life (`EOL`)^2^ | Discontinued version. No technical support is provided. Backup recovery is not guaranteed. Clusters operate normally, but are billed at an increased rate. | Year 7 onward |

^1^ The periods are relative to the major version release date. The exact status change dates are officially announced by the service.
^2^ Yandex will [notify](#notifications) you in advance of the changes and the upcoming billing rate increase as per the Agreement.


### Features for each version {#actions-available}

Depending on {{ SD }} version status, the following operations are available for clusters:

| Action | `Supported` | `Deprecated` | Legacy extra paid (`Legacy Extra Paid`) | End of Life (`EOL`) |
| :--- | :---: | :---: | :---: | :---: |
| Creating new clusters | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) |
| Recovery from a backup | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg)</br>(Not guaranteed) |
| Use of existing clusters | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| Possibility of upgrading to a new major version | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| Support | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![exclam](../../_assets/common/exclam.svg)</br>Limited | ![no](../../_assets/common/no.svg) |
| Pricing | Standard | Standard | ![exclam](../../_assets/common/exclam.svg)</br>Increased^2^ | ![exclam](../../_assets/common/exclam.svg)</br>Increased^2^ |

^2^ Yandex will [notify](#notifications) you in advance of the changes and the upcoming billing rate increase as per the Agreement.

{% note warning %}

Long-term backups (`LTR`) of `EOL` versions may not be available for recovery in {{ SD }} after those versions are discontinued. We recommend planning your data migration before the version reaches its end of life.

{% endnote %}


## Key principles of the {{ SD }} versioning policy {#key-principles}

The {{ SD }} versioning policy is based on the following key principles:

* **Support duration**. Each major version remains `Supported` for about five years.
* **Incremental deprecation**. Prior to the end of support, the version becomes `Deprecated`. After support ends, the version moves to `Legacy Extra Paid` and then to **End of Life (`EOL`)**.
* **Increased cost**. Once a version becomes `Legacy Extra Paid`, higher pricing applies to clusters, and technical support is limited.
* **End of life**. When a version enters the **End of Life (`EOL`)** status, clusters continue to run, but higher pricing applies, technical support is discontinued, and cluster recovery from backups is not guaranteed.
* **Major version upgrade**. When a version becomes `Legacy Extra Paid`, the service creates a forced cluster upgrade task. The customer can cancel it by [contacting]({{ link-console-support }}) support.

    {% note alert %}

    {{ SD }} **strongly recommends upgrading the version** before it becomes `EOL`.

    {% endnote %}

* **Change notifications**. The service proactively [notifies](#notifications) the customer about version status changes and upcoming price increases. Notifications are sent 90 calendar days before the version enters the `Legacy Extra Paid` and **End of Life (`EOL`)** statuses.


## Update policy {#update-policy}

* **Minor version updates** (within the same major version, e.g., 7.0.12 → 7.0.15) are installed **automatically** as part of maintenance performed during the cluster's scheduled [maintenance window](./maintenance.md#maintenance-window) or at the customer's request. These updates contain security and bug fixes. A minor update requires a short, successive reboot of the cluster hosts.
* **Major version upgrades** (change of the major version, e.g., 7.0.x → 8.0.x) take place when the version goes from `Deprecated` to `Legacy Extra Paid`. The scheduled update appears in the {{ yandex-cloud }} interface ahead of time and can be canceled by [contacting]({{ link-console-support }}) support.

{% note alert %}

The **End of Life (`EOL`)** versions cannot be upgraded to a newer major version. {{ SD }} strongly recommends upgrading the version before it reaches the `EOL` stage.

{% endnote %}


## Notifications {#notifications}

{{ SD }} notifies customers 90 calendar days in advance about:

* Version transition to the `Deprecated` [status](#version-lifecycle) (start of restrictions). In addition, {{ SD }}:

    * Informs that creating new clusters with this version is no longer supported.
    * Recommends scheduling upgrades for existing clusters.
    * Creates a forced cluster upgrade task in the interface.

* Version transition to the `Legacy Extra Paid` [status](#version-lifecycle) (higher fees start to apply). In addition, {{ SD }}:

    * Notifies of a price increase.
    * Warns about the upcoming end of support.

Yandex will notify you in advance of the changes and the upcoming billing rate increase as per the Agreement. Users will be receiving such notifications according to their [notification settings](../../console/operations/update.md#notifications).


### Notifications about scheduled operations {#notifications-on-operations}

The table below sets out the minimum user notification periods for different types of upcoming operations with {{ SD }} clusters.

Type of change | Minimum notification period^3^| Maximum migration period^4^
--- | --- | ---
Internal version update that requires restarting hosts. | 30 days | 90 days
Internal version update that does not require restarting hosts. | 3 days | 7 days
Internal version update that requires switching the master or blocking write operations. | 14 days | 14 days
Security updates (maximum severity) | 5 days | 2 days
Security updates (high severity) | 14 days | 14 days
Security updates (medium severity) | 21 days | 30 days
Security updates (low severity) | 28 days | 120 days

^3^ Minimum number of days between an upcoming operation and a notification about it from {{ yandex-cloud }}.
^4^ Period of time during which the customer can manually reschedule the operation in the [management console]({{ link-console-main }}).


## Versioning schedule {#version-schedule}

Version^5^ | `Supported` | `Deprecated` | Legacy extra paid (`Legacy Extra Paid`) | End of Life (`EOL`)
--- | --- | --- | --- | ---
`8.0` | 2024–2028 | 2029 | 2030 | 2031+
`7.0` | 2023–2027 | 2028 | 2029 | 2030+

^5^ The exact timeline of transitions between {{ SD }} [version statuses](#version-lifecycle) will be announced separately.

{% note info %}

{{ SD }} 6.0 and earlier DBMS versions have already reached **End of Life (`EOL`)**. Clusters using these versions will be forcibly upgraded.

{% endnote %}

### Currently supported versions (June 2026) {#currently-supported-versions}

Version | Status | End of life (`EOL`)^6^ | First release date
--- | --- | --- | ---
`8.0`| Full support | 31.10.2029 | 01.10.2024
`7.0`| Full support | 31.08.2027 | 01.08.2023

^6^ Support will be discontinued **no earlier** than the specified date.
