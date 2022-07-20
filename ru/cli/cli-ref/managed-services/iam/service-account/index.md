---
sourcePath: en/_cli-ref/cli-ref/managed-services/iam/service-account/index.md
---
# yc iam service-account

Manage service accounts

#### Command Usage

Syntax: 

`yc iam service-account <command>`

Aliases: 

- `service-accounts`

#### Command Tree

- [yc iam service-account get](get.md) — Show information about the specified service account
- [yc iam service-account list](list.md) — List service accounts
- [yc iam service-account create](create.md) — Create a service account
- [yc iam service-account update](update.md) — Update the specified service account
- [yc iam service-account delete](delete.md) — Delete the specified service account
- [yc iam service-account list-access-bindings](list-access-bindings.md) — List access bindings for ACCESSING the specified service account. To determine if a service account has an access to a resource, use list-access-bindings command for the corresponding resource
- [yc iam service-account set-access-bindings](set-access-bindings.md) — Set access bindings for ACCESSING the specified service account and DELETE all existing access bindings if there were any. To configure service account access to a resource use set-access-bindings command for the corresponding resource
- [yc iam service-account add-access-binding](add-access-binding.md) — Add access binding to ACCESS the specified service account as a resource. To configure service account access to a resource use add-access-binding command for the corresponding resource
- [yc iam service-account remove-access-binding](remove-access-binding.md) — Remove access binding for ACCESSING the specified service account as a resource. To configure service account access to a resource use remove-access-binding command for the corresponding resource
- [yc iam service-account list-operations](list-operations.md) — List operations for the specified service account

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom configuration file.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.<br/>Pass 0 to disable retries. Pass any negative value for infinite retries.<br/>Even infinite retries are capped with 2 minutes timeout.|
|`--cloud-id`|<b>`string`</b><br/>Set the ID of the cloud to use.|
|`--folder-id`|<b>`string`</b><br/>Set the ID of the folder to use.|
|`--folder-name`|<b>`string`</b><br/>Set the name of the folder to use (will be resolved to id).|
|`--endpoint`|<b>`string`</b><br/>Set the Cloud API endpoint (host:port).|
|`--token`|<b>`string`</b><br/>Set the OAuth token to use.|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|
