---
title: Searching for sensitive data in an {{ objstorage-name }} bucket
description: Follow this tutorial to create bucket scans and work with scan results in {{ objstorage-full-name }}.
---

# Searching for sensitive data in a bucket

{% include [note-preview](../../../_includes/note-preview.md) %}

[{{ dspm-full-name }}](../../../security-deck/concepts/dspm.md) scans [buckets](../../../storage/concepts/bucket.md) for [sensitive information](../../concepts/sensitive-data-search.md) in storage. You can create bucket scans and manage scan results in {{ objstorage-name }} via the [management console]({{ link-console-main }}).


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

  1. In the [management console]({{ link-console-main }}), select a folder.
  1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Click the name of the bucket you want to create a scan for.
  1. Go to the **{{ ui-key.yacloud.storage.bucket.switch_security }}** → **{{ ui-key.yacloud.storage.bucket.switch_sensitive-data-search }}** tab.
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

  1. In the [management console]({{ link-console-main }}), select a folder.
  1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Click the name of the bucket in question.
  1. Go to the **{{ ui-key.yacloud.storage.bucket.switch_security }}** → **{{ ui-key.yacloud.storage.bucket.switch_sensitive-data-search }}** tab.
  1. Sensitive data found during the scan, if any, will be displayed on the **{{ ui-key.yacloud.storage.Bucket.BucketSecuritySensitiveDataTab.sub_tab_results }}** tab. The information about each detected object is presented in the following columns:

      * `{{ ui-key.yacloud_org.dspm.scan.label_data-type }}`: Search category of the data, e.g., `FULL-NAME-RU-ML`: Full name.
      * `{{ ui-key.yacloud_org.dspm.scan.label_found-occurrence }}`: Sensitive data found.
      * `Object`: Path to the file the data was found in.

{% endlist %}


## Downloading scan results {#download}

{% include [download-scan-intro](../../../_includes/security-deck/download-scan-intro.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select a folder.
  1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Click the name of the bucket in question.
  1. Navigate to the **{{ ui-key.yacloud.storage.bucket.switch_security }}** → **{{ ui-key.yacloud.storage.bucket.switch_sensitive-data-search }}** tab.
  1. Click ![image](../../../_assets/console-icons/chevron-down.svg) **{{ ui-key.yacloud.shared.layout.PageActions.button_more_sGEBS }}** → **{{ ui-key.yacloud.storage.Bucket.BucketSecuritySensitiveDataTab.button_download_hR9sN }}**.
  1. In the window that opens, specify how to display names, contact information, and other personal data, then click **{{ ui-key.yacloud_components.security.dspm.action_button_apply }}**.

{% endlist %}


## Exporting scan results {#export}

{% include [export-scan-intro](../../../_includes/security-deck/export-scan-intro.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select a folder.
  1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Click the name of the bucket in question.
  1. Navigate to the **{{ ui-key.yacloud.storage.bucket.switch_security }}** → **{{ ui-key.yacloud.storage.bucket.switch_sensitive-data-search }}** tab.
  1. Click ![image](../../../_assets/console-icons/chevron-down.svg) **{{ ui-key.yacloud.shared.layout.PageActions.button_more_sGEBS }}** → **{{ ui-key.yacloud.storage.Bucket.BucketSecuritySensitiveDataTab.button_export_gQ8rM }}**.
  1. In the window that opens, set the export settings:

      * In the **{{ ui-key.yacloud_org.security.dspm.label_field-bucket_3mM6u }}** field, select the bucket to save the results to.
      * In the **{{ ui-key.yacloud_org.security.dspm.field_bucket-path_5qRqM }}** field, set the [prefix](../../concepts/object.md#folder) of the object to save the results to.
      * In the **{{ ui-key.yacloud_org.security.dspm.field_file-name_kWRPK }}** field, specify the name of the file to save the results to. The file will automatically get the `.csv` extension.
      * In the **{{ ui-key.yacloud_org.security.dspm.field_service-account_rTeXv }}** field, select the service account with the `storage.uploader` [role](../../../iam/concepts/access-control/roles.md) for the selected bucket and `kms.keys.encrypter` for the [encryption key](../../../kms/concepts/key.md), if the bucket is [encrypted](../../concepts/encryption.md).
      * Under **{{ ui-key.yacloud_components.security.dspm.header_scan_result_sensitive_data }}**, specify how to display names, contact information, and other personal data.
      * Click **{{ ui-key.yacloud_components.security.dspm.action_export }}** to export the parameter check results.

{% endlist %}


## Viewing scan errors {#errors}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select a folder.
  1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Click the name of the bucket in question.
  1. Navigate to **{{ ui-key.yacloud.storage.bucket.switch_security }}** → **{{ ui-key.yacloud.storage.bucket.switch_sensitive-data-search }}** → **{{ ui-key.yacloud.storage.Bucket.BucketSecuritySensitiveDataTab.sub_tab_issues }}**.

{% endlist %}

{% include [errors-scan-outro](../../../_includes/security-deck/errors-scan-outro.md) %}

[*bucket-object-key]: An [object key](../../concepts/object.md#key) is the full name of a file within a bucket, often formatted as a filesystem path. Here are some examples of keys: `docs/reports/2026/april.pdf`, `photos/trips/paris/img001.jpg`.

[*bucket-object-prefix]: A prefix is the initial part of a key displayed in the UI as a folder. Here are some examples of prefixes: `photos/`, `photos/trips/`, `photos/trips/paris/`.