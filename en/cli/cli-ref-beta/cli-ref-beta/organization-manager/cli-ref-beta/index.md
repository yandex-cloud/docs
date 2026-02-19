---
editable: false
noIndex: true
---

# yc beta organization-manager

Manage Yandex Organization Manager resources

#### Command Usage

Syntax:

`yc beta organization-manager <group>`

#### Command Tree

- [yc beta organization-manager federation](federation/index.md) — 



- [yc beta organization-manager group](group/index.md) — A set of methods for managing groups.

  - [yc beta organization-manager group convert-all-to-basic](group/convert-all-to-basic.md) — Converts all groups that belongs to subject container from external to basic (not external).

  - [yc beta organization-manager group convert-to-external](group/convert-to-external.md) — Converts single basic (not external) group to external. Precondition: group must be basic.

  - [yc beta organization-manager group create](group/create.md) — Creates a group in the specified organization.

  - [yc beta organization-manager group create-external](group/create-external.md) — Creates an external group.

  - [yc beta organization-manager group delete](group/delete.md) — Deletes the specified group.

  - [yc beta organization-manager group get](group/get.md) — Returns the specified Group resource.

  - [yc beta organization-manager group list](group/list.md) — Retrieves the list of group resources.

  - [yc beta organization-manager group list-access-bindings](group/list-access-bindings.md) — Lists access bindings for the specified group.

  - [yc beta organization-manager group list-effective](group/list-effective.md) — Returns groups that the subject belongs to within a specific organization.

  - [yc beta organization-manager group list-external](group/list-external.md) — Retrieves the list of external group linked subject container

  - [yc beta organization-manager group list-members](group/list-members.md) — List group active members.

  - [yc beta organization-manager group list-operations](group/list-operations.md) — Lists operations for the specified group.

  - [yc beta organization-manager group resolve-external](group/resolve-external.md) — Returns external group by subject container and external id

  - [yc beta organization-manager group set-access-bindings](group/set-access-bindings.md) — Sets access bindings for the specified group.

  - [yc beta organization-manager group update](group/update.md) — Updates the specified group.

  - [yc beta organization-manager group update-access-bindings](group/update-access-bindings.md) — Updates access bindings for the specified group.

  - [yc beta organization-manager group update-members](group/update-members.md) — Update group members.

- [yc beta organization-manager idp](idp/index.md) — 



- [yc beta organization-manager mfa-enforcement](mfa-enforcement/index.md) — a set of methods for managing MFA enforcements

  - [yc beta organization-manager mfa-enforcement activate](mfa-enforcement/activate.md) — activates the specified MFA enforcement

  - [yc beta organization-manager mfa-enforcement create](mfa-enforcement/create.md) — creates an MFA enforcement in the specified organization

  - [yc beta organization-manager mfa-enforcement deactivate](mfa-enforcement/deactivate.md) — deactivates the specified MFA enforcement

  - [yc beta organization-manager mfa-enforcement delete](mfa-enforcement/delete.md) — deletes the specified MFA enforcement

  - [yc beta organization-manager mfa-enforcement get](mfa-enforcement/get.md) — returns the specified MFA enforcement

  - [yc beta organization-manager mfa-enforcement list](mfa-enforcement/list.md) — returns MFA enforcements for the specified organization

  - [yc beta organization-manager mfa-enforcement list-audience](mfa-enforcement/list-audience.md) — returns specified MFA enforcement's audience

  - [yc beta organization-manager mfa-enforcement update](mfa-enforcement/update.md) — updates the specified MFA enforcement

  - [yc beta organization-manager mfa-enforcement update-audience](mfa-enforcement/update-audience.md) — updates specified MFA enforcement's audience

- [yc beta organization-manager organization](organization/index.md) — A set of methods for managing Organization resources.

  - [yc beta organization-manager organization bind-access-policy](organization/bind-access-policy.md) — Binds the access policy template to the organization.

  - [yc beta organization-manager organization get](organization/get.md) — Returns the specified Organization resource.

  - [yc beta organization-manager organization list](organization/list.md) — Retrieves the list of Organization resources.

  - [yc beta organization-manager organization list-access-bindings](organization/list-access-bindings.md) — Lists access bindings for the specified organization.

  - [yc beta organization-manager organization list-access-policy-bindings](organization/list-access-policy-bindings.md) — Returns list of access policy bindings for the organization.

  - [yc beta organization-manager organization list-operations](organization/list-operations.md) — Lists operations for the specified organization.

  - [yc beta organization-manager organization set-access-bindings](organization/set-access-bindings.md) — Sets access bindings for the specified organization.

  - [yc beta organization-manager organization unbind-access-policy](organization/unbind-access-policy.md) — Unbinds the access policy template from the organization.

  - [yc beta organization-manager organization update](organization/update.md) — Updates the specified organization.

  - [yc beta organization-manager organization update-access-bindings](organization/update-access-bindings.md) — Updates access bindings for the specified organization.

- [yc beta organization-manager oslogin](oslogin/index.md) — 



- [yc beta organization-manager ssh-certificate](ssh-certificate/index.md) — 

  - [yc beta organization-manager ssh-certificate generate](ssh-certificate/generate.md) — Members of an organization can generate certificates for themselves

- [yc beta organization-manager user](user/index.md) — A set of methods for managing Organization users.

  - [yc beta organization-manager user delete-membership](user/delete-membership.md) — Delete user membership.

  - [yc beta organization-manager user list-members](user/list-members.md) — List organization active members.

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