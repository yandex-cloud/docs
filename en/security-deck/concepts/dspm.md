---
title: Data Security Posture Management in {{ sd-full-name }}
description: Data Security Posture Management, or {{ dspm-name }}, is a {{ sd-name }} module that helps detect sensitive information stored in {{ objstorage-full-name }} buckets, as well as assess its impact on security posture and compliance with regulations and industry standards.
---

# Data Security Posture Management ({{ dspm-name }})

[Data Security Posture Management]({{ link-sd-main }}dspm/), or {{ dspm-name }}, helps quickly detect sensitive information stored in {{ objstorage-full-name }} [buckets](../../storage/concepts/bucket.md) for timely actions to protect it from unauthorized access or leaks, such as configuring [access policies](../../storage/concepts/policy.md), anonymizing data, etc.

## Scanning for sensitive information {#scanning}

{{ dspm-name }} scans _data sources_ for sensitive information in buckets. You can run a scan once or on a schedule.

To run scans for sensitive information, use a [service account](../../iam/concepts/users/service-accounts.md).

To [create a scan](../operations/dspm/create-scan.md), the user must have the `dspm.editor` [role](../../security-deck/security/dspm-roles.md#dspm-editor) for the folder [specified](../quickstart-overview.md#configure-sd) in the {{ sd-name }} settings as the default storage as well as the `iam.serviceAccounts.user` [role](../../iam/security/index.md#iam-serviceAccounts-user) for the service account that will run the scan.

{% include [sa-scan-roles-warning](../../_includes/security-deck/sa-scan-roles-warning.md) %}

Before you start scanning, select a data source and specify the _data categories_ to search for.

### Data source {#data-source}

A data source contains information about the _resources_ to scan, i.e., buckets, [folders](../../resource-manager/concepts/resources-hierarchy.md#folder), and [clouds](../../resource-manager/concepts/resources-hierarchy.md#cloud), as well as additional settings.

When you add folders and clouds to a data source, all buckets in the selected clouds and/or folders will be scanned. In this case, DSPM will scan both the buckets that already exist in these clouds and folders and any other buckets added to them by the time the scan is run. 

You can set the following scan scopes for a data source:

{% include [datasource-filetypes](../../_includes/security-deck/datasource-filetypes.md) %}

You can add multiple buckets, folders, and/or clouds as well as create multiple resource groups with different scan scope settings in a single data source at once. You can also add a bucket to multiple data sources with different scan scope settings at the same time.

### Data categories {#data-categories}

When setting up a new scan, you can specify the category of data to search for. You can select all the available categories at once or any combination of them.

Data categories available for scanning:

{% include [scan-data-types](../../_includes/security-deck/scan-data-types.md) %}

To create data sources, set up and run scans, and view scan results, the user must have the appropriate [roles](../security/index.md).

#### See also {#see-also}

* [{#T}](../operations/dspm/create-data-source.md)
* [{#T}](../operations/dspm/create-scan.md)
