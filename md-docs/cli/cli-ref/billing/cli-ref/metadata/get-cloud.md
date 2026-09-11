[Документация Yandex Cloud](../../../../../index.md) > [Интерфейс командной строки](../../../../index.md) > [Справочник (англ.)](../../../index.md) > [billing](../index.md) > [metadata](index.md) > get-cloud

# yc billing metadata get-cloud

GetCloud returns available folders for specified clouds within a billing account
with optional filtering by cloud IDs, folder IDs and pagination support.
This method returns a hierarchical view of clouds and their folders that the user
has access to within the specified date range. Results can be filtered by
specific cloud IDs and/or folder IDs, and pagination is supported for handling
large result sets.
Implementation details:
- The method result does not contain empty cloud id information
- Filtering is done using case-insensitive substring matching
- Only clouds with at least one folder are included in the response
- Folder pagination is based on folder IDs, ordered alphabetically
- NextPageToken is only returned when there are more results available
- Base64-encoded page tokens are used for pagination state
Error handling:
- Returns INVALID_ARGUMENT if the request parameters fail validation
- Returns UNAUTHENTICATED if the user is not authenticated or the billing account does not exist
- Returns PERMISSION_DENIED if the user lacks required permissions
- Returns INTERNAL for internal server errors
Required permissions:
- `billing.accounts.getReport` on the specified billing account

#### Command Usage

Syntax:

`yc billing metadata get-cloud <BILLING-ACCOUNT-ID>`

#### Flags

#|
||Flag | Description ||
|| `--billing-account-id` | `string`

Required. Billing account identifier. The ID of the billing account to retrieve cloud and folder metadata for. Must be a valid and accessible billing account ID. ||
|| `--start-date` | `time`

Start date for data retrieval. The inclusive start of the date range for which to retrieve cloud and folder metadata. Must be specified and cannot be empty. The time portion is ignored; the date is considered to start at 00:00:00. (RFC3339) ||
|| `--end-date` | `time`

End date for data retrieval. The inclusive end of the date range for which to retrieve cloud and folder metadata. Must be specified, cannot be empty, and must be greater than or equal to start_date. The time portion is ignored; the date is considered to end at 23:59:59. (RFC3339) ||
|| `--cloud-ids` | `[]string`

Optional. List of cloud IDs to filter clouds by. Note: cloud_id filtering supports case-insensitive substring matching. No wildcards or regex patterns are supported - just simple substring matching. The filter works with partial cloud IDs, and will match any cloud where the provided substring appears anywhere in the cloud_id. For example, filter "abc" will match cloud_ids like "abc123", "123abc", or "1abc2". If empty, no filtering by cloud ID is applied. ||
|| `--folder-ids` | `[]string`

Optional. List of folder IDs to filter folders by. Note: folder_id filtering supports case-insensitive substring matching. No wildcards or regex patterns are supported - just simple substring matching. The filter works with partial folder IDs, and will match any folder where the provided substring appears anywhere in the folder_id. For example, filter "abc" will match folder_ids like "abc123", "123abc", or "1abc2". If empty, no filtering by folder ID is applied. ||
|| `--page-size` | `int`

Optional. Page size for paginated results. Specifies the maximum number of Folder objects to return per page. If not specified or set to 0, defaults to 10. If greater than 10000, will be coerced down to 10000. ||
|| `--page-token` | `string`

Optional. Page token for paginated results. Token from a previous GetCloudResponse used to retrieve the next page. If empty, retrieves the first page. The token encodes the pagination state. ||
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