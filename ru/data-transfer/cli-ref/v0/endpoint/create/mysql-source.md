---
editable: false
canonical: https://yandex.cloud/en/docs/cli/cli-ref/datatransfer/cli-ref/v0/endpoint/create/mysql-source/
---

# yc datatransfer v0 endpoint create mysql-source

Create MySQL source

#### Command Usage

Syntax:

`yc datatransfer v0 endpoint create mysql-source [<ENDPOINT-NAME>] [Flags...] [Global Flags...]`

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
|| `--cluster-id` | `string`

Yandex Managed MySQL cluster ID ||
|| `--host` | `[]string`

MySQL server host name or IP address ||
|| `--port` | `int`

MySQL server port ||
|| `--ca-certificate` | `string`

Path to the CA certificate of the MySQL server. Implies enabled TLS ||
|| `--subnet-id` | `string`

Yandex Virtual Private Cloud subnet ID to access the MySQL server through ||
|| `--database` | `string`

Database name ||
|| `--user` | `string`

User name ||
|| `--raw-password` | `string`

Raw password value (unsafe, consider --password-file) ||
|| `--password-file` | `string`

Path to the file containing password ||
|| `-i`, `--include-table-regex` | `[]string`

Do not transfer the tables which do not match the specified regular expression ||
|| `-p`, `--exclude-table-regex` | `[]string`

Do not transfer the tables which match the specified regular expression ||
|| `--timezone` | `string`

Used for parsing timestamps for saving source timezones. Accepts values from IANA timezone database. Defaults to the local timezone ||
|| `-b`, `--transfer-before-data` | `[]string`

Schema objects to transfer before transferring data, one of [view, routine, trigger, tables] ||
|| `-a`, `--transfer-after-data` | `[]string`

Schema objects to transfer after transferring data, one of [view, routine, trigger, tables] ||
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