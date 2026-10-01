---
editable: false
canonical: https://yandex.cloud/en/docs/cli/cli-ref/billing/cli-ref/metadata/get-usage/
---

# yc billing metadata get-usage

GetUsage returns usage metadata including available clouds, services, SKUs, label keys, and date ranges
for a specific billing account and date range.
This method provides a view of all available entities
that can be used for usage reporting within the specified date range
for the billing account and all its sub-accounts including:
- List of available clouds in provided data range
- Available label keys that can be used for filtering or grouping
- Available services
- Available SKUs
- Available billing accounts (user billing account and his sub-accounts)
Implementation details:
- Empty cloud_id values are translated to a "Usage is out of scope of the Cloud" designation
- All data is filtered to only include items that had usage during the specified date range
Error handling:
- Returns INVALID_ARGUMENT if the request parameters fail validation
- Returns UNAUTHENTICATED if the user is not authenticated or the billing account does not exist
- Returns PERMISSION_DENIED if the user lacks required permissions
- Returns INTERNAL for internal server errors
Required permissions:
- `billing.accounts.getReport` on the specified billing account

#### Command Usage

Syntax:

`yc billing metadata get-usage <BILLING-ACCOUNT-ID>`

#### Flags

#|
||Flag | Description ||
|| `--billing-account-id` | `string`

Required. Billing account identifier. The ID of the billing account to retrieve usage metadata for. Must be a valid and accessible billing account ID. ||
|| `--start-date` | `time`

Start date for data retrieval. The inclusive start of the date range for which to retrieve usage metadata. Must be specified and cannot be empty. The time portion is ignored; the date is considered to start at 00:00:00. (RFC3339) ||
|| `--end-date` | `time`

End date for data retrieval. The inclusive end of the date range for which to retrieve usage metadata. Must be specified, cannot be empty, and must be greater than or equal to start_date. The time portion is ignored; the date is considered to end at 23:59:59. (RFC3339) ||
|| `--cloud-ids` | `[]string`

Optional. Cloud IDs filter. Additional filter that works alongside the billing_account_id and date range. When specified, includes usage records where cloud_id matches any of the provided values. Acts as an OR condition (cloud_id IN cloud_ids). If empty, this filter is not applied. ||
|| `--label-keys` | `[]string`

Optional. Label keys filter. Additional filter that works alongside the billing_account_id and date range. When specified, includes usage records where label_key matches any of the provided values. Acts as an OR condition (label_key IN label_keys). If empty, this filter is not applied. ||
|| `--service-ids` | `[]string`

Optional. Service IDs filter. Additional filter that works alongside the billing_account_id and date range. When specified, includes usage records where service_id matches any of the provided values. Acts as an OR condition (service_id IN service_ids). If empty, this filter is not applied. ||
|| `--sku-ids` | `[]string`

Optional. SKU IDs filter. Additional filter that works alongside the billing_account_id and date range. When specified, includes usage records where sku_id matches any of the provided values. Acts as an OR condition (sku_id IN sku_ids). If empty, this filter is not applied. ||
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