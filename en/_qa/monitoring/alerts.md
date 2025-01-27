# Alerts/notifications

#### How can I reduce the number of false alerts? {#reduce-false-alerts}

You can increase the [evaluation window](../../monitoring/concepts/alerting/alert.md#evaluation-window) or change the [aggregation function](../../monitoring/concepts/alerting/alert.md#aggregation) in the [alert](../../monitoring/concepts/alerting/alert.md#alert-parameters) parameters.

#### What value should I specify in a threshold? {#threshold-values}

The threshold value is set in the units of the selected metric.

For example, the value of a database cluster's free disk space threshold is specified in bytes. It is convenient to set a threshold by moving the slider on the chart with real data. Make sure the threshold value for a **{{ ui-key.yacloud_monitoring.alert-template.threshold-status.warn }}** does not exceed that for an **{{ ui-key.yacloud_monitoring.alert-template.threshold-status.alarm }}**.

#### How do I set an alert recipient? {#alert-recipient}

The following methods are supported in the [notification channel](../../monitoring/concepts/alerting/notification-channel.md):

{% include [channels](../../_includes/monitoring/channels.md) %}

{% include [account-info](../../_includes/monitoring/account-info.md) %}

#### A user does not receive any alerts. Why is that? {#alert-receive-failed}

Check the mailbox and phone number settings in the user account's [notification channel](../../monitoring/concepts/alerting/notification-channel.md).

{% include [notifications-requirements](../../_includes/monitoring/notifications-requirements.md) %}

#### What do I do if there is no data? {#alert-no-data}

If there is no data, the timeline for the last hour is displayed. To view the data, change the time in the [evaluation window](../../monitoring/concepts/alerting/alert.md#evaluation-window): it must include the most recent point.

If there are no function errors, no data will be displayed. For more information, see [No data policy](../../compute/concepts/vm-metadata.md).