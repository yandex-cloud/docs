---
editable: false
sourcePath: en/_cli-ref/cli-ref/backup/cli-ref/agent/debug-info.md
---

# yc backup agent debug-info

Displays backup agent installation logs. Attention! This command could be executed only on instances with oslogin support. This command will execute ssh connection on given instance, and fetch agent logs.

#### Command Usage

Syntax:

`yc backup agent debug-info [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--id` | `string`

Target instance id ||
|| `--name` | `string`

Target instance name ||
|| `--login` | `string`

Specifies the user to log in as on the remote machine. If not specified the certificate is issued to a default OS Login profile. ||
|| `--internal-address` | Connect to instance via internal address. ||
|| `--public-address` | Connect to instance via public address. ||
|| `-i`, `--identity-file` | `string`

Selects a file from which the identity (private key) for public key authentication is read. If not specified a new ssh certificate is issued. ||
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