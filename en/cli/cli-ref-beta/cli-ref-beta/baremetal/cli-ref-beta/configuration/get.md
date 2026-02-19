---
editable: false
noIndex: true
---

# yc beta baremetal configuration get

Returns the specific Configuration resource.
To get the list of available Configuration resources, make a [List] request.

#### Command Usage

Syntax:

`yc beta baremetal configuration get <CONFIGURATION-ID>`

#### Flags

#|
||Flag | Description ||
|| `--configuration-id` | `string`

ID of the Configuration resource to return. To get the configuration ID, use a [ConfigurationService.List] request. ||
|| `--folder-id` | `string`

ID of the folder to return a Configuration resource for. To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List] request. ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--format` | `string`

Set the output format: text, yaml, json, table, summary \|\| summary[name, instance.id, instance.disks[0].size]. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the IAM token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#