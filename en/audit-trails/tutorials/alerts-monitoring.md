# Alert settings in {{ monitoring-full-name }}

In this tutorial, you will learn how to track the status of [trails](https://cloud.yandex.ru/docs/audit-trails/concepts/trail) using [alerts](https://cloud.yandex.ru/docs/monitoring/concepts/alerting#alert).

To start tracking the status of trails:

1. [Prepare your cloud](#before-you-begin).
1. [Create a notification channel](#create-channel).
1. [Set up alerts](#setup-alerts).

If you no longer need the alerts, [delete them](#clear-out).

## Prepare your cloud {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

## Create a notification channel {#create-channel}

To get notifications about a triggered alert:

1. In the [management console]({{ link-console-main }}), select the folder where you want to create a notification channel.
1. Select **{{ monitoring-name }}**.
1. In the left-hand panel, select **Channels**.
1. In the top-right corner, click **Create channel**.
1. Specify the channel parameters:
   * In the **Name** field, specify `alerts-channel`.
   * In the **Method** field, specify the notification method.
   * In the **Recipients** field, list notification recipients.
1. Click **Create**.

The channel appears in the list.

## Set up alerts {#setup-alerts}

You can set up one or more alerts.

For more information about how to [create alerts](../../monitoring/operations/alert/create-alert.md) and about [alert parameters](../../monitoring/concepts/alerting.md#alert-parameters), see the {{ monitoring-full-name }} documentation.

### Deactivating a trail {#deactivating-trail}

The alert will send a notification that the trail is being deactivated.

1. In the [management console]({{ link-console-main }}), select the folder where you want to create an alert.
1. Select **{{ monitoring-name }}**.
1. In the left-hand panel, select **Alerts**.
1. In the top-right corner, click **Create alert**.
1. In the **Name** field, specify `deactivating-trail-alert`.
1. In the **Metrics** section to the right of the folder name, click ![image](../../_assets/plus-sign.svg) and specify:
   1. `service = Audit Trails`.
   1. `name = trail.status`.
   1. `status != ACTIVE`.
   1. `trail = <trail_name>`.
1. Under **Alert parameters**, specify:
   1. **Trigger condition**: `Not equal`.
   1. **Alarm**: `0`.
1. Under **Notification channels**, click **Add channel** and select the [previously created](#create-channel) notification channel.
1. Click **Create alert**.

The alert is created.

### Stopping delivery of audit logs to destination object {#stopping-logs}

The alert will send notification that the trail has stopped uploading audit logs to its destination object, for example, due to a lack of free space in the bucket.

The **Evaluation window** parameter depends on the specific trail. The type and number of resources within the audit trail logging section will define the frequency for uploading audit logs to the destination object.

1. In the [management console]({{ link-console-main }}), select the folder where you want to create an alert.
1. Select **{{ monitoring-name }}**.
1. In the left-hand panel, select **Alerts**.
1. In the top-right corner, click **Create alert**.
1. In the **Name** field, specify `stopping-logs-alert`.
1. In the **Metrics** section to the right of the folder name, click ![image](../../_assets/plus-sign.svg) and specify:
   1. `service = Audit Trails`.
   1. `name = trail.delivered_events_count`.
   1. `trail = <trail_name>`.
1. Under **Alert parameters**, specify:
   1. **Trigger condition**: `Equal`.
   1. **Alarm**: `0`.
   1. **Evaluation window**: `<value_for_trail>`.
1. Under **Notification channels**, click **Add channel** and select the [previously created](#create-channel) notification channel.
1. Click **Create alert**.

The alert is created.

### Modifying the number of trails {#number-trails}

The alert will send a notification that the number of trails in a cloud has changed.

1. In the [management console]({{ link-console-main }}), select the folder where you want to create an alert.
1. Select **{{ monitoring-name }}**.
1. In the left-hand panel, select **Alerts**.
1. In the top-right corner, click **Create alert**.
1. In the **Name** field, specify `number-trails-alert`.
1. In the **Metrics** section to the right of the folder name, click ![image](../../_assets/plus-sign.svg) and specify:
   1. `service = Audit Trails`.
   1. `name = quota.trails_count.usage`.
1. Under **Alert parameters**, specify:
   1. **Trigger condition**: `Not equal`.
   1. **Alarm**: `<number_of_trails>`.
1. Under **Notification channels**, click **Add channel** and select the [previously created](#create-channel) notification channel.
1. Click **Create alert**.

The alert is created.

### Nearing cloud trail quota {#trail-quota}

The alert will send a notification that the number of trails used per cloud consumed over 80% of the quota.

1. In the [management console]({{ link-console-main }}), select the folder where you want to create an alert.
1. Select **{{ monitoring-name }}**.
1. In the left-hand panel, select **Alerts**.
1. In the top-right corner, click **Create alert**.
1. In the **Name** field, specify `trail-quota-alert`.
1. In the **Metrics** section to the right of the folder name, click ![image](../../_assets/plus-sign.svg) and specify:
   1. `service = Audit Trails`.
   1. `name = quota.trails_count.usage`.
1. Under **Alert parameters**, specify:
   1. **Trigger condition**: `Greater than`.
   1. **Alarm**: `<number_amounting_to_80%_of_quota>`.
1. Under **Notification channels**, click **Add channel** and select the [previously created](#create-channel) notification channel.
1. Click **Create alert**.

The alert is created.

### Unauthorized access attempts {#unauthorized-access}

The alert will send a notification that an unauthorized request has been sent to one of the trail resources.

1. In the [management console]({{ link-console-main }}), select the folder where you want to create an alert.
1. Select **{{ monitoring-name }}**.
1. In the left-hand panel, select **Alerts**.
1. In the top-right corner, click **Create alert**.
1. In the **Name** field, specify `unauthorized-access-alert`.
1. In the **Metrics** section to the right of the folder name, click ![image](../../_assets/plus-sign.svg) and specify:
   1. `service = Audit Trails`.
   1. `name = trail.unauthorized_events_count`.
1. Under **Alert parameters**, specify:
   1. **Trigger condition**: `Greater than`.
   1. **Alarm**: `0`.
1. Under **Notification channels**, click **Add channel** and select the [previously created](#create-channel) notification channel.
1. Click **Create alert**.

The alert is created.

## How to delete the resources you created {#clear-out}

To stop tracking the status of trails, [delete](../../monitoring/operations/alert/delete-alert.md) the respective alert.
