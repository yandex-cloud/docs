# Alerts/notifications

#### How can I reduce the number of false alerts? {#reduce-false-alerts}

You can increase the [evaluation window](../../monitoring/concepts/alerting/alert.md#evaluation-window) or change the [aggregation function](../../monitoring/concepts/alerting/alert.md#aggregation) in the [alert](../../monitoring/concepts/alerting/alert.md#alert-parameters) settings.

#### What value should I specify as a threshold? {#threshold-values}

The threshold value is set in units of the selected metric.

For example, the free disk space threshold for a database cluster is specified in bytes. You can simply set a threshold by moving the slider on the chart with real data. Make sure the **{{ ui-key.yacloud_monitoring.alert-template.threshold-status.warn }}** threshold value does not exceed that for an **{{ ui-key.yacloud_monitoring.alert-template.threshold-status.alarm }}**.

#### How do I set an alert recipient? {#alert-recipient}

You can use the following supported [notification channel](../../monitoring/concepts/alerting/notification-channel.md) methods:

{% include [channels](../../_includes/monitoring/channels.md) %}

{% include [account-info](../../_includes/monitoring/account-info.md) %}

#### I do not receive any alerts. Why? {#alert-receive-failed}

If the alert fires but you do not get any notifications:

1. Check the recipient list, sending method, and alert statuses for which notifications are enabled, in the [channel settings](../../monium/concepts/alerting/notification-channel.md#channel-parameters). You can also find the requirements for the recipient's permissions and account settings there.
1. Make sure you specified the right email address and telephone number and enabled the monitoring notifications in the [management console settings]({{ link-console-settings }}). Also check the email address in your Yandex ID or federated account profile.
1. Check the [sending status](../../monium/concepts/alerting/notification-channel.md#dispatch-statuses). The `{{ ui-key.yacloud_monitoring.channel.status-description_resource_exhausted }}` status means that you reached the limit for this sending method. In {{ monium-name }}, the daily [limit](../../monium/concepts/limits.md#limits-metrics-alerts) is 100 SMS per number.
1. Check the **Spam** folder in your mail and on the telephone as well as the block list. If you have an SMS filter, disable it temporarily and check the delivery again. If you do not receive SMS still, contact your mobile operator to find out if any messages were sent to your number.

#### What should I do if there is no data? {#alert-no-data}

If there is no data, you will see the timeline for the last hour. To see the data, change the [evaluation window](../../monitoring/concepts/alerting/alert.md#evaluation-window) time to include the most recent point.

If there are no function errors, no data will be displayed. For more information, see [No data policy](../../monitoring/concepts/alerting/alert.md#no-data-policy).
