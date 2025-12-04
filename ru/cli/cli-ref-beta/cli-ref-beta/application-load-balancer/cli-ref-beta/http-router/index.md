---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/application-load-balancer/cli-ref-beta/http-router/index.md
---

# yc beta application-load-balancer http-router

A set of methods for managing HTTP routers.

#### Command Usage

Syntax: 

`yc beta application-load-balancer http-router <command>`

#### Command Tree

- [yc beta application-load-balancer http-router create](create.md) — Creates an HTTP router in the specified folder.
- [yc beta application-load-balancer http-router delete](delete.md) — Deletes the specified HTTP router.
- [yc beta application-load-balancer http-router get](get.md) — Returns the specified HTTP router.
- [yc beta application-load-balancer http-router list](list.md) — Lists HTTP routers in the specified folder.
- [yc beta application-load-balancer http-router list-operations](list-operations.md) — Lists operations for the specified HTTP router.
- [yc beta application-load-balancer http-router update](update.md) — Updates the specified HTTP router.

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
