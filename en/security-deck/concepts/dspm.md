---
title: '{{ dspm-full-name }} in {{ sd-full-name }}'
description: '{{ dspm-full-name }}, or {{ dspm-name }}, is a {{ sd-name }} module that helps you detect sensitive information stored in {{ objstorage-full-name }} buckets for assessment of its security posture impact and compliance with industry standards and regulations.'
---

# {{ dspm-full-name }} ({{ dspm-name }})

[{{ dspm-full-name }}]({{ link-sd-main }}dspm/), or {{ dspm-name }}, is a tool that helps you quickly detect sensitive information stored in {{ objstorage-full-name }} [buckets](../../storage/concepts/bucket.md) and {{ yandex-360 }} disks for timely action to protect it through [access policies](../../storage/concepts/policy.md), anonymization, etc.

{{ dspm-name }} works in two modes: [continuous change scanning](#change-scaning) based on [data analysis](#discovery-mode) and [regular scanning](#scanning). The management console provides a separate interface to manage each mode.


## Data analysis {#discovery-mode}

{% include [note-interface-v2](../../_includes/security-deck/note-interface-v2.md) %}

The first stage of {{ dspm-name }} is *data analysis*. This step automatically detects, identifies, and catalogs resources that may contain sensitive data within a selected [environment](workspace.md). 

The analysis starts automatically once you enable DSPM when creating or modifying an environment.

The analysis results provide a complete view of data locations across your cloud. Using this information, you can accurately define and add key *scan scopes* for continuous monitoring.

You can [save](../operations/dspm/discovery-mode.md#save-results) the data analysis results to a local file or to a {{ objstorage-full-name }} [bucket](../../storage/concepts/bucket.md).


## Continuous scanning of changes {#change-scaning}

{% include [note-interface-v2](../../_includes/security-deck/note-interface-v2.md) %}

To start scanning, you need to create a scan scope. A scan scope may include multiple resource groups. For each group, you can choose to scan either all environment resources or select specific targets:
* [Clouds](../../resource-manager/concepts/resources-hierarchy.md#cloud) in {{ yandex-cloud }}.
* {{ yandex-cloud }} folders.
* {{ objstorage-name }} buckets.

Optionally, you can configure filters for files within each group:

* Select formats.
* Set minimum and maximum size limits.
* Define a regular expression to target a specific path. 

Additionally, you can select [data categories](#data-categories) for separate searches in text and images.

Once a scan scope is created, {{ dspm-name }} continuously monitors it for new or modified sensitive data, providing ongoing protection.

When you run DSPM for the first time, it performs a full scan of all data stored inside the environment buckets. This may take a while since the scan targets all your data.

Following this initial scan, the module scans only modified or new files. This reduces scanning times and resource usage.


## Regular scanning {#scanning}

{% include [note-interface-v1](../../_includes/security-deck/note-interface-v1.md) %}

{{ dspm-name }} detects sensitive information in buckets and disks by scanning _data sources_. You can run a scan once or on a schedule.

To run scans for sensitive information, use a [service account](../../iam/concepts/users/service-accounts.md).

To [create a scan](../operations/dspm/create-scan.md), the user must have the `dspm.editor` [role](../../security-deck/security/dspm-roles.md#dspm-editor) for the folder [specified](../quickstart-overview.md#configure-sd) in the {{ sd-name }} settings as the default storage as well as the `iam.serviceAccounts.user` [role](../../iam/security/index.md#iam-serviceAccounts-user) for the service account that will run the scan.

{% include [sa-scan-roles-warning](../../_includes/security-deck/sa-scan-roles-warning.md) %}

Before you start scanning, select a data source and specify the _data categories_ to search for.

### Data source {#data-source}

A data source contains settings and information about the _resources_ to scan:

* {{ objstorage-name }} buckets
* {{ yandex-cloud }} [folders](../../resource-manager/concepts/resources-hierarchy.md#folder)
* {{ yandex-cloud }} [clouds](../../resource-manager/concepts/resources-hierarchy.md#cloud)
* Shared {{ yandex-360 }} [disks]({{ link-yandex }}/support/yandex-360/business/disk/web/{{ lang }}/share/shared-disks)
* Shared {{ yandex-360 }} [folders]({{ link-yandex }}/support/yandex-360/business/disk/web/{{ lang }}/share/shared-folders)

When you add folders and clouds to a data source, all buckets of the selected types in your selected clouds and/or folders will be scanned. This includes both the existing buckets and any other buckets added to these clouds and folders by the time of the scan.

You can set the following scan scopes for a data source:

{% include [datasource-filetypes](../../_includes/security-deck/datasource-filetypes.md) %}

You can add multiple buckets, folders, and/or clouds as well as create multiple resource groups with different scan scope settings in a single data source at once. You can also add a bucket to multiple data sources with different scan scope settings at the same time.

## Data categories {#data-categories}

When creating a new scan, you can select data categories separately for text and images.

You can select all the available categories at once or any combination of them.

Data categories available for scanning:

{% include [scan-data-types](../../_includes/security-deck/scan-data-types.md) %}

To create data sources, set up and run scans, and view scan results, the user must have the appropriate [roles](../security/index.md).

### Custom dictionaries {#custom-dictionaries}

{% note info %}

This feature is only available with a [fixed scan volume subscription](../pricing.md#dspm-package-subscription).

{% endnote %}

You can request to add custom keywords and search patterns. This allows you to detect non-standard data, such as:

* Internal documents and corporate secrets.
* Unique product or project IDs.
* Custom confidential data patterns not included in standard classifiers.

To enable a custom dictionary, submit a request when [creating](../operations/dspm/create-scan.md#object-storage) a scan for {{ objstorage-name }}, or via [this form](https://forms.yandex.ru/surveys/13835302.f77819f788eb2cd7df871cd6f8523fe29c5e4c23/). In your request, include your contact information, dictionary name, keyword or regular expression examples and describe the type of data you want this dictionary to detect. Our team will process your request and contact you for details and to inform you of the results.

#### Useful links {#see-also}

* [{#T}](../operations/dspm/create-data-source.md)
* [{#T}](../operations/dspm/create-scan.md)
