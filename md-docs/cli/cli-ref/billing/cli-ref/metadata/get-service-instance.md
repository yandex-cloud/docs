[Документация Yandex Cloud](../../../../../index.md) > [Интерфейс командной строки](../../../../index.md) > [Справочник (англ.)](../../../index.md) > [billing](../index.md) > [metadata](index.md) > get-service-instance

# yc billing metadata get-service-instance

GetServiceInstance returns service instance usage metadata for a specific billing account and date range.
This method provides a view of all available service instance entities
that can be used for usage reporting within the specified date range
for the billing account and all its sub-accounts including:
Implementation details:
- All data is filtered to only include items that had usage during the specified date range
Error handling:
- Returns INVALID_ARGUMENT if the request parameters fail validation
- Returns UNAUTHENTICATED if the user is not authenticated or the billing account does not exist
- Returns PERMISSION_DENIED if the user lacks required permissions
- Returns INTERNAL for internal server errors
This method supports additional filtering by service_instance_ids.
These filters work as supplementary conditions to the primary billing_account_id and date range filters.
When provided, they further narrow down the results by applying additional OR conditions for each filter type.
Required permissions:
- `billing.accounts.getReport` or `billingInternal.accounts.getReport` on the specified billing account

#### Command Usage

Syntax:

`yc billing metadata get-service-instance <BILLING-ACCOUNT-ID>`

#### Flags

#|
||Flag | Description ||
|| `--billing-account-id` | `string`

Required. Billing account identifier. The ID of the billing account to retrieve usage metadata for. Must be a valid and accessible billing account ID. ||
|| `--start-date` | `time`

Start date for data retrieval. The inclusive start of the date range for which to retrieve usage metadata. Must be specified and cannot be empty. The time portion is ignored; the date is considered to start at 00:00:00. (RFC3339) ||
|| `--end-date` | `time`

End date for data retrieval. The inclusive end of the date range for which to retrieve usage metadata. Must be specified, cannot be empty, and must be greater than or equal to start_date. The time portion is ignored; the date is considered to end at 23:59:59. (RFC3339) ||
|| `--service-instance-ids` | `[]string`

Optional. Service instance IDs filter. Additional filter that works alongside the billing_account_id and date range. When specified, includes usage records where service_instance_id matches any of the provided values. Acts as an OR condition (service_instance_id IN service_instance_ids). If empty, this filter is not applied. ||
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