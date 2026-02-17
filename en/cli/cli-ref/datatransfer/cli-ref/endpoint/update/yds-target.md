---
editable: false
---

# yc datatransfer endpoint update yds-target

Update YDS target

#### Command Usage

Syntax:

`yc datatransfer endpoint update yds-target [<ENDPOINT-ID>] [Flags...] [Global Flags...]`

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
|| `--endpoint` | `string`

YDS endpoint ||
|| `--database` | `string`

Database ||
|| `--stream` | `string`

Stream ||
|| `--service-account-id` | `string`

Service account ID for interaction with database. ||
|| `--save-tx-order` | Save transaction order ||
|| `--subnet-id` | `string`

Yandex Virtual Private Cloud subnet ID to access the YDS through ||
|| `--security-group` | `value[,value]`

Yandex Virtual Private Cloud security group ID to associate with the endpoint ||
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