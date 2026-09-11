[Документация Yandex Cloud](../../../../index.md) > [Yandex Virtual Private Cloud](../../../index.md) > [Справочник CLI (англ.)](../../index.md) > [v0](../index.md) > [address](index.md) > update

# yc vpc v0 address update

Modify configuration or attributes of the address.

#### Command Usage

Syntax:

`yc vpc v0 address update <ADDRESS-NAME>|<ADDRESS-ID> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--id` | `string`

Address id. ||
|| `--name` | `string`

Address name. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--new-name` | `string`

New name for the address ||
|| `--description` | `string`

Specifies a textual description of the address. ||
|| `--labels` | `key=value[,key=value...]`

New set of labels for the address as key-value pairs. Existing set of labels will be completely overwritten. ||
|| `--reserved` | Specifies if address is reserved or not. ||
|| `--deletion-protection` | Specifies if address is protected from deletion. ||
|| `--clear-dns-records` | Clear all DNS records. ||
|| `--dns-record` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

DNS record specifications

Possible property names:

- `dns-zone`: Specifies id of DNS zone.

- `fqdn`: Specifies fqdn for DNS record.

- `ptr`: Set if PTR record is required

- `ttl`: DNS record TTL in seconds ||
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