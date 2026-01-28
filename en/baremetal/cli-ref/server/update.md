---
editable: false
sourcePath: en/_cli-ref/cli-ref/baremetal/cli-ref/server/update.md
---

# yc baremetal server update

Update the specified server

#### Command Usage

Syntax:

`yc baremetal server update <SERVER-NAME>|<SERVER-ID> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--id` | `string`

Server id. ||
|| `--name` | `string`

Server name. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--new-name` | `string`

A new name of the server. ||
|| `--description` | `string`

Specifies a textual description of the server. ||
|| `--network-interfaces` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Adds a network interface spec to the server.

Possible property names:

- `private-subnet-id`: Specifies the ID of the private subnet that the interface will be part of.

- `public-subnet-id`: Specifies the ID of the public subnet that the interface will be part of.

- `private-subnet-name`: Specifies the name of the private subnet that the interface will be part of.

- `public-subnet-name`: Specifies the name of the public subnet that the interface will be part of.

- `ephemeral-public-subnet`: Creates an ephemeral public subnet for the interface. ||
|| `--labels` | `key=value[,key=value...]`

A list of label KEY=VALUE pairs to add. For example, to add two labels named 'foo' and 'bar', both with the value 'baz', use '--labels foo=baz,bar=baz'. ||
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