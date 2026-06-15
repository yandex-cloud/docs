---
title: '{{ monium-name }} quotas and limits'
description: '{{ monium-name }} has limits and quotas for the number of alerts per cloud and the number of labels per metric (including required ones). For more information about the service limitations, read this article.'
editable: false
---

# {{ monium-name }} quotas and limits

There are restrictions (quotas and limits) on a number of resources in {{ monium-name }}.

{% include [quotes-limits-def.md](../../_includes/quotes-limits-def.md) %}

## Viewing current quotas {#view-quotas}

{% list tabs group=instructions %}

- {{ monium-name }} UI {#console}
  
  1. On the [{{ monium-name }}]({{ link-monium }}) home page, select **Quotas** on the left.
  1. Select the project in the top left or leave the current one.
  1. On the **Project quotas** tab, view the quota values ​​for resource groups.
  1. To view quotas for individual shards, go to the **Distribution by shards** tab on the **Quotas** page.
  1. For each shard, it gives the following values:
     * **Used**: Shard's current resource consumption.
     * **Limit**: Shard's maximum quota.
     * **Utilization**: Share of used quota (consumption to limit ratio). Shows how close current consumption is to the quota.

{% endlist %}

## Changing quotas {#change-quotas}

{% list tabs group=instructions %}

- {{ monium-name }} UI {#console}
  
  1. Make sure your account has the [monium.admin](../security/index.md#monium-admin) or [monium.editor](../security/index.md#monium-editor) role.
  1. On the [{{ monium-name }}]({{ link-monium }}) home page, select **Quotas** on the left.
  1. Select the project in the top left or leave the current one.
  1. On the **Project quotas** tab, in the quota group, click ![image](../../_assets/console-icons/pencil.svg) **Change quota amount**.
  1. In the window that opens, enter new values for the group's quotas.
  1. Click **Create request**.

{% endlist %}

You can increase and decrease quotas.

A quota increase is confirmed automatically but only up to a certain limit. If a higher quota is required, the system will prompt you to contact [support]({{ link-console-support }}) for further approval.

Reducing the quota helps you limit unexpected consumption spikes. For example, after a release, the application started to generate too many logs. In which case you can first reduce the quota and then proceed to investigate the cause, roll back the release, or make a fix. This will help you manage your expenses.

## Resources subject to quotas {#quota-resources}

* **Metrics**:
  * `Metrics Write`: Speed of writing points to shard metrics, in points per second. Once the quota is exhausted, the service will randomly discard points for stored metrics. The charts may start having gaps.
  * `Stored Metrics`: Number of unique metrics (time series). Once the quota is exhausted, new metrics will not be saved. Data will continue to be written to existing metrics.
* **Alerts**:
  * `Alerts Count`: Number of alerts and sub-alerts in the project. Once the quota is exhausted, you will not be able to create new alerts and sub-alerts.
* **Logs**:
  * `Logs Write`: Stream of logs to write, [mebibytes](https://en.wikipedia.org/wiki/Byte#Multiple-byte_units) per second. Once the quota is exhausted, the service will begin randomly discarding incoming logs.
* **Traces**:
  * `Spans Write`: Stream of spans to write, mebibytes per second. Once the quota is exhausted, the service will begin randomly discarding incoming spans. Because of this, some traces may not be fully collected.

## Quotas and limits {#limits-quotas}

### Quotas {#default-quotas}

The table shows the default quota values ​​set for a new project in {{ monium-name }}.

{% include [monium-quotas.md](../../_includes/monium/monium-quotas.md) %}

### Metric and alert limits {#limits-metrics-alerts}

{% include [monium-limits.md](../../_includes/monium/monium-limits.md) %}

### Log limits {#limits-logs}

{% include [logging-limits.md](../../_includes/monium/limits-logs.md) %}

### Trace limits {#limits-traces}

{% include [traces-limits.md](../../_includes/monium/limits-traces.md) %}