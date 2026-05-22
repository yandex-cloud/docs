---
title: How to configure {{ monium-full-name }} alerts for {{ backup-full-name }} resources
description: Follow this guide to configure {{ monium-name }} alerts for {{ backup-name }} resources.
---

# Configuring {{ monium-full-name }} alerts for {{ backup-full-name }} resources

{% include [alert-definition](../../_includes/monium/alert-definition.md) %}

You can [configure](../../monium/operations/alert/create-alert.md) an alert for any of the [{{ backup-full-name }}](../../backup/) metrics. We recommend creating alerts for the following events:

* A new [{{ backup-name }} agent](../concepts/agent.md) version is out.
* {{ backup-name }} agent unavailable.
* Backup operation failed.

{% note info %}

If a metric has never come to {{ monium-name }} before, the system will not be able to suggest this metric in the pop-up menu of the query builder. In which case enter your query in code mode in the [query language](../../monium/concepts/querying.md).

{% endnote %}


### Available agent versions {#version-available}

To create an alert to get notified about available agent versions:

{% list tabs group=instructions %}

- Management console {#console}

  1. On the [{{ monium-name }}]({{ link-monium }}) home page, select **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.alerts.title }}** on the left.
  1. At the top right, click **{{ ui-key.yacloud_monitoring.homepage.button_alerts-action }}** → **{{ ui-key.yacloud_monitoring.monitoring-alerts.button.create-custom-title }}**.
  1. In the **{{ ui-key.yacloud_monitoring.alert.title_name }}** field, specify `agent_available_new_version`.
  1. Under **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.alert-config }}**:
      1. Click ![image](../../_assets/console-icons/code.svg) to enable code mode.
      1. Enter a query in the query language:

          ```text
          {project = "folder__<folder_ID>", service = "__backup__", cluster = "default", resource_type = "agent", name = "agent_version_available", resource_name = "<VM_name>"}
          ```

          Where:

          * `project`: ID of the folder the VM is in. You can [copy](../../resource-manager/operations/folder/get-id.md) the folder ID on the top panel in the management console.
          * `service`: Service name.
          * `cluster`: Environment.
          * `resource_type`: Resource type.
          * `name`: Metric name.
          * `resource_name`: VM name. To select all VMs, specify `"*"` instead of the VM name.

  1. Under **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.alert-conditions }}**, specify:
      * **{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-table.trigger-condition }}**: `{{ ui-key.yacloud_monitoring.alert.title_comparison-ne }}`.
      * **{{ ui-key.yacloud_monitoring.alert.status_warn }}**: Delete the value.
      * **{{ ui-key.yacloud_monitoring.alert.status_alarm }}**: `0`.

  1. Under **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.notification-channels }}**, add the notification channels of interest.
  1. Click **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.

{% endlist %}


### Agent unavailable {#agent-offline}

To create an alert get notified if the agent is unavailable:

{% list tabs group=instructions %}

- Management console {#console}

  1. On the [{{ monium-name }}]({{ link-monium }}) home page, select **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.alerts.title }}** on the left.
  1. At the top right, click **{{ ui-key.yacloud_monitoring.homepage.button_alerts-action }}** → **{{ ui-key.yacloud_monitoring.monitoring-alerts.button.create-custom-title }}**.
  1. In the **{{ ui-key.yacloud_monitoring.alert.title_name }}** field, specify `agent_status_offline`.
  1. Under **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.alert-config }}**:
      1. Click ![image](../../_assets/console-icons/code.svg) to enable code mode.
      1. Enter a query in the query language:

          ```text
          {project = "folder__<folder_ID>", service = "__backup__", cluster = "default", resource_type = "agent", name = "agent_alive", resource_name = "<VM_name>"}
          ```

          Where:

          * `project`: ID of the folder the VM is in. You can [copy](../../resource-manager/operations/folder/get-id.md) the folder ID on the top panel in the management console.
          * `service`: Service name.
          * `cluster`: Environment.
          * `resource_type`: Resource type.
          * `name`: Metric name.
          * `resource_name`: VM name. To select all VMs, specify `"*"` instead of the VM name.

  1. Under **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.alert-conditions }}**, specify:
      * **{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-table.trigger-condition }}**: `{{ ui-key.yacloud_monitoring.alert.title_comparison-eq }}`.
      * **{{ ui-key.yacloud_monitoring.alert.status_warn }}**: Delete the value.
      * **{{ ui-key.yacloud_monitoring.alert.status_alarm }}**: `0`.

  1. Under **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.notification-channels }}**, add the notification channels of interest.
  1. Click **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.

{% endlist %}


### Backup operation failed {#operation-failure}

To create an alert get notified about failed backup operations:

{% list tabs group=instructions %}

- Management console {#console}

  1. On the [{{ monium-name }}]({{ link-monium }}) home page, select **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.alerts.title }}** on the left.
  1. At the top right, click **{{ ui-key.yacloud_monitoring.homepage.button_alerts-action }}** → **{{ ui-key.yacloud_monitoring.monitoring-alerts.button.create-custom-title }}**.
  1. In the **{{ ui-key.yacloud_monitoring.alert.title_name }}** field, specify `agent_operation_failure`.
  1. Under **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.alert-config }}**:
      1. Click ![image](../../_assets/console-icons/code.svg) to enable code mode.
      1. Enter a query in the query language:

          ```text
          {project = "folder__<folder_ID>", service = "__backup__", cluster = "default", resource_type = "agent", name = "BackupError", action = "CompleteFailed", resource_name = "<VM_name>"}
          ```

          Where:

          * `project`: ID of the folder the VM is in. You can [copy](../../resource-manager/operations/folder/get-id.md) the folder ID on the top panel in the management console.
          * `service`: Service name.
          * `cluster`: Environment.
          * `resource_type`: Resource type.
          * `name`: Metric name.
          * `action`: Action type.
          * `resource_name`: VM name. To select all VMs, specify `"*"` instead of the VM name.

  1. Under **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.alert-conditions }}**, specify:
      * **{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-table.trigger-condition }}**: `{{ ui-key.yacloud_monitoring.alert.title_comparison-gt }}`.
      * **{{ ui-key.yacloud_monitoring.alert.status_warn }}**: Delete the value.
      * **{{ ui-key.yacloud_monitoring.alert.status_alarm }}**: `0`.

  1. Under **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.notification-channels }}**, add the notification channels of interest.
  1. Click **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.

{% endlist %}


#### See also {#see-also}

* [{#T}](get-stats.md)
* [{#T}](../metrics.md)