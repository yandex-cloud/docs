---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-services/certificate-manager/index.md
---

# yc certificate-manager

Manage Certificate Manager resources

#### Command Usage

Syntax: 

`yc certificate-manager <group>`

Aliases: 

- `cm`

#### Command Tree

- [yc certificate-manager certificate](certificate/index.md) — Manage certificates
	- [yc certificate-manager certificate get](certificate/get.md) — Show information about the specified certificate
	- [yc certificate-manager certificate content](certificate/content.md) — Download content of the specified certificate: chain and private key
	- [yc certificate-manager certificate list](certificate/list.md) — List certificates in the specified folder
	- [yc certificate-manager certificate create](certificate/create.md) — Create an imported certificate
	- [yc certificate-manager certificate request](certificate/request.md) — Request a managed certificate
	- [yc certificate-manager certificate update](certificate/update.md) — Update the specified certificate
	- [yc certificate-manager certificate delete](certificate/delete.md) — Delete the specified certificate
	- [yc certificate-manager certificate list-operations](certificate/list-operations.md) — List operations for the specified certificate
	- [yc certificate-manager certificate list-access-bindings](certificate/list-access-bindings.md) — List access bindings for the specified certificate
	- [yc certificate-manager certificate set-access-bindings](certificate/set-access-bindings.md) — Set access bindings for the specified certificate and delete all existing access bindings if there were any
	- [yc certificate-manager certificate add-access-binding](certificate/add-access-binding.md) — Add access binding for the specified certificate
	- [yc certificate-manager certificate remove-access-binding](certificate/remove-access-binding.md) — Remove access binding for the specified certificate

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
