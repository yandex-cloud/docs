---
editable: false
canonical: https://yandex.cloud/en/docs/cli/cli-ref/cic/cli-ref/v0/private-connection/create/
---

# yc cic v0 private-connection create

Create a privateConnection.

#### Command Usage

Syntax:

`yc cic v0 private-connection create <PRIVATE-CONNECTION-NAME>`

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

A list of IPv4 peering parameters of the privateConnection.

Supported peering parameters:
   peering-subnet: ip with format ipPrefix/length where address part of ipPrefix is 0.
   peer-ip: ip with just an ipAddress format without mask.
   cloud-ip: Ip with just an ipAddress format without mask.
   peer-bgp-asn: PeerAsn excluding rfc5398 (excluding 64496 - 64511 and 65536 - 65551).
   peer-bgp-md5-key: (optional) MD5 key of the peer. ||
|| `--ipv4-static-routes` | `[]string`

IPv4 static routes (in ipPrefix/length format) of the privateConnection. ||
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