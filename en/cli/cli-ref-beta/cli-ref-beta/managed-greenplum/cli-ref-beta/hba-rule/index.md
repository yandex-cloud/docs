---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/managed-greenplum/cli-ref-beta/hba-rule/index.md
---

# yc beta managed-greenplum hba-rule

A set of methods for managing Greenplum clusters.

#### Command Usage

Syntax: 

`yc beta managed-greenplum hba-rule <command>`

#### Command Tree

- [yc beta managed-greenplum hba-rule batch-update](batch-update.md) — Modifies all HBA rules for the specified Greenplum cluster.
- [yc beta managed-greenplum hba-rule create](create.md) — Create single HBA rule for the specified Greenplum cluster to the end of HBA rules list.
- [yc beta managed-greenplum hba-rule delete](delete.md) — Delete specified HBA rule for the specified Greenplum cluster.
- [yc beta managed-greenplum hba-rule list](list.md) — Retrieves a list of HBA rules for Greenplum clusters.
- [yc beta managed-greenplum hba-rule list-at-revision](list-at-revision.md) — Retrieves a list of HBA rules for Greenplum clusters for particular revision.
- [yc beta managed-greenplum hba-rule update](update.md) — Update specified HBA rule for the specified Greenplum cluster without changind it order.

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom profile.|
|`--region`|<b>`string`</b><br/>Set the region.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--pager`|<b>`string`</b><br/>Set the custom pager.|
|`--format`|<b>`string`</b><br/>Set the output format: text, yaml, json, table, json-rest.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.<br/>Pass 0 to disable retries. Pass any negative value for infinite retries.<br/>Even infinite retries are capped with 2 minutes timeout.|
|`--timeout`|<b>`string`</b><br/>Set the timeout.|
|`--token`|<b>`string`</b><br/>Set the IAM token to use.|
|`--impersonate-service-account-id`|<b>`string`</b><br/>Set the ID of the service account to impersonate.|
|`--no-browser`|Disable opening browser for authentication.|
|`--query`|<b>`string`</b><br/>Query to select values from the response using jq syntax|
|`-h`,`--help`|Display help for the command.|
