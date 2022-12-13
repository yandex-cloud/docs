---
editable: false
sourcePath: en/_api-ref/billing/api-ref/Budget/create.md
---

# Billing API, REST: Budget.create
Creates a budget for the specified billing account.
 

 
## HTTP request {#https-request}
```
POST https://billing.{{ api-host }}/billing/v1/budgets
```
 
## Body parameters {#body_params}
 
```json 
{
  "billingAccountId": "string",
  "name": "string",

  //  includes only one of the fields `costBudgetSpec`, `expenseBudgetSpec`, `balanceBudgetSpec`
  "costBudgetSpec": {
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
    "endDate": "string",

    // `costBudgetSpec` includes only one of the fields `resetPeriod`, `startDate`
    "resetPeriod": "string",
    "startDate": "string",
    // end of the list of possible fields`costBudgetSpec`

  },
  "expenseBudgetSpec": {
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
    "endDate": "string",

    // `expenseBudgetSpec` includes only one of the fields `resetPeriod`, `startDate`
    "resetPeriod": "string",
    "startDate": "string",
    // end of the list of possible fields`expenseBudgetSpec`

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

}
```

 
Field | Description
--- | ---
billingAccountId | **string**<br><p>Required. ID of the billing account to list budgets corresponding to. To get the billing account ID, use <a href="/docs/billing/api-ref/BillingAccount/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
name | **string**<br><p>Required. Name of the budget.</p> 
costBudgetSpec | **object**<br>Cost budget specification. <br> includes only one of the fields `costBudgetSpec`, `expenseBudgetSpec`, `balanceBudgetSpec`<br>
costBudgetSpec.<br>amount | **string**<br><p>Max cost threshold of the budget. Amount currency is the same as corresponding <a href="/docs/billing/api-ref/BillingAccount#representation">BillingAccount.currency</a>.</p> 
costBudgetSpec.<br>notificationUserAccountIds[] | **string**<br><p>IDs of the <a href="/docs/iam/api-ref/UserAccount#representation">UserAccount</a>. Specified users will be be notified if the budget exceeds.</p> 
costBudgetSpec.<br>thresholdRules[] | **object**<br><p>List of the ``ThresholdRule``. Rules define intermediate cost thresholds of the budget.</p> 
costBudgetSpec.<br>thresholdRules[].<br>type | **string**<br><p>Type of the rule.</p> <p>Define the unit of the [ThesholdRule.amount].</p> <ul> <li>PERCENT: Percent.</li> <li>AMOUNT: The same as budget amount.</li> </ul> 
costBudgetSpec.<br>thresholdRules[].<br>amount | **string**<br><p>Amount of the rule.</p> <ul> <li>Must be less than 100 if type is PERCENT.</li> <li>Must be less than budget's amount if type is AMOUNT.</li> </ul> 
costBudgetSpec.<br>thresholdRules[].<br>notificationUserAccountIds[] | **string**<br><p>IDs of the <a href="/docs/iam/api-ref/UserAccount#representation">UserAccount</a>. Specified users will be be notified if the threshold exceeds.</p> 
costBudgetSpec.<br>filter | **object**<br>Filter that can be used for specific resources selection. Only consumption expense of selected resources are used for the budget calculation.
costBudgetSpec.<br>filter.<br>serviceIds[] | **string**<br><p>IDs of the <a href="/docs/billing/api-ref/Service#representation">Service</a>. Only consumption of resources corresponding to the given services is used for the budget calculation. Empty sequence means no services filters.</p> 
costBudgetSpec.<br>filter.<br>cloudFoldersFilters[] | **object**<br><p>Cloud and folders consumption filter. Only consumption within specified clouds and folders is used for the budget calculation. Empty sequence means no cloud and folders filters.</p> 
costBudgetSpec.<br>filter.<br>cloudFoldersFilters[].<br>cloudId | **string**<br><p>ID of the <a href="/docs/resource-manager/api-ref/Cloud#representation">Cloud</a>. Only consumption within specified cloud is used for the budget calculation.</p> 
costBudgetSpec.<br>filter.<br>cloudFoldersFilters[].<br>folderIds[] | **string**<br><p>IDs of the <a href="/docs/resource-manager/api-ref/Folder#representation">Folder</a>. Only consumption within specified folders of the given cloud is used for the budget calculation. Empty sequence means no folders filters and the whole cloud consumption will be used.</p> 
costBudgetSpec.<br>endDate | **string**<br><p>End date of the budget. Must be the last day of a month and must be formatted like YYYY-MM-DD.</p> 
costBudgetSpec.<br>resetPeriod | **string**<br>Periodic start type that resets budget after specified period is finished. First time budget is calculated in the current period, i.e. current month, quarter or year. <br>`costBudgetSpec` includes only one of the fields `resetPeriod`, `startDate`<br><br><ul> <li>MONTHLY: Reset budget every month.</li> <li>QUARTER: Reset budget every quarter.</li> <li>ANNUALLY: Reset budget every year.</li> </ul> 
costBudgetSpec.<br>startDate | **string** <br>`costBudgetSpec` includes only one of the fields `resetPeriod`, `startDate`<br><br><p>Custom start date of the budget. Must be the first day of a month and must be formatted like YYYY-MM-DD.</p> 
expenseBudgetSpec | **object**<br>Expense budget specification. <br> includes only one of the fields `costBudgetSpec`, `expenseBudgetSpec`, `balanceBudgetSpec`<br>
expenseBudgetSpec.<br>amount | **string**<br><p>Max expense threshold of the budget. Amount currency is the same as corresponding <a href="/docs/billing/api-ref/BillingAccount#representation">BillingAccount.currency</a>.</p> 
expenseBudgetSpec.<br>notificationUserAccountIds[] | **string**<br><p>IDs of the <a href="/docs/iam/api-ref/UserAccount#representation">UserAccount</a>. Specified users will be be notified if the budget exceeds.</p> 
expenseBudgetSpec.<br>thresholdRules[] | **object**<br><p>List of the ``ThresholdRule``. Rules define intermediate expense thresholds of the budget.</p> 
expenseBudgetSpec.<br>thresholdRules[].<br>type | **string**<br><p>Type of the rule.</p> <p>Define the unit of the [ThesholdRule.amount].</p> <ul> <li>PERCENT: Percent.</li> <li>AMOUNT: The same as budget amount.</li> </ul> 
expenseBudgetSpec.<br>thresholdRules[].<br>amount | **string**<br><p>Amount of the rule.</p> <ul> <li>Must be less than 100 if type is PERCENT.</li> <li>Must be less than budget's amount if type is AMOUNT.</li> </ul> 
expenseBudgetSpec.<br>thresholdRules[].<br>notificationUserAccountIds[] | **string**<br><p>IDs of the <a href="/docs/iam/api-ref/UserAccount#representation">UserAccount</a>. Specified users will be be notified if the threshold exceeds.</p> 
expenseBudgetSpec.<br>filter | **object**<br>Filter that can be used for specific resources selection. Only consumption cost of selected resources are used for the budget calculation.
expenseBudgetSpec.<br>filter.<br>serviceIds[] | **string**<br><p>IDs of the <a href="/docs/billing/api-ref/Service#representation">Service</a>. Only consumption of resources corresponding to the given services is used for the budget calculation. Empty sequence means no services filters.</p> 
expenseBudgetSpec.<br>filter.<br>cloudFoldersFilters[] | **object**<br><p>Cloud and folders consumption filter. Only consumption within specified clouds and folders is used for the budget calculation. Empty sequence means no cloud and folders filters.</p> 
expenseBudgetSpec.<br>filter.<br>cloudFoldersFilters[].<br>cloudId | **string**<br><p>ID of the <a href="/docs/resource-manager/api-ref/Cloud#representation">Cloud</a>. Only consumption within specified cloud is used for the budget calculation.</p> 
expenseBudgetSpec.<br>filter.<br>cloudFoldersFilters[].<br>folderIds[] | **string**<br><p>IDs of the <a href="/docs/resource-manager/api-ref/Folder#representation">Folder</a>. Only consumption within specified folders of the given cloud is used for the budget calculation. Empty sequence means no folders filters and the whole cloud consumption will be used.</p> 
expenseBudgetSpec.<br>endDate | **string**<br><p>End date of the budget. Must be the last day of a month and must be formatted like YYYY-MM-DD.</p> 
expenseBudgetSpec.<br>resetPeriod | **string**<br>Periodic start type that resets budget after specified period is finished. First time budget is calculated in the current period, i.e. current month, quarter or year. <br>`expenseBudgetSpec` includes only one of the fields `resetPeriod`, `startDate`<br><br><ul> <li>MONTHLY: Reset budget every month.</li> <li>QUARTER: Reset budget every quarter.</li> <li>ANNUALLY: Reset budget every year.</li> </ul> 
expenseBudgetSpec.<br>startDate | **string** <br>`expenseBudgetSpec` includes only one of the fields `resetPeriod`, `startDate`<br><br><p>Custom start date of the budget. Must be the first day of a month and must be formatted like YYYY-MM-DD.</p> 
balanceBudgetSpec | **object**<br>Balance budget specification. <br> includes only one of the fields `costBudgetSpec`, `expenseBudgetSpec`, `balanceBudgetSpec`<br>
balanceBudgetSpec.<br>amount | **string**<br><p>Max balance threshold of the budget. Amount currency is the same as corresponding <a href="/docs/billing/api-ref/BillingAccount#representation">BillingAccount.currency</a>.</p> 
balanceBudgetSpec.<br>notificationUserAccountIds[] | **string**<br><p>IDs of the <a href="/docs/iam/api-ref/UserAccount#representation">UserAccount</a>. Specified users will be be notified if the budget exceeds.</p> 
balanceBudgetSpec.<br>thresholdRules[] | **object**<br><p>List of the ``ThresholdRule``. Rules define intermediate balance thresholds of the budget.</p> 
balanceBudgetSpec.<br>thresholdRules[].<br>type | **string**<br><p>Type of the rule.</p> <p>Define the unit of the [ThesholdRule.amount].</p> <ul> <li>PERCENT: Percent.</li> <li>AMOUNT: The same as budget amount.</li> </ul> 
balanceBudgetSpec.<br>thresholdRules[].<br>amount | **string**<br><p>Amount of the rule.</p> <ul> <li>Must be less than 100 if type is PERCENT.</li> <li>Must be less than budget's amount if type is AMOUNT.</li> </ul> 
balanceBudgetSpec.<br>thresholdRules[].<br>notificationUserAccountIds[] | **string**<br><p>IDs of the <a href="/docs/iam/api-ref/UserAccount#representation">UserAccount</a>. Specified users will be be notified if the threshold exceeds.</p> 
balanceBudgetSpec.<br>startDate | **string**<br><p>Start_date of the budget. Must be the first day of a month and must be formatted like YYYY-MM-DD.</p> 
balanceBudgetSpec.<br>endDate | **string**<br><p>End date of the budget. Must be the last day of a month and must be formatted like YYYY-MM-DD.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": true,
  "metadata": "object",

  //  includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object",
  // end of the list of possible fields

}
```
An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the operation.</p> 
description | **string**<br><p>Description of the operation. 0-256 characters long.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
createdBy | **string**<br><p>ID of the user or service account who initiated the operation.</p> 
modifiedAt | **string** (date-time)<br><p>The time when the Operation resource was last modified.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
done | **boolean** (boolean)<br><p>If the value is ``false``, it means the operation is still in progress. If ``true``, the operation is completed, and either ``error`` or ``response`` is available.</p> 
metadata | **object**<br><p>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any.</p> 
error | **object**<br>The error result of the operation in case of failure or cancellation. <br> includes only one of the fields `error`, `response`<br>
error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>An error message.</p> 
error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 
response | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any.</p> 