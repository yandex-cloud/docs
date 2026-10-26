---
editable: false
canonical: https://yandex.cloud/en/docs/cli/cli-ref/managed-kafka/cli-ref/connector-s3-sink/create/
---

# yc managed-kafka connector-s3-sink create

Create a Kafka S3-Sink connector.

#### Command Usage

Syntax:

`yc managed-kafka connector-s3-sink create <CONNECTOR-NAME> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--cluster-id` | `string`

Kafka cluster id. ||
|| `--cluster-name` | `string`

Kafka cluster name. ||
|| `--tasks-max` | `int`

Maximum number of s3-sink connector tasks. ||
|| `--properties` | `key=value[,key=value...]`

Additional properties for the Kafka s3-sink connector as key-value pairs. ||
|| `--topics` | `string`

List of topics, separated by comma, that will be replicated to bucket of s3-compatible storage. ||
|| `--file-max-records` | `int`

Max records number per single file in bucket of s3-compatible storage. ||
|| `--bucket-name` | `string`

Bucket of s3-compatible storage. ||
|| `--access-key-id` | `string`

ID of aws-compatible static-key. ||
|| `--secret-access-key` | `string`

Secret key of aws-compatible static-key. ||
|| `--storage-endpoint` | `string`

Endpoint of s3-compatible storage. Example: "storage.yandexcloud.net". ||
|| `--region` | `string`

Region of s3-compatible storage. Default: "us-east-1". ||
|| `--file-compression-type` | `string`

Compression type of files, that will be placed in bucket of s3-compatible storage. This setting cannot be updated after cluster will be created. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
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