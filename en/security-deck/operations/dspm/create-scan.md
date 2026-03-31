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
  1. In the left-hand panel, select ![Database-Magnifier](../../../_assets/console-icons/database-magnifier.svg) **{{ ui-key.yacloud_org.security-center.label_dspm }}** and go to the **{{ ui-key.yacloud_org.security-center.dspm.title_scan-jobs }}** tab.
  1. In the top-right corner, click **{{ ui-key.yacloud_org.dspm.scans.label_new-scan }}**.
  1. Under **{{ ui-key.yacloud_org.dspm.scan-jobs.field_data-sources }}**, select a data source with [{{ objstorage-name }}](../../../storage/) buckets.

      If necessary, [create](./create-data-source.md) a new data source.
      
      {% note info %}

      If access to the bucket is controlled by a [policy](../../../storage/security/policy.md#conditional-writes-policy), allow access to the {{ sd-name }} IP addresses in the bucket policy settings. For a list of addresses, see [Public IP address ranges](../../../overview/concepts/public-ips.md#security-deck-ips).

      {% endnote %}

  1. Under **{{ ui-key.yacloud_org.dspm.scans.section_access_title }}**, select the [service account](../../../iam/concepts/users/service-accounts.md) to use for scanning. If you need a new service account, click **{{ ui-key.yacloud_org.iam.folder.service-accounts.dialog_select-service-account_create-new-action }}**.

      {% include [sa-scan-roles-warning](../../../_includes/security-deck/sa-scan-roles-warning.md) %}

  1. Under **{{ ui-key.yacloud_org.dspm.scans.section_search-categories_title }}**, select the [data categories](../../concepts/dspm.md#data-source) to scan for, separately for text and images:

      {% include [scan-data-types](../../../_includes/security-deck/scan-data-types.md) %}

      You can select all the available categories at once or any combination of them.

  1. {% include [scan-settings](../../../_includes/security-deck/scan-settings.md) %}
  1. Click **{{ ui-key.yacloud_org.security.dspm.ScanForm.action_create-scan_dvakP }}**.

  The new scan will appear in the scan list, ready to run.

{% endlist %}


## Creating a scan for {{ yandex-360 }} {#yandex-360}

{% include [note-preview-by-request](../../../_includes/note-preview-by-request.md) %}

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select ![Database-Magnifier](../../../_assets/console-icons/database-magnifier.svg) **{{ ui-key.yacloud_org.security-center.label_dspm }}** and go to the **{{ ui-key.yacloud_org.security-center.dspm.title_scan-jobs }}** tab.
  1. In the top-right corner, click **{{ ui-key.yacloud_org.dspm.scans.label_new-scan }}**.
  1. Under **{{ ui-key.yacloud_org.dspm.scan-jobs.field_data-sources }}**, select the data source with [{{ yandex-360 }}]({{ link-yandex }}/support/yandex-360/business/admin/{{ lang }}/) resources.

      If necessary, [create](./create-data-source.md) a new data source.

  1. Under **{{ ui-key.yacloud_org.dspm.scans.section_search-categories_title }}**, select the [data categories](../../concepts/dspm.md#data-source) to scan for, separately for text and images:

      {% include [scan-data-types](../../../_includes/security-deck/scan-data-types.md) %}

      You can select all the available categories at once or any combination of them.

  1. {% include [scan-settings](../../../_includes/security-deck/scan-settings.md) %}
  1. Click **{{ ui-key.yacloud_org.security.dspm.ScanForm.action_create-scan_dvakP }}**.

  The new scan will appear in the scan list, ready to run.

{% endlist %}


#### See also {#see-also}

* [{#T}](./create-data-source.md)
* [{#T}](../../concepts/dspm.md)
* [{#T}](../../security/index.md)