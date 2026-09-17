The `security-deck.auditor` role enables viewing info on {{ dspm-name }}, {{ cspm-name }}, {{ kspm-name }}, {{ vuln-man-short-name }}, and {{ td-name }} resources, on alerts and alert sinks, as well as on scan jobs and the number of detected security threats. This role does not enable viewing masked and unprocessed data.

Users with this role can:
* View info on {{ dspm-name }} profiles.
* View info on {{ dspm-name }} [data sources](../../security-deck/concepts/dspm.md#data-source) and their scan areas.
* View info on sensitive data [scan](../../security-deck/concepts/dspm.md#scanning) jobs in {{ dspm-name }}.
* View info on data types and [categories](../../security-deck/concepts/dspm.md#data-categories).
* View info on sensitive data scan jobs in {{ dspm-name }}.
* View info on results of and errors relating to sensitive data scans in {{ dspm-name }} (unmasked data only).
* Download and export sensitive data scan results in {{ dspm-name }} (unmasked data only).
* View info on {{ dspm-name }} [data analysis](../../security-deck/concepts/dspm.md#discovery-mode) results.
* View info on {{ sd-name }} [workspaces](../../security-deck/concepts/workspace.md) and resources managed in them, as well as on [access permissions](../../iam/concepts/access-control/index.md) granted for them.
* View info on [connectors](../../security-deck/concepts/workspace.md#connectors).
* View info on cloud infrastructure checks for compliance with [security standards](../../security-deck/concepts/cspm.md#standards), as well as on jobs for such checks configured in the [{{ cspm-name }}](../../security-deck/concepts/cspm.md) settings.
* View info on the [{{ kspm-name }}](../../security-deck/concepts/kspm.md) settings and operations, as well as the list of exceptions from rules.
* View info on [alert sinks](../../security-deck/concepts/workspace.md#alert-sinks) and access permissions granted for them.
* View [{{ vuln-man-short-name }}](../../security-deck/concepts/vulnerability-management.md) scan results.
* View info on [{{ td-name }}](../../security-deck/concepts/threat-detector.md) security management rules and access permissions granted for {{ td-name }}.

This role includes the `dspm.auditor`, `cspm.auditor`, `kspm.auditor`, `security-deck.alertSinks.auditor`, `vulnerability-manager.auditor`, and `threat-detector.auditor` permissions.

To export sensitive data scan results in {{ dspm-name }}, you also need the `storage.uploader` role for the bucket to save the results in and the `kms.keys.encrypter` role for the encryption key if the bucket is encrypted.
