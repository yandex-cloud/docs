---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/serverless/cli-ref-beta/network/index.md
---

# yc beta serverless network

A set of methods for managing VPC networks connected to serverless resources.

#### Command Usage

Syntax: 

`yc beta serverless network <command>`

#### Command Tree

- [yc beta serverless network get-used](get-used.md) — Returns the specified network used in serverless resources.
- [yc beta serverless network list-connected-resources](list-connected-resources.md) — Retrieves the list of serverless resources connected to any network from the specified scope.
- [yc beta serverless network list-used](list-used.md) — Retrieves the list of networks in the specified scope that are used in serverless resources.
- [yc beta serverless network trigger-used-cleanup](trigger-used-cleanup.md) — Forces obsolete used network to start cleanup process as soon as possible.

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
