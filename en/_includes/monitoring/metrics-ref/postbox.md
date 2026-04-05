The `name` label contains the metric name.

Labels shared by all {{ postbox-name }} metrics:

Label | Value
----|----
identity | Sender [address](../../../postbox/concepts/glossary.md#adress) ID
service | Service label, always `postbox`

## Email acceptance metrics {#inbound-metrics}

| Metric name<br>Type, units | Description |
| --- | --- |
| `inbound_emails_count`<br>`RATE`, count | Number of emails accepted for delivery. If an email has multiple recipients, the metric will increase accordingly. For example, an email with three recipients will increment the metric by three. |
| `inbound_issues_rate`<br>`RATE`, count | Number of issues during the email acceptance. The `kind` label indicates the issue category and takes the following values: `temporary quota issue`, `permanent quota issue`, `malformed email`, `smtp session error`, or `client notification issue`. |

## Email delivery metrics {#delivery-metrics}

| Metric name<br>Type, units | Description |
| --- | --- |
| `process_duration_ms`<br>`HIST_RATE`, milliseconds | End-to-end email processing time from acceptance until the delivery attempt completes. |
| `emails_processed_count`<br>`RATE`, count | Number of processed emails regardless of the delivery result. |
| `delivery_success_count`<br>`RATE`, count | Number of emails successfully delivered to recipients. This metric increments for each individual recipient. |
| `delivery_retry_count`<br>`RATE`, count | Number of delivery retry attempts. Delivery is re-attempted if the recipient’s mail server is temporarily unavailable or returns a transient error. |
| `delivery_spam_count`<br>`RATE`, count | Number of emails the recipient’s mail server has identified as spam. |
| `delivery_reject_count`<br>`RATE`, count | Number of emails the recipient’s mail server has eventually rejected. |

## Event notification metrics {#notification-metrics}

The `topic` label contains the name of the event notification topic.

| Metric name<br>Type, units | Description |
| --- | --- |
| `notifications_published_count`<br>`RATE`, count | Number of event notifications successully published to the topic. |
| `notifications_error_rate`<br>`RATE`, count | Number of errors when publishing notifications to the topic. |