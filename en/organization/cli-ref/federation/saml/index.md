---
editable: false
---

# yc organization-manager federation saml

Manage SAML-compatible identity federations

#### Command Usage

Syntax:

`yc organization-manager federation saml <group|command>`

#### Command Tree

- [yc organization-manager federation saml add-domain](add-domain.md) — Add a domain to the specified federation

- [yc organization-manager federation saml add-labels](add-labels.md) — Add labels to specified federation

- [yc organization-manager federation saml add-user-accounts](add-user-accounts.md) — Add user accounts to the specified federation

- [yc organization-manager federation saml create](create.md) — Create a federation

- [yc organization-manager federation saml delete](delete.md) — Delete the specified federation

- [yc organization-manager federation saml delete-domain](delete-domain.md) — Delete a domain from the specified federation

- [yc organization-manager federation saml delete-user-accounts](delete-user-accounts.md) — Delete user accounts from the specified federation

- [yc organization-manager federation saml get](get.md) — Show information about the specified federation

- [yc organization-manager federation saml get-domain](get-domain.md) — Show information about the specified domain in the federation

- [yc organization-manager federation saml list](list.md) — List federations

- [yc organization-manager federation saml list-domains](list-domains.md) — List domains in the specified federation

- [yc organization-manager federation saml list-operations](list-operations.md) — List operations for the specified federation

- [yc organization-manager federation saml list-user-accounts](list-user-accounts.md) — List user accounts of the specified federation

- [yc organization-manager federation saml reactivate-user-accounts](reactivate-user-accounts.md) — Reactivate specified user accounts

- [yc organization-manager federation saml remove-labels](remove-labels.md) — Remove labels from specified federation

- [yc organization-manager federation saml suspend-user-accounts](suspend-user-accounts.md) — Suspend specified user accounts

- [yc organization-manager federation saml update](update.md) — Update the specified federation

- [yc organization-manager federation saml validate-domain](validate-domain.md) — Validate a domain in the specified federation

- [yc organization-manager federation saml certificate](certificate/index.md) — Manage certificates for the SAML-compatible identity federation

  - [yc organization-manager federation saml certificate create](certificate/create.md) — Create a certificate

  - [yc organization-manager federation saml certificate delete](certificate/delete.md) — Delete the specified certificate

  - [yc organization-manager federation saml certificate get](certificate/get.md) — Show information about the specified certificate

  - [yc organization-manager federation saml certificate list](certificate/list.md) — List certificates

  - [yc organization-manager federation saml certificate list-operations](certificate/list-operations.md) — List operations for the specified certificate

  - [yc organization-manager federation saml certificate update](certificate/update.md) — Update the specified certificate

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom configuration file. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--cloud-id` | `string`

Set the ID of the cloud to use. ||
|| `--folder-id` | `string`

Set the ID of the folder to use. ||
|| `--folder-name` | `string`

Set the name of the folder to use (will be resolved to id). ||
|| `--endpoint` | `string`

Set the Cloud API endpoint (host:port). ||
|| `--token` | `string`

Set the OAuth token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--format` | `string`

Set the output format: text (default), yaml, json, json-rest. ||
|| `--jq` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#