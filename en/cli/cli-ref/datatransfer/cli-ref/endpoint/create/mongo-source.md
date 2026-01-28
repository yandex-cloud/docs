---
editable: false
sourcePath: en/_cli-ref/cli-ref/datatransfer/cli-ref/endpoint/create/mongo-source.md
---

# yc datatransfer endpoint create mongo-source

Create MongoDB source

#### Command Usage

Syntax:

`yc datatransfer endpoint create mongo-source [<ENDPOINT-NAME>] [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--file` | `string`

Path to a file with grpc request, see proto files in the protobuf API specification: https://github.com/yandex-cloud/cloudapi/tree/master/yandex/cloud/datatransfer/v1 ||
|| `--name` | `string`

Endpoint name ||
|| `--description` | `string`

Endpoint description ||
|| `--labels` | `key=value[,key=value...]`

A list of label KEY=VALUE pairs to add. For example, to add two labels named 'foo' and 'bar', both with the value 'baz', use '--labels foo=baz,bar=baz'. ||
|| `--host` | `value[,value]`

MongoDB server host name or IP address ||
|| `--port` | `int`

MongoDB server host name or IP address ||
|| `--ca-certificate` | `string`

Path to the CA certificate of the MongoDB server. Implies enabled TLS ||
|| `--replica-set` | `string`

Replica set ||
|| `--cluster-id` | `string`

Yandex Managed MongoDB cluster ID ||
|| `--user` | `string`

User name ||
|| `--raw-password` | `string`

Raw password value (unsafe, consider --password-file) ||
|| `--password-file` | `string`

Path to the file containing password ||
|| `--auth-source` | `string`

Database name associated with the credentials ||
|| `--subnet-id` | `string`

Yandex Virtual Private Cloud subnet ID to access the MongoDB server through ||
|| `--security-group` | `value[,value]`

Yandex Virtual Private Cloud security group ID to associate with the endpoint ||
|| `--include-collection` | `value[,value]`

Do not transfer collections other than these. A collection is specified as {database_name}.{collection_name} ||
|| `--exclude-collection` | `value[,value]`

Do not transfer these collections. A collection is specified as {database_name}.{collection_name} ||
|| `--prefer-secondary` | Prefer secondary hosts in MongoDB cluster for reading data ||
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