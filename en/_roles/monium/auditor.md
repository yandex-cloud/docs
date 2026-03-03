The `monium.auditor` role enables viewing information on Monium resources. However, it does not allow reading the telemetry data.

Users with this role can:
* View info on [projects](../../monium/concepts/glossary.md#project) and [access permissions](../../iam/concepts/access-control/index.md) assigned to them.
* View [dashboards](../../monium/concepts/visualization/dashboard.md) and their [widgets](../../monium/concepts/visualization/widget.md).
* View the set-up context links on dashboard [charts](../../monium/concepts/visualization/widget.md#chart).
* View the list of the set-up [quick links](../../monium/concepts/glossary.md#project-menu) and info on them in the project menu.
* View info on [shards](../../monium/concepts/glossary.md#shard), [clusters](../../monium/concepts/glossary.md#cluster), [services](../../monium/concepts/glossary.md#service) and their quotas.
* View the list of [alerts](../../monium/concepts/alerting/alert.md), their settings, and trigger history.
* View the set-up [service level objectives (SLOs)](../../monium/slo/index.md).
* View the list of alert [notification channels](../../monium/concepts/alerting/notification-channel.md) and info on them.
* View the list and settings of alert [escalation policies](../../monium/concepts/alerting/escalations.md#intro).
* View info on alert notifications and [escalations](../../monium/concepts/alerting/escalations.md).
* View [mutes](../../monium/alerts/mutes.md), i.e., rules for temporarily disabling alert [notifications](../../monium/concepts/alerting/notification-channel.md).
* View [labels](../../monium/traces/operations/traces-explorer.md) assigned to log errors.
* View info on the Yandex Managed Service for Prometheus® [rules](../../monium/operations/prometheus/recording-rules.md).

This role includes the `monium.dashboards.viewer`, `monium.shards.viewer`, `monium.contextLinks.viewer`, `monium.quickLinks.viewer`, `monium.alerts.viewer`, `monium.serviceLevelObjectives.viewer`, `monium.channels.viewer`, `monium.escalationPolicies.viewer`, `monium.escalations.viewer`, `monium.mutes.viewer`, and `monium.logErrorLabels.viewer` permissions.
