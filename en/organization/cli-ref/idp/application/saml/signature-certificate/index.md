---
editable: false
sourcePath: en/_cli-ref/cli-ref/organization-manager/cli-ref/idp/application/saml/signature-certificate/index.md
---

# yc organization-manager idp application saml signature-certificate

Manage SAML signature certificates

#### Command Usage

Syntax: 

`yc organization-manager idp application saml signature-certificate <command>`

Aliases: 

- `signature-certificates`

#### Command Tree

- [yc organization-manager idp application saml signature-certificate create](create.md) — Create a SAML signature certificate
- [yc organization-manager idp application saml signature-certificate delete](delete.md) — Delete the specified SAML signature certificate
- [yc organization-manager idp application saml signature-certificate get](get.md) — Show information about the specified SAML signature certificate
- [yc organization-manager idp application saml signature-certificate list](list.md) — List SAML signature certificates
- [yc organization-manager idp application saml signature-certificate update](update.md) — Update the specified SAML signature certificate

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
