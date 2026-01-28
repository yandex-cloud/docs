---
editable: false
sourcePath: en/_cli-ref/cli-ref/organization-manager/cli-ref/idp/application/saml/application/index.md
---

# yc organization-manager idp application saml application

Manage SAML applications

#### Command Usage

Syntax:

`yc organization-manager idp application saml application <command>`

Aliases:

- `application-saml-applications`

#### Command Tree

- [yc organization-manager idp application saml application add-access-bindings](add-access-bindings.md) — Add access bindings for the specified SAML application

- [yc organization-manager idp application saml application add-assignments](add-assignments.md) — Add user assignments for the specified SAML application

- [yc organization-manager idp application saml application create](create.md) — Create a SAML application

- [yc organization-manager idp application saml application delete](delete.md) — Delete the specified SAML application

- [yc organization-manager idp application saml application get](get.md) — Show information about the specified SAML application

- [yc organization-manager idp application saml application list](list.md) — List SAML applications

- [yc organization-manager idp application saml application list-access-bindings](list-access-bindings.md) — List access bindings for the specified SAML application

- [yc organization-manager idp application saml application list-assignments](list-assignments.md) — List user assignments for the specified SAML application

- [yc organization-manager idp application saml application list-operations](list-operations.md) — List operations for the specified SAML application

- [yc organization-manager idp application saml application list-supported-attribute-values](list-supported-attribute-values.md) — List supported attribute values for SAML applications

- [yc organization-manager idp application saml application reactivate](reactivate.md) — Reactivate a previously suspended SAML application

- [yc organization-manager idp application saml application remove-access-bindings](remove-access-bindings.md) — Remove access bindings from the specified SAML application

- [yc organization-manager idp application saml application remove-assignments](remove-assignments.md) — Remove user assignments from the specified SAML application

- [yc organization-manager idp application saml application set-access-bindings](set-access-bindings.md) — Set access bindings for the specified SAML application

- [yc organization-manager idp application saml application suspend](suspend.md) — Suspend the specified SAML application

- [yc organization-manager idp application saml application update](update.md) — Update the specified SAML application

- [yc organization-manager idp application saml application update-assignments](update-assignments.md) — Update user assignments for the specified SAML application

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