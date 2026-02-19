---
editable: false
noIndex: true
---

# yc beta compute filesystem create

Creates a filesystem in the specified folder.

#### Command Usage

Syntax:

`yc beta compute filesystem create <FOLDER-ID>`

#### Flags

#|
||Flag | Description ||
|| `-r`, `--request-file` | `string`

Path to a request file. ||
|| `--example-json` | Generates a JSON template of the request.
The template can be customized and used as input for the command.
Usage example:

1. Generate template: yc beta compute instance create --example-json > request.json
2. Edit the template: vim request.json
3. Run with template: yc beta compute instance create -r request.json ||
|| `--example-yaml` | Generates a YAML template of the request.
The template can be customized and used as input for the command.
Usage example:

1. Generate template: yc beta compute instance create --example-yaml > request.yaml
2. Edit the template: vim request.yaml
3. Run with template: yc beta compute instance create -r request.yaml ||
|| `--block-size` | `int`

Block size used for the filesystem, specified in bytes. The block size cannot be updated after the filesystem creation. Default value: 4096. ||
|| `--description` | `string`

Description of the filesystem. ||
|| `--folder-id` | `string`

ID of the folder to create a filesystem in. To get the folder ID, make a [yandex.cloud.resourcemanager.v1.FolderService.List] request. ||
|| `--labels` | `map<string><string>`

Filesystem labels as 'key:value' pairs. For details about the concept, see documentation. ||
|| `--name` | `string`

Name of the filesystem. The name must be unique within the folder. ||
|| `--size` | `int`

Size of the filesystem, specified in bytes. The size of the filesystem cannot be updated after the filesystem creation. ||
|| `--type-id` | `string`

ID of the filesystem type. To get a list of available filesystem types, make a [yandex.cloud.compute.v1.DiskTypeService.List] request. The filesystem type cannot be updated after the filesystem creation. ||
|| `--zone-id` | `string`

ID of the availability zone where the filesystem resides. To get a list of available zones, make a [yandex.cloud.compute.v1.ZoneService.List] request. A filesystem can be attached only to virtual machines residing in the same availability zone. The filesystem availability zone cannot be updated after the filesystem creation. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
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