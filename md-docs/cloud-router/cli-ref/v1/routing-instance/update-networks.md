[Документация Yandex Cloud](../../../../index.md) > [Yandex Cloud Router](../../../index.md) > [Справочник CLI (англ.)](../../index.md) > [v1](../index.md) > [routing-instance](index.md) > update-networks

# yc cloudrouter v1 routing-instance update-networks

Updates multiple vpc using the data specified in the request.
Method starts an asynchronous operation that can be cancelled while it is in progress.

#### Command Usage

Syntax:

`yc cloudrouter v1 routing-instance update-networks <ROUTING-INSTANCE-NAME>|<ROUTING-INSTANCE-ID>`

#### Flags

#|
||Flag | Description ||
|| `--id` | `string`

ID of the RoutingInstance resource. ||
|| `--name` | `string`

Resolve id by resource name within the current scope. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--add-vpc-net` | `[]string`

Lists information about the VPC networks that are added to the routing instance.
Format: id=&lt;VPC-NETWORK-ID&gt;,zone=&lt;ZONE&gt;,ipv4-prefixes=[&lt;CIDR&gt;,...] ||
|| `--update-vpc-net` | `[]string`

List of VPC network information that is updated in the routing instance.
Format: id=&lt;VPC-NETWORK-ID&gt;,zone=&lt;ZONE&gt;,ipv4-prefixes=[&lt;CIDR&gt;,...] ||
|| `--delete-vpc-net-id` | `[]string`

List of VPC ids to remove from the routing instance. ||
|| `--strict-remove` | Specifies whether to check for vpc in routing instance. ||
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