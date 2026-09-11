[Документация Yandex Cloud](../../../../index.md) > [Yandex Virtual Private Cloud](../../../index.md) > [Справочник CLI (англ.)](../../index.md) > [v0](../index.md) > [security-group](index.md) > create

# yc vpc v0 security-group create

Create a security group.

#### Command Usage

Syntax:

`yc vpc v0 security-group create <SECURITY-GROUP-NAME> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--name` | `string`

Name of the security group. ||
|| `--description` | `string`

Description of the security group. ||
|| `--labels` | `key=value[,key=value...]`

A list of security group labels as key-value pairs. ||
|| `--network-id` | `string`

ID of the network to which the security group belongs. ||
|| `--network-name` | `string`

Name of the network to which the security group belongs. ||
|| `--rule` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

A list of rules in a security group.

Possible property names:

- `description`: Description of rule

- `direction`: Rule direction. May be one of ingress or egress

- `port`: Port for rule represented by port number or 'any'. Cannot be used with from-port and to-port flags. Can only be specified for rule with tcp or udp protocols.

- `from-port`: Start of rule port range. Must be followed by 'to-port'.

- `to-port`: End of rule port range. Must be proceeded by 'from-port'.

- `protocol`: Rule protocol. May be one of 'any', 'tcp', 'udp', 'icmp', 'ipv6_icmp' or IANA IP protocol number http://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml

- `v4-cidrs`: List of target IPv4 CIDRs for rule, v4-cidrs=192.168.0.1/32,v4-cidrs=[127.0.0.0/28,10.0.0.0/8]. For EGRESS rule those represent destination IP blocks, for INGRESS rule those represent source IP blocks.

- `v6-cidrs`: List of target IPv6 CIDRs for rule, v6-cidrs=beef::/64,v6-cidrs=[::/0,cafe::/32]. For EGRESS rule those represent destination IP blocks, for INGRESS rule those represent source IP block.

- `security-group-id`: Target security group's id.

- `security-group-name`: Target security group's name.

- `predefined`: Predefined target. See docs for choices. ||
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