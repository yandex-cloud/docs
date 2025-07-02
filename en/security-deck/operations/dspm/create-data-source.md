---
title: Creating a data source in {{ dspm-name }}
description: Follow this guide to create data sources from {{ objstorage-full-name }} buckets using the {{ sd-full-name }} {{ dspm-name }} module.
---

# Creating a {{ dspm-name }} data source

{% include [note-preview-by-request](../../../_includes/note-preview-by-request.md) %}

A [data source](../../concepts/dspm.md#data-source) contains information about the {{ objstorage-full-name }} [buckets](../../../storage/concepts/bucket.md) to scan as well as additional settings.

Before you start using {{ dspm-name }}, [set up](../../quickstart-overview.md#configure-sd) the default folder to store {{ sd-name }} data.

To create a data source:

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select ![Database-Magnifier](../../../_assets/console-icons/database-magnifier.svg) **Data Security Posture Management** and go to the **Data sources** tab.
  1. In the top-right corner, click **Create source**.
  1. Add the resources you want to scan to the data source:

      * To add individual buckets, click ![circle-plus](../../../_assets/console-icons/circle-plus.svg) **Select bucket** and select one or more buckets from one or more of your available folders.

          If required, use filters by access settings (`Limited` or `Public`) and by bucket name.
      * To add [clouds](../../../resource-manager/concepts/resources-hierarchy.md#cloud) or [folders](../../../resource-manager/concepts/resources-hierarchy.md#folder) to your data source, click ![circle-plus](../../../_assets/console-icons/circle-plus.svg) **Select cloud or folder** and select all or some of the clouds and/or folders available to you.
      
          All buckets in the selected clouds and/or folders will be added to the data source. In this case, DSPM will scan both the buckets that already exist in these clouds and folders and any other buckets added to them by the time the scan is run. 
  1. Under **Include in selection**, specify one or more scan scopes:

      {% include [datasource-filetypes](../../../_includes/security-deck/datasource-filetypes.md) %}

  1. If you want to add resources with different scan scope selection parameters to the same data source, click **Add resource group** and repeat steps `4` and `5` in the section that appears.

      You can add any number of resource groups to a single data source for scanning.
  1. Under **Information about source**, indicate the data source name you will use to select this source when [creating a scan](./create-scan.md). Follow these naming requirements:
      
      {% include [name-format](../../../_includes/name-format.md) %}

      Click ![Arrows-Rotate-Right](../../../_assets/console-icons/arrows-rotate-right.svg) on the right side of the **Name** field to automatically generate a name for the data source you are creating.
  1. Click **Create source**.

{% endlist %}

As a result, the new source will appear in the list of data sources. Now you can select this data source when [creating a scan](./create-scan.md).

#### See also {#see-also}

* [{#T}](./create-scan.md)
* [{#T}](../../concepts/dspm.md)
* [{#T}](../../security/index.md)