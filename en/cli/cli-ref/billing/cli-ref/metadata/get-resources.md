---
editable: false
canonical: https://yandex.cloud/en/docs/cli/cli-ref/billing/cli-ref/metadata/get-resources/
---

# yc billing metadata get-resources

GetResources returns available resources for specified service instances within a billing account
with optional filtering by service instance IDs, resource IDs and pagination support.
This method returns a hierarchical view of service instances and their resources that the user
has access to within the specified date range. Results can be filtered by
specific service instance IDs and/or resource IDs, and pagination is supported for handling
large result sets.
Implementation details:
- Filtering by resources is done using case-insensitive substring matching
- Filtering is done using case-insensitive substring matching
- Only service instances with at least one resource are included in the response
- Resource pagination is based on resource IDs, ordered alphabetically
- NextPageToken is only returned when there are more results available
- Base64-encoded page tokens are used for pagination state
Error handling:
- Returns INVALID_ARGUMENT if the request parameters fail validation
- Returns UNAUTHENTICATED if the user is not authenticated or the billing account does not exist
- Returns PERMISSION_DENIED if the user lacks required permissions
- Returns INTERNAL for internal server errors
Required permissions:
- `billing.accounts.getReport` or `billingInternal.accounts.getReport` on the specified billing account

#### Command Usage

Syntax:

`yc billing metadata get-resources <BILLING-ACCOUNT-ID>`

#### Flags

#|
||Flag | Description ||
|| `--billing-account-id` | `string`

Required. Billing account identifier. The ID of the billing account to retrieve resources for. Must be a valid and accessible billing account ID. ||
|| `--start-date` | `time`

Start date for data retrieval. The inclusive start of the date range for which to retrieve resources. Must be specified and cannot be empty. The time portion is ignored; the date is considered to start at 00:00:00. (RFC3339) ||
|| `--end-date` | `time`

End date for data retrieval. The inclusive end of the date range for which to retrieve resources. Must be specified, cannot be empty, and must be greater than or equal to start_date. The time portion is ignored; the date is considered to end at 23:59:59. (RFC3339) ||
|| `--service-instances-ids` | `[]string`

Optional. List of service instances IDs to filter service instances by. Filtering is done using case-insensitive substring matching. The filter matches any service instance where the provided substring appears anywhere in the service_instances_id. Example: filter "abc" matches "abc123", "123abc", "1abc2", etc. No wildcards or regex patterns are supported. If empty, no filtering by service instance ID is applied. ||
|| `--resource-ids` | `[]string`

Optional. List of resource IDs to filter resources by. Filtering is done using case-insensitive substring matching. The filter matches any resource where the provided substring appears anywhere in the resource_id. Example: filter "abc" matches "abc123", "123abc", "1abc2", etc. No wildcards or regex patterns are supported. If empty, no filtering by resource ID is applied. ||
|| `--page-size` | `int`

Optional. Page size for paginated results. Specifies the maximum number of resource IDs to return per page. If not specified or set to 0, defaults to 10. If greater than 10000, will be coerced down to 10000. ||
|| `--page-token` | `string`

Optional. Page token for paginated results. Token from a previous GetResourceIDsResponse used to retrieve the next page. If empty, retrieves the first page. The token encodes the pagination state. ||
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