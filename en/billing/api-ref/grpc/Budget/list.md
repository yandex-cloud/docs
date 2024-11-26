---
editable: false
sourcePath: en/_api-ref-grpc/billing/v1/api-ref/grpc/Budget/list.md
---

# Billing API, gRPC: BudgetService.List

Retrieves the list of budgets corresponding to the specified billing account.

## gRPC request

**rpc List ([ListBudgetsRequest](#yandex.cloud.billing.v1.ListBudgetsRequest)) returns ([ListBudgetsResponse](#yandex.cloud.billing.v1.ListBudgetsResponse))**

## ListBudgetsRequest {#yandex.cloud.billing.v1.ListBudgetsRequest}

```json
{
  "billing_account_id": "string",
  "page_size": "int64",
  "page_token": "string"
}
```

#|
||Field | Description ||
|| billing_account_id | **string**

Required field. ID of the billing account to list budgets corresponding to.
To get the billing account ID, use [BillingAccountService.List](/docs/billing/api-ref/grpc/BillingAccount/list#List) request. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`,
the service returns a [ListBudgetsResponse.next_page_token](#yandex.cloud.billing.v1.ListBudgetsResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| page_token | **string**

Page token. To get the next page of results,
set `page_token` to the [ListBudgetsResponse.next_page_token](#yandex.cloud.billing.v1.ListBudgetsResponse)
returned by a previous list request. ||
|#

## ListBudgetsResponse {#yandex.cloud.billing.v1.ListBudgetsResponse}

```json
{
  "budgets": [
    {
      "id": "string",
      "name": "string",
      "created_at": "google.protobuf.Timestamp",
      "billing_account_id": "string",
      "status": "BudgetStatus",
      // Includes only one of the fields `cost_budget`, `expense_budget`, `balance_budget`
      "cost_budget": {
        "amount": "string",
        "notification_user_account_ids": [
          "string"
        ],
        "threshold_rules": [
          {
            "type": "ThresholdType",
            "amount": "string",
            "notification_user_account_ids": [
              "string"
            ]
          }
        ],
        "filter": {
          "service_ids": [
            "string"
          ],
          "cloud_folders_filters": [
            {
              "cloud_id": "string",
              "folder_ids": [
                "string"
              ]
            }
          ]
        },
        // Includes only one of the fields `reset_period`, `start_date`
        "reset_period": "ResetPeriodType",
        "start_date": "string",
        // end of the list of possible fields
        "end_date": "string"
      },
      "expense_budget": {
        "amount": "string",
        "notification_user_account_ids": [
          "string"
        ],
        "threshold_rules": [
          {
            "type": "ThresholdType",
            "amount": "string",
            "notification_user_account_ids": [
              "string"
            ]
          }
        ],
        "filter": {
          "service_ids": [
            "string"
          ],
          "cloud_folders_filters": [
            {
              "cloud_id": "string",
              "folder_ids": [
                "string"
              ]
            }
          ]
        },
        // Includes only one of the fields `reset_period`, `start_date`
        "reset_period": "ResetPeriodType",
        "start_date": "string",
        // end of the list of possible fields
        "end_date": "string"
      },
      "balance_budget": {
        "amount": "string",
        "notification_user_account_ids": [
          "string"
        ],
        "threshold_rules": [
          {
            "type": "ThresholdType",
            "amount": "string",
            "notification_user_account_ids": [
              "string"
            ]
          }
        ],
        "start_date": "string",
        "end_date": "string"
      }
      // end of the list of possible fields
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| budgets[] | **[Budget](#yandex.cloud.billing.v1.Budget)**

List of budgets. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListBudgetsRequest.page_size](#yandex.cloud.billing.v1.ListBudgetsRequest), use
`next_page_token` as the value
for the [ListBudgetsRequest.page_token](#yandex.cloud.billing.v1.ListBudgetsRequest) query parameter
in the next list request. Each subsequent list request will have its own
`next_page_token` to continue paging through the results. ||
|#

## Budget {#yandex.cloud.billing.v1.Budget}

A Budget resource. For more information, see [/docs/billing/concepts/budget].

#|
||Field | Description ||
|| id | **string**

ID of the budget. ||
|| name | **string**

Name of the budget. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| billing_account_id | **string**

ID of the billing account that the budget belongs to. ||
|| status | enum **BudgetStatus**

Status of the budget.

- `BUDGET_STATUS_UNSPECIFIED`
- `CREATING`: The budget is being created.
- `ACTIVE`: The budget is active.
- `FINISHED`: The budget is finished. ||
|| cost_budget | **[CostBudgetSpec](#yandex.cloud.billing.v1.CostBudgetSpec)**

Cost budget specification.

Includes only one of the fields `cost_budget`, `expense_budget`, `balance_budget`.

Specification of the budget. ||
|| expense_budget | **[ExpenseBudgetSpec](#yandex.cloud.billing.v1.ExpenseBudgetSpec)**

Expense budget specification.

Includes only one of the fields `cost_budget`, `expense_budget`, `balance_budget`.

Specification of the budget. ||
|| balance_budget | **[BalanceBudgetSpec](#yandex.cloud.billing.v1.BalanceBudgetSpec)**

Balance budget specification.

Includes only one of the fields `cost_budget`, `expense_budget`, `balance_budget`.

Specification of the budget. ||
|#

## CostBudgetSpec {#yandex.cloud.billing.v1.CostBudgetSpec}

Cost budget specification describes budget that can be used to control cost of cloud resources usage.

#|
||Field | Description ||
|| amount | **string**

Required field. Max cost threshold of the budget. Amount currency is the same as corresponding [yandex.cloud.billing.v1.BillingAccount.currency](/docs/billing/api-ref/grpc/BillingAccount/get#yandex.cloud.billing.v1.BillingAccount). ||
|| notification_user_account_ids[] | **string**

IDs of the [yandex.cloud.iam.v1.UserAccount](/docs/iam/api-ref/grpc/Federation/listUserAccounts#yandex.cloud.iam.v1.UserAccount).
Specified users will be be notified if the budget exceeds. ||
|| threshold_rules[] | **[ThresholdRule](#yandex.cloud.billing.v1.ThresholdRule)**

List of the [ThresholdRule](#yandex.cloud.billing.v1.ThresholdRule).
Rules define intermediate cost thresholds of the budget. ||
|| filter | **[ConsumptionFilter](#yandex.cloud.billing.v1.ConsumptionFilter)**

Filter that can be used for specific resources selection. Only consumption cost of selected resources are used for the budget calculation. ||
|| reset_period | enum **ResetPeriodType**

Periodic start type that resets budget after specified period is finished.
First time budget is calculated in the current period, i.e. current month, quarter or year.

Includes only one of the fields `reset_period`, `start_date`.

Start type of the budget.

- `RESET_PERIOD_TYPE_UNSPECIFIED`
- `MONTHLY`: Reset budget every month.
- `QUARTER`: Reset budget every quarter.
- `ANNUALLY`: Reset budget every year. ||
|| start_date | **string**

Custom start date of the budget.
Must be the first day of a month and must be formatted like YYYY-MM-DD.

Includes only one of the fields `reset_period`, `start_date`.

Start type of the budget. ||
|| end_date | **string**

Required field. End date of the budget.
Must be the last day of a month and must be formatted like YYYY-MM-DD. ||
|#

## ThresholdRule {#yandex.cloud.billing.v1.ThresholdRule}

Rules that define intermediate cost thresholds of the budget.

#|
||Field | Description ||
|| type | enum **ThresholdType**

Required field. Type of the rule.

- `THRESHOLD_TYPE_UNSPECIFIED`
- `PERCENT`: Percent.
- `AMOUNT`: The same as budget amount. ||
|| amount | **string**

Required field. Amount of the rule.
* Must be less than 100 if type is PERCENT.
* Must be less than budget's amount if type is AMOUNT. ||
|| notification_user_account_ids[] | **string**

IDs of the [yandex.cloud.iam.v1.UserAccount](/docs/iam/api-ref/grpc/Federation/listUserAccounts#yandex.cloud.iam.v1.UserAccount).
Specified users will be be notified if the threshold exceeds. ||
|#

## ConsumptionFilter {#yandex.cloud.billing.v1.ConsumptionFilter}

Filter that can be used for specific resources selection.

#|
||Field | Description ||
|| service_ids[] | **string**

IDs of the [yandex.cloud.billing.v1.Service](/docs/billing/api-ref/grpc/Service/get#yandex.cloud.billing.v1.Service).
Only consumption of resources corresponding to the given services is used for the budget calculation.
Empty sequence means no services filters. ||
|| cloud_folders_filters[] | **[CloudFoldersConsumptionFilter](#yandex.cloud.billing.v1.CloudFoldersConsumptionFilter)**

Cloud and folders consumption filter.
Only consumption within specified clouds and folders is used for the budget calculation.
Empty sequence means no cloud and folders filters. ||
|#

## CloudFoldersConsumptionFilter {#yandex.cloud.billing.v1.CloudFoldersConsumptionFilter}

Filter that can be used for specific cloud and its folders selection.

#|
||Field | Description ||
|| cloud_id | **string**

ID of the [yandex.cloud.resourcemanager.v1.Cloud](/docs/resource-manager/api-ref/grpc/Cloud/get#yandex.cloud.resourcemanager.v1.Cloud).
Only consumption within specified cloud is used for the budget calculation. ||
|| folder_ids[] | **string**

IDs of the [yandex.cloud.resourcemanager.v1.Folder](/docs/resource-manager/api-ref/grpc/Folder/get#yandex.cloud.resourcemanager.v1.Folder).
Only consumption within specified folders of the given cloud is used for the budget calculation.
Empty sequence means no folders filters and the whole cloud consumption will be used. ||
|#

## ExpenseBudgetSpec {#yandex.cloud.billing.v1.ExpenseBudgetSpec}

Expense budget specification describes budget that can be used to control expense of cloud resources usage.

#|
||Field | Description ||
|| amount | **string**

Required field. Max expense threshold of the budget. Amount currency is the same as corresponding [yandex.cloud.billing.v1.BillingAccount.currency](/docs/billing/api-ref/grpc/BillingAccount/get#yandex.cloud.billing.v1.BillingAccount). ||
|| notification_user_account_ids[] | **string**

IDs of the [yandex.cloud.iam.v1.UserAccount](/docs/iam/api-ref/grpc/Federation/listUserAccounts#yandex.cloud.iam.v1.UserAccount).
Specified users will be be notified if the budget exceeds. ||
|| threshold_rules[] | **[ThresholdRule](#yandex.cloud.billing.v1.ThresholdRule)**

List of the [ThresholdRule](#yandex.cloud.billing.v1.ThresholdRule).
Rules define intermediate expense thresholds of the budget. ||
|| filter | **[ConsumptionFilter](#yandex.cloud.billing.v1.ConsumptionFilter)**

Filter that can be used for specific resources selection. Only consumption expense of selected resources are used for the budget calculation. ||
|| reset_period | enum **ResetPeriodType**

Periodic start type that resets budget after specified period is finished.
First time budget is calculated in the current period, i.e. current month, quarter or year.

Includes only one of the fields `reset_period`, `start_date`.

Start type of the budget.

- `RESET_PERIOD_TYPE_UNSPECIFIED`
- `MONTHLY`: Reset budget every month.
- `QUARTER`: Reset budget every quarter.
- `ANNUALLY`: Reset budget every year. ||
|| start_date | **string**

Custom start date of the budget.
Must be the first day of a month and must be formatted like YYYY-MM-DD.

Includes only one of the fields `reset_period`, `start_date`.

Start type of the budget. ||
|| end_date | **string**

Required field. End date of the budget.
Must be the last day of a month and must be formatted like YYYY-MM-DD. ||
|#

## BalanceBudgetSpec {#yandex.cloud.billing.v1.BalanceBudgetSpec}

Balance budget specification describes budget that can be used to control [yandex.cloud.billing.v1.BillingAccount.balance](/docs/billing/api-ref/grpc/BillingAccount/get#yandex.cloud.billing.v1.BillingAccount).

#|
||Field | Description ||
|| amount | **string**

Required field. Max balance threshold of the budget. Amount currency is the same as corresponding [yandex.cloud.billing.v1.BillingAccount.currency](/docs/billing/api-ref/grpc/BillingAccount/get#yandex.cloud.billing.v1.BillingAccount). ||
|| notification_user_account_ids[] | **string**

IDs of the [yandex.cloud.iam.v1.UserAccount](/docs/iam/api-ref/grpc/Federation/listUserAccounts#yandex.cloud.iam.v1.UserAccount).
Specified users will be be notified if the budget exceeds. ||
|| threshold_rules[] | **[ThresholdRule](#yandex.cloud.billing.v1.ThresholdRule)**

List of the [ThresholdRule](#yandex.cloud.billing.v1.ThresholdRule).
Rules define intermediate balance thresholds of the budget. ||
|| start_date | **string**

Start_date of the budget.
Must be the first day of a month and must be formatted like YYYY-MM-DD. ||
|| end_date | **string**

Required field. End date of the budget.
Must be the last day of a month and must be formatted like YYYY-MM-DD. ||
|#