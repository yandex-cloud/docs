---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/backup/cli-ref-beta/resource/index.md
---

# yc beta backup resource

A set of methods for managing backup resources: [Compute Cloud instances](/docs/backup/concepts/vm-connection#os).

#### Command Usage

Syntax: 

`yc beta backup resource <command>`

#### Command Tree

- [yc beta backup resource create-directory](create-directory.md) — CreateDirectory creates new directory by requested path.
- [yc beta backup resource delete](delete.md) — Delete specific Compute Cloud instance from Cloud Backup. It does not delete
- [yc beta backup resource get](get.md) — Get specific Compute Cloud instance.
- [yc beta backup resource get-instance-registration-token](get-instance-registration-token.md) — Get instance registration token to install backup agent withot SA attached to instance
- [yc beta backup resource list](list.md) — List resources: Compute Cloud instances.
- [yc beta backup resource list-directory](list-directory.md) — ListDirectory returns all subdirectories found in requested directory identified
- [yc beta backup resource list-operations](list-operations.md) — ListOperations return all operations in backup service for given instance
- [yc beta backup resource list-tasks](list-tasks.md) — List tasks of resources.

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
