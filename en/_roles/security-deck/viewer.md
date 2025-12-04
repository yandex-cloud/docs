The `security-deck.viewer` role enables viewing info on events of access to organization resources by Yandex Cloud employees, on DSPM, CSPM, and KSPM resources, on alerts and alert sinks, as well as on scan jobs and the number of detected security threats. With this role, you cannot view masked and unprocessed data.

{% cut "Users with this role can:" %}

* View the list of events when Yandex Cloud employees access organization resources.
* Approve or disapprove the result of a neural network-driven analysis of events when Yandex Cloud employees access organization resources.
* View info on DSPM profiles.
* View info on DSPM [data sources](../../security-deck/concepts/dspm.md#data-source).
* View info on DSPM security [scan](../../security-deck/concepts/dspm.md#scanning) jobs.
* View info on data types and [categories](../../security-deck/concepts/dspm.md#data-categories).
* View DSPM scan results and info on detected threats.
* View info on Security Deck [workspaces](../../security-deck/concepts/workspace.md) and resources managed in them, as well as on [access permissions](../../iam/concepts/access-control/index.md) granted for them.
* View info on [connectors](../../security-deck/concepts/workspace.md#connectors).
* View info on cloud infrastructure checks for compliance with [security standards](../../security-deck/concepts/cspm.md#standards) configured in the [CSPM](../../security-deck/concepts/cspm.md) settings, the results of such checks, and [exceptions](../../security-deck/concepts/cspm.md#exceptions) from check rules.
* View info on the [KSPM](../../security-deck/concepts/kspm.md) settings, Managed Service for Kubernetes [clusters](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) connected to KSPM, exceptions from rules, exceptions from the control scope, KSPM users, and KSPM operations.
* View info on [alert sinks](../../security-deck/concepts/workspace.md#alert-sinks) and access permissions granted for them.
* View info on [alerts](../../security-deck/concepts/alerts.md) and access permissions granted for them.
* View additional info on alerts and their sources, the list of affected resources, and tips on resolving issues.

{% endcut %}

This role includes the `access-transparency.viewer`, `dspm.viewer`, `cspm.viewer`, `kspm.viewer`, and `security-deck.alertSinks.viewer` permissions.
