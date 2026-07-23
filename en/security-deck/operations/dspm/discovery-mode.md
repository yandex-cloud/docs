---
title: Managing data analysis in {{ sd-full-name }}
description: Follow this guide to learn about data analysis in {{ sd-full-name }} {{ dspm-name }}.
---

# Managing {{ dspm-name }} data analysis

{% include [analysis-preview-mode](../../../_includes/security-deck/analysis-preview-mode.md) %}

[Data analysis](../../concepts/dspm.md#discovery-mode) is the first stage of {{ dspm-name }} [Data management](../../concepts/dspm.md). The module finds, identifies, and catalogs all {{ objstorage-short-name }} buckets within a selected [workspace](../../concepts/workspace.md).

The analysis starts automatically after you enable {{ dspm-full-name }}.


## Getting started {#before-begin}

{% include [dspm-before-begin-section](../../../_includes/security-deck/dspm-before-begin-section.md) %}


## Viewing analysis results {#view-results}

The summary for preliminary analysis of resources in the environment is available in Interface 2.0 in the **{{ ui-key.yacloud_org.security.dspm.DspmPageLayout.title_analytics_vaYT5 }}** section of the {{ dspm-name }} module. To see it, do the following:

{% list tabs group=instructions %}

- Interface v2.0 {#cloud-sd-v2}

  1. In the left-hand panel, select ![Database-Magnifier](../../../_assets/console-icons/database-magnifier.svg) **{{ ui-key.yacloud_org.security-center.label_dspm }}**.
  1. On the **{{ ui-key.yacloud_org.security-center.dspm.label_dspm }}** page, select `{{ ui-key.yacloud_org.security.dspm.DspmPageLayout.title_prefix_iWUEX }}{{ ui-key.yacloud_org.security.dspm.DspmPageLayout.title_discovery_kkTCM }}` and navigate to the **{{ ui-key.yacloud_org.security.dspm.DspmPageLayout.title_analytics_vaYT5 }}** tab.

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
          * `Documents`:
              * `Text documents`: Text files of MIME types such as `text/plain`, `application/rtf`, etc.
              * `Text processor documents`: Text files of MIME types such as `application/macwriteii`, `application/msword`, etc.
              * `PDF and other documents for printing`: Files of MIME types such as `application/pdf`, `image/vnd.djvu`, etc.
              * `Presentations`: Presentation files of MIME types such as `application/vnd.apple.keynote`, `application/vnd.ms-powerpoint`, etc.
              * `E-books`: Text files of MIME types such as `application/epub+zip`, `application/hwp+zip`, etc.
          * `Graphics and design`:
              * `Raster graphics`: Image files of MIME types such as `image/bmp`, `image/gif`, etc.
              * `Vector graphics`: Image files of MIME types such as `application/coreldraw`, `image/cgm`, etc.
              * `3D models`: Image files of MIME types such as `image/x-3ds`, `model/e57`, etc.
          * `Multimedia`:
              * `Audio files`: Audio files of MIME types such as `audio/32kadpcm`, `audio/3gpp`, etc.
              * `Video files`: Video files of MIME types such as `application/mp4`, `application/mpeg4-generic`, etc.
          * `Code and service files`:
              * `Source code`: Code files of types such as `application/sieve`, `application/x-bat`, etc.
              * `Configuration files`: Configuration files of MIME types such as `text/x-config`, `text/x-ini`, etc.
              * `Certificates and keys`: Secret files of MIME types such as `application/pgp-encrypted`, `application/pgp-keys`, etc.
              * `Executables and binaries`: Service files of MIME types such as `application/applefile`, `application/java-vm`, etc.
          * `Datasets`:
              * `Structured data`: Data files of MIME types such as `application/cbor`, `application/json`, etc.
              * `Table formats`: Table files of MIME types such as `application/vnd.apple.numbers`, `application/vnd.ms-excel`, etc.
              * `Database files`: Database files of MIME types such as `application/vnd.lotus-approach`, `application/vnd.oasis.opendocument.base`, etc.
              * `GIS`: Files of MIME types such as `application/vnd.google-earth.kml+xml`, `application/vnd.google-earth.kmz`, etc.
          * `Archives and containers`: 
              * `Archives`: Archive files of MIME types such as `application/gzip`, `application/java-archive`, etc.
              * `Disk images`: Image files of MIME types such as `application/vnd.msa-disk-image`, `application/x-apple-diskimage`, etc.
          * `Digital communications`:
              * `Web`: Web files of MIME types such as `application/ecmascript`, `text/html`, etc.
              * `Mail and messages`: Files of MIME types such as `application/activemessage`, `message/cpim`, etc.
              * `Fonts`: Font files of MIME types such as `application/font-tdpfr`, `application/x-font-bdf`, etc.
          * `Niche formats`:
              * `Scientific data`: Scientific data files of MIME types such as `application/cellml+xml`, `chemical/x-cdx`, etc.
          * `Medical images`: Files of MIME types such as `application/dicom`.
          * `Miscellaneous`: Other MIME type files. 

      To reset the applied filters, click ![arrow-rotate-left](../../../_assets/console-icons/arrow-rotate-left.svg) **{{ ui-key.yacloud.common.reset }}**.

{% endlist %}

After data analysis detects potentially dangerous resources, click **{{ ui-key.yacloud_org.security.discovery.action_include-in-scan_2wT6B }}** to [create](create-scan.md#cloud-sd-v2) a continuous update scan for them.


## Saving analysis results {#save-results}

To save a summary for preliminary analysis of environment resources to a file or bucket:

{% list tabs group=instructions %}

- Interface v2.0 {#cloud-sd-v2}

  1. In the left-hand panel, select ![Database-Magnifier](../../../_assets/console-icons/database-magnifier.svg) **{{ ui-key.yacloud_org.security-center.label_dspm }}**.
  1. On the **{{ ui-key.yacloud_org.security-center.dspm.label_dspm }}** page, select `{{ ui-key.yacloud_org.security.dspm.DspmPageLayout.title_prefix_iWUEX }}{{ ui-key.yacloud_org.security.dspm.DspmPageLayout.title_discovery_kkTCM }}` and navigate to the **{{ ui-key.yacloud_org.security.dspm.DspmPageLayout.title_analytics_vaYT5 }}** tab.
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


#### Useful links {#see-also}

* [{#T}](../../concepts/dspm.md)
* [{#T}](../../concepts/workspace.md)
* [{#T}](./create-data-source.md)
* [{#T}](./create-scan.md)