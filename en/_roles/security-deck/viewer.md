The `security-deck.viewer` role enables viewing info on events of access to organization resources by {{ yandex-cloud }} employees, on {{ dspm-name }}, {{ cspm-name }}, {{ kspm-name }}, {{ vuln-man-short-name }}, and {{ td-name }} resources, on alerts and alert sinks, as well as on scan jobs and the number of detected security threats. This role does not enable viewing masked and unprocessed data.

{% cut "Users with this role can:" %}

* View the list of events when {{ yandex-cloud }} employees access organization resources.
* Approve or disapprove the results of a neural network-driven analysis of events when {{ yandex-cloud }} employees access organization resources.
* View info on {{ dspm-name }} profiles.
* View info on {{ dspm-name }} [data sources](../../security-deck/concepts/dspm.md#data-source) and their scan areas.
* View info on sensitive data [scan](../../security-deck/concepts/dspm.md#scanning) jobs in {{ dspm-name }}.
* View info on data types and [categories](../../security-deck/concepts/dspm.md#data-categories).
* View info on sensitive data scan jobs in {{ dspm-name }}.
* View info on results of and errors relating to [continuous update scans](../../security-deck/concepts/dspm.md#change-scaning) and [regular sensitive data scans](../../security-deck/concepts/dspm.md#scanning) in {{ dspm-name }} (unmasked data only).
* Download and export sensitive data scan results in {{ dspm-name }} (unmasked data only).
* Estimate the cost of using {{ dspm-name }} (drawing on {{ objstorage-full-name }} bucket metadata in data sources).
* View info on {{ sd-name }} [workspaces](../../security-deck/concepts/workspace.md) and resources managed in them, as well as on [access permissions](../../iam/concepts/access-control/index.md) granted for them.
* View info on [connectors](../../security-deck/concepts/workspace.md#connectors).
* View info on cloud infrastructure checks for compliance with [security standards](../../security-deck/concepts/cspm.md#standards) and their results, as well as on jobs for such checks and [exceptions](../../security-deck/concepts/cspm.md#exceptions) from check rules configured in the [{{ cspm-name }}](../../security-deck/concepts/cspm.md) settings.
* View info on the [{{ kspm-name }}](../../security-deck/concepts/kspm.md) settings, {{ managed-k8s-name }} [clusters](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) connected to {{ kspm-name }}, exceptions from rules, exceptions from the scope of control, and {{ kspm-name }} users and operations.
* View info on [alert sinks](../../security-deck/concepts/workspace.md#alert-sinks) and access permissions granted for them.
* View info on [alerts](../../security-deck/concepts/alerts.md) and access permissions granted for them.
* View additional info on alerts and their sources, the list of affected resources, and tips on resolving issues.
* View info on [{{ vuln-man-short-name }}](../../security-deck/concepts/vulnerability-management.md) scan jobs and their results.
* View info on [{{ td-name }}](../../security-deck/concepts/threat-detector.md) security management rules and access permissions granted for {{ td-name }}.

{% endcut %}

This role includes the `access-transparency.viewer`, `dspm.viewer`, `cspm.viewer`, `kspm.viewer`, `security-deck.alertSinks.viewer`, `vulnerability-manager.viewer`, and `threat-detector.viewer` permissions.

To export sensitive data scan results in {{ dspm-name }}, you also need the `storage.uploader` role for the bucket to save the results in and the `kms.keys.encrypter` role for the encryption key if the bucket is encrypted.
