# yc organization-manager federation saml

Manage SAML-compatible identity federations

#### Command Usage

Syntax: 

`yc organization-manager federation saml <group|command>`

#### Command Tree

- [yc organization-manager federation saml get](get.md) — Show information about the specified federation
- [yc organization-manager federation saml list](list.md) — List federations
- [yc organization-manager federation saml create](create.md) — Create a federation
- [yc organization-manager federation saml update](update.md) — Update the specified federation
- [yc organization-manager federation saml delete](delete.md) — Delete the specified federation
- [yc organization-manager federation saml add-user-accounts](add-user-accounts.md) — Add user accounts to the specified federation
- [yc organization-manager federation saml list-user-accounts](list-user-accounts.md) — List user accounts of the specified federation
- [yc organization-manager federation saml list-operations](list-operations.md) — List operations for the specified federation
- [yc organization-manager federation saml certificate](certificate/index.md) — Manage certificates for the SAML-compatible identity federation
	- [yc organization-manager federation saml certificate get](certificate/get.md) — Show information about the specified certificate
	- [yc organization-manager federation saml certificate list](certificate/list.md) — List certificates
	- [yc organization-manager federation saml certificate create](certificate/create.md) — Create a certificate
	- [yc organization-manager federation saml certificate update](certificate/update.md) — Update the specified certificate
	- [yc organization-manager federation saml certificate delete](certificate/delete.md) — Delete the specified certificate
	- [yc organization-manager federation saml certificate list-operations](certificate/list-operations.md) — List operations for the specified certificate

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
