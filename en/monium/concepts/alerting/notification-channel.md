# Notification channel

To enable notifications of alert status changes, specify a notification channel. This channel contains information about the recipients, send method, and notification parameters.

You can use the same channel in multiple alerts; and the same alert can send notifications to multiple channels.

## Notification channel parameters {#channel-parameters}

* **{{ ui-key.yacloud_monitoring.channel.field_name }}**. Notification channel name.
* **ID**. Unique channel ID. By default, it is formed from the project ID and channel name.
* **Default for levels**. Alert levels for which notifications to this channel will be sent without adding the channel to each alert.
* **{{ ui-key.yacloud_monitoring.channel.field_recipients }}**. List of users to be notified of the alert.

  {% note info %}

  {% include [account-info](../../../_includes/monitoring/account-info.md) %}

  {% include [notifications-requirements](../../../_includes/monitoring/notifications-requirements.md) %}

  {% endnote %}

* **{{ ui-key.yacloud_monitoring.channel.field_method }}**. Notification delivery method. The following notification methods are supported:

  {% include [channels](../../../_includes/monium/channels.md) %}

As soon as a notification channel is created, the following additional parameters become available:

* **{{ ui-key.yacloud_monitoring.monitoring-alerts.label.sent-notify-statuses }}**. Alert statuses to trigger a notification from {{ monium-name }}.
* **{{ ui-key.yacloud_monitoring.monitoring-alerts.channel-table.repeat }}**. Interval to resend the notification if the alert remains in the same status. Does not apply for the `OK` status.

**{{ messenger-full-name }}** notifications can include a screenshot of the alert metrics chart.

## Notification delivery statuses {#dispatch-statuses}

Each notification can have one of the following delivery statuses:

Status | Description
----- | -----
`{{ ui-key.yacloud_monitoring.channel.status-description_success }}` | Notification successful.
`{{ ui-key.yacloud_monitoring.channel.status-description_error }}` | Notification not sent due to an error.
`Invalid request` | Notification not sent due to invalid channel parameters. No retry attempts are made.
`Retry error` | Notification not sent due to a temporary send method error. {{ monium-name }} will retry.
`Obsolete` | Notification was not sent before the next event in the channel.
`{{ ui-key.yacloud_monitoring.channel.status-description_resource_exhausted }}` | Notification not sent due to channel restrictions.

#### Useful links {#see-also}

[Creating a notification channel](../../operations/alert/create-channel.md)
