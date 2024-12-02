---
editable: false
---

# yc iam

Manage Yandex Identity and Access Manager resources

#### Command Usage

Syntax: 

`yc iam <group|command>`

#### Command Tree

- [yc iam create-token](create-token.md) — Create IAM token and print to STDOUT
- [yc iam revoke-token](revoke-token.md) — Revoke IAM token
- [yc iam access-key](access-key/index.md) — Manage service account access keys
	- [yc iam access-key create](access-key/create.md) — Create an access key for the specified service account
	- [yc iam access-key delete](access-key/delete.md) — Delete the specified access key
	- [yc iam access-key get](access-key/get.md) — Show information about the specified access key
	- [yc iam access-key list](access-key/list.md) — List access keys for the specified service account
- [yc iam api-key](api-key/index.md) — Manage service account API keys
	- [yc iam api-key create](api-key/create.md) — Create an API key for the specified service account
	- [yc iam api-key delete](api-key/delete.md) — Delete the specified API key
	- [yc iam api-key get](api-key/get.md) — Show information about the specified API key
	- [yc iam api-key list](api-key/list.md) — List API keys for the specified service account
	- [yc iam api-key list-scopes](api-key/list-scopes.md) — List of scopes
- [yc iam key](key/index.md) — Manage IAM keys
	- [yc iam key create](key/create.md) — Create an IAM key for for authenticated account or the specified service account
	- [yc iam key delete](key/delete.md) — Delete the specified IAM key
	- [yc iam key get](key/get.md) — Show information about the specified IAM key
	- [yc iam key list](key/list.md) — List IAM keys for authenticated account or the specified service account
- [yc iam role](role/index.md) — Manage roles
	- [yc iam role get](role/get.md) — Show information about the specified role
	- [yc iam role list](role/list.md) — List roles
- [yc iam service-account](service-account/index.md) — Manage service accounts
	- [yc iam service-account add-access-binding](service-account/add-access-binding.md) — Add access binding to ACCESS the specified service account as a resource. To configure service account access to a resource use add-access-binding command for the corresponding resource
	- [yc iam service-account add-labels](service-account/add-labels.md) — Add labels to specified service account
	- [yc iam service-account create](service-account/create.md) — Create a service account
	- [yc iam service-account delete](service-account/delete.md) — Delete the specified service account
	- [yc iam service-account get](service-account/get.md) — Show information about the specified service account
	- [yc iam service-account list](service-account/list.md) — List service accounts
	- [yc iam service-account list-access-bindings](service-account/list-access-bindings.md) — List access bindings for ACCESSING the specified service account. To determine if a service account has an access to a resource, use list-access-bindings command for the corresponding resource
	- [yc iam service-account list-operations](service-account/list-operations.md) — List operations for the specified service account
	- [yc iam service-account remove-access-binding](service-account/remove-access-binding.md) — Remove access binding for ACCESSING the specified service account as a resource. To configure service account access to a resource use remove-access-binding command for the corresponding resource
	- [yc iam service-account remove-labels](service-account/remove-labels.md) — Remove labels from specified service account
	- [yc iam service-account set-access-bindings](service-account/set-access-bindings.md) — Set access bindings for ACCESSING the specified service account and DELETE all existing access bindings for all accounts if there were any. To configure service account access to a resource use set-access-bindings command for the corresponding resource
	- [yc iam service-account update](service-account/update.md) — Update the specified service account
- [yc iam service-control](service-control/index.md) — Manage service access to cloud
	- [yc iam service-control disable](service-control/disable.md) — Disable service access to cloud
	- [yc iam service-control enable](service-control/enable.md) — Enable service access to cloud
	- [yc iam service-control get](service-control/get.md) — Show information about state of specified service
	- [yc iam service-control list](service-control/list.md) — List service states
- [yc iam user-account](user-account/index.md) — Manage user accounts
	- [yc iam user-account get](user-account/get.md) — Show information about the specified user account
- [yc iam workload-identity](workload-identity/index.md) — Manage workload identity

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
|`--impersonate-service-account-id`|<b>`string`</b><br/>Set the ID of the service account to impersonate.|
|`--no-browser`|Disable opening browser for authentication.|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`--jq`|<b>`string`</b><br/>Query to select values from the response using jq syntax|
|`-h`,`--help`|Display help for the command.|
