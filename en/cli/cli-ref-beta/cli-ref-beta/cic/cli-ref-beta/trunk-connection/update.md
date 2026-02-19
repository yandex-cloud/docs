---
editable: false
noIndex: true
---

# yc beta cic trunk-connection update

Updates a TrunkConnection resource using the data specified in the request.
Method starts an asynchronous operation that can be cancelled while it is in progress.

#### Command Usage

Syntax:

`yc beta cic trunk-connection update <TRUNK-CONNECTION-ID>`

#### Flags

#|
||Flag | Description ||
|| `--capacity` | `enum`

Capacity of the trunkConnection Possible Values: 'capacity-50-mbps', 'capacity-100-mbps', 'capacity-200-mbps', 'capacity-300-mbps', 'capacity-400-mbps', 'capacity-500-mbps', 'capacity-1-gbps', 'capacity-2-gbps', 'capacity-3-gbps', 'capacity-4-gbps', 'capacity-5-gbps', 'capacity-10-gbps', 'capacity-20-gbps', 'capacity-30-gbps', 'capacity-40-gbps', 'capacity-50-gbps', 'capacity-100-gbps', 'capacity-200-gbps' ||
|| `--deletion-protection` | Deletion protection flag. Optional. If set prohibits deletion of the trunkConnection. ||
|| `--description` | `string`

Optional description of the trunkConnection. 0-256 characters long. ||
|| `--labels` | `map<string><string>`

Resource labels, 'key:value' pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression '[-_0-9a-z]*'. The string length in characters for each key must be 1-63. Each key must match the regular expression '[a-z][-_0-9a-z]*'. ||
|| `--name` | `string`

Name of the trunkConnection. The name must be unique within the folder. Value must match the regular expression ''\\|a-zA-Z?''. ||
|| `--point-of-presence-id` | `string`

ID of pointOfPresence that the trunkConnection is deployed on. Optional. If is not set scheduler selects it by himself. ||
|| `--region-id` | `string`

ID of the region that the trunkConnection belongs to. ||
|| `--trunk-connection-id` | `string`

ID of the TrunkConnection resource to return. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
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
|| `-h`, `--help` | Display help for the command. ||
|#