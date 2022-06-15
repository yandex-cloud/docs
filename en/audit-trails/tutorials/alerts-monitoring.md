# Alert settings in {{ monitoring-full-name }}

For more information about how to [create alerts](../../monitoring/operations/alert/create-alert.md) and about [alert parameters](../../monitoring/concepts/alerting.md), see the {{ monitoring-full-name }} documentation.

## Before you begin {#before-you-begin}

Create a notification channel in {{ monitoring-name }}. For more information about creating a notification channel, see the [{{ monitoring-full-name }} documentation](../../monitoring/operations/alert/create-channel.md).

## Deactivating a trail {#deactivating-trail}

This scenario describes the parameters of an alert that sends a notification that its configured trail is being deactivated.

1. Go to the page for [creating a new alert](../../monitoring/operations/alert/create-alert.md) for {{ monitoring-name }} in the {{ yandex-cloud }} console.
1. In the **Title** field, enter a name for the alert.
1. Under **Metrics**, specify the following values:
   1. `service = Audit Trails`.
   1. `name = trail.status`.
   1. `status != ACTIVE`.
   1. `trail = <trail name>`.
1. Under **Alert settings**, specify the following values:
   1. **Trigger condition**: `Not equal`.
   1. **Alarm**: `0`.
1. Under **Notification channels**, select a notification channel.
1. Click **Create alert**.

The alert is created.

## Stopping delivery of audit logs to destination object {#stopping-logs}

The alert will send notification that its configured trail has stopped uploading audit logs to its destination object, for example, because there is a shortage of free space in a bucket.

The "Evaluation window" parameter depends on the specific trail since the type and number of resources within the audit trail logging scope will define the frequency for uploading audit logs to the destination object.

1. Go to the page for [creating a new alert](../../monitoring/operations/alert/create-alert.md) for {{ monitoring-name }} in the {{ yandex-cloud }} console.
1. In the **Title** field, enter a name for the alert.
1. Under **Metrics**, specify the following values:
   1. `service = Audit Trails`.
   1. `name = trail.delivered_events_count`.
   1. `trail = <trail name>`.
1. Under **Alert settings**, specify the following values:
   1. **Trigger condition**: `Equal`.
   1. **Alarm**: `0`.
   1. **Evaluation window**: `<trail value>`.
1. Under **Notification channels**, select a notification channel.
1. Click **Create alert**.

The alert is created.

## Modifying the number of trails {#number-trails}

The alert will send a notification that the number of trails in a cloud has changed.

1. Go to the page for [creating a new alert](../../monitoring/operations/alert/create-alert.md) for {{ monitoring-name }} in the {{ yandex-cloud }} console.
1. In the **Title** field, enter a name for the alert.
1. Under **Metrics**, specify the following values:
   1. `service = Audit Trails`.
   1. `name = trail.quota_usage_count`.
1. Under **Alert settings**, specify the following values:
   1. **Trigger condition**: `Not equal`.
   1. **Alarm**: `<number of trails>`.
1. Under **Notification channels**, select a notification channel.
1. Click **Create alert**.

The alert is created.

## Nearing cloud trail quota {#trail-quota}

The alert will send a notification that the number of trails in a cloud has fallen below 80% of the quota.

1. Go to the page for [creating a new alert](../../monitoring/operations/alert/create-alert.md) for {{ monitoring-name }} in the {{ yandex-cloud }} console.
1. In the **Title** field, enter a name for the alert.
1. Under **Metrics**, specify the following values:
   1. `service = Audit Trails`.
   1. `name = trail.quota_usage_count`.
1. Under **Alert settings**, specify the following values:
   1. **Trigger condition**: `Greater than`.
   1. **Alarm**: `<number equal to 80% of quota>`.
1. Under **Notification channels**, select a notification channel.
1. Click **Create alert**.

The alert is created.

## Unauthorized access attempts {#unauthorized-access}

The alert will send a notification that an unauthorized request has been sent to one of the resources that are within its audit logging scope.

1. Go to the page for [creating a new alert](../../monitoring/operations/alert/create-alert.md) for {{ monitoring-name }} in the {{ yandex-cloud }} console.
1. In the **Title** field, enter a name for the alert.
1. Under **Metrics**, specify the following values:
   1. `service = Audit Trails`.
   1. `name = trail.unauthorized_events_count`.
1. Under **Alert settings**, specify the following values:
   1. **Trigger condition**: `Greater than`.
   1. **Alarm**: `0`.
1. Under **Notification channels**, select a notification channel.
1. Click **Create alert**.

The alert is created.