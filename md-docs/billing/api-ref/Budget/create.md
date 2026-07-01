# Billing API, REST: Budget.Create

Creates a budget for the specified billing account.

## HTTP request

```
POST https://billing.api.cloud.yandex.net/billing/v1/budgets
```

## Body parameters {#yandex.cloud.billing.v1.CreateBudgetRequest}

```json
{
  // Includes only one of the fields `costBudgetSpec`, `expenseBudgetSpec`, `balanceBudgetSpec`
  "costBudgetSpec": {
    // Includes only one of the fields `resetPeriod`, `startDate`
    "resetPeriod": "string",
    "startDate": "string",
    // end of the list of possible fields
    "amount": "string",
    "notificationUserAccountIds": [
      "string"
    ],
    "thresholdRules": [
      {
        "type": "string",
        "amount": "string",
        "notificationUserAccountIds": [
          "string"
        ]
      }
    ],
    "filter": {
      "serviceIds": [
        "string"
      ],
      "cloudFoldersFilters": [
        {
          "cloudId": "string",
          "folderIds": [
            "string"
          ]
        }
      ]
    },
    "endDate": "string"
  },
  "expenseBudgetSpec": {
    // Includes only one of the fields `resetPeriod`, `startDate`
    "resetPeriod": "string",
    "startDate": "string",
    // end of the list of possible fields
    "amount": "string",
    "notificationUserAccountIds": [
      "string"
    ],
    "thresholdRules": [
      {
        "type": "string",
        "amount": "string",
        "notificationUserAccountIds": [
          "string"
        ]
      }
    ],
    "filter": {
      "serviceIds": [
        "string"
      ],
      "cloudFoldersFilters": [
        {
          "cloudId": "string",
          "folderIds": [
            "string"
          ]
        }
      ]
    },
    "endDate": "string"
  },
  "balanceBudgetSpec": {
    "amount": "string",
    "notificationUserAccountIds": [
      "string"
    ],
    "thresholdRules": [
      {
        "type": "string",
        "amount": "string",
        "notificationUserAccountIds": [
          "string"
        ]
      }
    ],
    "startDate": "string",
    "endDate": "string"
  },
  // end of the list of possible fields
  "billingAccountId": "string",
  "name": "string"
}
```

