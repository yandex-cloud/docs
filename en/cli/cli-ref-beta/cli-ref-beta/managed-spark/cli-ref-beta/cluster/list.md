---
editable: false
noIndex: true
---

# yc beta managed-spark cluster list

Retrieves a list of Spark clusters.

#### Command Usage

Syntax:

`yc beta managed-spark cluster list <FOLDER-ID>`

#### Flags

#|
||Flag | Description ||
|| `--filter` | `string`

String that describes a display filter. ||
|| `--folder-id` | `string`

ID of the folder to list Spark clusters in. ||
|| `--page-size` | `int`

The maximum number of results per page that should be returned. If the number of available results is larger than 'page_size', the service returns a 'next_page_token' that can be used to get the next page of results in subsequent ListClusters requests. Acceptable values are 0 to 1000, inclusive. Default value: 100. ||
|| `--page-token` | `string`

Page token. Set 'page_token' to the 'next_page_token' returned by a previous ListClusters request to get the next page of results. ||
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