---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/managed-spark/cli-ref-beta/job/index.md
---

# yc beta managed-spark job

A set of methods for managing jobs for Spark cluster.

#### Command Usage

Syntax: 

`yc beta managed-spark job <command>`

#### Command Tree

- [yc beta managed-spark job cancel](cancel.md) — Cancels the specified Spark job.
- [yc beta managed-spark job create](create.md) — Creates a job for Spark cluster.
- [yc beta managed-spark job get](get.md) — Returns the specified Spark job.
- [yc beta managed-spark job list](list.md) — Retrieves a list of jobs for Spark cluster.
- [yc beta managed-spark job list-log](list-log.md) — Returns a log for Spark job.

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
