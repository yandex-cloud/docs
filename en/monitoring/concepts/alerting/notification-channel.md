# Notification channel

To enable notifications of alert status changes, specify a notification channel. The channel contains information about notification recipients and sending methods.

One channel can be used multiple times for different alerts.

## Notification channel parameters {#channel-parameters}

* **{{ ui-key.yacloud_monitoring.channel.field_recipients }}**. List of recipients to get notifications in the event an alert function is triggered.

   {% note info %}

   {% include [account-info](../../../_includes/monitoring/account-info.md) %}

   {% include [notifications-requirements](../../../_includes/monitoring/notifications-requirements.md) %}

   {% endnote %}

* **{{ ui-key.yacloud_monitoring.channel.field_method }}**. Notification delivery method. The following notification methods are supported:

   {% include [channels](../../../_includes/monitoring/channels.md) %}

As soon as a notification channel is created, the following additional parameters become available:

* **{{ ui-key.yacloud_monitoring.monitoring-alerts.label.sent-notify-statuses }}**. Select a list of alert statuses to notify users of via the notification channel.
* **{{ ui-key.yacloud_monitoring.monitoring-alerts.channel-table.repeat }}**. Select a period for {{ monitoring-short-name }} to send repeated notifications saying that an alert is in the same status.

## Notification sending statuses {#dispatch-statuses}

Each sending of a notification can have one of the following statuses:

| Status | Description |
----- | -----
| `{{ ui-key.yacloud_monitoring.channel.status-description_success }}` | Notification successful. |
| `{{ ui-key.yacloud_monitoring.channel.status-description_error }}` | Notification not sent due to an error. |
| `{{ ui-key.yacloud_monitoring.channel.status-description_resource_exhausted }}` | Notification not sent due to a sending method restriction. |

## See also

* [Creating a notification channel](../../operations/alert/create-channel.md)
