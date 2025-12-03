---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/iam/cli-ref-beta/oauth-client/index.md
---

# yc beta iam oauth-client

A set of methods for managing OAuthClient resources.

#### Command Usage

Syntax: 

`yc beta iam oauth-client <command>`

#### Command Tree

- [yc beta iam oauth-client create](create.md) — Creates an oauth client in the specified folder.
- [yc beta iam oauth-client delete](delete.md) — Deletes the specified oauth client with all its secrets.
- [yc beta iam oauth-client get](get.md) — Returns the sepcified OAuthClient resource.
- [yc beta iam oauth-client list](list.md) — Retrieves the list of OAuthClient resources views in the specified folder
- [yc beta iam oauth-client update](update.md) — Updates the specified oauth client.

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
