---
editable: false
---

# yc dns firewall create

Create a dns firewall in the specified folder.

#### Command Usage

Syntax:

`yc dns firewall create <DNS-FIREWALL-NAME> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--name` | `string`

A name of the dns firewall. ||
|| `--description` | `string`

Specifies a textual description of the dns firewall. ||
|| `--labels` | `key=value[,key=value...]`

A list of label KEY=VALUE pairs to add. For example, to add two labels named 'foo' and 'bar', both with the value 'baz', use '--labels foo=baz,bar=baz'. ||
|| `--deletion-protection` | Prevents accidental firewall removal. ||
|| `--network-ids` | `value[,value]`

Specifies the network identifiers where the firewall will be applied. ||
|| `--folder-ids` | `value[,value]`

Specifies the folder identifiers where the firewall will be applied. ||
|| `--cloud-ids` | `value[,value]`

Specifies the cloud identifiers where the firewall will be applied. ||
|| `--lock-resources` | Restricts DNS firewall resources and sub-resources to their creation folder. ||
|| `--enabled` | Specifies whether the DNS firewall is enabled. ||
|| `--whitelist-fqdns` | `value[,value]`

Specifies the FQDNs in the whitelist. ||
|| `--blacklist-fqdns` | `value[,value]`

SSpecifies the FQDNs in the blacklist. ||
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
|| `--syntax` | `string`

CLI syntax: 1 (legacy) or 2 (current). Omit to use default-syntax in the profile or the product default. ||
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