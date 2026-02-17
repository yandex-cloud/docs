---
editable: false
---

# yc dns bind-file migrate-to-terraform

Writes terraform specification to stdout

#### Command Usage

Syntax:

`yc dns bind-file migrate-to-terraform <PATH TO FILE> [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--file` | `string`

Path to a text file that contains dns resource records in text form described in rfc1035. ||
|| `--zone-name` | `string`

The name of the dns zone where records will be created. ||
|| `--exclude-types` | `string`

The types of records to exclude. Default value - NS,SOA. ||
|| `--domain` | `string`

The domain that will be used as origin. ||
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