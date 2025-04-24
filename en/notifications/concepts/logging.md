# Logs {{ cloud-logging-name }}

You can [configure](../operations/configure-logging.md) saving endpoint creation and notification logs to [{{ cloud-logging-name }}](../../logging/).

The table below describes possible log contents (`json_payload`).

#|
|| **Field** | **Comment** ||

|| `message_id` | Message ID ||
|| `event`| Event name ||
|| `status` | Message sending status. It may take one of the following values:
* `conveyed`: Sent.
* `filtered`: Filtered out.
* `expired`: TTL expired.
* `client_error`: Not sent due to a request or data error.
* `server_error`: Not sent due to a server error. ||

|| `error` | Description of the `client error` status when sending a message:
* `rate_limit`: Too many send requests.
* `misconfigured_channel`: Invalid channel configuration, e.g., invalid mobile app secret.
* `invalid_or_revoked_endpoint`: Endpoint is invalid or rejected by the message sending platform.
* `invalid_message_or_endpoint`: Invalid message, sending parameters, or endpoint attributes (most often, a token error). ||

|| `endpoint_id` | Endpoint ID, the unique part of the endpoint ARN ||
|| `channel_name` | Channel name ||
|| `message_type` | Message type ||
|| `platform` | Mobile notification platform name ||
|#
