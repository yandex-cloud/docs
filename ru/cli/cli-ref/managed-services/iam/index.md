---
sourcePath: ru/_cli-ref/cli-ref/managed-services/iam/index.md
---
# yc iam

Manage Yandex Identity and Access Manager resources

#### Command Usage

Syntax: 

`yc iam <group|command>`

#### Command Tree

- [yc iam create-token](create-token.md) — Create IAM token and print to STDOUT
- [yc iam role](role/index.md) — Manage roles
	- [yc iam role get](role/get.md) — Show information about the specified role
	- [yc iam role list](role/list.md) — List roles
- [yc iam service-account](service-account/index.md) — Manage service accounts
	- [yc iam service-account get](service-account/get.md) — Show information about the specified service account
	- [yc iam service-account list](service-account/list.md) — List service accounts
	- [yc iam service-account create](service-account/create.md) — Create a service account
	- [yc iam service-account update](service-account/update.md) — Update the specified service account
	- [yc iam service-account delete](service-account/delete.md) — Delete the specified service account
	- [yc iam service-account list-access-bindings](service-account/list-access-bindings.md) — List access bindings for ACCESSING the specified service account. To determine if a service account has an access to a resource, use list-access-bindings command for the corresponding resource
	- [yc iam service-account set-access-bindings](service-account/set-access-bindings.md) — Set access bindings for ACCESSING the specified service account and DELETE all existing access bindings if there were any. To configure service account access to a resource use set-access-bindings command for the corresponding resource
	- [yc iam service-account add-access-binding](service-account/add-access-binding.md) — Add access binding to ACCESS the specified service account as a resource. To configure service account access to a resource use add-access-binding command for the corresponding resource
	- [yc iam service-account remove-access-binding](service-account/remove-access-binding.md) — Remove access binding for ACCESSING the specified service account as a resource. To configure service account access to a resource use remove-access-binding command for the corresponding resource
	- [yc iam service-account list-operations](service-account/list-operations.md) — List operations for the specified service account
- [yc iam certificate](certificate/index.md) — Manage certificates
	- [yc iam certificate get](certificate/get.md) — Show information about the specified certificate
	- [yc iam certificate list](certificate/list.md) — List certificates
	- [yc iam certificate create](certificate/create.md) — Create a certificate
	- [yc iam certificate update](certificate/update.md) — Update the specified certificate
	- [yc iam certificate delete](certificate/delete.md) — Delete the specified certificate
	- [yc iam certificate list-operations](certificate/list-operations.md) — List operations for the specified certificate
- [yc iam federation](federation/index.md) — Manage federations
	- [yc iam federation get](federation/get.md) — Show information about the specified federation
	- [yc iam federation list](federation/list.md) — List federations
	- [yc iam federation create](federation/create.md) — Create a federation
	- [yc iam federation update](federation/update.md) — Update the specified federation
	- [yc iam federation delete](federation/delete.md) — Delete the specified federation
	- [yc iam federation add-user-accounts](federation/add-user-accounts.md) — Add user accounts to the specified federation
	- [yc iam federation list-user-accounts](federation/list-user-accounts.md) — List user accounts of the specified federation
	- [yc iam federation list-operations](federation/list-operations.md) — List operations for the specified federation
- [yc iam key](key/index.md) — Manage IAM keys
	- [yc iam key get](key/get.md) — Show information about the specified IAM key
	- [yc iam key list](key/list.md) — List IAM keys for authenticated account or the specified service account
	- [yc iam key create](key/create.md) — Create an IAM key for for authenticated account or the specified service account
	- [yc iam key delete](key/delete.md) — Delete the specified IAM key
- [yc iam access-key](access-key/index.md) — Manage service account access keys
	- [yc iam access-key get](access-key/get.md) — Show information about the specified access key
	- [yc iam access-key list](access-key/list.md) — List access keys for the specified service account
	- [yc iam access-key create](access-key/create.md) — Create an access key for the specified service account
	- [yc iam access-key delete](access-key/delete.md) — Delete the specified access key
- [yc iam api-key](api-key/index.md) — Manage service account API keys
	- [yc iam api-key get](api-key/get.md) — Show information about the specified API key
	- [yc iam api-key list](api-key/list.md) — List API keys for the specified service account
	- [yc iam api-key create](api-key/create.md) — Create an API key for the specified service account
	- [yc iam api-key delete](api-key/delete.md) — Delete the specified API key
- [yc iam user-account](user-account/index.md) — Manage user accounts
	- [yc iam user-account get](user-account/get.md) — Show information about the specified user account

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom configuration file.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts. Pass 0 to disable retries. Pass any negative value for infinite retries. Even infinite retries are capped with 2 minutes timeout.|
|`--cloud-id`|<b>`string`</b><br/>Set the ID of the cloud to use.|
|`--folder-id`|<b>`string`</b><br/>Set the ID of the folder to use.|
|`--folder-name`|<b>`string`</b><br/>Set the name of the folder to use (will be resolved to id).|
|`--token`|<b>`string`</b><br/>Set the OAuth token to use.|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|
