---
title: Monitoring the state of a {{ GP }} instance and hosts
description: You can monitor the status of a {{ mgl-name }} instance using the monitoring tools in the management console. These tools display diagnostic information as charts. You can also configure alerts in {{ monitoring-full-name }} to monitor the instance state automatically.
---

# Monitoring {{ mgl-name }} instance status

{% include [note-preview](../../../_includes/note-preview.md) %}

You can view instance status data in the **{{ ui-key.yacloud.common.monitoring }}** tab on the instance page or in [{{ monitoring-full-name }}](../../../monitoring/concepts/index.md).

Diagnostic information about the instance status is visualized in charts. The charts automatically apply the most appropriate multiple measurement units (GB, percentage, etc.).

{% include [alerts](../../../_includes/mdb/alerts.md) %}

## Monitoring instance status {#view-graphs}

To view detailed information about the {{ mgl-name }} instance state:

1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
1. Click the instance name and select the **{{ ui-key.yacloud.common.monitoring }}** tab.
1. {% include [open-in-yandex-monitoring](../../../_includes/mdb/open-in-yandex-monitoring.md) %}

The following charts will open on the page:

* **Data disk**: Amount of used and free space on the data storage disk.
* **System disk**: Amount of used and free space in the system storage.
* **CPU**: Load on processor cores.
* **Memory**: RAM usage. At high loads, the value of the **Available memory** parameter goes down and the **Used memory** values go up.

## Alert settings in {{ monitoring-name }} {#monitoring-integration}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder with the instance you want to configure alerts for.
   1. In the list of services, select ![image](../../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
   1. On the home page, under **{{ ui-key.yacloud_monitoring.homepage.title_service-dashboards }}**, select **Managed Gitlab**.
   1. In the chart you need, click ![options](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.
   1. If the selected chart contains multiple metrics in the **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.alert-config }}** section, you can keep all data queries or only specific ones. For example, for the **System disk** metric, you can remove the redundant free storage space query and keep only the used space query.

      To remove the redundant query, click ![options](../../../_assets/console-icons/ellipsis.svg) → **{{ ui-key.yacloud_monitoring.actions.common.delete }}** in the query row.

      You can learn more about the query language in the [{{ monitoring-name }}](../../../monitoring/concepts/querying.md) documentation.

   1. Set the [alert trigger conditions](../../../monitoring/concepts/alerting/alert.md#condition):

      * Set the query name that will be used to calculate the alert status.

      * Select the aggregation function to apply to metric values in the time window.

      * Select the comparison function t0 compare the aggregation function result with threshold values.

      * Specify the `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.warn }}` and `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.alarm }}` threshold values. Select whether the current chart value should be greater than, less than, or equal to the threshold. 

      * Set the alert calculation time window and delay.

   1. Click **{{ ui-key.yacloud_monitoring.actions.common.create }}**.

{% endlist %}

You can also create alerts for specific {{ mgl-name }} metrics. 

The recommended thresholds are as follows:

The recommended thresholds for the **Remaining free disk space** (`sys.filesystem.FreeB`) metric are as follows:

1. **{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-table.evaluation-type }}**: **Average**.
1. **{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-table.trigger-condition }}**: **Less than or equal to**.
1. **{{ ui-key.yacloud_monitoring.alert-template.threshold-status.alarm }}**: 7% of the storage size.
1. **{{ ui-key.yacloud_monitoring.alert-template.threshold-status.warn }}**: 10% of the storage size.
1. **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.evaluation-window }}**: 5 minutes.
1. **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.time-shift }}**: 30 seconds.

## Instance statuses {#statuses}

The _status_ shows whether the instance is started, stopped, or in intermediate state. You can view the status in the list of {{ mgl-name }} instances or on each instance's page.

The following statuses are possible:

#|
|| **Status** | **Description** | **Suggested actions** ||
|| **CREATING** | Preparing for the first launch | Wait a while and get started. The time it takes to create an instance depends on the host class. ||
|| **RUNNING** | The instance is running normally. | No action is required. ||
|| **STOPPING** | Stopping the instance | After a while, the instance status will change to `STOPPED` and the instance will be disabled. No action is required. ||
|| **STOPPED** | The instance is stopped. | Start the instance to get it running again. ||
|| **STARTING** | Starting the instance that was stopped earlier | After a while, the instance status will change to `RUNNING`. Wait a while and get started. ||
|| **UPDATING** | Updating the instance | After the update is completed, the cluster status will change to `RUNNING`. Wait a while and get started. ||
|| **ERROR** | An error occurred that does not allow the instance to continue working | Run the initial diagnostics:

* Review instance [monitoring charts](#view-graphs).
* On the instance page, under ![image](../../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.common.operations-key-value }}**, view which operations were performed in the instance.

If you cannot find the cause of the error yourself, [contact support]({{ link-console-support }}). ||
|| **STATUS_UNKNOWN** | Instance is unable to determine its own status | Run the initial diagnostics:

* Review instance [monitoring charts](#view-graphs).
* On the instance page, under ![image](../../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.common.operations-key-value }}**, view which operations were performed in the instance.

If you cannot find the cause of the error yourself, contact support. ||
|| **DELETING** | Deleting the instance | Once deleted, the instance will be removed from the **{{ ui-key.yacloud.gitlab.label_instances-title }}** page and will no longer be accessible. No action is required.

When you delete an instance, a backup is automatically created and stored for two weeks. If you need to restore the instance after deletion, contact support. ||
|#
