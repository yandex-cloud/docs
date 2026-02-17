---
editable: false
---

# yc vpc security-group update

Modify configuration or attributes of a security group.

#### Command Usage

Syntax:

`yc vpc security-group update <SECURITY-GROUP-NAME>|<SECURITY-GROUP-ID> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--id` | `string`

Security group's id. ||
|| `--name` | `string`

Security group's name. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--new-name` | `string`

New name for the security group. ||
|| `--description` | `string`

New description for the security group. ||
|| `--labels` | `key=value[,key=value...]`

New set of labels for the security group as key-value pairs. Existing set of labels will be completely overwritten. ||
|| `--clear-rules` | Clear all rules from a security group. ||
|| `--rule` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

New list of rules for security group.

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