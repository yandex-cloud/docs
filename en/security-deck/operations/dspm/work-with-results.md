---
title: Managing scan results in {{ dspm-name }}
description: Follow this guide to learn about the operations you can perform with scan results in {{ sd-full-name }}'s {{ dspm-name }} module.
---

# Managing scan results in {{ dspm-name }}

Once the [scan](../../concepts/dspm.md#scanning) is complete, you can do the following with the results:

* [View](#view)
* [Download](#download)
* [Export](#export)
* [View errors](#errors)
* [Delete](#delete)

## Viewing scan results {#view}

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select ![Database-Magnifier](../../../_assets/console-icons/database-magnifier.svg) **{{ ui-key.yacloud_org.security-center.label_dspm }}** and go to the **{{ ui-key.yacloud_org.security-center.dspm.title_scans }}** tab.
  1. Select a scan.
  1. Sensitive data found during the scan, if any, will be displayed on the **{{ ui-key.yacloud_org.security-center.dspm.scan_results-title }}** tab. The information about each detected object is presented in the following columns:

     * `{{ ui-key.yacloud_org.dspm.scan.label_data-type }}`: Search category of the data, e.g., `FULL-NAME-RU-ML`: Full name.
     * `{{ ui-key.yacloud_org.dspm.scan.label_found-occurrence }}`: Sensitive data found.
     * `{{ ui-key.yacloud_org.dspm.scan.scan-issue_data-source }}`: Data source name.
     * `{{ ui-key.yacloud_org.dspm.scan.results_resource-name }}`: Name of the resource the data was found in.
     * `{{ ui-key.yacloud_org.dspm.scan.scan-issue_object-path }}`: Path to the file the data was found in.

{% endlist %}

## Downloading scan results {#download}

As you download, a CSV file with the scan results is saved locally on your computer.

{% note info %}

The file can contain a maximum of 10,000 sensitive data records. To export a larger number of records, use [export](#export) to {{ objstorage-name }}.

{% endnote %}

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select ![Database-Magnifier](../../../_assets/console-icons/database-magnifier.svg) **{{ ui-key.yacloud_org.security-center.label_dspm }}** and go to the **{{ ui-key.yacloud_org.security-center.dspm.title_scans }}** tab.
  1. To the right of the scan, click ![image](../../../_assets/console-icons/ellipsis.svg) and select ![image](../../../_assets/console-icons/arrow-shape-down-to-line.svg) **{{ ui-key.yacloud_org.dspm.scan.action_download-results }}**.

     Alternatively, go to the scan page, click **{{ ui-key.yacloud_org.common.more }}** ![image](../../../_assets/console-icons/chevron-down.svg), and select ![image](../../../_assets/console-icons/arrow-shape-down-to-line.svg) **{{ ui-key.yacloud_org.dspm.scan.action_download-results }}**.

  1. In the **{{ ui-key.yacloud_org.dspm.scan.header_scan-result_sensitive-data }}** field, specify how to display names, contact information, and other personal data.
  1. Click **{{ ui-key.yacloud_org.dspm.scan.action_button_apply }}**.

{% endlist %}

## Exporting scan results {#export}

When exporting, the file with scan results is saved to the bucket you select.

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select ![Database-Magnifier](../../../_assets/console-icons/database-magnifier.svg) **{{ ui-key.yacloud_org.security-center.label_dspm }}** and go to the **{{ ui-key.yacloud_org.security-center.dspm.title_scans }}** tab.
  1. Click ![image](../../../_assets/console-icons/ellipsis.svg) to the right of the scan and select ![image](../../../_assets/console-icons/folder-arrow-up-in.svg) **{{ ui-key.yacloud_org.dspm.scan.action_export-results }}**.

     Alternatively, go to the scan page, click **{{ ui-key.yacloud_org.common.more }}** ![image](../../../_assets/console-icons/chevron-down.svg), and select ![image](../../../_assets/console-icons/folder-arrow-up-in.svg) **{{ ui-key.yacloud_org.dspm.scan.action_export-results }}**.

  1. In the window that opens, set the export settings:
  
     * In the **{{ ui-key.yacloud_org.security.dspm.label_field-bucket_3mM6u }}** field, select the bucket to save the results to.
     * In the **{{ ui-key.yacloud_org.security.dspm.field_bucket-path_5qRqM }}** field, set the [prefix](../../../storage/concepts/object.md#folder) of the object to save the results to.
     * In the **{{ ui-key.yacloud_org.security.dspm.field_file-name_kWRPK }}** field, specify the name of the file to save the results to. The file will automatically get the `.csv` extension.
     * In the **{{ ui-key.yacloud_org.security.dspm.field_service-account_rTeXv }}** field, select the service account with the `storage.uploader` [role](../../../iam/concepts/access-control/roles.md) for the selected bucket and `kms.keys.encrypter` for the [encryption key](../../../kms/concepts/key.md), if the bucket is [encrypted](../../../storage/concepts/encryption.md).
     * Click **{{ ui-key.yacloud_org.dspm.scan.action_button_export }}** to export the results with parameter validation.

       If the selected service account does not have enough permissions for the operation, the information about this will be displayed on the **{{ ui-key.yacloud_org.security.dspm.tab_issues_title_hLQN2 }}** tab.

       Expand the section with information about missing roles, select the service account, and click ![list-check](../../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud_org.security.dspm.ScanForm.table_action_assign_roles_bw4am }}** to grant the lacking permissions to this service account. Then click **{{ ui-key.yacloud_org.dspm.scan.action_button_export }}** again.

     Alternatively, you can export the results without parameter validation by clicking the **{{ ui-key.yacloud_org.security.dspm.ScanExportDialog.action_button_export_without_validation_pFWLZ }}**. If the selected service account does not have enough permissions for the operation, you will see an error.

{% endlist %}

## Viewing scan errors {#errors}

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select ![Database-Magnifier](../../../_assets/console-icons/database-magnifier.svg) **{{ ui-key.yacloud_org.security-center.label_dspm }}** and go to the **{{ ui-key.yacloud_org.security-center.dspm.title_scans }}** tab.
  1. Select the scan and navigate to the **{{ ui-key.yacloud_org.security-center.dspm.scan-issues-title }}** tab.

  For more information about scanning errors, see [{#T}](../../diagnostics/dspm-diagnostics.md).

{% endlist %}

## Deleting scan results {#delete}

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select ![Database-Magnifier](../../../_assets/console-icons/database-magnifier.svg) **{{ ui-key.yacloud_org.security-center.label_dspm }}** and go to the **{{ ui-key.yacloud_org.security-center.dspm.title_scans }}** tab.
  1. To the right of the scan, click ![image](../../../_assets/console-icons/ellipsis.svg) and select ![image](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.

     Alternatively, go to the scan page, click **{{ ui-key.yacloud_org.common.more }}** ![image](../../../_assets/console-icons/chevron-down.svg), and select ![image](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.

  1. In the window that opens, confirm the deletion.

{% endlist %}