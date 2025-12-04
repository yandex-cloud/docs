The `security-deck.admin` role enables managing subscriptions to events of access to organization resources by Yandex Cloud employees, managing workspaces, alerts, and alert sinks, as well DSPM, CSPM, and KSPM resources. With this role, you can view masked and unprocessed data in scan results.

{% cut "Users with this role can:" %}

* Select a [billing account](../../billing/concepts/billing-account.md) in Access Transparency.
* View info on subscriptions to events of access to organization resources by Yandex Cloud employees, as well as create, delete, and cancel deletion of such subscriptions.
* View the list of events when Yandex Cloud employees access organization resources.
* Approve or disapprove the result of a neural network-driven analysis of events when Yandex Cloud employees access organization resources.
* View info on DSPM profiles and use them.
* View info on DSPM [data sources](../../security-deck/concepts/dspm.md#data-source), as well as create, modify, use, and delete them.
* Use Yandex Cloud resources in DSPM data sources.
* View info on DSPM data [types and categories](../../security-deck/concepts/dspm.md#data-categories).
* View info on DSPM security [scan](../../security-deck/concepts/dspm.md#scanning) jobs, as well as create, modify, and delete such jobs.
* Run DSPM security scan jobs, view their result and info on detected threats, which includes viewing masked and unprocessed data in the scan results.
* View [bucket](../../storage/concepts/bucket.md) metadata.
* View info on Security Deck [workspaces](../../security-deck/concepts/workspace.md) and resources managed in them, as well as create, update, and delete Security Deck workspaces.
* View info on [access permissions](../../iam/concepts/access-control/index.md) granted for Security Deck workspaces and modify such permissions.
* View info on [connectors](../../security-deck/concepts/workspace.md#connectors), as well as create, use, modify, and delete them.
* View info on cloud infrastructure checks for compliance with [security standards](../../security-deck/concepts/cspm.md#standards) configured in the [CSPM](../../security-deck/concepts/cspm.md) settings.
* View CSPM check results.
* Create, suspend, resume, update, and delete CSPM checks.
* View [exceptions](../../security-deck/concepts/cspm.md#exceptions) from CSPM check rules, create and delete such exceptions.
* Engage, set up, and disconnect [KSPM](../../security-deck/concepts/kspm.md), as well as create, modify, and delete exceptions from rules and exceptions from the control scope.
* View info on Managed Service for Kubernetes [clusters](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) connected to KSPM, KSPM users, and KSPM operations.
* View info on [alert sinks](../../security-deck/concepts/workspace.md#alert-sinks), as well as create, use, modify, and delete them.
* View info on access permissions granted for alert sinks and modify such permissions.
* View info on [alerts](../../security-deck/concepts/alerts.md), as well as create, modify, and delete them.
* View info on access permissions granted for alerts and modify such permissions.
* View additional info on alerts and their sources, the list of affected resources, and tips on resolving issues.
* View the list of comments to alerts, as well as create, modify, and delete such comments.

{% endcut %}

This role includes the `access-transparency.admin`, `dspm.admin`, `cspm.admin`, `kspm.admin`, and `security-deck.alertSinks.admin` permissions.
