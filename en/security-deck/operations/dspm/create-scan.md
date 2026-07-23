---
title: Creating a scan in {{ dspm-name }}
description: Follow this tutorial to create scans in {{ sd-full-name }} {{ dspm-name }}.
---

# Creating a {{ dspm-name }} scan

[{{ dspm-full-name }}](../../concepts/dspm.md) scans {{ objstorage-full-name }} [buckets](../../../storage/concepts/bucket.md) and {{ yandex-360 }} [Yandex Disks]({{ link-yandex }}/support/yandex-360/business/disk/web/{{ lang }}/index.html) for sensitive information in storage.


## Getting started {#before-begin}

{% include [dspm-before-begin-section](../../../_includes/security-deck/dspm-before-begin-section.md) %}


## Creating a scan {#change-scaning}

When {{ dspm-name }} is activated, [data analysis](discovery-mode.md) starts automatically. Based on the results of analysis for buckets, you can create a [continuous update scan](#cloud-sd-v2) in Interface v2.0.

In Interface v1.0, you can create a [regular scan](#cloud-sd-v1) for buckets and disks.

{% list tabs group=instructions %}

- Interface v2.0 {#cloud-sd-v2}

  To create a continuous update scan, create a scan scope:
  
  {% include [create-scan-area](../../../_includes/security-deck/dspm-create-scan-area.md) %}

- Interface v1.0 {#cloud-sd-v1}

  To create a regular scan, you need a [data source](../../concepts/dspm.md#data-source). [Create](create-data-source.md#create-data-source) it beforehand or when creating the scan.

  To create a regular scan for {{ objstorage-name }} or {{ yandex-360 }}:

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select ![Database-Magnifier](../../../_assets/console-icons/database-magnifier.svg) **{{ ui-key.yacloud_org.security-center.label_dspm }}**.
  1. On the **{{ ui-key.yacloud_org.security-center.dspm.label_dspm }}** module page, select `{{ ui-key.yacloud_org.security.dspm.DspmPageLayout.title_prefix_iWUEX }}{{ ui-key.yacloud_org.security.dspm.DspmPageLayout.title_dspm_xm8pa }}` and navigate to the **{{ ui-key.yacloud_org.security-center.dspm.title_scan-jobs }}** tab.
  1. In the top-right corner, click **{{ ui-key.yacloud_org.dspm.scans.label_new-scan }}**.
  1. Under **{{ ui-key.yacloud_org.dspm.scan-jobs.field_data-sources }}**, select the data source: an [{{ objstorage-name }}](../../../storage/) bucket or [{{ yandex-360 }}]({{ link-yandex }}/support/yandex-360/business/admin/{{ lang }}/) disk.
      
      If necessary, [create](./create-data-source.md) a new data source.
      
      {% note info %}

      If access to the bucket is controlled by a [policy](../../../storage/security/policy.md#conditional-writes-policy), allow access to {{ sd-name }} IP addresses in the bucket policy settings. For a list of addresses, see [Public IP address ranges](../../../overview/concepts/public-ips.md#security-deck-ips).

      {% endnote %}

  1. If using a bucket as a source, under **{{ ui-key.yacloud_org.dspm.scans.section_access_title }}**, select the [service account](../../../iam/concepts/users/service-accounts.md) to perform the scan. Click **{{ ui-key.yacloud_components.security.dspm.dialog_select-service-account_create-new-action }}** to create a new service account if you need one.

     {% include [sa-scan-roles-warning](../../../_includes/security-deck/sa-scan-roles-warning.md) %}

  1. Under **{{ ui-key.yacloud_org.dspm.scans.section_search-categories_title }}**, select the [data categories](../../concepts/dspm.md#data-source) to scan for, separately for text and images:

      {% include [scan-data-types](../../../_includes/security-deck/scan-data-types.md) %}

      You can select all the available categories at once or any combination of them.

  1. {% include [scan-settings](../../../_includes/security-deck/scan-settings.md) %}
  1. Click **{{ ui-key.yacloud_org.security.dspm.ScanForm.action_create-scan_dvakP }}**.

  The new scan will appear in the scan list, ready to run.

{% endlist %}

#### Useful links {#see-also}

* [{#T}](../../concepts/dspm.md)
* [{#T}](../../security/index.md)
