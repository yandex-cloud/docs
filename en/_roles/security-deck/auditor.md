The `security-deck.auditor` role enables viewing info on DSPM, CSPM, and KSPM resources, on alerts and alert sinks, as well as on scan jobs and the number of detected security threats. With this role, you cannot view masked and unprocessed data.

Users with this role can:
* View info on DSPM profiles.
* View info on DSPM [data sources](../../security-deck/concepts/dspm.md#data-source).
* View info on DSPM security [scan](../../security-deck/concepts/dspm.md#scanning) jobs.
* View info on data types and [categories](../../security-deck/concepts/dspm.md#data-categories).
* View DSPM scan results and info on detected threats.
* View info on Security Deck [workspaces](../../security-deck/concepts/workspace.md) and resources managed in them, as well as on [access permissions](../../iam/concepts/access-control/index.md) granted for them.
* View info on [connectors](../../security-deck/concepts/workspace.md#connectors).
* View info on cloud infrastructure checks for compliance with [security standards](../../security-deck/concepts/cspm.md#standards) configured in the [CSPM](../../security-deck/concepts/cspm.md) settings.
* View info on the [KSPM settings](../../security-deck/concepts/kspm.md) and operations, as well as the list of exceptions from rules.
* View info on [alert sinks](../../security-deck/concepts/workspace.md#alert-sinks) and access permissions granted for them.

This role includes the `dspm.auditor`, `cspm.auditor`, `kspm.auditor`, and `security-deck.alertSinks.auditor` permissions.
