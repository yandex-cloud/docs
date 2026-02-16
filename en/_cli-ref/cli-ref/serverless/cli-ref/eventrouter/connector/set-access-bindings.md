---
editable: false
---

# yc serverless eventrouter connector set-access-bindings

Set access bindings for the specified connector and delete all existing access bindings if there were any

#### Command Usage

Syntax:

`yc serverless eventrouter connector set-access-bindings <CONNECTOR-NAME>|<CONNECTOR-ID> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--id` | `string`

Connector id. ||
|| `--name` | `string`

Connector name. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--access-binding` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Access binding to set. Can be used multiple times.

Possible property names:

- `role`: Binding role ID.

- `service-account-id`: Service account, whose access will be updated.

- `service-account-name`: Service account, whose access will be updated.

- `user-account-id`: User account, whose access will be updated.

- `user-yandex-login`: User account, whose access will be updated.

- `all-authenticated-users`: Access will be updated for all authenticated users

- `group-members`: Update access for members of the group with specified ID

- `organization-users`: Update access for users of organization with specified ID

- `federation-users`: Update access for users of federation with specified ID

- `subject`: Subject whose access will be updated; in TYPE:ID format, e.g. userAccount:&lt;ID&gt;, serviceAccount:&lt;ID&gt;, system:&lt;ID&gt;. ||
|| `-y`, `--yes` | Automatic yes to prompts. ||
|#

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