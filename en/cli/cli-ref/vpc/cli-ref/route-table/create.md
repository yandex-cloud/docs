---
editable: false
---

# yc vpc route-table create

Create a route table.

#### Command Usage

Syntax:

`yc vpc route-table create <ROUTE-TABLE-NAME> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--name` | `string`

Name of the route table. ||
|| `--description` | `string`

Description of the route table. ||
|| `--labels` | `key=value[,key=value...]`

A list of route table labels as key-value pairs. ||
|| `--network-id` | `string`

ID of the network to which the route table belongs. ||
|| `--network-name` | `string`

Name of the network to which the route table belongs. ||
|| `--route` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

A list of static routes in a table.

Possible property names:

- `destination`: Destination subnet in CIDR notation.

- `next-hop`: Next hop IP address.

- `gateway-id`: ID of the gateway to use as next hop.

- `gateway-name`: Name of the gateway to use as next hop. ||
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