---
editable: false
sourcePath: en/_cli-ref/cli-ref/cic/cli-ref/trunk-connection/create.md
---

# yc cic trunk-connection create

Create a trunk connection.

#### Command Usage

Syntax:

`yc cic trunk-connection create <TRUNK-CONNECTION-NAME> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--name` | `string`

Name of the trunkConnection. ||
|| `--description` | `string`

Description of the trunkConnection. ||
|| `--labels` | `key=value[,key=value...]`

A list of trunkConnection labels as key-value pairs. ||
|| `--region` | `string`

Region of the trunkConnection. ||
|| `--deletion-protection` | Flag protecting the trunkConnection from deletion. ||
|| `--pop` | `string`

Point of presence id where the trunkConnection is located. ||
|| `--capacity` | `string`

Capacity of the trunkConnection. ||
|| `--trunk-options` | `key=value[,key=value...]`

A list options of the trunkConnection as key-value pairs. ||
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