[Документация Yandex Cloud](../../../../index.md) > [Yandex Managed Service for Trino](../../../index.md) > [Справочник CLI (англ.)](../../index.md) > [catalog](../index.md) > [update](index.md) > iceberg

# yc managed-trino catalog update iceberg

Update Iceberg catalog

#### Command Usage

Syntax:

`yc managed-trino catalog update iceberg <CATALOG-NAME> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--cluster-id` | `string`

Trino cluster id. ||
|| `--cluster-name` | `string`

Trino cluster name. ||
|| `--id` | `string`

Trino catalog id. ||
|| `--name` | `string`

Trino catalog name. ||
|| `--new-name` | `string`

New name for the Trino catalog ||
|| `--description` | `string`

Description of the catalog. ||
|| `--labels` | `key=value[,key=value...]`

A list of Trino catalog labels as key-value pairs. ||
|| `--metastore-hive-uri` | `string`

An URL of Hive Metastore. ||
|| `--metastore-hive-cluster-id` | `string`

ID of the managed Hive Metastore cluster. ||
|| `--filesystem-native-s3` | Native S3 filesystem. ||
|| `--filesystem-external-s3-aws-access-key` | `string`

External S3 filesystem AWS Access Key. ||
|| `--filesystem-external-s3-aws-secret-key` | `string`

External S3 filesystem AWS Secret Key. ||
|| `--filesystem-external-s3-aws-endpoint` | `string`

External S3 filesystem AWS Endpoint. ||
|| `--filesystem-external-s3-aws-region` | `string`

External S3 filesystem AWS Region. ||
|| `--metastore-rest-uri` | `string`

An URL of the Iceberg REST Catalog metastore. ||
|| `--metastore-hive-protocol` | `string`

Protocol for connecting to the Hive Metastore: thrift or rest (Iceberg REST). ||
|| `--additional-properties` | `key=value[,key=value...]`

A list of Trino catalog additional properties as key-value pairs. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
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