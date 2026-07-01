---
title: Managing data analysis in {{ sd-full-name }}
description: Follow this guide to learn about data analysis in {{ sd-full-name }} {{ dspm-name }}.
---

# Managing {{ dspm-name }} data analysis

{% include [analysis-preview-mode](../../../_includes/security-deck/analysis-preview-mode.md) %}

[Data analysis](../../concepts/dspm.md#discovery-mode) is the first stage of {{ dspm-name }} [Data management](../../concepts/dspm.md). It is intended to automatically detect, identify, and catalog resources that may contain sensitive data within a selected [environment](../../concepts/workspace.md).

You can [save](#save-results) the data analysis results to a local file or to a {{ objstorage-full-name }} [bucket](../../../storage/concepts/bucket.md).

## Getting started {#before-begin}

{% include [dspm-before-begin-section](../../../_includes/security-deck/dspm-before-begin-section.md) %}

## Viewing analysis results {#view-results}

The summary for preliminary analysis of resources in the environment is available in the **{{ ui-key.yacloud_org.security.dspm.DspmPageLayout.title_analytics_vaYT5 }}** section of the {{ dspm-name }} module. To see it, do the following:

{% list tabs group=instructions %}

- {{ sd-name }} UI {#console}

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select ![Database-Magnifier](../../../_assets/console-icons/database-magnifier.svg) **{{ ui-key.yacloud_org.security-center.label_dspm }}** and go to the **{{ ui-key.yacloud_org.security.dspm.DspmPageLayout.title_analytics_vaYT5 }}** tab.

      The page displays information about the number and total size of files found in the environment's resources that may potentially contain sensitive data:

      * A list of clouds, folders, and buckets that host objects potentially containing sensitive information.

          The number of files found and their total size are indicated for each cloud, folder, and bucket.
      * Infographics showing the number of files found by type and their size as a percentage.

          Click **{{ ui-key.yacloud_org.security.discovery.AnalyticsDashboard.details_button_1ZfAk }}** to expand the diagram and show more detailed information.
  1. If required, use filters to get specific information about resources and the types of files found in them:

      * Optionally, under **{{ ui-key.yacloud_org.security.discovery.header_resource_kDJFW }}**, select the resources you want analyzed.

          If needed, use the **{{ ui-key.yacloud_org.security.dspm.AnalyticsPage.searchResource_cGkdQ }}** filter to view resources by cloud, folder, or bucket name.
      * Optionally, under **{{ ui-key.yacloud_org.security.dspm.AnalyticsPage.buckets_jwots }}**, select **{{ ui-key.yacloud_org.security.dspm.AnalyticsPage.public_2C56E }}** for the analysis to only display information about objects located in buckets with [public access](../../../storage/concepts/bucket.md#bucket-access).
      * Optionally, under **{{ ui-key.yacloud_org.security.dspm.AnalyticsPage.mediaTypes_r8ro5 }}**, select the [MIME types](https://en.wikipedia.org/wiki/Media_type) of files you want analyzed:

          * `{{ ui-key.yacloud_org.security.dspm.AnalyticsPage.scannable_jWMD6 }}`: Files of all supported MIME types.
          * `Office documents`: Text files of MIME types such as `Text files`, `text/plain`, etc.
          * `Office documents`: Document, table, and presentation files of MIME types such as `application/msword`, `application/vnd.ms-excel`, etc.
          * `PDF documents`: Document files of MIME type `application/pdf`.
          * `Images`: Image files of MIME types such as `image/bmp`, `image/gif`, etc.
          * `Email and messages`: Message files of MIME type `message/rfc822`.
          * `Specialized formats`: Files in specialized formats such as `application/x-x509-cert; format=pem`, etc.

      To reset the applied filters, click ![arrow-rotate-left](../../../_assets/console-icons/arrow-rotate-left.svg) **{{ ui-key.yacloud.common.reset }}**.

{% endlist %}

## Saving analysis results {#save-results}

To save a summary for preliminary analysis of environment resources to a file or bucket:

{% list tabs group=instructions %}

- {{ sd-name }} UI {#console}

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select ![Database-Magnifier](../../../_assets/console-icons/database-magnifier.svg) **{{ ui-key.yacloud_org.security-center.label_dspm }}** and go to the **{{ ui-key.yacloud_org.security.dspm.DspmPageLayout.title_analytics_vaYT5 }}** tab.
  1. Click ![arrow-down-to-line](../../../_assets/console-icons/arrow-down-to-line.svg) **{{ ui-key.yacloud_org.security.dspm.AnalyticsPage.label_export_s4obE }}** and select:

      * ![arrow-down-to-line](../../../_assets/console-icons/arrow-down-to-line.svg) **{{ ui-key.yacloud_org.security.dspm.AnalyticsPage.label_download-analytics_8mgG8 }}** to save the analysis results to a local file.

          In the window that opens, click **{{ ui-key.yacloud.common.download }}**.

          {% note info %}

          You can save no more than 10,000 log lines to a local file. To export a larger number of lines, export the analysis results to a bucket.

          {% endnote %}

      * ![folder-arrow-up-in](../../../_assets/console-icons/folder-arrow-up-in.svg) **{{ ui-key.yacloud_org.security.dspm.AnalyticsPage.label_export-analytics_7ASg9 }}** to save the analysis results to an {{ objstorage-name }} bucket. In the window that opens:

          * In the **{{ ui-key.yacloud_org.security.dspm.label_field-bucket_3mM6u }}** field, select the bucket to save the results to.
          * In the **{{ ui-key.yacloud_org.security.dspm.field_bucket-path_5qRqM }}** field, set the [prefix](../../../storage/concepts/object.md#folder) of the object to save the results to.
          * In the **{{ ui-key.yacloud_org.security.dspm.field_file-name_kWRPK }}** field, specify the name of the file to save the results to. The file will automatically get the `.csv` extension.
          * In the **{{ ui-key.yacloud_org.security.dspm.field_service-account_rTeXv }}** field, select the service account on whose behalf export will be done. You must have the right to use the selected service account, i.e., the `iam.serviceAccounts.user` [role](../../../iam/security/index.md#iam-serviceAccounts-user) or higher, and the service account must have the following roles:
              * [`storage.uploader`](../../../storage/security/index.md#storage-uploader) for the selected bucket.
              * [`kms.keys.encrypter`](../../../kms/security/index.md#kms-keys-encrypter) for the [encryption key](../../../kms/concepts/key.md) if the bucket is [encrypted](../../../storage/concepts/encryption.md).
          * Click **{{ ui-key.yacloud_org.security.dspm.action_button-export_pMSM8 }}** to export the analysis results to the bucket.

              If the selected service account does not have enough permissions for the operation, the information about this will be displayed on the **{{ ui-key.yacloud_org.security.dspm.tab_issues_title_hLQN2 }}** tab.

              Expand the section with information about missing roles, select the service account, and click ![list-check](../../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud_org.security.dspm.ScanForm.table_action_assign_roles_bw4am }}** to grant the lacking permissions to this service account. Then click **{{ ui-key.yacloud_org.security.dspm.action_button-export_pMSM8 }}** again.

{% endlist %}


#### See also {#see-also}

* [{#T}](../../concepts/dspm.md)
* [{#T}](../../concepts/workspace.md)
* [{#T}](./create-data-source.md)
* [{#T}](./create-scan.md)