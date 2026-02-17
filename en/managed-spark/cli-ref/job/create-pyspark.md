---
editable: false
---

# yc managed-spark job create-pyspark

Create PySpark job.

#### Command Usage

Syntax:

`yc managed-spark job create-pyspark [Flags...] [Global Flags...]`

Aliases:

- `submit-pyspark`

#### Flags

#|
||Flag | Description ||
|| `--cluster-id` | `string`

Spark cluster id. ||
|| `--cluster-name` | `string`

Spark cluster name. ||
|| `--name` | `string`

Optional job name ||
|| `--main-python-file-uri` | `string`

Main Python file URI ||
|| `--python-file-uris` | `value[,value]`

Python file URIs ||
|| `--jar-file-uris` | `value[,value]`

JAR file URIs ||
|| `--file-uris` | `value[,value]`

File URIs ||
|| `--archive-uris` | `value[,value]`

Archive URIs ||
|| `--packages` | `value[,value]`

Packages ||
|| `--repositories` | `value[,value]`

Repositories ||
|| `--exclude-packages` | `value[,value]`

Packages to exclude ||
|| `--properties` | `stringToString`

Properties ||
|| `--args` | `value[,value]`

Arguments ||
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