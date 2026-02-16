---
editable: false
sourcePath: en/_cli-ref/cli-ref/vpc/cli-ref/route-table/update.md
---

# yc vpc route-table update

Modify configuration or attributes of a route table.

#### Command Usage

Syntax:

`yc vpc route-table update <ROUTE-TABLE-NAME>|<ROUTE-TABLE-ID> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--id` | `string`

Route table id. ||
|| `--name` | `string`

Route table name. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--new-name` | `string`

New name for the route table. ||
|| `--description` | `string`

New description for the route table. ||
|| `--labels` | `key=value[,key=value...]`

New set of labels for the route table as key-value pairs. Existing set of labels will be completely overwritten. ||
|| `--clear-routes` | Clear all routes from a table. ||
|| `--route` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

New list of static routes for table.

Possible property names:

- `destination`: Destination subnet in CIDR notation.

- `next-hop`: Next hop IP address.

- `gateway-id`: ID of the gateway to use as next hop.

- `gateway-name`: Name of the gateway to use as next hop. ||
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