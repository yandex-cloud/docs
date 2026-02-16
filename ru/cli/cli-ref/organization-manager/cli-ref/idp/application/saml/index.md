---
editable: false
sourcePath: en/_cli-ref/cli-ref/organization-manager/cli-ref/idp/application/saml/index.md
---

# yc organization-manager idp application saml

Manage SAML applications and related resources

#### Command Usage

Syntax:

`yc organization-manager idp application saml <group>`

Aliases:

- `application-saml`

#### Command Tree

- [yc organization-manager idp application saml application](application/index.md) — Manage SAML applications

  - [yc organization-manager idp application saml application add-access-bindings](application/add-access-bindings.md) — Add access bindings for the specified SAML application

  - [yc organization-manager idp application saml application add-assignments](application/add-assignments.md) — Add user assignments for the specified SAML application

  - [yc organization-manager idp application saml application create](application/create.md) — Create a SAML application

  - [yc organization-manager idp application saml application delete](application/delete.md) — Delete the specified SAML application

  - [yc organization-manager idp application saml application get](application/get.md) — Show information about the specified SAML application

  - [yc organization-manager idp application saml application list](application/list.md) — List SAML applications

  - [yc organization-manager idp application saml application list-access-bindings](application/list-access-bindings.md) — List access bindings for the specified SAML application

  - [yc organization-manager idp application saml application list-assignments](application/list-assignments.md) — List user assignments for the specified SAML application

  - [yc organization-manager idp application saml application list-operations](application/list-operations.md) — List operations for the specified SAML application

  - [yc organization-manager idp application saml application list-supported-attribute-values](application/list-supported-attribute-values.md) — List supported attribute values for SAML applications

  - [yc organization-manager idp application saml application reactivate](application/reactivate.md) — Reactivate a previously suspended SAML application

  - [yc organization-manager idp application saml application remove-access-bindings](application/remove-access-bindings.md) — Remove access bindings from the specified SAML application

  - [yc organization-manager idp application saml application remove-assignments](application/remove-assignments.md) — Remove user assignments from the specified SAML application

  - [yc organization-manager idp application saml application set-access-bindings](application/set-access-bindings.md) — Set access bindings for the specified SAML application

  - [yc organization-manager idp application saml application suspend](application/suspend.md) — Suspend the specified SAML application

  - [yc organization-manager idp application saml application update](application/update.md) — Update the specified SAML application

  - [yc organization-manager idp application saml application update-assignments](application/update-assignments.md) — Update user assignments for the specified SAML application

- [yc organization-manager idp application saml signature-certificate](signature-certificate/index.md) — Manage SAML signature certificates

  - [yc organization-manager idp application saml signature-certificate create](signature-certificate/create.md) — Create a SAML signature certificate

  - [yc organization-manager idp application saml signature-certificate delete](signature-certificate/delete.md) — Delete the specified SAML signature certificate

  - [yc organization-manager idp application saml signature-certificate get](signature-certificate/get.md) — Show information about the specified SAML signature certificate

  - [yc organization-manager idp application saml signature-certificate list](signature-certificate/list.md) — List SAML signature certificates

  - [yc organization-manager idp application saml signature-certificate update](signature-certificate/update.md) — Update the specified SAML signature certificate

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