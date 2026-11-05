---
title: Creating an SLO alert
description: Follow this guide to create an SLO alert.
---

# Creating an SLO alert

SLO alerts help monitor service reliability against a target [SLO](../../slo/index.md). These alerts are configured based on the selected SLO and its calculated metrics: [error budget](../../slo/index.md#basic-terms) and burn rate. Use these alerts to promptly detect the risk of SLO breach and assess the incident's impact on the user journey.

Before creating an SLO alert, [create and configure the SLO](../../slo/management.md#config).

{% include [alert-viewer-role](../../../_includes/monium/alert-viewer-role.md) %}

{% list tabs group=instructions %}

- {{ monium-name }} UI {#console}

  1. On the [{{ monium-name }}]({{ link-monium }}) home page, select ![alt](../../../_assets/console-icons/shield-exclamation.svg) **Alerts and SLOs** → ![alt](../../../_assets/console-icons/megaphone.svg) **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.alerts.title }}** on the left.
  1. At the top right, click **{{ ui-key.yacloud_monitoring.homepage.button_alerts-action }}** → **SLO**.
  1. Specify the main alert parameters:

      {% include [alert-basic-parameters](../../../_includes/monium/alert-basic-parameters.md) %}

  1. In the **Type** field, select:

      * **Error Budget**: Monitors the remaining error budget. Choose this type for release planning and assessing the risk of SLO violation.
      * **Burn Rate**: Monitors the rate of error budget consumption. It is good for on-duty alerting and fast incident detection.

      For critical SLOs, create alerts of both types. **Error Budget** shows how much budget is left, while **Burn Rate** indicates how fast it is being consumed.

  1. Under **Alert settings**, select the project and SLO to create the alert for.
  1. Under **Trigger conditions**, set the conditions for the alert to change its status.

      For **Error Budget**:

      * **Calculation method**: Select which method to use to monitor `Error Budget`:
        * **Error Budget Remaining**: Triggers when the remaining budget falls below the threshold. Under **Warning** and **Alarm**, set the lowest allowed budget percentage. For example, set the `20`% threshold for an early warning, and `10`%, to alert about a critical risk of budget depletion.
        * **Error Budget Exhaustion Rate**: Triggers when consumption exceeds the threshold within the **Evaluation window**. Use this method for incidents that rapidly consume the budget, such as a post-release spike in authorization errors.

      For **Burn Rate**:

      * **Warning**: Specify the warning threshold. `0,5` means the `Error Budget` is being consumed at 50% of the maximum rate.
      * **Alarm**: Specify the critical status threshold. `1` means the `Error Budget` is being consumed at its maximum rate: keeping this rate will have the budget exhausted by the end of the SLO window.
      * **Long Window**: Set the primary evaluation window for calculating the `Error Budget` burn rate. Use it to assess sustained SLO degradation, e.g., an upward trend in error rates over the past hour.
      * **Short Window**: Set an additional short window for rapid status downgrades. If `Error Budget` consumption stops, the short window will quickly detect the recovery and downgrade the alert to a less critical status.
      * **Enable additional error budget check**: Enable this so your alert triggers only when there is a high burn rate and a significant portion of the `Error Budget` has already been spent. This reduces the risk of false positives during low-traffic periods: when events are few, the error rate may rise, but the actual budget consumption remains low.
      * **Evaluation window**: Set the period over which the condition is checked. For fast user journeys, choose a short window; for background tasks, a longer one.

  1. Configure [data decimation](../../concepts/alerting/alert.md#decimation) or leave the default values. For peak value alerts, choose `Maximum`; for counters, `Sum` or `Count`. If the state metric changes rarely, select **Previous value** in the **Fill** field.
  1. Set [no data policies](../../concepts/alerting/alert.md#no-data-policy) or leave the default values. For critical SLOs, choose the `No data` status to distinguish metric collection failures from SLO compliance. If individual instances tend to disappear during autoscaling, use simplified policy application.

  1. Optionally, specify [annotations](../../concepts/alerting/annotation.md) for the alert.
  1. Optionally, to sort alerts and search for alerts, add labels in `key=value` format.

      You can add multiple labels. Do it by entering a `key=value` pair and clicking **Enter**. To use labels in another alert or the search bar, click **Copy all labels**.

  1. Optionally, under **Links**, add links to related resources.
  1. Configure [notifications](../../concepts/alerting/notification-channel.md). If you do not have a notification channel, [create one](create-channel.md).

      To avoid receiving notifications every time the status changes, enable **Noise suppression**. Use this setting for low-traffic SLOs where the status may briefly change due to a small number of events. For more on noise suppression, see [{#T}](../../concepts/alerting/alert.md#noise-suppression).

  1. Check the alert evaluation result.

      {% include [alert-check-result](../../../_includes/monium/alert-check-result.md) %}

  1. Click **{{ ui-key.yacloud_monitoring.actions.common.create }}**. The alert will appear in the list.

{% endlist %}
