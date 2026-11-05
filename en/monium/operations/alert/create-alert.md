---
title: Creating an alert
description: Follow this guide to create an alert.
---

# Creating an alert

Alerts monitor metrics and change their [status](*alert-status) when values fall outside the specified thresholds. You can set two thresholds for the same alert: **Warning** for a warning and **Alarm** for a critical error. To receive notifications when the status changes, [create a notification channel](create-channel.md) beforehand. For real-time monitoring, [add an alert widget](../dashboard/add-widget.md) to your dashboard.

This section explains how to create a custom alert and a multialert. {{ monium-name }} also supports [SLO alerts](create-slo-alert.md) and [composite alerts](create-composite-alert.md) whose status is evaluated based on other alerts.

{% include [alert-viewer-role](../../../_includes/monium/alert-viewer-role.md) %}

{% list tabs group=instructions %}

- {{ monium-name }} UI {#console}

  1. On the [{{ monium-name }}]({{ link-monium }}) home page, select ![alt](../../../_assets/console-icons/shield-exclamation.svg) **Alerts and SLOs** → ![alt](../../../_assets/console-icons/megaphone.svg) **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.alerts.title }}** on the left.
  1. At the top right, click **{{ ui-key.yacloud_monitoring.homepage.button_alerts-action }}** → **Custom**.
  1. Specify the main alert parameters:

      {% include [alert-basic-parameters](../../../_includes/monium/alert-basic-parameters.md) %}

  1. Under **Alerts settings**, describe one or more [queries](../../concepts/alerting/alert.md#queries).

      * To search for application metrics, enter the following in the query string:
             
        {% include [application-labels](../../../_includes/monium/application-labels.md) %}
        
      * To search for {{ yandex-cloud }} resource metrics, enter the following in the query string:
        
        {% include [yc-resource-labels](../../../_includes/monium/yc-resource-labels-metrics.md) %}
      
      
      You can use query names as variables in other queries, e.g., `A + B`. Do it by switching the query string to text mode ![code](../../../_assets/console-icons/code.svg).

  1. Under **Trigger conditions**, set the conditions for the alert to get the `Warning` and `Alarm` statuses:

      * **Query for verification**: Query the result of which is processed using the aggregation function.
      * **Aggregation function**: Method for calculating a single value from the query results. For spikes, use **maximum** or **at least one value**; for sustained degradation, use **average** or **all values**.
      * **Comparison function**: Condition for comparing the result with the `Warning` and `Alarm` thresholds. For example, **more** is typically used for API latency, and **less**, for free disk space.
      * **Warning**: Early warning threshold, e.g., `80`% CPU utilization.
      * **Alarm**: Critical error threshold, e.g., `90`% CPU utilization.
      * **Evaluation window**: Interval for calculating the aggregation function. Increase the window to avoid responding to isolated spikes.
      * **Evaluation delay**: Back-shift of the evaluation window. Use it if metrics arrive late or are aggregated with a delay.

      For more on condition parameters, see [{#T}](../../concepts/alerting/alert.md#condition).

  1. Configure [data decimation](../../concepts/alerting/alert.md#decimation) or leave the default values. For peak value alerts, choose `Maximum`; for counters, `Sum` or `Count`. If the state metric changes rarely, select **Previous value** in the **Fill** field.
  1. To create a [multialert](../../concepts/alerting/alert.md#multi-alerts), add labels under **Decomposition by labels**.

      Add labels that require a separate response. For example, if you add decomposition by `disk`, {{ monium-name }} will create subalerts for each disk. Do not use labels with many unique values, e.g., `request_id` or `user_id`, as they can create too many subalerts.

  1. Set the [no data policies](../../concepts/alerting/alert.md#no-data-policy) or leave the default values. For critical metrics, choose the `No data` status to distinguish metric collection failures from normal behavior. If individual instances tend to disappear during autoscaling, use simplified policy application.

  1. Optionally, specify [annotations](../../concepts/alerting/annotation.md) for the alert. Annotations add additional metadata to the alert. You can include this metadata into the notification message or display in the alert widget on your dashboard. For example, you can use annotations to provide metric timestamp and value when the alert triggers or generate a link to a chart.

  1. Optionally, to sort alerts and search for alerts, add labels in `key=value` format.

      You can add multiple labels. Do it by entering a `key=value` pair and clicking **Enter**. To use labels in another alert or the search bar, click **Copy all labels**.

  1. Optionally, under **Links**, add links to related resources.
  1. Configure [notifications](../../concepts/alerting/notification-channel.md). If you do not have a notification channel, [create one](create-channel.md).

      To avoid receiving notifications every time the status changes, enable **Noise suppression**. Set the timeout interval during which {{ monium-name }} will send one notification with the resulting status. Use this setting for unstable metrics, e.g., API latency during brief load spikes. For more on noise suppression, see [{#T}](../../concepts/alerting/alert.md#noise-suppression).

  1. Check the result of evaluating the alert.

      {% include [alert-check-result](../../../_includes/monium/alert-check-result.md) %}

  1. Click **{{ ui-key.yacloud_monitoring.actions.common.create }}**. The alert will appear in the list.

{% endlist %}

[*alert-status]: {% include notitle [alert-statuses-table](../../../_includes/monium/alert-statuses-table.md) %}