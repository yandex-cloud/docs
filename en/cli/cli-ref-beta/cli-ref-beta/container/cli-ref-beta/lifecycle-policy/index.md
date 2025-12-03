---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/container/cli-ref-beta/lifecycle-policy/index.md
---

# yc beta container lifecycle-policy

A set of methods for managing Lifecycle policy resources.

#### Command Usage

Syntax: 

`yc beta container lifecycle-policy <command>`

#### Command Tree

- [yc beta container lifecycle-policy create](create.md) — Creates a lifecycle policy in the specified repository.
- [yc beta container lifecycle-policy delete](delete.md) — Deletes the specified lifecycle policy.
- [yc beta container lifecycle-policy dry-run](dry-run.md) — Creates a request of a dry run of the lifecycle policy.
- [yc beta container lifecycle-policy get](get.md) — Returns the specified lifecycle policy.
- [yc beta container lifecycle-policy get-dry-run-result](get-dry-run-result.md) — Returns the dry run result of the specified lifecycle policy.
- [yc beta container lifecycle-policy list](list.md) — Retrieves the list of lifecycle policies in the specified repository.
- [yc beta container lifecycle-policy list-dry-run-result-affected-images](list-dry-run-result-affected-images.md) — Retrieves the list of the affected images.
- [yc beta container lifecycle-policy list-dry-run-results](list-dry-run-results.md) — Retrieves the list of the dry run results.
- [yc beta container lifecycle-policy update](update.md) — Updates the specified lifecycle policy.

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
