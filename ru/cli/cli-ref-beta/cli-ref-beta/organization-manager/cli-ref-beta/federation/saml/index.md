---
editable: false
noIndex: true
---

# yc beta organization-manager federation saml



#### Command Usage

Syntax:

`yc beta organization-manager federation saml <group>`

#### Command Tree

- [yc beta organization-manager federation saml certificate](certificate/index.md) — A set of methods for managing certificates.

  - [yc beta organization-manager federation saml certificate create](certificate/create.md) — Creates a certificate in the specified federation.

  - [yc beta organization-manager federation saml certificate delete](certificate/delete.md) — Deletes the specified certificate.

  - [yc beta organization-manager federation saml certificate get](certificate/get.md) — Returns the specified certificate.

  - [yc beta organization-manager federation saml certificate list](certificate/list.md) — Retrieves the list of certificates in the specified federation.

  - [yc beta organization-manager federation saml certificate list-operations](certificate/list-operations.md) — Lists operations for the specified certificate.

  - [yc beta organization-manager federation saml certificate update](certificate/update.md) — Updates the specified certificate.

- [yc beta organization-manager federation saml federation](federation/index.md) — A set of methods for managing federations.

  - [yc beta organization-manager federation saml federation add-domain](federation/add-domain.md) — Adds a domain to the specified federation.

  - [yc beta organization-manager federation saml federation add-user-accounts](federation/add-user-accounts.md) — Adds users to the specified federation.

  - [yc beta organization-manager federation saml federation create](federation/create.md) — Creates a federation in the specified organization.

  - [yc beta organization-manager federation saml federation delete](federation/delete.md) — Deletes the specified federation.

  - [yc beta organization-manager federation saml federation delete-domain](federation/delete-domain.md) — Deletes the specified domain from the federation.

  - [yc beta organization-manager federation saml federation delete-user-accounts](federation/delete-user-accounts.md) — Deletes users from the specified federation.

  - [yc beta organization-manager federation saml federation get](federation/get.md) — Returns the specified federation.

  - [yc beta organization-manager federation saml federation get-domain](federation/get-domain.md) — Returns the specified domain in the federation.

  - [yc beta organization-manager federation saml federation list](federation/list.md) — Retrieves the list of federations in the specified organization.

  - [yc beta organization-manager federation saml federation list-domains](federation/list-domains.md) — Retrieves the list of domains in the specified federation.

  - [yc beta organization-manager federation saml federation list-operations](federation/list-operations.md) — Lists operations for the specified federation.

  - [yc beta organization-manager federation saml federation list-user-accounts](federation/list-user-accounts.md) — Lists users for the specified federation.

  - [yc beta organization-manager federation saml federation reactivate-user-accounts](federation/reactivate-user-accounts.md) — Reactivate federated user accounts.

  - [yc beta organization-manager federation saml federation suspend-user-accounts](federation/suspend-user-accounts.md) — Suspend federated user accounts.

  - [yc beta organization-manager federation saml federation update](federation/update.md) — Updates the specified federation.

  - [yc beta organization-manager federation saml federation validate-domain](federation/validate-domain.md) — Validates a domain in the specified federation.

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--format` | `string`

Set the output format: text, yaml, json, table, summary \|\| summary[name, instance.id, instance.disks[0].size]. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the IAM token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#