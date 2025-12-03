---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/marketplace/cli-ref-beta/license-manager/lock/index.md
---

# yc beta marketplace license-manager lock

A set of methods for managing subscription locks.

#### Command Usage

Syntax: 

`yc beta marketplace license-manager lock <command>`

#### Command Tree

- [yc beta marketplace license-manager lock create](create.md) — Locks the specified subscription instance to the resource.
- [yc beta marketplace license-manager lock delete](delete.md) — Unlocks the specified subscription lock.
- [yc beta marketplace license-manager lock ensure](ensure.md) — Checks if the she specified subscription is already locked to the specified resource.
- [yc beta marketplace license-manager lock get](get.md) — Returns the specified subscription lock.
- [yc beta marketplace license-manager lock get-by-instance-and-resource](get-by-instance-and-resource.md) — Returns the subscription lock for specified subscription instance and resource.
- [yc beta marketplace license-manager lock list](list.md) — Returns subscriptions locks for specified resource and folder.

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
