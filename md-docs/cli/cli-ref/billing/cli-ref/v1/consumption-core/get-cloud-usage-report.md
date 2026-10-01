[Документация Yandex Cloud](../../../../../../index.md) > [Интерфейс командной строки](../../../../../index.md) > [Справочник (англ.)](../../../../index.md) > [billing](../../index.md) > [v1](../index.md) > [consumption-core](index.md) > get-cloud-usage-report

# yc billing v1 consumption-core get-cloud-usage-report

Returns aggregated usage report for the specified clouds
under the specified billing account.
This method provides detailed usage and cost information grouped by clouds
within the specified billing account. The data can be filtered by various
entity types and aggregated at different time granularities.
Implementation details:
- Results are organized by cloud, with each cloud's usage, costs, and credits detailed
- If cloud_ids are specified, only data for those clouds is included (using OR logic)
- When no cloud_ids are specified, data for all clouds under the billing account is returned
- Other filters (folder_ids, service_ids, sku_ids, resource_ids, labels) are always applied if present
- Hierarchical data structure allows analyzing costs across the organization's cloud resources
Error handling:
- Returns INVALID_ARGUMENT if the request parameters fail validation
- Returns UNAUTHENTICATED if the user is not authenticated or the billing account does not exist
- Returns PERMISSION_DENIED if the user lacks required permissions
- Returns INTERNAL for internal server errors

#### Command Usage

Syntax:

`yc billing v1 consumption-core get-cloud-usage-report <BILLING-ACCOUNT-ID>`

#### Flags

#|
||Flag | Description ||
|| `--billing-account-id` | `string`

Required. Billing account identifier. ||
|| `--start-date` | `time`

Required. Inclusive start date for metrics selection (UTC). This timestamp defines the beginning of the reporting period. All usage data starting from this timestamp will be included in the report. Note: The time component (hours/minutes/seconds) is ignored since the smallest aggregation period is a day. For example, both 2023-04-15T00:00:00 and 2023-04-15T23:59:59 will include the entire day of April 15, 2023. For best results, align with natural time boundaries (start of day, month) based on your aggregation_period value. (RFC3339) ||
|| `--end-date` | `time`

Required. Inclusive end date for metrics selection (UTC). This timestamp defines the end of the reporting period. All usage data up to and including this timestamp will be included in the report. Note: The time component (hours/minutes/seconds) is ignored since the smallest aggregation period is a day. For example, both 2023-04-15T00:00:00 and 2023-04-15T23:59:59 will include the entire day of April 15, 2023. For best results, align with natural time boundaries (end of day, month) based on your aggregation_period value. (RFC3339) ||
|| `--cloud-ids` | `[]string`

Optional. List of cloud IDs to filter the data. If specified, only usage data from these clouds will be included in the report. If omitted, data from all clouds available to the billing account will be included. The filter is applied with OR logic (results include data matching any of the specified cloud IDs). ||
|| `--folder-ids` | `[]string`

Optional. List of folder IDs to filter the data. If specified, only usage data from these folders will be included in the report. If omitted, data from all folders available to the billing account will be included. The filter is applied with OR logic (results include data matching any of the specified folder IDs). ||
|| `--service-ids` | `[]string`

Optional. List of Service IDs to filter the data. If specified, only usage data from these services (e.g., Compute, Storage, AI) will be included. If omitted, data from all services used by the billing account will be included. The filter is applied with OR logic (results include data matching any of the specified service IDs). ||
|| `--sku-ids` | `[]string`

Optional. List of SKU (Stock Keeping Unit) IDs to filter the data. If specified, only usage data from these specific SKUs will be included. If omitted, data from all SKUs used by the billing account will be included. The filter is applied with OR logic (results include data matching any of the specified SKU IDs). ||
|| `--labels` | `shorthand/json`

Optional. Filter by labels: key is label key (e.g., "env", "team", "region"), value is list of label values to match (e.g., ["prod", "stage"] for key "env"). This allows filtering resources based on their attached labels. Example: To filter resources that have either (env=prod OR env=test) AND (team=finance), use the following filter: { "env": { "values": ["prod", "test"] }, "team": { "values": ["finance"] } } Note: The filter logic is (value1 OR value2 OR ...) for each key, and (key1 AND key2 AND ...) between different keys.

{% cut "Description" %}

> - values ([]string)\
List of label values associated with a specific label key.

{% endcut %}

{% cut "Shorthand Syntax" %}

```hcl
{key={
  values = string,...
}, key=...}
```

{% endcut %}

{% cut "JSON Syntax" %}

```json
{
  "<key>": {
    "values": [
      "string", ...
    ]
  }, ...
}
```

{% endcut %} ||
|| `--labels-or-filter-logic` | Optional. Controls the logic for combining different label filters. When false (default): AND logic between different label keys - resources must match ALL specified label conditions. When true: OR logic between different label keys - resources must match ANY specified label condition. Example with labels_or_filter_logic = false (AND logic): labels = {"env": ["prod"], "team": ["finance"]} Returns resources that have BOTH env=prod AND team=finance Example with labels_or_filter_logic = true (OR logic): labels = {"env": ["prod"], "team": ["finance"]} Returns resources that have EITHER env=prod OR team=finance (or both) Note: Within each label key, multiple values are always combined with OR logic. For example: {"env": ["prod", "test"]} always means env=prod OR env=test ||
|| `--resource-ids` | `[]string`

Optional. List of resource IDs to filter the data. If specified, only usage data from these specific resources (e.g., individual VMs, disks) will be included. If omitted, data from all resources used by the billing account will be included. Filter is applied with OR logic (results include data matching any of the specified resource IDs). ||
|| `--aggregation-period` | `enum`

Optional. Aggregation granularity for the report, controlling how data points are grouped in time series results. Available options include: - DAY: Group metrics by day, providing daily breakdowns - WEEK: Group metrics by week, providing weekly breakdowns - MONTH: Group metrics by month, providing monthly breakdowns - QUARTER: Group metrics by quarter, providing quarterly breakdowns - YEAR: Group metrics by year, providing yearly breakdowns This setting affects the time series data returned in the periodic field of each entity. If omitted, the service will typically use DAY as the default granularity. Possible Values: 'day', 'week', 'month', 'quarter', 'year' ||
|| `--service-instance-ids` | `[]string`

Optional. List of service instance IDs to filter the data. If specified, only usage data from these specific service instances (e.g., cloud instances, DataLens instances, Tracker instances, Cloud Video instances) will be included. If omitted, data from all service instances used by the billing account will be included. ||
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