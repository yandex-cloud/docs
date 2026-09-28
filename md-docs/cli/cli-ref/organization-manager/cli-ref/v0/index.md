[Документация Yandex Cloud](../../../../../index.md) > [Интерфейс командной строки](../../../../index.md) > [Справочник (англ.)](../../../index.md) > [organization-manager](../index.md) > v0 > Overview

# yc organization-manager v0

Manage Yandex Cloud Organization Manager resources

#### Command Usage

Syntax:

`yc organization-manager v0 <group>`

#### Command Tree

- [yc organization-manager v0 federation](federation/index.md) — Manage federations



- [yc organization-manager v0 group](group/index.md) — Manage groups in organizations

  - [yc organization-manager v0 group add-access-binding](group/add-access-binding.md) — Add access binding for the specified group

  - [yc organization-manager v0 group add-labels](group/add-labels.md) — Add labels to specified group

  - [yc organization-manager v0 group add-members](group/add-members.md) — Add members to the specified group

  - [yc organization-manager v0 group create](group/create.md) — Create a group

  - [yc organization-manager v0 group delete](group/delete.md) — Delete the specified group

  - [yc organization-manager v0 group get](group/get.md) — Show information about the specified group

  - [yc organization-manager v0 group list](group/list.md) — List groups

  - [yc organization-manager v0 group list-access-bindings](group/list-access-bindings.md) — List access bindings for the specified group

  - [yc organization-manager v0 group list-effective](group/list-effective.md) — List groups that the subject belongs to within a specific organization.

  - [yc organization-manager v0 group list-members](group/list-members.md) — List members of the specified group

  - [yc organization-manager v0 group list-operations](group/list-operations.md) — List operations for the specified group

  - [yc organization-manager v0 group remove-access-binding](group/remove-access-binding.md) — Remove access binding for the specified group

  - [yc organization-manager v0 group remove-labels](group/remove-labels.md) — Remove labels from specified group

  - [yc organization-manager v0 group remove-members](group/remove-members.md) — Remove members from the specified group

  - [yc organization-manager v0 group set-access-bindings](group/set-access-bindings.md) — Set access bindings for the specified group and delete all existing access bindings if there were any

  - [yc organization-manager v0 group update](group/update.md) — Update the specified group

- [yc organization-manager v0 idp](idp/index.md) — Manage Identity Provider



- [yc organization-manager v0 mfa-enforcement](mfa-enforcement/index.md) — Manage MFA enforcements in organizations

  - [yc organization-manager v0 mfa-enforcement activate](mfa-enforcement/activate.md) — Activate the specified mfa enforcement

  - [yc organization-manager v0 mfa-enforcement create](mfa-enforcement/create.md) — Create mfa enforcement

  - [yc organization-manager v0 mfa-enforcement deactivate](mfa-enforcement/deactivate.md) — Deactivate the specified mfa enforcement

  - [yc organization-manager v0 mfa-enforcement delete](mfa-enforcement/delete.md) — Delete the specified mfa enforcement

  - [yc organization-manager v0 mfa-enforcement get](mfa-enforcement/get.md) — Show information about the specified mfa enforcement

  - [yc organization-manager v0 mfa-enforcement list](mfa-enforcement/list.md) — List mfa enforcements

  - [yc organization-manager v0 mfa-enforcement list-audience](mfa-enforcement/list-audience.md) — List audience for the specified mfa enforcement

  - [yc organization-manager v0 mfa-enforcement list-excluded-audience](mfa-enforcement/list-excluded-audience.md) — List excluded audience for the specified mfa enforcement

  - [yc organization-manager v0 mfa-enforcement update](mfa-enforcement/update.md) — Update the specified mfa enforcement

  - [yc organization-manager v0 mfa-enforcement update-audience](mfa-enforcement/update-audience.md) — Update audience for the specified mfa enforcement

  - [yc organization-manager v0 mfa-enforcement update-excluded-audience](mfa-enforcement/update-excluded-audience.md) — Update excluded audience for the specified mfa enforcement

- [yc organization-manager v0 organization](organization/index.md) — Manage organizations

  - [yc organization-manager v0 organization add-access-binding](organization/add-access-binding.md) — Add access binding for the specified organization

  - [yc organization-manager v0 organization add-labels](organization/add-labels.md) — Add labels to specified organization

  - [yc organization-manager v0 organization bind-access-policy](organization/bind-access-policy.md) — Bind access policy to the specified organization

  - [yc organization-manager v0 organization get](organization/get.md) — Show information about the specified organization

  - [yc organization-manager v0 organization leave](organization/leave.md) — Remove user accounts from the specified organization. Operation is performed by the account that wants to leave.

  - [yc organization-manager v0 organization list](organization/list.md) — List organizations

  - [yc organization-manager v0 organization list-access-bindings](organization/list-access-bindings.md) — List access bindings for the specified organization

  - [yc organization-manager v0 organization list-access-policy-bindings](organization/list-access-policy-bindings.md) — List access policy bindings for the specified organization

  - [yc organization-manager v0 organization list-operations](organization/list-operations.md) — List operations for the specified organization

  - [yc organization-manager v0 organization remove-access-binding](organization/remove-access-binding.md) — Remove access binding for the specified organization

  - [yc organization-manager v0 organization remove-labels](organization/remove-labels.md) — Remove labels from specified organization

  - [yc organization-manager v0 organization set-access-bindings](organization/set-access-bindings.md) — Set access bindings for the specified organization and delete all existing access bindings if there were any

  - [yc organization-manager v0 organization unbind-access-policy](organization/unbind-access-policy.md) — Unbind access policy from the specified organization

  - [yc organization-manager v0 organization update](organization/update.md) — Update the specified organization

- [yc organization-manager v0 oslogin](oslogin/index.md) — Setting up OS Login

  - [yc organization-manager v0 oslogin get-settings](oslogin/get-settings.md) — Show information about OS Login settings for the specified organization.

  - [yc organization-manager v0 oslogin update-settings](oslogin/update-settings.md) — Update OS Login settings for the specified organization.

- [yc organization-manager v0 user](user/index.md) — Manage users in organizations

  - [yc organization-manager v0 user list](user/list.md) — List user accounts of the specified organization

  - [yc organization-manager v0 user remove](user/remove.md) — Remove user accounts from the specified organization

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--cloud-id` | `string`

Set the ID of the cloud to use. ||
|| `--folder-id` | `string`

Set the ID of the folder to use. ||
|| `--folder-name` | `string`

Set the name of the folder to use (will be resolved to id). ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--no-pager` | Do not pipe help output through a pager. ||
|| `--format` | `string`

Set the output format: text (default), yaml, json, json-rest. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the OAuth token to use. ||
|| `--jq` | `string`

Query to select values from the response using jq syntax ||
|| `--endpoint` | `string`

Set the Cloud API endpoint (host:port). ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `--print-metadata` | Print operation metadata along with result. ||
|| `--syntax` | `string`

Choose syntax option. ||
|| `--cli-auto-prompt` | `string[="on"]`

Enable interactive auto-prompt mode. Values: on, partial, off. Bare --cli-auto-prompt is equivalent to --cli-auto-prompt=on. ||
|| `--no-cli-auto-prompt` | Disable interactive auto-prompt mode (overrides --cli-auto-prompt, env and profile). ||
|| `-h`, `--help` | Display help for the command. ||
|#