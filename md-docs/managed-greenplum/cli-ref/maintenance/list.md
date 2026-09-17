[Документация Yandex Cloud](../../../index.md) > [Yandex MPP Analytics for PostgreSQL](../../index.md) > [Справочник CLI (англ.)](../index.md) > [maintenance](index.md) > list

# yc managed-greenplum maintenance list

List maintenances.

#### Command Usage

Syntax:

`yc managed-greenplum maintenance list [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--limit` | `int`

The maximum number of items to list. Default is 1000 items ||
|| `--page-token` | `string`

Page token pagination simplifies navigating large datasets by using a token to represent the current page. ||
|| `--cloud-id` | `string`

List by cloud ID. ||
|| `--folder-id` | `string`

List by folder ID. ||
|| `--resource-id` | `string`

List by resource ID. ||
|| `--filter` | `string`

Filter by status, resource type, or resource ID. ||
|| `--order-by` | `string`

Order by created time, scheduled start time, or actual start time. ||
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