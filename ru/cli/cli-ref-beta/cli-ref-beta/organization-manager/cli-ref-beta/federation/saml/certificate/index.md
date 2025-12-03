---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/organization-manager/cli-ref-beta/federation/saml/certificate/index.md
---

# yc beta organization-manager federation saml certificate

A set of methods for managing certificates.

#### Command Usage

Syntax: 

`yc beta organization-manager federation saml certificate <command>`

#### Command Tree

- [yc beta organization-manager federation saml certificate create](create.md) — Creates a certificate in the specified federation.
- [yc beta organization-manager federation saml certificate delete](delete.md) — Deletes the specified certificate.
- [yc beta organization-manager federation saml certificate get](get.md) — Returns the specified certificate.
- [yc beta organization-manager federation saml certificate list](list.md) — Retrieves the list of certificates in the specified federation.
- [yc beta organization-manager federation saml certificate list-operations](list-operations.md) — Lists operations for the specified certificate.
- [yc beta organization-manager federation saml certificate update](update.md) — Updates the specified certificate.

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
