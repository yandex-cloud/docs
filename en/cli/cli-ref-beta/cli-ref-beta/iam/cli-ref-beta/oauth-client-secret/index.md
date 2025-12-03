---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/iam/cli-ref-beta/oauth-client-secret/index.md
---

# yc beta iam oauth-client-secret

A set of methods for managing OAuthClientSecret resources.

#### Command Usage

Syntax: 

`yc beta iam oauth-client-secret <command>`

#### Command Tree

- [yc beta iam oauth-client-secret create](create.md) — Creates an OAuthClientSecret resource for the specified OAuthClient.
- [yc beta iam oauth-client-secret delete](delete.md) — Deletes the specified OAuthClientSecret resource.
- [yc beta iam oauth-client-secret get](get.md) — Returns the sepcified OAuthClientSecret resource.
- [yc beta iam oauth-client-secret list](list.md) — Retrieves the list of OAuthClientSecret resources of the specified OAuthClient.

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
