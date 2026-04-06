The `security-deck.editor` role enables managing subscriptions to events of access to organization resources by Yandex Cloud employees, managing workspaces, alerts, and alert sinks, as well {{ dspm-name }}, {{ cspm-name }}, and {{ kspm-name }} resources. With this role, you cannot view masked and unprocessed data.

{% cut "Users with this role can:" %}

* Select a [billing account](../../billing/concepts/billing-account.md) in {{ atr-name }}.
* View info on subscriptions to events of access to organization resources by Yandex Cloud employees, as well as create, delete, and cancel deletion of such subscriptions.
* View the list of events when Yandex Cloud employees access organization resources.
* Approve or disapprove the result of a neural network-driven analysis of events when Yandex Cloud employees access organization resources.
* View info on {{ dspm-name }} profiles and use them.
* View info on {{ dspm-name }} [data sources](../../security-deck/concepts/dspm.md#data-source), as well as create, modify, use, and delete them.
* View info on {{ dspm-name }} security [scan](../../security-deck/concepts/dspm.md#scanning) jobs, as well as create, modify, and delete such jobs.
* Run {{ dspm-name }} security scan jobs and view their results, as well as info on detected threats.
* View info on {{ dspm-name }} data [types and categories](../../security-deck/concepts/dspm.md#data-categories).
* View [bucket](../../storage/concepts/bucket.md) metadata.
* View info on Security Deck [workspaces](../../security-deck/concepts/workspace.md) and resources managed in them, as well as on [access permissions](../../iam/concepts/access-control/index.md) granted for them.
* Create, modify, and delete Security Deck workspaces.
* View info on [connectors](../../security-deck/concepts/workspace.md#connectors), as well as create, use, modify, and delete them.
* View info on cloud infrastructure checks for compliance with [security standards](../../security-deck/concepts/cspm.md#standards) configured in the [{{ cspm-name }}](../../security-deck/concepts/cspm.md) settings.
* View {{ cspm-name }} check results.
* Create, suspend, resume, update, and delete {{ cspm-name }} checks.
* View [exceptions](../../security-deck/concepts/cspm.md#exceptions) from {{ cspm-name }} check rules, create and delete such exceptions.
* Engage, set up, and disconnect [{{ kspm-name }}](../../security-deck/concepts/kspm.md), as well as create, modify, and delete exceptions from rules and exceptions from the control scope.
* View info on Managed Service for Kubernetes [clusters](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) connected to {{ kspm-name }}, {{ kspm-name }} users, and {{ kspm-name }} operations.
* View info on [alert sinks](../../security-deck/concepts/workspace.md#alert-sinks) and access permissions granted for them.
* Create, use, modify, and delete alert sinks.
* View info on [alerts](../../security-deck/concepts/alerts.md) and access permissions granted for them.
* View additional info on alerts and their sources, the list of affected resources, and tips on resolving issues.
* Create, modify, and delete alerts.
* View the list of comments to alerts, as well as create, modify, and delete such comments.

{% endcut %}

This role includes the `access-transparency.editor`, `dspm.editor`, `cspm.editor`, `kspm.editor`, and `security-deck.alertSinks.editor` permissions.
