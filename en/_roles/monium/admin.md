The `monium.admin` role enables managing Monium resources, read and write all types of telemetry, and manage projects and access to them.

Users with this role can:
* View info on [projects](../../monium/concepts/glossary.md#project) and create, set up, and delete them.
* View info on [access permissions](../../iam/concepts/access-control/index.md) granted for projects and modify such permissions.
* Read and write all types of Monium telemetry, such as [metrics](../../monium/metrics/quickstart.md), [logs](../../monium/logs/quickstart.md), and [distributed tracing](../../monium/traces/index.md).
* View [dashboards](../../monium/concepts/visualization/dashboard.md) and their [widgets](../../monium/concepts/visualization/widget.md), as well as create, modify, and delete dashboards.
* View the set-up context links on dashboard [charts](../../monium/concepts/visualization/widget.md#chart), as well as create, edit, and delete such links.
* View the list of the set-up [quick links](../../monium/concepts/glossary.md#project-menu) and info on them in the [project](../../monium/concepts/glossary.md#project) menu, as well as create, modify, and delete such links.
* View info on [shards](../../monium/concepts/glossary.md#shard), [clusters](../../monium/concepts/glossary.md#cluster), [services](../../monium/concepts/glossary.md#service) and their quotas, as well as create, modify, and delete shards.
* View the list of [alerts](../../monium/concepts/alerting/alert.md), their settings, and trigger history, as well as create, modify, and delete alerts.
* View the set-up [service level objectives (SLOs)](../../monium/slo/index.md), as well as create, modify, and delete SLOs.
* View the list of alert [notification channels](../../monium/concepts/alerting/notification-channel.md) and info on them, as well as create, modify, and delete such channels.
* View the list and settings of alert [escalation policies](../../monium/concepts/alerting/escalations.md#intro), as well as create, modify, and delete such policies.
* View info on alert notifications and [escalations](../../monium/concepts/alerting/escalations.md), as well as create, modify, and delete escalations.
* View, create, edit, and delete [mutes](../../monium/alerts/mutes.md), i.e., rules for temporarily disabling alert [notifications](../../monium/concepts/alerting/notification-channel.md).
* View, add new, edit, and delete the existing [labels](../../monium/traces/operations/traces-explorer.md) to log errors.
* View info on the Yandex Managed Service for Prometheus® [rules](../../monium/operations/prometheus/recording-rules.md), as well as create, modify, and delete such rules.
* View info on the relevant [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).

This role includes the `monium.editor` permissions.
