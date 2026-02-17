---
editable: false
---

# yc desktops image copy

Create desktop image as copy of the specified desktop or compute image

#### Command Usage

Syntax:

`yc desktops image copy <IMAGE-NAME>|<IMAGE-ID> [<IMAGE-NAME>|<IMAGE-ID>...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--desktop-id` | `string`

Desktop to copy the image from ||
|| `--compute-image-id` | `string`

Compute image to copy the image from ||
|| `--new-image-name` | `string`

Name for new desktop image ||
|| `--folder-id` | `string`

Destination folder for new desktop image ||
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