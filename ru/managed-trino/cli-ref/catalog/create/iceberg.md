---
editable: false
---

# yc managed-trino catalog create iceberg

Create Iceberg catalog

#### Command Usage

Syntax:

`yc managed-trino catalog create iceberg <CATALOG-NAME> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--cluster-id` | `string`

Trino cluster id. ||
|| `--cluster-name` | `string`

Trino cluster name. ||
|| `--name` | `string`

Name of the Trino catalog. ||
|| `--description` | `string`

Description of the catalog. ||
|| `--labels` | `key=value[,key=value...]`

A list of Trino catalog labels as key-value pairs. ||
|| `--metastore-hive-uri` | `string`

An URL of Hive Metastore. ||
|| `--filesystem-native-s3` | Native S3 filesystem. ||
|| `--filesystem-external-s3-aws-access-key` | `string`

External S3 filesystem AWS Access Key. ||
|| `--filesystem-external-s3-aws-secret-key` | `string`

External S3 filesystem AWS Secret Key. ||
|| `--filesystem-external-s3-aws-endpoint` | `string`

External S3 filesystem AWS Endpoint. ||
|| `--filesystem-external-s3-aws-region` | `string`

External S3 filesystem AWS Region. ||
|| `--additional-properties` | `key=value[,key=value...]`

A list of Trino catalog additional properties as key-value pairs. ||
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