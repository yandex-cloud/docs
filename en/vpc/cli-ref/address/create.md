---
editable: false
sourcePath: en/_cli-ref/cli-ref/vpc/cli-ref/address/create.md
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