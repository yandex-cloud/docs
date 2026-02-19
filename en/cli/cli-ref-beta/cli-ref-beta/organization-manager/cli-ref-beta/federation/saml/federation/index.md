---
editable: false
noIndex: true
---

# yc beta organization-manager federation saml federation

A set of methods for managing federations.

#### Command Usage

Syntax:

`yc beta organization-manager federation saml federation <command>`

#### Command Tree

- [yc beta organization-manager federation saml federation add-domain](add-domain.md) — Adds a domain to the specified federation.

- [yc beta organization-manager federation saml federation add-user-accounts](add-user-accounts.md) — Adds users to the specified federation.

- [yc beta organization-manager federation saml federation create](create.md) — Creates a federation in the specified organization.

- [yc beta organization-manager federation saml federation delete](delete.md) — Deletes the specified federation.

- [yc beta organization-manager federation saml federation delete-domain](delete-domain.md) — Deletes the specified domain from the federation.

- [yc beta organization-manager federation saml federation delete-user-accounts](delete-user-accounts.md) — Deletes users from the specified federation.

- [yc beta organization-manager federation saml federation get](get.md) — Returns the specified federation.

- [yc beta organization-manager federation saml federation get-domain](get-domain.md) — Returns the specified domain in the federation.

- [yc beta organization-manager federation saml federation list](list.md) — Retrieves the list of federations in the specified organization.

- [yc beta organization-manager federation saml federation list-domains](list-domains.md) — Retrieves the list of domains in the specified federation.

- [yc beta organization-manager federation saml federation list-operations](list-operations.md) — Lists operations for the specified federation.

- [yc beta organization-manager federation saml federation list-user-accounts](list-user-accounts.md) — Lists users for the specified federation.

- [yc beta organization-manager federation saml federation reactivate-user-accounts](reactivate-user-accounts.md) — Reactivate federated user accounts.

- [yc beta organization-manager federation saml federation suspend-user-accounts](suspend-user-accounts.md) — Suspend federated user accounts.

- [yc beta organization-manager federation saml federation update](update.md) — Updates the specified federation.

- [yc beta organization-manager federation saml federation validate-domain](validate-domain.md) — Validates a domain in the specified federation.

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