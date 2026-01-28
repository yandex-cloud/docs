---
editable: false
sourcePath: en/_cli-ref/cli-ref/datatransfer/cli-ref/endpoint/update/postgres-source.md
---

# yc datatransfer endpoint update postgres-source

Update PostgreSQL source

#### Command Usage

Syntax:

`yc datatransfer endpoint update postgres-source [<ENDPOINT-ID>] [Flags...] [Global Flags...]`

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

Yandex Managed Service for PostgreSQL cluster ID ||
|| `--host` | `value[,value]`

PostgreSQL server host name or IP address ||
|| `--port` | `int`

PostgreSQL server port ||
|| `--ca-certificate` | `string`

Path to the CA certificate of the PostgreSQL server. Implies enabled TLS ||
|| `--subnet-id` | `string`

Yandex Virtual Private Cloud subnet ID to access the PostgreSQL server through ||
|| `--database` | `string`

Database name ||
|| `--user` | `string`

User name ||
|| `--raw-password` | `string`

Raw password value (unsafe, consider --password-file) ||
|| `--password-file` | `string`

Path to the file containing password ||
|| `-i`, `--include-table` | `value[,value]`

Do not transfer tables other than these ||
|| `-p`, `--exclude-table` | `value[,value]`

Do not transfer these tables ||
|| `--slot-lag-limit` | `int`

Terminate replication once the WAL lag on the slot exceeds the specified limit, in bytes. Unlimited by default ||
|| `--service-schema` | `string`

Schema to create auxiliary tables in ||
|| `-b`, `--transfer-before-data` | `value[,value]`

Schema objects to transfer before transferring data, one of [sequence, sequence_owned_by, table, primary_key, fk_constraint, default_values, constraint, index, view, function, trigger, type, rule, collation, policy, cast, materialized_view, sequence_set] ||
|| `-a`, `--transfer-after-data` | `value[,value]`

Schema objects to transfer after transferring data, one of [sequence, sequence_owned_by, table, primary_key, fk_constraint, default_values, constraint, index, view, function, trigger, type, rule, collation, policy, cast, materialized_view, sequence_set] ||
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