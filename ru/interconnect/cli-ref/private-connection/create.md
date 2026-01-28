---
editable: false
sourcePath: en/_cli-ref/cli-ref/cic/cli-ref/private-connection/create.md
---

# yc cic private-connection create

Create a privateConnection.

#### Command Usage

Syntax:

`yc cic private-connection create <PRIVATE-CONNECTION-NAME> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--name` | `string`

Name of the privateConnection. ||
|| `--description` | `string`

Description of the privateConnection. ||
|| `--labels` | `key=value[,key=value...]`

A list of privateConnection labels as key-value pairs. ||
|| `--region` | `string`

Region of the privateConnection. ||
|| `--trunk-id` | `string`

Id of a trunk connection of the privateConnection. ||
|| `--vlan-id` | `int`

VLAN id that the privateConnection uses in multiplexing. ||
|| `--ipv4-peering` | `key=value[,key=value...]`

A list of IPv4 peering parameters of the privateConnection. ||
|| `--ipv4-static-routes` | `value[,value]`

IPv4 static routes (in ipPrefix/length format) of the privateConnection. ||
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