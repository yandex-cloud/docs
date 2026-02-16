---
editable: false
sourcePath: en/_cli-ref/cli-ref/vpc/cli-ref/private-endpoint/create.md
---

# yc vpc private-endpoint create

Create a private endpoint.

#### Command Usage

Syntax:

`yc vpc private-endpoint create <PRIVATE-ENDPOINT-NAME> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--name` | `string`

Name of the private endpoint. ||
|| `--network-id` | `string`

ID of the network to which the private endpoint belongs. ||
|| `--network-name` | `string`

Name of the network to which the private endpoint belongs. ||
|| `--object-storage` | Object storage ||
|| `--description` | `string`

Description of the private endpoint. ||
|| `--labels` | `key=value[,key=value...]`

A list of private endpoint labels as key-value pairs. ||
|| `--address-spec` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Internal ipv4 address specification.

Possible property names:

- `address-id`: Specifies address-id for private endpoint.

- `address`: Specifies address for private endpoint.

- `subnet-id`: Specifies subnet-id of address for private endpoint. ||
|| `--private-dns-records-enabled` | Enable private dns records ||
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