---
editable: false
noIndex: true
---

# yc beta datatransfer endpoint list

Lists endpoints in the specified folder.

#### Command Usage

Syntax:

`yc beta datatransfer endpoint list <FOLDER-ID>`

#### Flags

#|
||Flag | Description ||
|| `--folder-id` | `string`

Identifier of the folder containing the endpoints to be listed. ||
|| `--page-size` | `int`

The maximum number of endpoints to be sent in the response message. If the folder contains more endpoints than 'page_size', 'next_page_token' will be included in the response message. Include it into the subsequent 'ListEndpointRequest' to fetch the next page. Defaults to '100' if not specified. The maximum allowed value for this field is '1000'. ||
|| `--page-token` | `string`

Opaque value identifying the endpoints page to be fetched. Should be empty in the first 'ListEndpointsRequest'. Subsequent requests should have this field filled with the 'next_page_token' from the previous 'ListEndpointsResponse'. ||
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