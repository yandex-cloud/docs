---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-services/organization-manager/federation/index.md
---

# yc organization-manager federation

Manage federations

#### Command Usage

Syntax: 

`yc organization-manager federation <group>`

Aliases: 

- `federations`

#### Command Tree

- [yc organization-manager federation saml](saml/index.md) — Manage SAML-compatible identity federations
	- [yc organization-manager federation saml get](saml/get.md) — Show information about the specified federation
	- [yc organization-manager federation saml list](saml/list.md) — List federations
	- [yc organization-manager federation saml create](saml/create.md) — Create a federation
	- [yc organization-manager federation saml update](saml/update.md) — Update the specified federation
	- [yc organization-manager federation saml delete](saml/delete.md) — Delete the specified federation
	- [yc organization-manager federation saml add-user-accounts](saml/add-user-accounts.md) — Add user accounts to the specified federation
	- [yc organization-manager federation saml list-user-accounts](saml/list-user-accounts.md) — List user accounts of the specified federation
	- [yc organization-manager federation saml list-operations](saml/list-operations.md) — List operations for the specified federation

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
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|
