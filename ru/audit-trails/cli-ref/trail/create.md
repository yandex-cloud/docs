---
editable: false
sourcePath: en/_cli-ref/cli-ref/audit-trails/cli-ref/trail/create.md
---

# yc audit-trails trail create

Create the specified trail

#### Command Usage

Syntax:

`yc audit-trails trail create <TRAIL-NAME> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--file` | `string`

Path to a file with a gRPC request to be executed, see proto files in the protobuf API specification: https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/audittrails/v1/trail_service.proto ||
|| `--name` | `string`

A name of the trail. ||
|| `--description` | `string`

Specifies the textual description of the trail. ||
|| `--labels` | `key=value[,key=value...]`

Specifies the list of label KEY=VALUE pairs to add. For example, to add two labels named 'foo' and 'bar', both with the value 'baz', use '--labels foo=baz,bar=baz'. ||
|| `--service-account-id` | `string`

Specifies the trail service account ID. ||
|| `--destination-bucket` | `string`

Specifies the name of the destination bucket. ||
|| `--destination-bucket-object-prefix` | `string`

Specifies the prefix for uploaded results of the trail. Requires specifying 'destination-bucket'. ||
|| `--destination-log-group-id` | `string`

Specifies the ID of the destination log group. ||
|| `--destination-yds-database-id` | `string`

Specifies the ID of the YDB hosting a destination YDS stream. Requires specifying 'destination-yds-stream'. ||
|| `--destination-yds-stream` | `string`

Specifies the name of the destination YDS stream. Requires specifying 'destination-yds-database-id'. ||
|| `--destination-yds-codec` | `string`

Codec for compressing events. Allowed values: RAW, GZIP, ZSTD. Default: RAW. ||
|| `--destination-eventrouter-connector-id` | `string`

Specifies the ID of the destination EventRouter Connector. ||
|| `--filter-all-folder-id` | `string`

Specifies the ID of the folder from which all management events will be collected. ||
|| `--filter-all-cloud-id` | `string`

Specifies the ID of the cloud from which all management events will be collected. ||
|| `--filter-all-organisation-id` | `string`

Specifies the ID of the organisation from which all management events will be collected. ||
|| `--filter-from-cloud-id` | `string`

Specifies the ID of the cloud which contain all folders specified at 'filter-some-folder-ids'. Deprecated ||
|| `--filter-some-folder-ids` | `value[,value]`

Specifies the list of folder IDs from which all management events will be collected. ||
|| `--filter-from-organisation-id` | `string`

Specifies the ID of the organisation which contain all clouds specified at 'filter-some-cloud-ids'. Deprecated ||
|| `--filter-some-cloud-ids` | `value[,value]`

Specifies a list of cloud IDs from which all management events will be collected. ||
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