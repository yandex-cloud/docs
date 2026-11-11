---
title: Creating an SLO alert
description: Follow this guide to create an SLO alert.
---

# Creating an SLO alert

SLO alerts monitor metrics for the selected [SLO](../../slo/index.md), including the remaining [error budget](../../slo/index.md#basic-terms), actual error budget consumption, and burn rate. Use these alerts to promptly detect the risk of SLO breach and assess the incident’s impact on the service reliability.

Before creating an SLO alert, [create and configure the SLO](../../slo/management.md#config). For **Burn Rate** alerts, make sure to [enable the burn rate calculation](../../slo/management.md#burn-rate) in the source SLO. Otherwise, the alert will enter the `No data` status.

{% include [alert-viewer-role](../../../_includes/monium/alert-viewer-role.md) %}

{% list tabs group=instructions %}

- {{ monium-name }} UI {#console}

  1. On the [{{ monium-name }}]({{ link-monium }}) home page, select ![alt](../../../_assets/console-icons/shield-exclamation.svg) **Alerts and SLOs** → ![alt](../../../_assets/console-icons/megaphone.svg) **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.alerts.title }}** on the left.
  1. At the top right, click **{{ ui-key.yacloud_monitoring.homepage.button_alerts-action }}** → **{{ ui-key.yacloud_monitoring.monitoring-alerts.button.create-slo-title }}**.
  1. Specify the main alert parameters:

      {% include [alert-basic-parameters](../../../_includes/monium/alert-basic-parameters.md) %}

  1. In the **{{ ui-key.yacloud_monitoring.monitoring-alerts.label.slo-alert-type }}** field, select:

      * **{{ ui-key.yacloud_monitoring.monitoring-alerts.slo-type.error-budget-key-value }}**: Monitors the remaining error budget or its actual consumption over the alert window.
      * **Burn Rate**: Monitors the rate of error budget consumption. It is good for on-duty alerting and fast incident detection.

      For more information about the differences between checks, see [SLO alerts](../../concepts/alerting/alert.md#slo-alerts).

  1. Under **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.alert-config }}**, select the project that contains the SLO, then select the SLO itself. The SLO and the alert can belong to different projects. You do not need to define custom metric queries.
  1. Under **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.alert-conditions }}**, set the conditions for the alert to change its status.

      Specify at least one threshold: **{{ ui-key.yacloud_monitoring.monitoring-alerts.slo.warn-threshold }}** or **{{ ui-key.yacloud_monitoring.monitoring-alerts.slo.alarm-threshold }}**.

      For the **{{ ui-key.yacloud_monitoring.monitoring-alerts.slo-type.error-budget-key-value }}** type, select one of the following methods in the **{{ ui-key.yacloud_monitoring.monitoring-alerts.slo.alert-type-key-value }}** field:

      * **{{ ui-key.yacloud_monitoring.monitoring-alerts.slo.alert-type.absolute }}**: Checks the average remaining budget over the alert calculation window. Set the minimum allowed remaining budget as a percentage. For example, use `20%` for **{{ ui-key.yacloud_monitoring.monitoring-alerts.slo.warn-threshold }}** and `10%` for **{{ ui-key.yacloud_monitoring.monitoring-alerts.slo.alarm-threshold }}**. If you specify both thresholds, make sure the **{{ ui-key.yacloud_monitoring.monitoring-alerts.slo.alarm-threshold }}** value is lower than the **{{ ui-key.yacloud_monitoring.monitoring-alerts.slo.warn-threshold }}** value.
      * **{{ ui-key.yacloud_monitoring.monitoring-alerts.slo.alert-type.diff }}**: Checks the difference between the remaining budget at the beginning and end of the evaluation window. Set the **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.evaluation-window-key-value }}** and the allowed consumption thresholds as percentages. For example, for a `1h` window and a `5%` **{{ ui-key.yacloud_monitoring.monitoring-alerts.slo.alarm-threshold }}** threshold, the alert fires if budget consumption exceeds 5% in an hour. If you specify both thresholds, make sure the **{{ ui-key.yacloud_monitoring.monitoring-alerts.slo.alarm-threshold }}** value is greater than the **{{ ui-key.yacloud_monitoring.monitoring-alerts.slo.warn-threshold }}** value.

      For the **Burn Rate** type, specify the evaluation window and thresholds:

      1. Select the long evaluation window. The short window is automatically derived as 1/12 of the long window. For example, if the long window is `1h`, the short one is `5m`.
      1. Choose how to specify the thresholds: as a burn rate or as the percentage of the error budget consumed over the alert window.
      1. Set the selected thresholds in the specified units. If both thresholds are set, make sure the **{{ ui-key.yacloud_monitoring.monitoring-alerts.slo.alarm-threshold }}** value is greater than the **{{ ui-key.yacloud_monitoring.monitoring-alerts.slo.warn-threshold }}** value. For example, for an SLO with a 30-day window, a burn rate of `14.4` over a `1h` window is equivalent to 2% error budget consumption in an hour.

      A burn rate alert fires when the burn rate values for both the long and short windows exceed their respective thresholds. Learn more about [evaluation windows](../../concepts/alerting/alert.md#slo-burn-rate-windows) and [threshold configuration methods](../../concepts/alerting/alert.md#slo-burn-rate-thresholds).

  1. Configure [data decimation](../../concepts/alerting/alert.md#decimation) or leave the default values.
  1. Set up [no data policies](../../concepts/alerting/alert.md#no-data-policy). To avoid interpreting missing data as SLO compliance, set `No data` for both missing metrics and missing data points within the evaluation window.

  1. Optionally, specify [annotations](../../concepts/alerting/annotation.md) for the alert.
  1. Optionally, to sort alerts and search for alerts, add labels in `key=value` format.

      Separate `key=value` pairs with commas. To use labels in another alert or the search bar, click **{{ ui-key.yacloud_monitoring.monitoring-alerts.labels.tokenized-input.copy-button }}**.

  1. Optionally, under **Links**, add links to related resources.
  1. Configure [notifications](../../concepts/alerting/notification-channel.md). If you do not have a notification channel, [create one](create-channel.md).

      If default notification methods are set for the selected alert severity, they apply even if the notification table is empty. To configure the settings, click **{{ ui-key.yacloud_monitoring.monitoring-alerts.label.edit-notify-methods }}**. Check the values of the **{{ ui-key.yacloud_monitoring.monitoring-alerts.channel-table.notify-statuses }}** and **{{ ui-key.yacloud_monitoring.monitoring-alerts.channel-table.repeat }}** settings.

      To avoid receiving notifications every time the status changes, enable **{{ ui-key.yacloud_monitoring.monitoring-alerts.flap-suppressor.checkbox }}**. Use this setting for low-traffic SLOs where the status may briefly change due to a small number of events. For more on noise suppression, see [{#T}](../../concepts/alerting/alert.md#noise-suppression).

  1. Check the alert calculation result.

      {% include [alert-check-result](../../../_includes/monium/alert-check-result.md) %}

  1. Click **{{ ui-key.yacloud_monitoring.actions.common.create }}**. The alert will appear in the list.

{% endlist %}
