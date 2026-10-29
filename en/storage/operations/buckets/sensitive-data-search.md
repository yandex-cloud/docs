---
title: Searching for sensitive data in an {{ objstorage-name }} bucket
description: Follow this tutorial to create bucket scans and work with scan results in {{ objstorage-full-name }}.
---

# Searching for sensitive data in a bucket

You can search for [sensitive data](../../concepts/sensitive-data-search.md), such as passwords, credit/debit card details, email addresses, and more, in the bucket using [{{ dspm-full-name }}](../../../security-deck/concepts/dspm.md). You can create a bucket scan and manage the results in {{ objstorage-name }} via the [management console]({{ link-console-main }}).

{% note warning %}

Searching for sensitive data in a bucket is a paid operation. A scan initiated from the {{ objstorage-name }} UI is performed by the Data Security Posture Management module ({{ dspm-name }}) of [{{ sd-full-name }}](../../../security-deck/). The cost of scanning is calculated in line with the {{ sd-name }} [pricing policy](../../../security-deck/pricing.md) and is attributed to this service in the usage details.

{% endnote %}


## Getting started {#before-begin}

Make sure the [service account](../../../iam/concepts/service-control.md#service-agent) you will use to scan a bucket and work with scan results has the following roles:

* [`dspm.editor`](../../../security-deck/security/dspm-roles.md#dspm-editor) or higher: Required to create scans.
* [`dspm.admin`](../../../security-deck/security/dspm-roles.md#dspm-admin) or [`dspm.viewer`](../../../security-deck/security/dspm-roles.md#dspm-viewer) or higher: Required to view scan results with masked or public data, respectively.
* [`dspm.viewer`](../../../security-deck/security/dspm-roles.md#dspm-viewer) or higher: Required to download scan results.
* [`dspm.viewer`](../../../security-deck/security/dspm-roles.md#dspm-viewer) or higher: Required to export results. Also the service account that will perform the export must have write permissions for the target bucket.

## Creating a {#create} scan

{% note tip %}

The {{ objstorage-name }} UI allows you to scan individual buckets for sensitive data. To monitor data in multiple buckets at the folder, cloud, or organization level, use the [{{ dspm-name }}](../../../security-deck/concepts/dspm.md) module inside [{{ sd-full-name }}](../../../security-deck/).

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder.
  1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Click the name of the bucket you want to create a scan for.
  1. Navigate to the **{{ ui-key.yacloud.storage.bucket.switch_security }}** tab, then to **{{ ui-key.yacloud.storage.bucket.switch_sensitive-data-search }}**.
  1. Click **{{ ui-key.yacloud.storage.Bucket.BucketSecuritySensitiveDataTab.button_run_scan_af4cy }}**.

      {% note info %}

      If access to the bucket is controlled by a [policy](../../security/policy.md#conditional-writes-policy), allow access to {{ sd-name }} IP addresses in the bucket policy settings. For a list of addresses, see [Public IP address ranges](../../../overview/concepts/public-ips.md#security-deck-ips).

      {% endnote %}

  1. Under **{{ ui-key.yacloud.storage.Bucket.BucketSecurityScanForm.title_profiles }}**, select the [data categories](../../../security-deck/concepts/dspm.md#data-source) to scan for. You can select all the available categories at once or any combination of them.

  1. Optionally, under **{{ ui-key.yacloud.storage.Bucket.BucketSecurityScanForm.title_file-filter }}**, specify the [object keys](*bucket-object-key) or [prefixes](*bucket-object-prefix) to include in the scan. By default, the scan targets all supported file formats.

      {% note info %}

      Currently, you cannot scan objects encrypted with a [{{ kms-short-name }} key](../../../kms/concepts/key.md).

      {% endnote %}

  1. Click **{{ ui-key.yacloud.storage.Bucket.BucketSecurityScanForm.button_submit }}**.

  The scan will start automatically. To repeat the scan, click **{{ ui-key.yacloud.storage.Bucket.BucketSecuritySensitiveDataTab.button_repeat_scan_fN7pL }}**.

{% endlist %}


## Viewing scan results {#view}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder.
  1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Click the name of the bucket in question.
  1. Navigate to the **{{ ui-key.yacloud.storage.bucket.switch_security }}** tab, then to **{{ ui-key.yacloud.storage.bucket.switch_sensitive-data-search }}**.
  1. Sensitive data found during the scan, if any, will be displayed on the **{{ ui-key.yacloud.storage.Bucket.BucketSecuritySensitiveDataTab.sub_tab_results }}** tab. The information about each detected object is presented in the following columns:

      * `{{ ui-key.yacloud_org.dspm.scan.label_data-type }}`: Search category of the data, e.g., `FULL-NAME-RU-ML`: Full name.
      * `{{ ui-key.yacloud_org.dspm.scan.label_found-occurrence }}`: Sensitive data found.
      * `Object`: Path to the file the data was found in.

{% endlist %}


## Downloading scan results {#download}

{% include [download-scan-intro](../../../_includes/security-deck/download-scan-intro.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder.
  1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Click the name of the bucket in question.
  1. Navigate to the **{{ ui-key.yacloud.storage.bucket.switch_security }}** tab, then to **{{ ui-key.yacloud.storage.bucket.switch_sensitive-data-search }}**.
  1. Click **{{ ui-key.yacloud.shared.layout.PageActions.button_more_sGEBS }}** ![chevron-down](../../../_assets/console-icons/chevron-down.svg) and select ![arrow-down-to-line](../../../_assets/console-icons/arrow-down-to-line.svg) **{{ ui-key.yacloud.storage.Bucket.BucketSecuritySensitiveDataTab.button_download_hR9sN }}**.
  1. In the window that opens, specify how to display names, contact information, and other personal data, then click **{{ ui-key.yacloud_components.security.dspm.action_button_apply }}**.

{% endlist %}


## Exporting scan results {#export}

{% include [export-scan-intro](../../../_includes/security-deck/export-scan-intro.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder.
  1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Click the name of the bucket in question.
  1. Navigate to the **{{ ui-key.yacloud.storage.bucket.switch_security }}** tab, then to **{{ ui-key.yacloud.storage.bucket.switch_sensitive-data-search }}**.
  1. Click **{{ ui-key.yacloud.shared.layout.PageActions.button_more_sGEBS }}** ![chevron-down](../../../_assets/console-icons/chevron-down.svg) and select ![folder-arrow-up-in](../../../_assets/console-icons/folder-arrow-up-in.svg) **{{ ui-key.yacloud.storage.Bucket.BucketSecuritySensitiveDataTab.button_export_gQ8rM }}**.
  1. In the window that opens, set the export settings:

      * In the **{{ ui-key.yacloud_components.security.dspm.label_field_bucket }}** field, select the bucket to save the results to.
      * In the **Path to bucket** field, set the [prefix](../../concepts/object.md#folder) of the object to save the results to.
      * In the **{{ ui-key.yacloud_components.security.dspm.field_file_name }}** field, specify the name of the file to save the results to. The file will automatically get the `.csv` extension.
      * In the **{{ ui-key.yacloud_components.security.dspm.field_service_account }}** field, select the service account with the `storage.uploader` [role](../../../iam/concepts/access-control/roles.md) for the selected bucket and `kms.keys.encrypter` for the [encryption key](../../../kms/concepts/key.md), if the bucket is [encrypted](../../concepts/encryption.md).
      * Under **{{ ui-key.yacloud_components.security.dspm.header_scan_result_sensitive_data }}**, specify how to display names, contact information, and other personal data.
      * Click **{{ ui-key.yacloud_components.security.dspm.action_export }}** to export the parameter check results.

{% endlist %}


## Viewing scan errors {#errors}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder.
  1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Click the name of the bucket in question.
  1. Navigate to the **{{ ui-key.yacloud.storage.bucket.switch_security }}** tab, then to **{{ ui-key.yacloud.storage.bucket.switch_sensitive-data-search }}**, and then to **{{ ui-key.yacloud.storage.Bucket.BucketSecuritySensitiveDataTab.sub_tab_issues }}**.

{% endlist %}

{% include [errors-scan-outro](../../../_includes/security-deck/errors-scan-outro.md) %}

#### Useful links {#see-also}

* [{#T}](../../concepts/sensitive-data-search.md)
* [{#T}](../../../security-deck/concepts/dspm.md)
* [{#T}](../../../security-deck/operations/dspm/create-data-source.md)

[*bucket-object-key]: An [object key](../../concepts/object.md#key) is the full name of a file within a bucket, often formatted as a filesystem path. Here are some examples of keys: `docs/reports/2026/april.pdf`, `photos/trips/paris/img001.jpg`.

[*bucket-object-prefix]: A prefix is the initial part of a key displayed in the UI as a folder. Here are some examples of prefixes: `photos/`, `photos/trips/`, `photos/trips/paris/`.
