[Документация Yandex Cloud](../../../../../../index.md) > [Интерфейс командной строки](../../../../../index.md) > [Справочник (англ.)](../../../../index.md) > [baremetal](../../index.md) > [v2](../index.md) > [image](index.md) > resolve

# yc baremetal v2 image resolve

Resolves the latest published Image for each available family within the specified folder.
Returns one Image per family - the most recently published one.

#### Command Usage

Syntax:

`yc baremetal v2 image resolve <FOLDER-ID>`

#### Flags

#|
||Flag | Description ||
|| `--folder-id` | `string`

ID of the parent folder. "baremetal-standard-images" folder contains general images and used by default To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List] request. ||
|| `--page-size` | `int`

The maximum number of results per page to return. If the number of available results is greater than 'page_size', the service returns a [ResolveImagesResponse.next_page_token] that can be used to get the next page of results in subsequent resolve requests. Default value is 20. ||
|| `--page-token` | `string`

Page token. To get the next page of results, set 'page_token' to the [ResolveImagesResponse.next_page_token] returned by a previous resolve request. ||
|| `--order-by` | `string`

Sorting order for the listing. Follows the AIP-132 'order_by' format: '"field [asc\|desc]"', e.g. '"family desc"'. Supported fields: 'family', 'imageId', 'createTime'. Default order: 'family asc'. ||
|| `-r`, `--request-file` | `string`

Path to a request file. ||
|| `--example-json` | Generates a JSON template of the request. ||
|| `-e`, `--example-yaml` | Generates a YAML template of the request.

The template can be customized and used as input for the command.

Usage example:

1. Generate template:
yc baremetal v2 image resolve --example-json > request.json
or
yc baremetal v2 image resolve --example-yaml > request.yaml

2. Edit the template file

3. Run with template:
yc baremetal v2 image resolve -r request.json
or
yc baremetal v2 image resolve -r request.yaml ||
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
|| `--no-pager` | Do not pipe help output through a pager. ||
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
|| `--print-metadata` | Print operation metadata along with result. ||
|| `--syntax` | `string`

Choose syntax option. ||
|| `--cli-auto-prompt` | `string[="on"]`

Enable interactive auto-prompt mode. Values: on, partial, off. Bare --cli-auto-prompt is equivalent to --cli-auto-prompt=on. ||
|| `--no-cli-auto-prompt` | Disable interactive auto-prompt mode (overrides --cli-auto-prompt, env and profile). ||
|| `-h`, `--help` | Display help for the command. ||
|#