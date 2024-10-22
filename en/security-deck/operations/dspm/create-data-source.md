---
title: Creating a data source in DSPM
description: Follow this guide to create data sources from {{ objstorage-full-name }} buckets using the {{ sd-full-name }} DSPM module.
---

# Creating a DSPM data source

{% include [note-preview-by-request](../../../_includes/note-preview-by-request.md) %}

A [data source](../../concepts/dspm.md#data-source) contains information on the {{ objstorage-full-name }} [bucket](../../../storage/concepts/bucket.md) to scan, along with additional settings.

To create a data source:

{% list tabs group=instructions %}

- {{ sd-name }} interface {#cloud-sd}

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select ![Database-Magnifier](../../../_assets/console-icons/database-magnifier.svg) **Data Security Posture Management** and go to the **Data sources** tab.
  1. In the top-right corner, click **Create source**.
  1. In the **Bucket** field, select an available bucket you want to use as a source of data for scanning.
  1. Under **Selection settings**, specify the scope for the scan:

      * `All files`: The scan will check all the files saved in the bucket.
      * `Files by template`: The scan will check all the bucket files whose names match or do not match the specified templates:

          * **File name contains**: The scan will check files whose names match this template.
          * **File name does not contain**: The scan will ignore files whose names match this template.

          You need to set each template as a [regular expression](https://en.wikipedia.org/wiki/Regular_expression). You can provide templates in both fields, in which case the scan will employ the `AND` logic to select files.

  1. Under **Information about source**, in the **Name** field, indicate the data source name you will use to select this source when [creating a scan](./create-scan.md).

      To use a bucket name as a data source name, click ![Arrows-Rotate-Right](../../../_assets/console-icons/arrows-rotate-right.svg) on the right side of the **Name** field.

  1. Click **Create source**.

{% endlist %}

As a result, the new source will appear in the list of data sources. Now you can select this data source when [creating a scan](./create-scan.md).

#### See also {#see-also}

* [{#T}](./create-scan.md)
* [{#T}](../../concepts/dspm.md)
* [{#T}](../../security/index.md)