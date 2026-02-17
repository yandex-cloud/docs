---
editable: false
---

# yc help

Help provides help for any command in the application.
Simply type yc help [path to command] for full details.

#### Command Usage

Syntax:

`yc help [command] [flags]`

#### Global Flags

#|
||Flag | Description ||
|| `--cloud-id` | `string`

Set the ID of the cloud to use. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--endpoint` | `string`

Set the Cloud API endpoint (host:port). ||
|| `--folder-id` | `string`

Set the ID of the folder to use. ||
|| `--folder-name` | `string`

Set the name of the folder to use (will be resolved to id). ||
|| `--format` | `string`

Set the output format: text (default), yaml, json, json-rest. ||
|| `-h`, `--help` | Display help for the command. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--jq` | `string`

Query to select values from the response using jq syntax ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--profile` | `string`

Set the custom configuration file. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--token` | `string`

Set the OAuth token to use. ||
|#