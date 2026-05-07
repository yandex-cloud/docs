---
title: '{{ VLK }} versioning policy'
description: In this tutorial, you will learn about the {{ VLK }} versioning policy in {{ mrd-full-name }}.
---

# {{ VLK }} versioning policy

The _{{ VLK }} versioning policy_ is aimed at providing users with extended support for [{{ VLK }}](./index.md) versions allowing to use well-proven DBMS versions longer.

The {{ mrd-full-name }} versioning policy is based on the [compatibility guarantee](./index.md#compatibility-warranty) that allows selecting a version _compatible with_ a specific version rather than selecting a specific {{ VLK }} version itself. The versioning policy applies to all new clusters created in {{ mrd-name }}.

{% note info %}

Until the end of 2026, all clusters that had been created before this policy was introduced will have been switched to it and upgraded via [maintenance](./maintenance.md) tasks:

* Clusters with version `7.2`: To a version [compatible with {{ VLK }} 7.2](#compatibility-table).
* Clusters with version `8.0`: To a version [compatible with {{ VLK }} 8.0](#compatibility-table).
* Clusters with version `8.1`: To a version [compatible with {{ VLK }} 8.1](#compatibility-table).
* Clusters with version `9.0`: To a version [compatible with {{ VLK }} 9.0](#compatibility-table).

The upgrades will run automatically during maintenance [windows](./maintenance.md#maintenance-window) using scheduled tasks **with 90-days advance notifications sent to the user**.

{% endnote %}

## Stages of the compatible version lifecycle {#lifecycle-stages}

For every {{ VLK }} version that has a [compatible](./index.md#compatibility-warranty) version in the {{ yandex-cloud }} implementation, the service maintains its support for no less than the support duration of the latest compatible version as per the official {{ VLK }} lifecycle.

Version stage | Description and key [actions](#actions-available) | Period
--- | --- | ---
Full support (`Supported`) | The version is fully supported. **Recommended for new projects.** | Lasts until the support for the latest compatible version is discontinued, but no less than the official {{ VLK }} support for this version.
`Deprecated` | Support for the version will be discontinued soon. **Creating new clusters is unavailable. The existing clusters operate normally.** | Six months
`Legacy` | Support for the version was officially discontinued. **Clusters operate normally, but are billed at an increased rate. Technical support is limited.** | Six months
End of life (`EOL`) | Discontinued version. **Technical support is not provided. Clusters operate normally, but are billed at an increased rate.** | N/A

### Features for each version stage {#actions-available}

#|
||
**Action** | **Full support (`Supported`)** {.cell-align-top-center} | **`Deprecated`** {.cell-align-top-center} | **`Legacy`** {.cell-align-top-center} | **End of life (`EOL`)** {.cell-align-top-center}
||
||
Creating new clusters | ![yes](../../_assets/common/yes.svg) {.cell-align-center} | ![no](../../_assets/common/no.svg) {.cell-align-center} | ![no](../../_assets/common/no.svg) {.cell-align-center} | ![no](../../_assets/common/no.svg) {.cell-align-center}
||
||
Recovery from a backup | ![yes](../../_assets/common/yes.svg) {.cell-align-center} | ![yes](../../_assets/common/yes.svg) {.cell-align-center} | ![yes](../../_assets/common/yes.svg) {.cell-align-center} | ![no](../../_assets/common/no.svg) {.cell-align-center}
||
||
Use of existing clusters | ![yes](../../_assets/common/yes.svg) {.cell-align-center} | ![yes](../../_assets/common/yes.svg) {.cell-align-center} | ![yes](../../_assets/common/yes.svg) {.cell-align-center} | ![yes](../../_assets/common/yes.svg) {.cell-align-center}
||
||
Support | ![yes](../../_assets/common/yes.svg) {.cell-align-center} | ![yes](../../_assets/common/yes.svg) {.cell-align-center} | limited {.cell-align-center} | ![no](../../_assets/common/no.svg) {.cell-align-center}
||
||
Pricing | standard {.cell-align-center} | standard {.cell-align-center} | increased^1^ {.cell-align-center} | increased^1^ {.cell-align-center}
||
|#

^1^ {{ yandex-cloud }} will [notify](#notifications) you in advance when a version billing starts or about upcoming changes as per the agreement.

### Version support periods {#support-periods}

Version type | Support period | Note
--- | --- | ---
Compatible versions | Extended support (longer than the official {{ VLK }} support). Versions are automatically updated to the latest compatible one. | The support duration is until the end of support for the latest compatible version.
Minor versions | Automatic update | {{ VLK }} backward-compatibility guarantee
Fixed versions | Automatic update | Secure bug fixes

### Version compatibility {#compatibility-table}

Currently, {{ mrd-name }} provides^2^ the following compatibility with original {{ VLK }} versions:

Compatibility with a version | Actual version | Compatibility guarantee | Stage | First release date | Scheduled full support expiry date^3^
--- | --- | --- | --- | --- | ---
**{{ VLK }} `7.2`** | {{ VLK }} `8.1` | Full compatibility with version `7.2` | Full support | 16.04.2024 | 31.03.2028
**{{ VLK }} `8.0`** | {{ VLK }} `8.1` | Full compatibility with version `8.0` | Full support | 15.09.2024 | 31.03.2028
**{{ VLK }} `8.1`** | {{ VLK }} `8.1` | Full compatibility with version `8.1` | Full support | 31.03.2025 | 31.03.2028
**{{ VLK }} `9.0`** | {{ VLK }} `9.0` | Full compatibility with version `9.0` | Full support | 21.10.2025 | 21.10.2028

^2^ As new DBMS versions are released, information in the table will be updated.
^3^ Support will be discontinued no earlier than the specified date.

## Key principles of the {{ VLK }} versioning policy {#key-principles}

The {{ VLK }} versioning policy is based on the following key principles:

* **Extended version support**. {{ mrd-name }} provides time-extended {{ VLK }} version support, where each version is supported longer than the official period due to compatibility with new {{ VLK }} versions.
* **Compatibility guarantee**. The service provides extended support with a guarantee of full compatibility with the selected {{ VLK }} version.
* **Proven compatibility**. Each DBMS implementation by {{ yandex-cloud }} is [tested](#compatibility-testing) for compatibility with the target version. Updates are only applied in case the tests are passed successfully and completely.
* **Active participation in {{ VLK }} development**. {{ yandex-cloud }}'s commitment to {{ VLK }} development allows the {{ mrd-name }} team to have a thorough understanding of the platform and ensure compatibility based on newer and more efficient implementations.
* **Automatic improvements**. Users automatically get the benefits of new versions without the need to migrate.
* **Security and performance**. Regular updates to current versions ensure the highest security and performance.

## Update policy {#update-policy}

{{ mrd-full-name }} can automatically update {{ yandex-cloud }}'s {{ VLK }} implementation that works on your cluster without changing the target compatibility version. Such updates include:

* Updates to newer versions with [guaranteed compatibility](#compatibility-warranty) preserved.
* Specific configuration adjustments to ensure backward compatibility.
* Compatibility mode with adapted performance parameters.
* Additional [checks](#compatibility-testing) on the {{ mrd-name }} side to monitor application behavior.

{% note tip %}

When updating the DBMS implementation, the cluster's target compatibility version will not change, and your app will continue to operate without the need to modify it. If required, you can [contact]({{ link-console-support }}) support for details about an update.

{% endnote %}

### Discontinuation of updates {#update-termination}

Updates of the DBMS implementation are discontinued once it becomes impossible to support compatibility with newer {{ VLK }} versions. In this case, the version is supported until the end of support for the latest original compatible {{ VLK }} version.

## Notifications {#notifications}

{{ mrd-full-name }} will notify you in advance about upcoming changes related to the cluster’s current {{ VLK }} version switching to another [stage](#lifecycle-stages):

* When your cluster's {{ VLK }} version switches to **Deprecated** (and the limitations start to apply), the service will notify you 90 days in advance that creating new clusters with this version will no longer be available and will offer you to schedule an upgrade of the existing clusters to the {{ VLK }} version compatible with the newer fully supported version.
* When your cluster's {{ VLK }} version switches to **Legacy** (and the increase billing rate starts to apply), the service will notify you 90 days in advance about the upcoming version support expiry and the application of an increased billing rate to such clusters.

Users will get such update notifications according to their [notification settings](../../console/operations/update.md#notifications).

### Notifications about scheduled operations {#notifications-on-operations}

The table below sets out the periods for notifying users about different types of upcoming operations with {{ mrd-full-name }} clusters.

Type of change | Minimum notification period^4^ | Maximum migration period^5^
--- | --- | ---
Internal version update that requires restarting hosts. | 30 days | 90 days
Internal version update that does not require restarting hosts. | 3 days | 7 days
Internal version update that requires switching the master or blocking write operations. | 14 days | 14 days
Security updates (maximum severity) | 5 days | 2 days
Security updates (high severity) | 14 days | 14 days
Security updates (medium severity) | 21 days | 30 days
Security updates (low severity) | 28 days | 120 days

^4^ Minimum number of days intervening between an upcoming operation and a notification about it from {{ yandex-cloud }}.
^5^ Period of time during which a user can manually reschedule the operation date via the [management console]({{ link-console-main }}).
