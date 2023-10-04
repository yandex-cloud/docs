# Creating alerts

1. On the {{ monitoring-short-name }} home page, click **{{ ui-key.yacloud_monitoring.homepage.button_alerts-action }}**.
1. Specify the main parameters of the alert:

   * **{{ ui-key.yacloud_monitoring.alert.title_name }}**. Enter the name of the alert.
   * **{{ ui-key.yacloud_monitoring.alert.title_description }}**. Describe the purpose of the alert.

1. Describe [queries](../../concepts/alerting/alert.md#queries).
1. Configure the [conditions to trigger the alert](../../concepts/alerting/alert.md#condition):

   * **{{ ui-key.yacloud_monitoring.monitoring-alerts.label.query-to-check }}**
   * **{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-table.evaluation-type }}**
   * **{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-table.trigger-condition }}**
   * **{{ ui-key.yacloud_monitoring.monitoring-alerts.status.warn }}** and **{{ ui-key.yacloud_monitoring.monitoring-alerts.status.alarm }}** trigger thresholds
   * **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.evaluation-window }}**
   * **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.time-shift }}**

   For more information, see [{#T}](../../concepts/alerting/alert.md#condition).

1. Set the [no data policies](../../concepts/alerting/alert.md#no-data-policy) or leave the default values.
1. Specify alert [annotations](../../concepts/alerting/annotation.md).
1. Configure [notifications](../../concepts/alerting/notification-channel.md). If you do not have a notification channel, [create one](create-channel.md).
1. Click **{{ ui-key.yacloud_monitoring.actions.common.create }}**. Your alert will appear in the list.
