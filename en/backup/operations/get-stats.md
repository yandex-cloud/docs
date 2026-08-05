---
title: How to view backup statistics in {{ backup-full-name }}
description: Follow this guide to view backup statistics in {{ backup-full-name }}.
---

# Viewing backup statistics


{{ backup-name }} automatically supplies the metrics on the number of [resources to back up](../concepts/index.md#protected-resources) and storage space used for backups to [{{ monitoring-full-name }}](../../monitoring/).

To view the statistics:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) the backup [policy](../concepts/policy.md) was created in.
  1. [Navigate]({{ link-monitoring }}) to **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
  1. Select the dashboard: **{{ backup-name }}**.
  1. In the **Resource name** field, select the resource you want to view statistics for.

     If you select `*` in this field, the dashboard will display generalized statistics for all [resources to back up](../concepts/index.md#protected-resources) in the folder.

  1. Select the statistics time interval.
  1. To refresh the dashboard, click ![](../../_assets/console-icons/arrows-rotate-right.svg). You can also set the auto refresh rate next to this button.

{% endlist %}

{% note tip %}

Other than viewing metrics, you can [set up](configure-alerts.md) alerts to get notified about metric updates.

{% endnote %}

#### Useful links {#see-also}

* [{#T}](configure-alerts.md)
* [{#T}](../metrics.md)
