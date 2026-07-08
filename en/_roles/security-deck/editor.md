The `security-deck.editor` role enables managing subscriptions to events of access to organization resources by {{ yandex-cloud }} employees, managing workspaces, alerts, and alert sinks, as well as {{ dspm-name }}, {{ cspm-name }}, {{ kspm-name }}, {{ vuln-man-short-name }}, and {{ td-name }} resources. This role does not enable viewing masked and unprocessed data.

{% cut "Users with this role can:" %}

* Select a [billing account](../../billing/concepts/billing-account.md) in {{ atr-name }}.
* View info on subscriptions to events of access to organization resources by {{ yandex-cloud }} employees, as well as create, delete, and cancel deletion of such subscriptions.
* View the list of events when {{ yandex-cloud }} employees access organization resources.
* Approve or disapprove the results of a neural network-driven analysis of events when {{ yandex-cloud }} employees access organization resources.
* View info on {{ dspm-name }} profiles and use them.
* View info on {{ dspm-name }} [data sources](../../security-deck/concepts/dspm.md#data-source) and their scan areas, as well as create, modify, use, and delete such sources.
* View info on {{ dspm-name }} sensitive data [scan](../../security-deck/concepts/dspm.md#scanning) jobs, as well as create, run, suspend, resume, modify, and delete such jobs.
* View info on sensitive data scans, as well as create, suspend, resume, modify, and delete them.
* View the lists of results and scan errors when scanning for sensitive data.
* View {{ dspm-name }} sensitive data scan results and info on detected threats.
* View info on {{ dspm-name }} data types and [categories](../../security-deck/concepts/dspm.md#data-categories).
* View info on {{ dspm-name }} [data analysis](../../security-deck/concepts/dspm#discovery-mode) results.
* View [bucket](../../storage/concepts/bucket.md) metadata.
* View info on {{ sd-name }} [workspaces](../../security-deck/concepts/workspace.md) and resources managed in them, as well as on [access permissions](../../iam/concepts/access-control/index.md) granted for them.
* Create, modify, and delete {{ sd-name }} workspaces.
* View info on [connectors](../../security-deck/concepts/workspace.md#connectors), as well as create, use, modify, and delete them.
* View info on cloud infrastructure checks for compliance with [security standards](../../security-deck/concepts/cspm.md#standards) configured in the [{{ cspm-name }} settings](../../security-deck/concepts/cspm.md), as well as delete checks.
* View info on {{ cspm-name }} check jobs.
* Manually run checks for compliance with {{ cspm-name }} security standards.
* View {{ cspm-name }} check results.
* Create, suspend, resume, modify, and delete {{ cspm-name }} check jobs.
* View [exceptions](../../security-deck/concepts/cspm.md#exceptions) from {{ cspm-name }} check rules, as well as create and delete such exceptions.
* Engage, set up, and disconnect [{{ kspm-name }}](../../security-deck/concepts/kspm.md), as well as create, modify, and delete exceptions from rules and from the control scope.
* View info on {{ managed-k8s-name }} [clusters](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) connected to {{ kspm-name }}, as well as on {{ kspm-name }} users and operations.
* View info on [alert sinks](../../security-deck/concepts/workspace.md#alert-sinks) and access permissions granted for them.
* Create, use, modify, and delete alert sinks.
* View info on [alerts](../../security-deck/concepts/alerts.md) and access permissions granted for them.
* View additional info on alerts and their sources, the list of affected resources, and tips on resolving issues.
* Create, modify, and delete alerts.
* View the list of comments to alerts, as well as create, modify, and delete such comments.
* View info on {{ vuln-man-name }} [scan](../../security-deck/concepts/vulnerability-management.md#scanning) jobs and modify such jobs.
* Run [{{ vuln-man-name }}](../../security-deck/concepts/vulnerability-management.md) scan jobs and view their results.
* View info on [{{ td-name }}](../../security-deck/concepts/threat-detector.md) security management rules and create exceptions from such rules.
* View info on access permissions granted for {{ td-name }}.

{% endcut %}

This role includes the `access-transparency.editor`, `dspm.editor`, `cspm.editor`, `kspm.editor`, `security-deck.alertSinks.editor`, `vulnerability-manager.editor`, and `threat-detector.editor` permissions.
