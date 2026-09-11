---
editable: false
canonical: https://yandex.cloud/en/docs/cli/cli-ref/vpc/cli-ref/address/create/
---

# yc vpc address create

Create an address.

#### Command Usage

Syntax:

`yc vpc address create <ADDRESS-NAME> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--name` | `string`

Name of the address. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--description` | `string`

Description of the address. ||
|| `--labels` | `key=value[,key=value...]`

A list of address labels as key-value pairs. ||
|| `--external-ipv4` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

External ipv4 address specification.

Possible property names:

- `zone`: Specifies the zone. ||
|| `--internal-ipv4` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Internal ipv4 address specification.

Possible property names:

- `address`: Specifies desired address.

- `subnet`: Specifies the subnet. ||
|| `--deletion-protection` | Specifies if address protected from deletion. ||
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