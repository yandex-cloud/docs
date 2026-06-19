# Adding an alert for a certificate

You can add alerts for certificate expiration or invalid certificate events.

## Adding an alert about upcoming certificate expiration {#expired}

To create an alert:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) for your alert.
  1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
  1. On the home page, click **{{ ui-key.yacloud_monitoring.homepage.button_alerts-action }}** under **{{ ui-key.yacloud_monitoring.homepage.title_service-features }}**.
  1. Under **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.main-info }}**, specify the main alert parameters:
     * **{{ ui-key.yacloud_monitoring.monitoring-alerts.list-table.name }}**. Name the channel.
     * **{{ ui-key.yacloud_monitoring.monitoring-alerts.label.type }}**. Specify the notification method.
  1. Set the alert trigger conditions:
     1. Under **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.metrics }}**, select the metric to base the alert on:
        * `service = Certificate Manager`.
        * `name = certificate.days_until_expiration`.
        * `certificate = *`. To monitor a specific certificate, specify its ID.
        * Optionally, if you choose more than one certificate, use the `series_min()` function that selects the minimum value.
     1. Under **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.alert-conditions }}**, configure the main and additional alert settings:
        * **{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-table.evaluation-type }}**.
        * **{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-table.trigger-condition }}**. The condition is **{{ ui-key.yacloud_monitoring.alert.title_comparison-lte }}**. The number of days for **{{ ui-key.yacloud_monitoring.monitoring-alerts.status.warn }}** is `14`; for **{{ ui-key.yacloud_monitoring.monitoring-alerts.status.alarm }}**, `4`. 
        * **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.evaluation-window-key-value }}**.

        
        For more information, see [{#T}](../../monitoring/concepts/alerting/alert.md#condition).


     1. Specify the notification channel. If you do not have a notification channel, [create one](../../monitoring/operations/alert/create-channel.md).
     1. Click **{{ ui-key.yacloud_monitoring.actions.common.create }}**. The alert will appear in the list.

{% endlist %}

## Adding an alert about an invalid certificate {#inoperable}

To create an alert:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder for the alert.
  1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
  1. On the home page, click **{{ ui-key.yacloud_monitoring.homepage.button_alerts-action }}** under **{{ ui-key.yacloud_monitoring.homepage.title_service-features }}**.
  1. Under **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.main-info }}**, specify the main alert parameters:
     * **{{ ui-key.yacloud_monitoring.monitoring-alerts.list-table.name }}**. Name the channel.
     * **{{ ui-key.yacloud_monitoring.monitoring-alerts.label.type }}**. Specify the notification method.
  1. Set the alert trigger conditions:
     1. Under **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.metrics }}**, select the metric to base the alert on:
        * `service = Certificate Manager`.
        * `name = certificate.is_out_of_order`.
        * `certificate = *`. To monitor a specific certificate, specify its ID.
        * Optionally, if you choose more than one certificate, use the `series_sum()` summing function.
     1. Under **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.alert-conditions }}**, configure the main and additional alert settings:
        * **{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-table.evaluation-type }}**.
        * **{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-table.trigger-condition }}**. The condition is **{{ ui-key.yacloud_monitoring.alert.title_comparison-gt }}**. The number of invalid certificates for **{{ ui-key.yacloud_monitoring.monitoring-alerts.status.alarm }}** is `0`.
        * **{{ ui-key.yacloud_monitoring.alert.label_evaluation-window }}**.

        
        For more information, see [{#T}](../../monitoring/concepts/alerting/alert.md#condition). 


     1. Specify the notification channel. If you do not have a notification channel, [create one](../../monitoring/operations/alert/create-channel.md).
     1. Click **{{ ui-key.yacloud_monitoring.actions.common.create }}**. The alert will appear in the list.

{% endlist %}