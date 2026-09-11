[Документация Yandex Cloud](../../../../index.md) > [Yandex Virtual Private Cloud](../../../index.md) > [Справочник CLI (англ.)](../../index.md) > [v0](../index.md) > [route-table](index.md) > create

# yc vpc v0 route-table create

Create a route table.

#### Command Usage

Syntax:

`yc vpc v0 route-table create <ROUTE-TABLE-NAME> [Flags...] [Global Flags...]`

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