---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/quota-manager/cli-ref-beta/index.md
---

# yc beta quota-manager

Manage Yandex Quota Manager resources

#### Command Usage

Syntax: 

`yc beta quota-manager <group>`

#### Command Tree

- [yc beta quota-manager quota-limit](quota-limit/index.md) — A set of methods for managing quota limits.
	- [yc beta quota-manager quota-limit get](quota-limit/get.md) — Returns the specified quota limit.
	- [yc beta quota-manager quota-limit list](quota-limit/list.md) — Retrieves the list of quota limits for a given service.
	- [yc beta quota-manager quota-limit list-services](quota-limit/list-services.md) — Retrieves the list of services available for quota management.
- [yc beta quota-manager quota-request](quota-request/index.md) — A set of methods for managing quota requests.
	- [yc beta quota-manager quota-request cancel](quota-request/cancel.md) — Cancels quotas in the specified quota request.
	- [yc beta quota-manager quota-request create](quota-request/create.md) — Creates a quota request in the specified resource.
	- [yc beta quota-manager quota-request get](quota-request/get.md) — Returns the specified quota request.
	- [yc beta quota-manager quota-request list](quota-request/list.md) — Retrieves the list of quota requests in the specified resource.
	- [yc beta quota-manager quota-request list-operations](quota-request/list-operations.md) — Lists operations for the specified quota request.

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
