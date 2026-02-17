---
editable: false
---

# yc init

CLI initialization

#### Command Usage

Syntax:

`yc init`

#### Flags

#|
||Flag | Description ||
|| `--endpoint` | `string`

Set the Cloud API endpoint (host:port). ||
|| `--federation-id` | `string`

Set the Federation ID to use for authentication. ||
|| `--userpool-id` | `string`

Set the Userpool ID to use for authentication. ||
|| `--username` | `string`

Set the Userpool ID to use for authentication. ||
|| `--federation-endpoint` | `string`

Set the Federation endpoint to use for authentication. ||
|| `--region` | `string`

Set the region flag to use cli with different regions. ||
|| `--dpop` | Initialize DPOP authenticator ||
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