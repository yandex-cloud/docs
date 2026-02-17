---
editable: false
---

# yc compute maintenance list

List maintenances

#### Command Usage

Syntax:

`yc compute maintenance list [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--cloud-id` | `string`

List by cloud ID. ||
|| `--folder-id` | `string`

List by folder ID. ||
|| `--resource-id` | `string`

List by resource ID. ||
|| `--filter` | `string`

Filter by status, resource_type or resource_id. ||
|| `--order` | `string`

Order by created_at, start_scheduled_at or started_at. ||
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