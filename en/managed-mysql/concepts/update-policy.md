---
title: '{{ MY }} versioning policy'
description: In this tutorial, you will learn about the {{ MY }} versioning policy in {{ mmy-full-name }}.
---

# {{ MY }} versioning policy

This document describes the lifecycle of major {{ MY }} versions in {{ mmy-full-name }}. The policy is based on the [official Oracle {{ MY }} support schedule](https://www.mysql.com/support/eol-notice.html) and {{ MY }} [Percona Extended Support](https://www.percona.com/release-lifecycle-overview/#lifecycle) schedule for a balance between [cluster](./index.md) stability and maintaining a modern and secure infrastructure.

## Terminology and lifecycle stages of {{ MY }} versions {#version-lifecycle}

In {{ mmy-name }}, each major {{ MY }} version has a lifecycle of 8–10 years comprising the following stages (statuses):

| Version stage | Description and key [actions](#actions-available) | Approximate lifetime^1^                     |
|:------|:-------------|:----------------------------|
| Current (`Actual`) | The latest [LTS](https://en.wikipedia.org/wiki/Long-term_support) version with active support. **Recommended for all new projects**. | Years 1 through 5 |
| Supported (`Supported`)  | Previous LTS version with Percona `Extended Support`. Fully supported; allows creating new clusters. | Years 6 through 8 |
| Deprecated (`Deprecated`) | Version approaching the end of Percona `Extended Support`. Creating new clusters is blocked. The existing clusters operate normally. | Year 9 |
| Legacy extra paid (`Legacy Extra Paid`)^2^ | Version that has no official support. Clusters operate normally, but are billed at an increased rate. Technical support is limited. | Year 10 |
| End of life (`EOL`)^2^ | Discontinued version. No technical support is provided. Clusters operate normally, but are billed at an increased rate. | Year 11 onward |

^1^ The periods are relative to the major version release date. The exact status change dates are officially announced by the service.
^2^ Yandex will [notify](#notifications) you in advance of the changes and the upcoming billing rate increase as per the Agreement.

### Features for each version {#actions-available}

Depending on {{ MY }} version status, the following operations are available for clusters:

| Action | Current (`Actual`) | Supported (`Supported`) | Deprecated (`Deprecated`) | Legacy (`Legacy`) | `EOL` |
| :--- | :---: | :---: | :---: | :---: | :---: |
| Creating new clusters | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) |
| Recovery from a backup | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) |
| Use of existing clusters | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| Possibility of upgrading to a new major version | not applicable | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |

{% note warning %}

Long-term backups (`LTR`) of a {{ MY }} version close to `EOL` may not be available for recovery in {{ mmy-name }} after that version is discontinued. We recommend you to plan data migration before the end of the version lifecycle.

{% endnote %}

## Key principles of the {{ MY }} versioning policy {#key-principles}

The {{ MY }} versioning policy is based on the following key principles:

* **Support duration**. Each LTS version remains `Actual` or `Supported` for eight years thanks to [Percona Extended Support](https://www.percona.com/release-lifecycle-overview/#lifecycle).
* **Incremental deprecation**. In its ninth year, the version gets the `Deprecated` status, making it impossible to create new clusters.
* **Increased cost**^2^. In its tenth year, the version gets the `Legacy Extra Paid` status. Clusters are subject to extra pay; support is limited.
* **End of life**^2^. After the `EOL` date (eleventh year and onwards), no support is provided any longer. Backup recovery is not possible. Clusters are operational but subject to extra pay.

^2^ Yandex will [notify](#notifications) you in advance of the changes and the upcoming billing rate increase as per the Agreement.

## Update policy {#update-policy}

* **Minor updates** (within the major version, e.g., 8.0.34 → 8.0.35) are installed **automatically** as part of maintenance performed during the cluster's stated [maintenance window](./maintenance.md#maintenance-window) or at the customer's request. These updates contain security and bug fixes. A minor update requires a short, successive reboot of the cluster hosts.
* **Major updates** (changes of the major version, e.g., 8.0.x → 8.1.x) take place when the version goes from `Deprecated` to `Legacy`. The scheduled update appears in the {{ yandex-cloud }} interface ahead of time and can be canceled by [contacting]({{ link-console-support }}) support. The `EOL` versions cannot be updated to a new major version. **We highly recommend you to update before the EOL date**.

{% note info "Aspects of Percona Server for {{ MY }}" %}

Thanks to `Extended Support` by Percona, {{ MY }} versions get security updates and bug fixes for a longer period than provided by Oracle {{ MY }} standard support schedule.

{% endnote %}

## Notifications {#notifications}

{{ mmy-name }} provides these early upcoming update notifications:

* When your {{ MY }} version turns `Deprecated` (limitations start to apply), the service will notify you 90 days in advance that you will no longer be able to create new clusters with your current {{ MY }} version, and suggest that your schedule an upgrade of your existing clusters.
* When your {{ MY }} version turns `Legacy` (increased rate starts to apply), the service will notify you 90 days in advance of the upcoming billing rate increase and issue the _end of support_ warning.

Users will be receiving such notifications according to their [notification settings](../../console/operations/update.md#notifications).

### Notifications about scheduled operations {#notifications-on-operations}

The table below sets out the minimum user notification periods for different types of upcoming operations with {{ mmy-name }} clusters.

Type of change | Minimum notification period^3^ | Maximum migration period^4^
--- | --- | ---
Internal version update that requires restarting hosts. | 30 days | 90 days
Internal version update that does not require restarting hosts. | 3 days | 7 days
Internal version update that requires switching the master or blocking write operations. | 14 days | 14 days
Security updates (maximum severity) | 5 days | 2 days
Security updates (high severity) | 14 days | 14 days
Security updates (medium severity) | 21 days | 30 days
Security updates (low severity) | 28 days | 120 days

^3^ Minimum number of days intervening between an upcoming operation and a notification about it from {{ yandex-cloud }}.
^4^ Period of time during which a user can manually reschedule the operation date via the [management console]({{ link-console-main }}).

## Versioning schedule {#version-schedule}

The relevant status of major {{ MY }} versions by Percona is based on the [official Oracle {{ MY }} support schedule](https://www.mysql.com/support/eol-notice.html) and the [Percona Extended Support](https://www.percona.com/release-lifecycle-overview/#lifecycle) schedule.

| Version^5^ | Current (`Actual`) | Supported (`Supported`) | Deprecated (`Deprecated`) | Legacy (`Legacy`) | `EOL` |
| :--- | :---: | :---: | :---: | :---: | :---: |
| **{{ MY }}&nbsp;8.4&nbsp;LTS** | 2024–2029 | 2029–2032 | 2033 | 2034 | 2035 |
| **{{ MY }}&nbsp;8.0&nbsp;LTS** | 2018–2023 | 2023–2028 | 2029 | 2029 | 2030 |
| **{{ MY }}&nbsp;5.7** | — | — | end of&nbsp;2026 | 2027 | end of&nbsp;2027 |

^5^ The exact timeline of transitions between {{ MY }} version statuses will be announced separately. The `EOL` dates match the end of Percona `Extended Support` dates.

{% note info %}

{{ MY }} version 5.7 reached its end of life (`EOL`) in October 2023. Clusters of this version are subject to a forced upgrade in line with the service's policy.

{% endnote %}
