---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/container/cli-ref-beta/scan-policy/index.md
---

# yc beta container scan-policy

A set of methods for managing scan policy resources.

#### Command Usage

Syntax: 

`yc beta container scan-policy <command>`

#### Command Tree

- [yc beta container scan-policy create](create.md) — Creates a scan policy for the specified registry.
- [yc beta container scan-policy delete](delete.md) — Deletes the specified scan policy.
- [yc beta container scan-policy get](get.md) — Returns the specified scan policy.
- [yc beta container scan-policy get-by-registry](get-by-registry.md) — Returns scan policy for the registry if any exists.
- [yc beta container scan-policy update](update.md) — Updates the specified scan policy.

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
