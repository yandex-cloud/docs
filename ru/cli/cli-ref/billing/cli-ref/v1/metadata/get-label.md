---
editable: false
canonical: https://yandex.cloud/en/docs/cli/cli-ref/billing/cli-ref/v1/metadata/get-label/
---

# yc billing v1 metadata get-label

GetLabel returns available label keys and values for a specific billing account
with pagination support.
This method retrieves all available label values for a specified label key
within the given date range. It supports filtering by label value substring
and provides pagination for handling large result sets.
The method can be used in several ways:
- With label_key only: Returns all values for that key with pagination
- With label_key and label_value: Returns array of matching labelValues with pagination
- With label_key and label_value_filter: Returns all values for that key with pagination
and a separate array of labelValues from the labelValueFilters parameter
- With label_key, label_value and label_value_filter: returns only an array of matching labelValues
with pagination and ignores labelValueFilters (i.e., labelValueFilters won't be returned)
Implementation details:
- Case-insensitive label value matching when label_value is provided
- When label_value is specified, label_value_filter is ignored
- Label values are sorted alphabetically
- Pagination occurs when results exceed page_size
Error handling:
- Returns INVALID_ARGUMENT if the request parameters fail validation
- Returns UNAUTHENTICATED if the user is not authenticated or the billing account does not exist
- Returns PERMISSION_DENIED if the user lacks required permissions
- Returns INTERNAL for internal server errors
Required permissions:
- `billing.accounts.getReport` on the specified billing account

#### Command Usage

Syntax:

`yc billing v1 metadata get-label <BILLING-ACCOUNT-ID>`

#### Flags

#|
||Flag | Description ||
|| `--billing-account-id` | `string`

Required. Billing account identifier. The ID of the billing account to retrieve label metadata for. Must be a valid and accessible billing account ID. ||
|| `--start-date` | `time`

Start date for data retrieval. The inclusive start of the date range for which to retrieve label metadata. Must be specified and cannot be empty. The time portion is ignored; the date is considered to start at 00:00:00. (RFC3339) ||
|| `--end-date` | `time`

End date for data retrieval. The inclusive end of the date range for which to retrieve label metadata. Must be specified, cannot be empty, and must be greater than or equal to start_date. The time portion is ignored; the date is considered to end at 23:59:59. (RFC3339) ||
|| `--cloud-ids` | `[]string`

Optional. Cloud IDs filter. Additional filter that works alongside the billing_account_id and date range. When specified, includes labels where cloud_id matches any of the provided values. Acts as an OR condition (cloud_id IN cloud_ids). If specified, will be used for addditional authorization check to provided clouds. If empty, this filter is not applied. ||
|| `--folder-ids` | `[]string`

Optional. Folder IDs filter. Additional filter that works alongside the billing_account_id and date range. When specified, includes labels where folder_id matches any of the provided values. Acts as an OR condition (folder_id IN folder_ids). If specified, will be used for addditional authorization check to provided folders. If empty, this filter is not applied. ||
|| `--label-key` | `string`

Label key to filter values for. If specified, response will contain values for this specific key. Must be a non-empty string representing a valid label key. ||
|| `--label-value` | `string`

Optional. If provided along with label_key, the response will return an array of matches for this label_value. Used for exact matching of label values. If specified, label_value_filter is ignored and pagination is not applied. ||
|| `--label-value-filter` | `[]string`

Optional array of label values to filter results: Returns in response as is if label_value is not provided, otherwise returns empty label_value_filter ||
|| `--page-size` | `int`

Optional. Page size for paginated results. Specifies the maximum number of label values to return per page. If not specified or set to 0, defaults to 10. If greater than 10000, will be coerced down to 10000. ||
|| `--page-token` | `string`

Optional. Page token for paginated results. Token from a previous GetLabelResponse used to retrieve the next page. If empty, retrieves the first page. ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--cloud-id` | `string`

Set the ID of the cloud to use. ||
|| `--folder-id` | `string`

Set the ID of the folder to use. ||
|| `--folder-name` | `string`

Set the name of the folder to use (will be resolved to id). ||
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