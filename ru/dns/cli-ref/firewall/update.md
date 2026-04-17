---
editable: false
---

# yc dns firewall update

Modify configuration or attributes of a dns firewall.

#### Command Usage

Syntax:

`yc dns firewall update <DNS-FIREWALL-NAME>|<DNS-FIREWALL-ID> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--id` | `string`

DNS firewall id. ||
|| `--name` | `string`

DNS firewall name. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--new-name` | `string`

A new name of the DNS firewall. ||
|| `--description` | `string`

Specifies a textual description of the DNS firewall. ||
|| `--labels` | `key=value[,key=value...]`

A list of label KEY=VALUE pairs to add. For example, to add two labels named 'foo' and 'bar', both with the value 'baz', use '--labels foo=baz,bar=baz'. ||
|| `--deletion-protection` | Prevents accidental firewall removal. ||
|| `--network-ids` | `value[,value]`

Specifies network identifiers from which dns firewall will be accessible. ||
|| `--folder-ids` | `value[,value]`

Specifies folder identifiers from which dns firewall will be accessible. ||
|| `--cloud-ids` | `value[,value]`

Specifies cloud identifiers from which dns firewall will be accessible. ||
|| `--lock-resources` | Specifies whether the dns firewall locks resources in the folder in which it is created. ||
|| `--enabled` | Specifies whether the dns firewall is enabled or not. ||
|| `--whitelist-fqdns` | `value[,value]`

Specifies a list of FQDNs to whitelist. ||
|| `--blacklist-fqdns` | `value[,value]`

Specifies a list of FQDNs to blacklist. ||
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