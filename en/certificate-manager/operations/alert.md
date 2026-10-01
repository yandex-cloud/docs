---
title: How to add an alert for a certificate in {{ certificate-manager-full-name }}
description: Follow this guide to add an alert about an invalid certificate or upcoming certificate expiration.
---

# Adding an alert for a certificate

You can add alerts for certificate expiration or invalid certificate events.

## Adding an alert about upcoming certificate expiration {#expired}

To create an alert:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) for your alert.
  1. [Navigate]({{ link-monitoring }}) to **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
  1. On the home page, click **{{ ui-key.yacloud_monitoring.homepage.button_alerts-action }}** under **{{ ui-key.yacloud_monitoring.homepage.title_service-features }}**.
  1. Under **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.main-info }}**, specify the main alert parameters:

     * **{{ ui-key.yacloud_monitoring.monitoring-alerts.list-table.name }}**. Name the alert.
     * **{{ ui-key.yacloud_monitoring.monitoring-alerts.label.type }}**. Specify the notification method.
     * Optionally, add a description for the alert.

  1. Set the alert trigger conditions:

     1. Under **{{ ui-key.yacloud_monitoring.alert-template.section.type-settings }}**, start building a query for metric display. In the query construction form, enter the following rows one by one:

        * `service = certificate-manager`.
        * `name = certificate.days_until_expiration`.
        * `certificate = *`. To monitor a specific certificate, specify its ID.
        * Optionally, if you choose more than one certificate, use the `series_min()` function that selects the minimum value.

     1. Under **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.alert-conditions }}**, configure additional alert settings:

        * **{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-table.evaluation-type }}**. The aggregation function applied to the metric values in the time window. The function is calculated using raw metric values before decimation.
        * **{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-table.trigger-condition }}**. The condition is **{{ ui-key.yacloud_monitoring.alert.title_comparison-lte }}**. The number of days for **{{ ui-key.yacloud_monitoring.monitoring-alerts.status.warn }}** is `14`; for **{{ ui-key.yacloud_monitoring.monitoring-alerts.status.alarm }}**, `4`.
        * **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.evaluation-window-key-value }}**. Time window for alert evaluation. For more information, see [Evaluation window](../../monitoring/concepts/alerting/alert.md#evaluation-window).
        * **{{ ui-key.yacloud_monitoring.alert-template.field.delay-key-value }}**. Time window offset into the past. This setting is useful for aggregated metrics since collection of individual metrics within an aggregation pool is distributed over time. For more information, see [Evaluation delay](../../monitoring/concepts/alerting/alert.md#evaluation-delay).

        
        For more information, see [{#T}](../../monitoring/concepts/alerting/alert.md#condition).


     1. Under **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.notification-channels }}**, specify a notification channel. If you do not have a notification channel, [create one](../../monitoring/operations/alert/create-channel.md).
     1. Click **{{ ui-key.yacloud_monitoring.actions.common.create }}**. The alert will appear in the list.

{% endlist %}

## Adding an alert about an invalid certificate {#inoperable}

To create an alert:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) for your alert.
  1. [Navigate]({{ link-monitoring }}) to **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
  1. On the home page, click **{{ ui-key.yacloud_monitoring.homepage.button_alerts-action }}** under **{{ ui-key.yacloud_monitoring.homepage.title_service-features }}**.
  1. Under **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.main-info }}**, specify the main alert parameters:

     * **{{ ui-key.yacloud_monitoring.monitoring-alerts.list-table.name }}**. Name the alert.
     * **{{ ui-key.yacloud_monitoring.monitoring-alerts.label.type }}**. Specify the notification method.
     * Optionally, add a description for the alert.

  1. Set the alert trigger conditions:

     1. Under **{{ ui-key.yacloud_monitoring.alert-template.section.type-settings }}**, start building a query for metric display. In the query construction form, enter the following rows one by one:

        * `service = certificate-manager`.
        * `name = certificate.is_out_of_order`.
        * `certificate = *`. To monitor a specific certificate, specify its ID.
        * Optionally, if you choose more than one certificate, use the `series_sum()` summing function.

     1. Under **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.alert-conditions }}**, configure additional alert settings:

        * **{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-table.evaluation-type }}**. The aggregation function applied to the metric values in the time window. The function is calculated using raw metric values before decimation.
        * **{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-table.trigger-condition }}**. The condition is **{{ ui-key.yacloud_monitoring.alert.title_comparison-gt }}**. The number of invalid certificates for **{{ ui-key.yacloud_monitoring.monitoring-alerts.status.alarm }}** is `0`.
        * **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.evaluation-window-key-value }}**. Time window for alert evaluation. For more information, see [Evaluation window](../../monitoring/concepts/alerting/alert.md#evaluation-window).
        * **{{ ui-key.yacloud_monitoring.alert-template.field.delay-key-value }}**. Time window offset into the past. This setting is useful for aggregated metrics since collection of individual metrics within an aggregation pool is distributed over time. For more information, see [Evaluation delay](../../monitoring/concepts/alerting/alert.md#evaluation-delay).

        
        For more information, see [{#T}](../../monitoring/concepts/alerting/alert.md#condition).


     1. Under **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.notification-channels }}**, specify a notification channel. If you do not have a notification channel, [create one](../../monitoring/operations/alert/create-channel.md).
     1. Click **{{ ui-key.yacloud_monitoring.actions.common.create }}**. The alert will appear in the list.

{% endlist %}
