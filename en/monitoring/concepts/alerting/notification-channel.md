# Notification channel

To enable notifications of alert status changes, specify a notification channel. The channel contains information about notification recipients and sending methods.

One channel can be used multiple times for different alerts.

## Notification channel parameters {#channel-parameters}

* **Recipients**: List of recipients to get notifications in the event an alert function is triggered.

   {% note info %}

   {% include [account-info](../../../_includes/monitoring/account-info.md) %}

   {% include [notifications-requirements](../../../_includes/monitoring/notifications-requirements.md) %}

   {% endnote %}

* **Notification method**: Method for sending notifications to users.  The following notification methods are supported:
   - Email
   - Text message (SMS)
   - Push notifications in the {{ yandex-cloud }} [mobile app](../../../overview/mobile-app/index.md)

Once the notification channel is created, the following additional parameters are available:

* **Notify about statuses**: Select a list of alert statuses to notify users of via the notification channel.
* **Re-notification**: Select a period for {{ monitoring-short-name }} to send repeated notifications saying that an alert is in the same status.

## Notification sending statuses {#dispatch-statuses}

Each sending of a notification can have one of the following statuses:

| Status | Description |
----- | -----
| `Sent` | Notification has been sent. |
| `Failed to send` | Notification has not been sent due to an error. |
| `Resource limit reached` | Notification has not been sent due to a sending method restriction. |