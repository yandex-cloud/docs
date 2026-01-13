---
title: Creating a data source in {{ dspm-name }}
description: Follow this guide to create data sources from {{ objstorage-full-name }} buckets and Yandex Disks in {{ yandex-360 }} using the {{ sd-full-name }} {{ dspm-name }} module.
---

# Creating a {{ dspm-name }} data source

{% include [note-preview-by-request](../../../_includes/note-preview-by-request.md) %}

A [data source](../../concepts/dspm.md#data-source) contains information about the storages to scan and additional settings. The available storages are {{ objstorage-full-name }} [buckets](../../../storage/concepts/bucket.md) and [Yandex Disk]({{ link-yandex }}/support/yandex-360/business/disk/web/{{ lang }}/index.html) in {{ yandex-360 }}. You cannot use both [{{ objstorage-name }}](../../../storage/) and [{{ yandex-360 }}]({{ link-yandex }}/support/yandex-360/business/admin/{{ lang }}/) storage in the same data source.

Before you start using {{ dspm-name }}, [set up](../../quickstart-overview.md#configure-sd) the default folder to store {{ sd-name }} data.


## Creating a data source for {{ objstorage-name }} {#object-storage}

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

  1. If you want to add resources with different scan scope selection settings to the same data source, click **Add resource group** and repeat steps `4` and `5` in the section that appears.

      You can add any number of resource groups to a single data source for scanning.

  1. {% include [source-info](../../../_includes/security-deck/source-info.md) %}
  1. Click **Create source**.

  As a result, the new source will appear in the list of data sources. Now you can select this data source when [creating a scan](./create-scan.md).

{% endlist %}


## Creating a data source for {{ yandex-360 }} {#yandex-360}

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select ![Database-Magnifier](../../../_assets/console-icons/database-magnifier.svg) **Data Security Posture Management** and go to the **Data sources** tab.
  1. In the top-right corner, click **Create source**.
  1. Select **{{ yandex-360 }}**.
  1. Click **Configure connection** and configure integration with the {{ yandex-360 }} organization:
      1. Specify the [Organization 360]({{ link-yandex }}/support/yandex-360/business/admin/{{ lang }}/org-admin) ID.

          You can look up the ID in your [company profile](https://admin.yandex.com/company-profile) in the organization administrator account.

      1. Enter the [OAuth token]({{ ya-oauth-url }}/authorize?response_type=token&client_id=c0e37287a72a43658011f68ef6e70def).
      1. Optionally, to provide access to custom resources, e.g., to scan custom disks, [create]({{ link-yandex }}/support/yandex-360/business/admin/{{ lang }}/security-service-applications) a service application and specify the following properties:
          * **ClientID**
          * **Client secret**

          {% note info %}

          This feature is not available for the {{ yandex-360 }} Minimum [plan]({{ link-yandex }}/support/yandex-360/business/purchase/{{ lang }}/plans/payment-plans-ru).

          {% endnote %}

      1. Click **Save**.

  1. Add the resources you want to scan to the data source:
      * To add shared disks to your organization, under **Organization resources**, click **Add resources**. Select or deselect disks as appropriate in one or more folders.
      * To add custom disks to the data source, in the **Custom resources** section, click **Add resources**. Select or deselect custom disks as appropriate.
      * To add all available disks to the data source, click **All disks** under **Shared resources** or **Custom resources**. The scan will include not only the disks existing in the selected organization when the data source is created, but also disks added later (by the time of the scan).

  1. Under **Include in selection**, specify one or more scan scopes:

      {% include [datasource-filetypes](../../../_includes/security-deck/datasource-filetypes.md) %}

  1. If you want to add resources with different scan scope selection settings to the same data source, click **Add resources** and repeat steps `6` and `7` in the section that appears.

      You can add any number of resource groups to a single data source for scanning.

  1. {% include [source-info](../../../_includes/security-deck/source-info.md) %}
  1. Click **Create source**.

  As a result, the new source will appear in the list of data sources. Now you can select this data source when [creating a scan](./create-scan.md).

{% endlist %}

#### See also {#see-also}

* [{#T}](./create-scan.md)
* [{#T}](../../concepts/dspm.md)
* [{#T}](../../security/index.md)