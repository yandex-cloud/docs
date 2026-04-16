---
editable: false
---

# yc managed-kafka connector-iceberg-sink create

Create a Kafka Iceberg-Sink connector.

#### Command Usage

Syntax:

`yc managed-kafka connector-iceberg-sink create <CONNECTOR-NAME> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--cluster-id` | `string`

Kafka cluster id. ||
|| `--cluster-name` | `string`

Kafka cluster name. ||
|| `--tasks-max` | `int`

Maximum number of iceberg-sink connector tasks. ||
|| `--properties` | `key=value[,key=value...]`

Additional properties for the Kafka iceberg-sink connector as key-value pairs. ||
|| `--topics` | `string`

List of topics, separated by comma, that will be replicated to Iceberg tables. ||
|| `--topics-regex` | `string`

Regex pattern for topics that will be replicated to Iceberg tables. ||
|| `--control-topic` | `string`

Control topic name for Iceberg connector. ||
|| `--catalog-uri` | `string`

Thrift URI of Hive Metastore. Format: "thrift://host:9083". ||
|| `--warehouse` | `string`

Warehouse root directory in S3. Format: "s3a://bucket-name/path/to/warehouse". ||
|| `--access-key-id` | `string`

ID of aws-compatible static-key. ||
|| `--secret-access-key` | `string`

Secret key of aws-compatible static-key. ||
|| `--storage-endpoint` | `string`

Endpoint of s3-compatible storage. Example: "storage.yandexcloud.net". ||
|| `--region` | `string`

Region of s3-compatible storage. Default: "us-east-1". ||
|| `--tables` | `string`

List of tables, separated by comma, for static table routing. ||
|| `--route-field` | `string`

Field in the message to define the target table for dynamic table routing. ||
|| `--default-commit-branch` | `string`

Default Git-like branch name for Iceberg commits. Default: "main". ||
|| `--default-id-columns` | `string`

List of columns used as identifiers for upsert operations, separated by comma. ||
|| `--default-partition-by` | `string`

Comma-separated list of columns or transform expressions for table partitioning. ||
|| `--evolve-schema-enabled` | Enable automatic schema evolution. Default: false. ||
|| `--schema-force-optional` | Force all columns to be nullable. Default: false. ||
|| `--schema-case-insensitive` | Enable case-insensitive field name matching. Default: false. ||
|| `--group-id-prefix` | `string`

Consumer group ID prefix for control topic. Default: "cg-control". ||
|| `--commit-interval-ms` | `int`

Interval between commits in milliseconds. Default: 300000 (5 minutes). ||
|| `--commit-timeout-ms` | `int`

Commit operation timeout in milliseconds. Default: 30000 (30 seconds). ||
|| `--commit-threads` | `int`

Number of threads for commit operations. Default: cores * 2. ||
|| `--transactional-prefix` | `string`

Prefix for transactional operations. Default: "". ||
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
|| `--syntax` | `string`

CLI syntax: 1 (legacy) or 2 (current). Omit to use default-syntax in the profile or the product default. ||
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