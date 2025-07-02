---
title: Creating a scan in {{ dspm-name }}
description: Follow this tutorial to create scans in {{ sd-full-name }} {{ dspm-name }}.
---

# Creating a {{ dspm-name }} scan

{% include [note-preview-by-request](../../../_includes/note-preview-by-request.md) %}

[Data Security Posture Management](../../concepts/dspm.md) (DSPM) scans [data sources](../../concepts/dspm.md#data-source) to identify sensitive information in buckets.

Before you start using {{ dspm-name }}, [set up](../../quickstart-overview.md#configure-sd) the default folder to store {{ sd-name }} data.

To create a scan:

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select ![Database-Magnifier](../../../_assets/console-icons/database-magnifier.svg) **DSPM** and go to the **Regular scans** tab.
  1. In the top-right corner, click **New scan**.
  1. Under **Data sources**, select the data source you need.

      If necessary, [create](./create-data-source.md) a new data source.
  1. Under **Access to data in sources**, select the [service account](../../../iam/concepts/users/service-accounts.md) to use to run your scans. If you need to create a new service account, click **Create new**.

      {% include [sa-scan-roles-warning](../../../_includes/security-deck/sa-scan-roles-warning.md) %}

  1. Under **Data search categories**, select the [data categories](../../concepts/dspm.md#data-source) to scan for:

      {% include [scan-data-types](../../../_includes/security-deck/scan-data-types.md) %}

      You can select all the available categories at once or any combination of them.
  1. Under **Scan settings**:

      1. In the **Start** field, select the new scan frequency: `Once`, `Every 7 days`, `Every 30 days`, `Every 90 days`, or set a custom frequency by selecting `Custom number of days`.
      1. In the **Scan name** field, specify the name to identify your new scan. Follow these naming requirements:
      
           {% include [name-format](../../../_includes/name-format.md) %}

  1. Click **Create scan**.

{% endlist %}

The new scan will appear in the scan list, ready to run.

#### See also {#see-also}

* [{#T}](./create-data-source.md)
* [{#T}](../../concepts/dspm.md)
* [{#T}](../../security/index.md)