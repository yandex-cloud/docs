{% if audience != "internal" %}

You can [configure alerts](#monitoring-integration) in {{ monitoring-full-name }} to receive notifications about cluster failures. In {{ monitoring-full-name }}, there are two alert thresholds: `Warning` and `Alarm`. If the specified threshold is exceeded, you'll receive alerts via the configured [notification channels](../../monitoring/concepts/alerting.md#notification-channel).

{% endif %}