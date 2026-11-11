# Alerting

{{ monium-name }}'s alerting feature sends metric update notifications. For example, you can get alerted about a change in your cloud resource's status and deal with it before it is too late.

Alerting monitors particular metrics for changes using [alerts](alerting/alert.md) and serves notifications via your [notification channel](./alerting/notification-channel.md) or [escalation policy](alerting/escalations.md).

Use [SLO alerts](alerting/alert.md#slo-alerts) to monitor the reliability of user journeys. They track the remaining error budget, actual error budget consumption, or burn rate for the selected SLO. To configure notifications, [create an SLO alert](../operations/alert/create-slo-alert.md).
