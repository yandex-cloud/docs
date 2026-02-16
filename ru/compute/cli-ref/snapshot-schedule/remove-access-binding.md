---
editable: false
sourcePath: en/_cli-ref/cli-ref/compute/cli-ref/snapshot-schedule/remove-access-binding.md
---

# yc compute snapshot-schedule remove-access-binding

Remove access binding for the specified snapshot schedule

#### Command Usage

Syntax:

`yc compute snapshot-schedule remove-access-binding <SNAPSHOT-SCHEDULE-NAME>|<SNAPSHOT-SCHEDULE-ID> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--id` | `string`

Snapshot schedule id. ||
|| `--name` | `string`

Snapshot schedule name. ||
|| `--role` | `string`

Binding role ID. ||
|| `--service-account-id` | `string`

Service account, whose access will be updated. ||
|| `--service-account-name` | `string`

Service account, whose access will be updated. ||
|| `--user-account-id` | `string`

User account, whose access will be updated. ||
|| `--user-yandex-login` | `string`

User account, whose access will be updated. ||
|| `--agent` | `string`

Agent service account, whose access will be updated; in SERVICE_ID:MICROSERVICE_ID format. ||
|| `--all-authenticated-users` | Access will be updated for all authenticated users ||
|| `--group-members` | `string`

Update access for members of the group with specified ID ||
|| `--organization-users` | `string`

Update access for users of organization with specified ID ||
|| `--federation-users` | `string`

Update access for users of federation with specified ID ||
|| `--subject` | `string`

Subject whose access will be updated; in TYPE:ID format, e.g. userAccount:&lt;ID&gt;, serviceAccount:&lt;ID&gt;, system:&lt;ID&gt;. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
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