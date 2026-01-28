---
editable: false
sourcePath: en/_cli-ref/cli-ref/dns/cli-ref/zone/add-records.md
---

# yc dns zone add-records

Add records to dns zone.

#### Command Usage

Syntax:

`yc dns zone add-records <DNS-ZONE-NAME>|<DNS-ZONE-ID> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--id` | `string`

DNS zone id. ||
|| `--name` | `string`

DNS zone name. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--record` | `"<NAME> [TTL] <TYPE> <DATA>"`

record to add in format "&lt;NAME&gt; [TTL] &lt;TYPE&gt; &lt;DATA&gt;". If record with specified name and type is already present no error will be shown. ||
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