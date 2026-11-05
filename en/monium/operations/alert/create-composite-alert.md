---
title: Creating a composite alert
description: Follow this guide to create a composite alert.
---

# Creating a composite alert

A _composite alert_ figures out its status based on the statuses of other alerts. It helps you set the overall alert logic for several related checks. For example, you can count an issue only if several alerts get the `Alarm` status at the same time.

{% include [alert-viewer-role](../../../_includes/monium/alert-viewer-role.md) %}

{% list tabs group=instructions %}

- {{ monium-name }} UI {#console}

  1. On the [{{ monium-name }}]({{ link-monium }}) home page, select ![alt](../../../_assets/console-icons/shield-exclamation.svg) **Alerts and SLOs** → ![alt](../../../_assets/console-icons/megaphone.svg) **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.alerts.title }}** on the left.
  1. In the top-right corner, click **{{ ui-key.yacloud_monitoring.homepage.button_alerts-action }}** → **Composite**.
  1. Specify the main alert parameters:

      {% include [alert-basic-parameters](../../../_includes/monium/alert-basic-parameters.md) %}

  1. Under **Alert selector**, specify labels to search for source alerts.

      For example, `severity = "Critical"` (groups critical alerts), `status = "Alarm"` (groups triggered alerts), or `notification_channel.id = "<channel_ID>"` (groups alerts from a specific notification channel).

  1. Under **Trigger conditions**, select a composition strategy (method used to determine the final alert status):

      * **By share**: This status will be assigned to the alert as soon as a target percentage of selected alerts get the specified statuses. Use this strategy for similar types of checks, e.g., based on the share of unavailable hosts in the cluster.
      * **By count**: This status will be assigned to the alert as soon as the target number of selected alerts get the specified statuses. Use the fixed quorum strategy, e.g., when it is enough to have three triggered alerts across the availability zones.

  1. Configure the conditions for the **Warning** and **Alarm** statuses:

     * Set a threshold: percentage or quantity. For **Warning**, set an early warning threshold, e.g., `20`% of problematic instances. For **Alarm**, set a threshold that requires a response from the operator on duty.
     * Select the statuses of the source alerts to consider. If no statuses are selected, alerts with the `Warning` and `Alarm` statuses are counted.

     When the threshold is reached, the composite alert will get the appropriate status. For example, for **Alarm**, the selected statuses are `Alarm` and `Error`, with the threshold of `3`. In this case, the composite will go `Alarm` as soon as a total of at least three source alerts get the `Alarm` and `Error` statuses.

  1. Optionally, configure additional conditions:

      * **Force the composite status to No Data**: The composite alert gets the `No Data` status if at least one source alert is in the `No Data` status. Use this setting if a data loss for a single critical source is more important than the rest of the conditions.
      * **Force the composite status to Error**: The composite alert gets the `Error` status if at least one source alert is in the `Error` status. This prevents concealing the source alert evaluation error.
      * **Treat muted alerts as Ok**: [Muted](../../alerts/mutes.md) alerts are counted as the `Ok` status. Use this setting for scheduled maintenance so that muting one source alert does not elevate the status of the composite.

  1. Optionally, specify [annotations](../../concepts/alerting/annotation.md) for the alert.

      You can add new annotations or select those specified in the source alerts.

  1. Optionally, to sort alerts and search for alerts, add labels in `key=value` format.

      You can add multiple labels. Do it by entering a `key=value` pair and clicking **Enter**. To use labels in another alert or the search bar, click **Copy all labels**.

  1. Optionally, under **Links**, add links to related resources.
  1. Configure [notifications](../../concepts/alerting/notification-channel.md). If you do not have a notification channel, [create one](create-channel.md).

      To avoid receiving notifications every time the status changes, enable **Noise suppression**. Use this setting if the source alerts change their status frequently near the composite threshold. For more on noise suppression, see [{#T}](../../concepts/alerting/alert.md#noise-suppression).

  1. Check the alert evaluation result.

      {% include [alert-check-result](../../../_includes/monium/alert-check-result.md) %}

  1. Click **{{ ui-key.yacloud_monitoring.actions.common.create }}**. The alert will appear in the list.

{% endlist %}
