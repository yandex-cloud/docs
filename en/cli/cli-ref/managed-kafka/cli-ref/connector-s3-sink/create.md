---
editable: false
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