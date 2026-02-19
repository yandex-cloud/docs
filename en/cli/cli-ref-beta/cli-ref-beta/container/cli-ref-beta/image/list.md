---
editable: false
noIndex: true
---

# yc beta container image list

Retrieves the list of Image resources in the specified registry or repository.

#### Command Usage

Syntax:

`yc beta container image list <FOLDER-ID>`

#### Flags

#|
||Flag | Description ||
|| `--filter` | `string`

A filter expression that filters resources listed in the response. The expression must specify: 1. The field name. Currently you can use filtering only on [Image.name] field. 2. An '=' operator. 3. The value in double quotes ('"'). Must be a maximum of 256 characters long and match the regular expression '[a-z0-9]+(?:[._-][a-z0-9]+)*(/([a-z0-9]+(?:[._-][a-z0-9]+)*))'. ||
|| `--folder-id` | `string`

ID of the folder to list Docker images in. [folder_id] is ignored if a [ListImagesRequest.repository_name] or a [ListImagesRequest.registry_id] are specified in the request. To get the folder ID use a [yandex.cloud.resourcemanager.v1.FolderService.List] request. ||
|| `--order-by` | `string`

By which field to sort the results. You can sort by 'name', 'digest', 'created_at', 'last_modified'. To sort results by multiple fields, separate the fields with commas. ||
|| `--page-size` | `int`

The maximum number of results per page to return. If the number of available results is larger than [page_size], the service returns a [ListImagesResponse.next_page_token] that can be used to get the next page of results in subsequent list requests. Default value: 100. ||
|| `--page-token` | `string`

Page token. To get the next page of results, set [page_token] to the [ListImagesResponse.next_page_token] returned by a previous list request. ||
|| `--registry-id` | `string`

ID of the registry to list Docker images in. [registry_id] is ignored if a [ListImagesRequest.repository_name] is specified in the request. To get the registry ID use a [RegistryService.List] request. ||
|| `--repository-name` | `string`

Name of the repository to list Docker images in. To get the repository name use a [RepositoryService.List] request. ||
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