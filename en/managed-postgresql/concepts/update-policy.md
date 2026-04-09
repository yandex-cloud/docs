---
title: '{{ PG }} versioning policy'
description: In this tutorial, you will learn about the {{ PG }} versioning policy in {{ mpg-full-name }}.
---

# {{ PG }} versioning policy

This document describes the lifecycle of [major](#version-lifecycle) {{ PG }} versions in {{ yandex-cloud }}. The policy is based on the {{ PG }} [community's](https://www.postgresql.org/) official support cycle and seeks to strike a balance between stable cluster operation and maintaining a modern, secure infrastructure.

{% note info %}

The new major version (`New`) becomes available shortly after its release by the {{ PG }} [community](https://www.postgresql.org/). At the initial stage, not all functions and extensions may be fully supported. We recommend you to consult the guides for the current list of supported extensions.

{% endnote %}

## {{ PG }} version lifecycle terms and stages {#version-lifecycle}

In {{ mpg-name }}, each major {{ PG }} version has the following **5-year** lifecycle:

| Version status | Description and key [actions](#actions-available) | Period^1^                     |
|:------|:-------------|:----------------------------|
| `New` | Latest version with long-term support (`LTS`). **Recommended for all new projects**.   | First year                  |
| `Supported`  | Previous LTS version. Fully supported; allows creating new clusters. **Recommended for all projects**.  | Years two through four |
| `Deprecated` | Version nearing the end of its support period. The existing clusters operate normally. **Six months before the end of support, an active notification effort starts about the need to update. From this point on, you cannot create new clusters.** | Fifth year                   |
| End of life (EOL) | Discontinued version. **Clusters still running this version get auto-updated to the latest supported version or stopped.** | At the end of five years |

^1^ The periods are relative to the major version release date. The exact status change dates are officially announced by the service.

### Features for each version {#actions-available}

Depending on {{ PG }} version status, the following operations are available for clusters:

| Action | `New` | `Supported` | `Deprecated` | End of life (`EOL`) |
| :--- | :---: | :---: | :---: | :---: |
| Creating new clusters | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) |
| Recovery from a backup | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| Use of existing clusters | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| Choice of the major version update window | N/A | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |

{% note warning %}

Long-term backups (`LTR`) created for versions close to `EOL` may not be available for restoration in {{ mpg-name }} after that version is no longer supported. We recommend you to plan data migration before the end of the version lifecycle.

{% endnote %}

## Key principles of the {{ PG }} versioning policy {#key-principles}

The {{ PG }} versioning policy is based on the following key principles:

* **Support duration**. Each major version remains either `New` or `Supported` for four and a half years.
* **Incremental deprecation**. In its fifth year, the version get the `Deprecated` status, and it becomes impossible to create new clusters six months before the end of life date.
* **Active notification**: **Six months before `EOL`**, {{ mpg-name }} begins an active campaign to notify customers about the need to update.
* **End of life**: On reaching `EOL` (end of fifth year), clusters running obsolete versions get **automatically updated ** to the **latest `Supported` version**. If the update is not possible for technical reasons, the cluster will be stopped. **Before it stops, the final backup will be automatically uploaded to the customer's {{ objstorage-name }} bucket**. After the cluster is stopped and the backup is uploaded, the cluster will be deleted.

## Update policy {#update-policy}

* **Minor updates** (within a major version, e.g., 15.1 → 15.2) are installed automatically as part of maintenance performed during the cluster's specified maintenance window or at the customer's request. These updates contain security and bug fixes. The update requires a short, successive reboot of the cluster hosts.
* **Major updates** (major version changes, e.g., 15.x → 16.x) are user-initiated, except for automatic updates for versions that have reached EOL. **We highly recommend you to update before the EOL date**.

## Automatic update and stopping procedure {#update-eol}
For clusters still running versions with expired support (`EOL`), {{ mpg-name }} initiates an automatic update.

1. **Notification**: Owners of clusters based on `Deprecated` versions will get a series of official email notifications: the first one **6 months** before `EOL`, and then 90 and 30 days before the scheduled start date of the **auto-update** campaign.
1. **Automatic update**: **Three months** before `EOL`, {{ mpg-name }} begins the process of auto-updating clusters that had not been updated by their owners.
1. **Stopping as a final measure**: If an automatic update is not possible, {{ mpg-name }} will stop the cluster. Before it stops, the final backup will be created and saved in the customer's bucket.
1. **Access to data**: Once the cluster is stopped, the responsibility for data is transferred to the customer. You can restore the data only in your own infrastructure, e.g., {{ compute-full-name }} VMs, using the backup you export.

## Notifications {#notifications}

{{ mpg-name }} provides these upcoming update notifications in advance:

* Entering `Deprecated` status (prohibits creating new clusters).
* **Six months** ahead of `EOL` (start of active notification phase).
* Start of the **automatic update** campaign: 90 and 30 days before the start of the campaign.

{% note warning %}

We recommend you to schedule cluster updates in advance before you get your auto-update notifications. This will allow you to choose a convenient time for migration and avoid the risks associated with automatic updates.

{% endnote %}

## Versioning schedule {#version-schedule}

The current status of major {{ PG }} versions is based on the [official support schedule](https://www.postgresql.org/support/versioning/).

| Version^2^ | `New` | `Supported` | `Deprecated` | End of life (`EOL`) |
| :--- | :---: | :---: | :---: |:----------------------------------:|
| **{{ PG }}&nbsp;18** | 2025–2026 | 2025–2029 | 2030 | End of 2030 |
| **{{ PG }}&nbsp;17** | — | 2024–2028 | 2029 | End of 2029 |
| **{{ PG }}&nbsp;16** | — | 2023–2027 | 2028 | End of 2028 |
| **{{ PG }}&nbsp;15** | — | 2022–2026 | 2027 | End of 2027 |
| **{{ PG }}&nbsp;14** | — | — | 2026 | End of 2026 |

^2^ Exact dates of transitions between statuses will be announced additionally. The `EOL` dates match the {{ PG }} community end of support dates.
