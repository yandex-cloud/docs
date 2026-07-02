[Документация Yandex Cloud](../../../../../index.md) > [Интерфейс командной строки](../../../../index.md) > [Справочник CLI (англ.)](../../../index.md) > [cic](../index.md) > [private-connection](index.md) > create

# yc cic private-connection create

Create a privateConnection.

#### Command Usage

Syntax:

`yc cic private-connection create <PRIVATE-CONNECTION-NAME>`

#### Flags

#|
||Flag | Description ||
|| `--name` | `string`

Name of the privateConnection. ||
|| `--description` | `string`

Description of the privateConnection. ||
|| `--labels` | `key=value[,key=value...]`

A list of privateConnection labels as key-value pairs. ||
|| `--trunk-id` | `string`

Id of a trunk connection of the privateConnection. ||
|| `--vlan-id` | `int`

VLAN id that the privateConnection uses in multiplexing. ||
|| `--ipv4-peering` | `key=value[,key=value...]`

A list of IPv4 peering parameters of the privateConnection. ||
|| `--ipv4-static-routes` | `[]string`

IPv4 static routes (in ipPrefix/length format) of the privateConnection. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `-r`, `--request-file` | `string`

Path to a request file. ||
|| `--example-json` | Generates a JSON template of the request. ||
|| `-e`, `--example-yaml` | Generates a YAML template of the request.

The template can be customized and used as input for the command.

Usage example:

1. Generate template:
yc cic private-connection create --example-json > request.json
or
yc cic private-connection create --example-yaml > request.yaml

2. Edit the template file

3. Run with template:
yc cic private-connection create -r request.json
or
yc cic private-connection create -r request.yaml ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--no-pager` | Do not pipe help output through a pager. ||
|| `--format` | `string`

Set the output format: text, yaml, json, table, summary \|\| summary[name, instance.id, instance.disks[0].size]. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the IAM token to use. ||
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