#|
||Field | Description ||
|| costBudgetSpec | **[CostBudgetSpec](#yandex.cloud.billing.v1.CostBudgetSpec)**

Cost budget specification.

Includes only one of the fields `costBudgetSpec`, `expenseBudgetSpec`, `balanceBudgetSpec`.

Specification of the budget. ||
|| expenseBudgetSpec | **[ExpenseBudgetSpec](#yandex.cloud.billing.v1.ExpenseBudgetSpec)**

Expense budget specification.

Includes only one of the fields `costBudgetSpec`, `expenseBudgetSpec`, `balanceBudgetSpec`.

Specification of the budget. ||
|| balanceBudgetSpec | **[BalanceBudgetSpec](#yandex.cloud.billing.v1.BalanceBudgetSpec)**

Balance budget specification.

Includes only one of the fields `costBudgetSpec`, `expenseBudgetSpec`, `balanceBudgetSpec`.

Specification of the budget. ||
|| billingAccountId | **string**

Required field. ID of the billing account to list budgets corresponding to.
To get the billing account ID, use [yandex.cloud.billing.v1.BillingAccountService.List](../BillingAccount/list.md#List) request.

The maximum string length in characters is 50. ||
|| name | **string**

Required field. Name of the budget. ||
|#

## CostBudgetSpec {#yandex.cloud.billing.v1.CostBudgetSpec}

Cost budget specification describes budget that can be used to control cost of cloud resources usage.

#|
||Field | Description ||
|| resetPeriod | **enum** (ResetPeriodType)

Periodic start type that resets budget after specified period is finished.
First time budget is calculated in the current period, i.e. current month, quarter or year.

Includes only one of the fields `resetPeriod`, `startDate`.

Start type of the budget.

- `MONTHLY`: Reset budget every month.
- `QUARTER`: Reset budget every quarter.
- `ANNUALLY`: Reset budget every year. ||
|| startDate | **string**

Custom start date of the budget.
Must be the first day of a month and must be formatted like YYYY-MM-DD.

Includes only one of the fields `resetPeriod`, `startDate`.

Start type of the budget. ||
|| amount | **string**

Required field. Max cost threshold of the budget. Amount currency is the same as corresponding [yandex.cloud.billing.v1.BillingAccount.currency](../BillingAccount/get.md#yandex.cloud.billing.v1.BillingAccount). ||
|| notificationUserAccountIds[] | **string**

User account IDs.
Specified users will be be notified if the budget exceeds.

The minimum number of elements is 1. ||
|| thresholdRules[] | **[ThresholdRule](#yandex.cloud.billing.v1.ThresholdRule)**

List of the [ThresholdRule](#yandex.cloud.billing.v1.ThresholdRule).
Rules define intermediate cost thresholds of the budget. ||
|| filter | **[ConsumptionFilter](#yandex.cloud.billing.v1.ConsumptionFilter)**

Filter that can be used for specific resources selection. Only consumption cost of selected resources are used for the budget calculation. ||
|| endDate | **string**

Required field. End date of the budget.
Must be the last day of a month and must be formatted like YYYY-MM-DD. ||
|#

## ThresholdRule {#yandex.cloud.billing.v1.ThresholdRule}

Rules that define intermediate cost thresholds of the budget.

#|
||Field | Description ||
|| type | **enum** (ThresholdType)

Required field. Type of the rule.

- `PERCENT`: Percent.
- `AMOUNT`: The same as budget amount. ||
|| amount | **string**

Required field. Amount of the rule.
* Must be less than 100 if type is PERCENT.
* Must be less than budget's amount if type is AMOUNT. ||
|| notificationUserAccountIds[] | **string**

User account IDs.
Specified users will be be notified if the threshold exceeds. ||
|#

## ConsumptionFilter {#yandex.cloud.billing.v1.ConsumptionFilter}

Filter that can be used for specific resources selection.

#|
||Field | Description ||
|| serviceIds[] | **string**

IDs of the [yandex.cloud.billing.v1.Service](../Service/get.md#yandex.cloud.billing.v1.Service).
Only consumption of resources corresponding to the given services is used for the budget calculation.
Empty sequence means no services filters. ||
|| cloudFoldersFilters[] | **[CloudFoldersConsumptionFilter](#yandex.cloud.billing.v1.CloudFoldersConsumptionFilter)**

Cloud and folders consumption filter.
Only consumption within specified clouds and folders is used for the budget calculation.
Empty sequence means no cloud and folders filters. ||
|#

## CloudFoldersConsumptionFilter {#yandex.cloud.billing.v1.CloudFoldersConsumptionFilter}

Filter that can be used for specific cloud and its folders selection.

#|
||Field | Description ||
|| cloudId | **string**

ID of the [yandex.cloud.resourcemanager.v1.Cloud](../../../resource-manager/api-ref/Cloud/get.md#yandex.cloud.resourcemanager.v1.Cloud).
Only consumption within specified cloud is used for the budget calculation. ||
|| folderIds[] | **string**

IDs of the [yandex.cloud.resourcemanager.v1.Folder](../../../resource-manager/api-ref/Folder/get.md#yandex.cloud.resourcemanager.v1.Folder).
Only consumption within specified folders of the given cloud is used for the budget calculation.
Empty sequence means no folders filters and the whole cloud consumption will be used. ||
|#

## ExpenseBudgetSpec {#yandex.cloud.billing.v1.ExpenseBudgetSpec}

Expense budget specification describes budget that can be used to control expense of cloud resources usage.

#|
||Field | Description ||
|| resetPeriod | **enum** (ResetPeriodType)

Periodic start type that resets budget after specified period is finished.
First time budget is calculated in the current period, i.e. current month, quarter or year.

Includes only one of the fields `resetPeriod`, `startDate`.

Start type of the budget.

- `MONTHLY`: Reset budget every month.
- `QUARTER`: Reset budget every quarter.
- `ANNUALLY`: Reset budget every year. ||
|| startDate | **string**

Custom start date of the budget.
Must be the first day of a month and must be formatted like YYYY-MM-DD.

Includes only one of the fields `resetPeriod`, `startDate`.

Start type of the budget. ||
|| amount | **string**

Required field. Max expense threshold of the budget. Amount currency is the same as corresponding [yandex.cloud.billing.v1.BillingAccount.currency](../BillingAccount/get.md#yandex.cloud.billing.v1.BillingAccount). ||
|| notificationUserAccountIds[] | **string**

User account IDs.
Specified users will be be notified if the budget exceeds.

The minimum number of elements is 1. ||
|| thresholdRules[] | **[ThresholdRule](#yandex.cloud.billing.v1.ThresholdRule)**

List of the [ThresholdRule](#yandex.cloud.billing.v1.ThresholdRule).
Rules define intermediate expense thresholds of the budget. ||
|| filter | **[ConsumptionFilter](#yandex.cloud.billing.v1.ConsumptionFilter)**

Filter that can be used for specific resources selection. Only consumption expense of selected resources are used for the budget calculation. ||
|| endDate | **string**

Required field. End date of the budget.
Must be the last day of a month and must be formatted like YYYY-MM-DD. ||
|#

## BalanceBudgetSpec {#yandex.cloud.billing.v1.BalanceBudgetSpec}

Balance budget specification describes budget that can be used to control [yandex.cloud.billing.v1.BillingAccount.balance](../BillingAccount/get.md#yandex.cloud.billing.v1.BillingAccount).

#|
||Field | Description ||
|| amount | **string**

Required field. Max balance threshold of the budget. Amount currency is the same as corresponding [yandex.cloud.billing.v1.BillingAccount.currency](../BillingAccount/get.md#yandex.cloud.billing.v1.BillingAccount). ||
|| notificationUserAccountIds[] | **string**

User account IDs.
Specified users will be be notified if the budget exceeds.

The minimum number of elements is 1. ||
|| thresholdRules[] | **[ThresholdRule](#yandex.cloud.billing.v1.ThresholdRule)**

List of the [ThresholdRule](#yandex.cloud.billing.v1.ThresholdRule).
Rules define intermediate balance thresholds of the budget. ||
|| startDate | **string**

Start_date of the budget.
Must be the first day of a month and must be formatted like YYYY-MM-DD. ||
|| endDate | **string**

Required field. End date of the budget.
Must be the last day of a month and must be formatted like YYYY-MM-DD. ||
|#

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": "object",
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object"
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](../../../api-design-guide/concepts/operation.md).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **object**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **object**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
|#