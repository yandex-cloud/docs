---
title: Sensitive data search in {{ objstorage-name }}
description: Sensitive data search is a tool hat helps to detect sensitive information stored in {{ objstorage-full-name }} buckets for timely action to protect it through access policies, anonymization, etc.
---

# Sensitive data search in {{ objstorage-name }}

{% include [note-preview](../../_includes/note-preview.md) %}

_Sensitive data search_ is a tool powered by [{{ dspm-full-name }}](../../security-deck/concepts/dspm.md) that helps you detect sensitive information stored in {{ objstorage-name }} [buckets](./bucket.md) for timely action to protect it through [access policies](./policy.md), anonymization, etc.

You can [create](../operations/buckets/sensitive-data-search.md) bucket scanning tasks and manage scan results via the {{ objstorage-name }} interface in the [management console]({{ link-console-main }}).

Sensitive data search is subject to the {{ dspm-name }} [pricing policy](../../security-deck/pricing.md#modules-rules).

## Scanning a bucket {#scanning}

Scanning discovers sensitive information within a bucket. To initiate scanning, use a [service account](../../iam/concepts/service-control.md#service-agent).


### Data categories {#data-categories}

When creating a scan, you can specify which data categories to search for. You can target all available categories at once or select specific categories.

Data categories available for scanning:

* `{{ ui-key.yacloud_org.security.dspm.infoTypes.value_personal-data_w5gVm }}`: Full names, email addresses, phone numbers, and social security numbers (SNILS).
* `{{ ui-key.yacloud_org.security.dspm.infoTypes.value_financial-data_kTC5e }}`: Bank card details.
* `{{ ui-key.yacloud_org.security.dspm.infoTypes.value_secrets_4CdGy }}`: Cloud access keys, passwords, tokens, SSH keys, etc.


## Scan results {#results}

After a scan is complete, the system displays its results available for you to [view](../operations/buckets/sensitive-data-search.md#view), [download](../operations/buckets/sensitive-data-search.md#download), or [export](../operations/buckets/sensitive-data-search.md#export).

If an error occur during scanning, you can view diagnostic messages describing the issue under **Messages and errors**. For more information about errors, see [{#T}](limits.md).


## Centralized Data Security Posture Management {#centralized-control}

The {{ objstorage-name }} UI supports sensitive data search in individual buckets. To monitor data in multiple buckets at the folder, cloud, or organization level, use the [{{ dspm-name }}](../../security-deck/concepts/dspm.md) module inside [{{ sd-full-name }}](../../security-deck/). With {{ dspm-name }}, you can aggregate multiple buckets, folders, and clouds into a single [data source](../../security-deck/operations/dspm/create-data-source.md) and set up scheduled scans.


#### Useful links {#see-also}

* [{#T}](../operations/buckets/sensitive-data-search.md)
* [{#T}](../../security-deck/concepts/dspm.md)
* [{#T}](../../security-deck/operations/dspm/create-data-source.md)
