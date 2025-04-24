The `name` label contains the metric name.

Labels shared by all {{ cns-name }} metrics:

#|
|| **Label** | **Value**||

|| service | Service ID: `notifications`||

|| status | Message sending status. The possible values are:
* `conveyed`: Sent successfully.
* `filtered`: Filtered out.
* `--message`: Message TTL expired.
* `client_error`: Failed to send the message. Request or data error, see the `error` label.
* `server_error`: Failed to send the message. Server error.||
|#

Service metrics:

#|
|| **Metric name**
**Type, units** | **Description**||

|| `application.notifications.count`
`IGAUGE`, count | Number of [mobile push notifications](../../../notifications/concepts/push.md) sent within one minute.
Labels:
* `app`: Channel (application) name.
* `platform`: Mobile notification platform name.||

|| `application.notifications.errors.count`
`IGAUGE`, count | Number of mobile push notification send errors within one minute.
Labels:
* `app`: Channel (application) name.
* `platform`: Mobile notification platform name.
* `error`: Description of the `client_error` status when sending a message. The possible values are:
  * `rate_limit`: Too many send requests to the device.
  * `misconfigured_channel`: Misconfigured [channel](../../../notifications/concepts/index.md#channels), e.g., an invalid mobile app secret is loaded.
  * `invalid_or_revoked_endpoint`: Endpoint is incorrect or invalidated by the platform.
  * `invalid_message_or_endpoint`: Incorrect message, incorrect sending or endpoint parameters.
  * `total`: Aggregate.||

|| `sms_channel.notifications.count`
`IGAUGE`, count | Number of [SMS](../../../notifications/concepts/sms.md) messages sent within one minute.
The `sender_id` label represents the channel ID.||

|| `sms_channel.notifications.errors.count`
`IGAUGE`, count | Number of SMS send errors within one minute.
Labels:
* `sender_id`: Channel ID.
* `error`: Description of the `client_error` status when sending a message.||

|| `webpush_channel.notifications.count`
`IGAUGE`, count | Number of [in-browser push notifications](../../../notifications/concepts/browser.md) sent within one minute.<br/>The `channel_name` label represents the channel name.||

|| `webpush_channel.notifications.errors.count`
`IGAUGE`, count | Number of in-browser push notification send errors within one minute.
Labels:
* `channel_name`: Channel name.
* `error`: Description of the `client_error` status when sending a message.||
|#