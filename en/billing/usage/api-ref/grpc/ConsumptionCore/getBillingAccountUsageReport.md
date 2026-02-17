---
editable: false
---

# Billing Usage API, gRPC: ConsumptionCoreService.GetBillingAccountUsageReport

Returns aggregated usage report for a single specified billing account,
optionally filtered by clouds, folders, SKUs, labels, and period granularity.

This method provides a comprehensive view of all usage and costs for a specific
billing account, with options to filter data by various entity types and to aggregate
results at different time granularities (daily, monthly, etc.).

Implementation details:
- The report includes the total cost, applied credits (monetary grants, volume incentives, committed use discounts, and free credits), and final expense
- Results can be filtered by cloud IDs, folder IDs, service IDs, SKU IDs, resource IDs, or labels
- All applicable filters from the request will be applied (with AND logic between different filter types)
- Time-based data is grouped according to the specified aggregation period

Error handling:
- Returns INVALID_ARGUMENT if the request parameters fail validation
- Returns UNAUTHENTICATED if the user is not authenticated or the billing account does not exist
- Returns PERMISSION_DENIED if the user lacks required permissions
- Returns INTERNAL for internal server errors

## gRPC request

**rpc GetBillingAccountUsageReport ([UsageReportRequest](#yandex.cloud.billing.usage_records.v1.UsageReportRequest)) returns ([BillingAccountUsageReportResponse](#yandex.cloud.billing.usage_records.v1.BillingAccountUsageReportResponse))**

## UsageReportRequest {#yandex.cloud.billing.usage_records.v1.UsageReportRequest}

```json
{
  "billing_account_id": "string",
  "start_date": "google.protobuf.Timestamp",
  "end_date": "google.protobuf.Timestamp",
  "cloud_ids": [
    "string"
  ],
  "folder_ids": [
    "string"
  ],
  "service_ids": [
    "string"
  ],
  "sku_ids": [
    "string"
  ],
  "labels": "map<string, LabelList>",
  "resource_ids": [
    "string"
  ],
  "aggregation_period": "TimeGrouping"
}
```

Request for retrieving usage report data.

This message defines the parameters for requesting usage reports across
all ConsumptionCoreService methods. It supports filtering by various
entity types and specifying the time range and aggregation period.

#|
||Field | Description ||
|| billing_account_id | **string**

Required field. Required. Billing account identifier. ||
|| start_date | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Required field. Required. Inclusive start date for metrics selection (UTC).
This timestamp defines the beginning of the reporting period.
All usage data starting from this timestamp will be included in the report.
Note: The time component (hours/minutes/seconds) is ignored since the smallest
aggregation period is a day. For example, both 2023-04-15T00:00:00 and
2023-04-15T23:59:59 will include the entire day of April 15, 2023.
For best results, align with natural time boundaries (start of day, month)
based on your aggregation_period value. ||
|| end_date | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Required field. Required. Inclusive end date for metrics selection (UTC).
This timestamp defines the end of the reporting period.
All usage data up to and including this timestamp will be included in the report.
Note: The time component (hours/minutes/seconds) is ignored since the smallest
aggregation period is a day. For example, both 2023-04-15T00:00:00 and
2023-04-15T23:59:59 will include the entire day of April 15, 2023.
For best results, align with natural time boundaries (end of day, month)
based on your aggregation_period value. ||
|| cloud_ids[] | **string**

Optional. List of cloud IDs to filter the data.
If specified, only usage data from these clouds will be included in the report.
If omitted, data from all clouds available to the billing account will be included.
The filter is applied with OR logic (results include data matching any of the specified cloud IDs). ||
|| folder_ids[] | **string**

Optional. List of folder IDs to filter the data.
If specified, only usage data from these folders will be included in the report.
If omitted, data from all folders available to the billing account will be included.
The filter is applied with OR logic (results include data matching any of the specified folder IDs). ||
|| service_ids[] | **string**

Optional. List of Service IDs to filter the data.
If specified, only usage data from these services (e.g., Compute, Storage, AI) will be included.
If omitted, data from all services used by the billing account will be included.
The filter is applied with OR logic (results include data matching any of the specified service IDs). ||
|| sku_ids[] | **string**

Optional. List of SKU (Stock Keeping Unit) IDs to filter the data.
If specified, only usage data from these specific SKUs will be included.
If omitted, data from all SKUs used by the billing account will be included.
The filter is applied with OR logic (results include data matching any of the specified SKU IDs). ||
|| labels | **object** (map<**string**, **[LabelList](#yandex.cloud.billing.usage_records.v1.LabelList)**>)

Optional. Filter by labels: key is label key (e.g., "env", "team", "region"),
value is list of label values to match (e.g., ["prod", "stage"] for key "env").
This allows filtering resources based on their attached labels.

Example: To filter resources that have either (env=prod OR env=test) AND (team=finance),
use the following filter:
{
"env": { "values": ["prod", "test"] },
"team": { "values": ["finance"] }
}

Note: The filter logic is (value1 OR value2 OR ...) for each key,
and (key1 AND key2 AND ...) between different keys. ||
|| resource_ids[] | **string**

Optional. List of resource IDs to filter the data.
If specified, only usage data from these specific resources (e.g., individual VMs, disks) will be included.
If omitted, data from all resources used by the billing account will be included.
Filter is applied with OR logic (results include data matching any of the specified resource IDs). ||
|| aggregation_period | enum **TimeGrouping**

Optional. Aggregation granularity for the report, controlling how data points are grouped
in time series results. Available options include:
- DAY: Group metrics by day, providing daily breakdowns
- WEEK: Group metrics by week, providing weekly breakdowns
- MONTH: Group metrics by month, providing monthly breakdowns
- QUARTER: Group metrics by quarter, providing quarterly breakdowns
- YEAR: Group metrics by year, providing yearly breakdowns

This setting affects the time series data returned in the periodic field of each entity.
If omitted, the service will typically use DAY as the default granularity.

- `TIME_GROUPING_UNSPECIFIED`: Default unspecified value. Typically treated as DAY.
- `DAY`: Group reports by day.
- `WEEK`: Group reports by week.
- `MONTH`: Group reports by month.
- `QUARTER`: Group reports by quarter (3-month periods).
- `YEAR`: Group reports by year. ||
|#

## LabelList {#yandex.cloud.billing.usage_records.v1.LabelList}

Represents a list of label values for filtering or grouping in usage reports.
For example, to filter resources with label key "env" that have value "prod" or "test",
a LabelList with values ["prod", "test"] would be used for the key "env".

#|
||Field | Description ||
|| values[] | **string**

List of label values associated with a specific label key. ||
|#

## BillingAccountUsageReportResponse {#yandex.cloud.billing.usage_records.v1.BillingAccountUsageReportResponse}

```json
{
  "currency": "Currency",
  "cost": {
    "value": "string"
  },
  "credit_details": {
    "credit": {
      "value": "string"
    },
    "monetary_grant_credit": {
      "value": "string"
    },
    "volume_incentive_credit": {
      "value": "string"
    },
    "cud_credit": {
      "value": "string"
    },
    "free_credit": {
      "value": "string"
    }
  },
  "expense": {
    "value": "string"
  },
  "entities_data": [
    {
      "cost": {
        "value": "string"
      },
      "credit_details": {
        "credit": {
          "value": "string"
        },
        "monetary_grant_credit": {
          "value": "string"
        },
        "volume_incentive_credit": {
          "value": "string"
        },
        "cud_credit": {
          "value": "string"
        },
        "free_credit": {
          "value": "string"
        }
      },
      "expense": {
        "value": "string"
      },
      "billing_account": {
        "id": "string",
        "name": "string"
      },
      "periodic": [
        {
          "cost": {
            "value": "string"
          },
          "credit_details": {
            "credit": {
              "value": "string"
            },
            "monetary_grant_credit": {
              "value": "string"
            },
            "volume_incentive_credit": {
              "value": "string"
            },
            "cud_credit": {
              "value": "string"
            },
            "free_credit": {
              "value": "string"
            }
          },
          "expense": {
            "value": "string"
          },
          "timestamp": "google.protobuf.Timestamp"
        }
      ]
    }
  ]
}
```

Response for usage report requests by billing account.

Contains aggregated usage, cost, and credit information for a billing account,
with both summary totals and detailed breakdowns by billing account entity.
The response includes:
1. Overall totals for the entire period (cost, credits, expense)
2. Entity-level totals for the specified billing account
3. Time series breakdown for the billing account according to the requested aggregation period

#|
||Field | Description ||
|| currency | enum **Currency**

Currency code (e.g., "RUB", "USD") for all monetary values in the response.
Determined by the billing account's settings.

- `CURRENCY_UNSPECIFIED`: Unspecified or unknown currency.
- `RUB`: Russian Ruble
- `USD`: US Dollar
- `KZT`: Kazakhstani Tenge
- `EUR`: Euro ||
|| cost | **[StringDecimal](#yandex.cloud.billing.usage_records.v1.StringDecimal)**

Total usage cost for the selected time period.
This represents the raw cost before any credits or discounts are applied.
Calculated based on the resource consumption and the corresponding price rates. ||
|| credit_details | **[CreditDetails](#yandex.cloud.billing.usage_records.v1.CreditDetails)**

Total credits (monetary grants, volume incentives, committed use discounts, and free credits) applied in the selected period.
Contains a detailed breakdown of all credit types that reduced the final billable amount. ||
|| expense | **[StringDecimal](#yandex.cloud.billing.usage_records.v1.StringDecimal)**

Total expense (including cost and credit) for the selected time period.
This is the final billable amount after all credits have been applied.
Formula: expense = cost - sum of all credits. ||
|| entities_data[] | **[BillingAccountUsageReportEntityData](#yandex.cloud.billing.usage_records.v1.BillingAccountUsageReportEntityData)**

Detailed usage and billing data for the specified billing account entity.
This field contains a structured breakdown of costs, credits, and expenses
for the requested billing account, including:
1. Entity-level totals for the entire period (cost, credits, expense)
2. Time series data broken down by the specified aggregation period (day/week/month/quarter/year)
This represents the second and third levels in the overall three-level response structure. ||
|#

## StringDecimal {#yandex.cloud.billing.usage_records.v1.StringDecimal}

StringDecimal representation for financial values
Used to ensure precise handling of monetary values

#|
||Field | Description ||
|| value | **string**

String representation of the decimal value to avoid floating-point precision issues ||
|#

## CreditDetails {#yandex.cloud.billing.usage_records.v1.CreditDetails}

Detailed breakdown of credits (discounts, incentives, grants, etc.) applied to an entity.
Credits reduce the effective cost that customers pay for cloud resources.
The 'credit' field is the total amount of credits (the sum of all credit types below).
This breakdown allows for detailed analysis of different discount types affecting billing.

#|
||Field | Description ||
|| credit | **[StringDecimal](#yandex.cloud.billing.usage_records.v1.StringDecimal)**

Total amount of credits (sum of all credit types) applied to the entity.
This is the overall discount applied, reducing the cost to arrive at the final expense.
Formula: expense = cost + credit ||
|| monetary_grant_credit | **[StringDecimal](#yandex.cloud.billing.usage_records.v1.StringDecimal)**

Credits granted as a one-time monetary grant. ||
|| volume_incentive_credit | **[StringDecimal](#yandex.cloud.billing.usage_records.v1.StringDecimal)**

Credits given as a volume-based incentive. ||
|| cud_credit | **[StringDecimal](#yandex.cloud.billing.usage_records.v1.StringDecimal)**

Committed Use Discount credits. ||
|| free_credit | **[StringDecimal](#yandex.cloud.billing.usage_records.v1.StringDecimal)**

Credits provided as part of a 'free' program. ||
|#

## BillingAccountUsageReportEntityData {#yandex.cloud.billing.usage_records.v1.BillingAccountUsageReportEntityData}

Usage and billing data for the billing account entity in the report.
This represents the second level in the response structure hierarchy (entity-level totals),
containing both summary data for the specified billing account across the entire period and a time series breakdown.

#|
||Field | Description ||
|| cost | **[StringDecimal](#yandex.cloud.billing.usage_records.v1.StringDecimal)**

Total cost associated with this billing account. ||
|| credit_details | **[CreditDetails](#yandex.cloud.billing.usage_records.v1.CreditDetails)**

Total credits (discounts, grants, adjustments) applied to this billing account. ||
|| expense | **[StringDecimal](#yandex.cloud.billing.usage_records.v1.StringDecimal)**

Total expense (including cost and credit) for this billing account. ||
|| billing_account | **[BillingAccount](#yandex.cloud.billing.usage_records.v1.BillingAccount)**

Metadata for the specified billing account entity. ||
|| periodic[] | **[UsageReportPeriodicData](#yandex.cloud.billing.usage_records.v1.UsageReportPeriodicData)**

Time series with usage and billing details for each TimeGrouping period (e.g., daily). ||
|#

## BillingAccount {#yandex.cloud.billing.usage_records.v1.BillingAccount}

Represents a billing account entity

#|
||Field | Description ||
|| id | **string**

Unique identifier of the billing_account entity. ||
|| name | **string**

Human-readable display name of the billing account. ||
|#

## UsageReportPeriodicData {#yandex.cloud.billing.usage_records.v1.UsageReportPeriodicData}

Represents usage and billing data for a specific aggregation period (e.g., a single day, month).
This message is part of the third level in the response structure hierarchy, providing the
time series breakdown for entities. It appears in the 'periodic' field of each entity data object,
containing financial metrics for each time interval within the requested date range.

#|
||Field | Description ||
|| cost | **[StringDecimal](#yandex.cloud.billing.usage_records.v1.StringDecimal)**

Cost incurred during this specific period.
This is the raw cost before any credits are applied. ||
|| credit_details | **[CreditDetails](#yandex.cloud.billing.usage_records.v1.CreditDetails)**

Credits applied during this period.
Contains a detailed breakdown of all credit types (monetary grants, volume incentives, etc.)
that were applied during this specific time interval. ||
|| expense | **[StringDecimal](#yandex.cloud.billing.usage_records.v1.StringDecimal)**

Total expense (including cost and credit) for this period.
This is the final billable amount after all credits have been applied.
Formula: expense = cost + credit_details.credit ||
|| timestamp | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp indicating the beginning of the TimeGrouping period. ||
|#