---
title: Creating a scan in {{ dspm-name }}
description: Follow this tutorial to create scans in {{ sd-full-name }} {{ dspm-name }}.
---

# Creating a {{ dspm-name }} scan

[Data Security Posture Management](../../concepts/dspm.md) (DSPM) scans [data sources](../../concepts/dspm.md#data-source) – {{ objstorage-full-name }} [buckets](../../../storage/concepts/bucket.md) and {{ yandex-360 }} [Disks]({{ link-yandex }}/support/yandex-360/business/disk/web/{{ lang }}/index.html) – for sensitive information in storages.

Before you start using {{ dspm-name }}, [set up](../../quickstart-overview.md#configure-sd) the default folder to store {{ sd-name }} data.


## Creating a scan for {{ objstorage-name }} {#object-storage}

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select ![Database-Magnifier](../../../_assets/console-icons/database-magnifier.svg) **DSPM** and go to the **Regular scans** tab.
  1. In the top-right corner, click **New scan**.
  1. Under **Data sources**, select a data source with [{{ objstorage-name }}](../../../storage/) buckets.

      If necessary, [create](./create-data-source.md) a new data source.

  1. Under **Access to data in sources**, select a [service account](../../../iam/concepts/users/service-accounts.md) you are going to use to run the scans. If you need to create a new service account, click **Create new**.

      {% include [sa-scan-roles-warning](../../../_includes/security-deck/sa-scan-roles-warning.md) %}

  1. Under **Data search categories**, select the [data categories](../../concepts/dspm.md#data-source) to scan for:

      {% include [scan-data-types](../../../_includes/security-deck/scan-data-types.md) %}

      You can select all the available categories at once or any combination of them.

  1. {% include [scan-settings](../../../_includes/security-deck/scan-settings.md) %}
  1. Click **Create scan**.

  The new scan will appear in the scan list, ready to run.

{% endlist %}


## Creating a scan for {{ yandex-360 }} {#yandex-360}

{% include [note-preview-by-request](../../../_includes/note-preview-by-request.md) %}

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select ![Database-Magnifier](../../../_assets/console-icons/database-magnifier.svg) **DSPM** and go to the **Regular scans** tab.
  1. In the top-right corner, click **New scan**.
  1. Under **Data sources**, select a data source with [{{ yandex-360 }}]({{ link-yandex }}/support/yandex-360/business/admin/{{ lang }}/) resources.

      If necessary, [create](./create-data-source.md) a new data source.

  1. Under **Data search categories**, select the [data categories](../../concepts/dspm.md#data-source) to scan for:

      {% include [scan-data-types](../../../_includes/security-deck/scan-data-types.md) %}

      You can select all the available categories at once or any combination of them.

  1. {% include [scan-settings](../../../_includes/security-deck/scan-settings.md) %}
  1. Click **Create scan**.

  The new scan will appear in the scan list, ready to run.

{% endlist %}


#### See also {#see-also}

* [{#T}](./create-data-source.md)
* [{#T}](../../concepts/dspm.md)
* [{#T}](../../security/index.md)