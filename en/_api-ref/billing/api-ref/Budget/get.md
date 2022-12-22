---
editable: false
---

# Billing API, REST: Budget.get
Returns the specified budget.
 

 
## HTTP request {#https-request}
```
GET https://billing.{{ api-host }}/billing/v1/budgets/{id}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
id | <p>Required. ID of the budget to return. To get the budget ID, use <a href="/docs/billing/api-ref/Budget/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "name": "string",
  "createdAt": "string",
  "billingAccountId": "string",
  "status": "string",

  //  includes only one of the fields `costBudget`, `expenseBudget`, `balanceBudget`
  "costBudget": {
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

    // `costBudget` includes only one of the fields `resetPeriod`, `startDate`
    "resetPeriod": "string",
    "startDate": "string",
    // end of the list of possible fields`costBudget`

  },
  "expenseBudget": {
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

    // `expenseBudget` includes only one of the fields `resetPeriod`, `startDate`
    "resetPeriod": "string",
    "startDate": "string",
    // end of the list of possible fields`expenseBudget`

  },
  "balanceBudget": {
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
A Budget resource. For more information, see [/docs/billing/concepts/budget].
 
Field | Description
--- | ---
id | **string**<br><p>ID of the budget.</p> 
name | **string**<br><p>Name of the budget.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
billingAccountId | **string**<br><p>ID of the billing account that the budget belongs to.</p> 
status | **string**<br>Status of the budget.<br><ul> <li>CREATING: The budget is being created.</li> <li>ACTIVE: The budget is active.</li> <li>FINISHED: The budget is finished.</li> </ul> 
costBudget | **object**<br>Cost budget specification. <br> includes only one of the fields `costBudget`, `expenseBudget`, `balanceBudget`<br>
costBudget.<br>amount | **string**<br><p>Max cost threshold of the budget. Amount currency is the same as corresponding <a href="/docs/billing/api-ref/BillingAccount#representation">BillingAccount.currency</a>.</p> 
costBudget.<br>notificationUserAccountIds[] | **string**<br><p>IDs of the <a href="/docs/iam/api-ref/UserAccount#representation">UserAccount</a>. Specified users will be be notified if the budget exceeds.</p> 
costBudget.<br>thresholdRules[] | **object**<br><p>List of the ``ThresholdRule``. Rules define intermediate cost thresholds of the budget.</p> 
costBudget.<br>thresholdRules[].<br>type | **string**<br><p>Type of the rule.</p> <p>Define the unit of the [ThesholdRule.amount].</p> <ul> <li>PERCENT: Percent.</li> <li>AMOUNT: The same as budget amount.</li> </ul> 
costBudget.<br>thresholdRules[].<br>amount | **string**<br><p>Amount of the rule.</p> <ul> <li>Must be less than 100 if type is PERCENT.</li> <li>Must be less than budget's amount if type is AMOUNT.</li> </ul> 
costBudget.<br>thresholdRules[].<br>notificationUserAccountIds[] | **string**<br><p>IDs of the <a href="/docs/iam/api-ref/UserAccount#representation">UserAccount</a>. Specified users will be be notified if the threshold exceeds.</p> 
costBudget.<br>filter | **object**<br>Filter that can be used for specific resources selection. Only consumption expense of selected resources are used for the budget calculation.
costBudget.<br>filter.<br>serviceIds[] | **string**<br><p>IDs of the <a href="/docs/billing/api-ref/Service#representation">Service</a>. Only consumption of resources corresponding to the given services is used for the budget calculation. Empty sequence means no services filters.</p> 
costBudget.<br>filter.<br>cloudFoldersFilters[] | **object**<br><p>Cloud and folders consumption filter. Only consumption within specified clouds and folders is used for the budget calculation. Empty sequence means no cloud and folders filters.</p> 
costBudget.<br>filter.<br>cloudFoldersFilters[].<br>cloudId | **string**<br><p>ID of the <a href="/docs/resource-manager/api-ref/Cloud#representation">Cloud</a>. Only consumption within specified cloud is used for the budget calculation.</p> 
costBudget.<br>filter.<br>cloudFoldersFilters[].<br>folderIds[] | **string**<br><p>IDs of the <a href="/docs/resource-manager/api-ref/Folder#representation">Folder</a>. Only consumption within specified folders of the given cloud is used for the budget calculation. Empty sequence means no folders filters and the whole cloud consumption will be used.</p> 
costBudget.<br>endDate | **string**<br><p>End date of the budget. Must be the last day of a month and must be formatted like YYYY-MM-DD.</p> 
costBudget.<br>resetPeriod | **string**<br>Periodic start type that resets budget after specified period is finished. First time budget is calculated in the current period, i.e. current month, quarter or year. <br>`costBudget` includes only one of the fields `resetPeriod`, `startDate`<br><br><ul> <li>MONTHLY: Reset budget every month.</li> <li>QUARTER: Reset budget every quarter.</li> <li>ANNUALLY: Reset budget every year.</li> </ul> 
costBudget.<br>startDate | **string** <br>`costBudget` includes only one of the fields `resetPeriod`, `startDate`<br><br><p>Custom start date of the budget. Must be the first day of a month and must be formatted like YYYY-MM-DD.</p> 
expenseBudget | **object**<br>Expense budget specification. <br> includes only one of the fields `costBudget`, `expenseBudget`, `balanceBudget`<br>
expenseBudget.<br>amount | **string**<br><p>Max expense threshold of the budget. Amount currency is the same as corresponding <a href="/docs/billing/api-ref/BillingAccount#representation">BillingAccount.currency</a>.</p> 
expenseBudget.<br>notificationUserAccountIds[] | **string**<br><p>IDs of the <a href="/docs/iam/api-ref/UserAccount#representation">UserAccount</a>. Specified users will be be notified if the budget exceeds.</p> 
expenseBudget.<br>thresholdRules[] | **object**<br><p>List of the ``ThresholdRule``. Rules define intermediate expense thresholds of the budget.</p> 
expenseBudget.<br>thresholdRules[].<br>type | **string**<br><p>Type of the rule.</p> <p>Define the unit of the [ThesholdRule.amount].</p> <ul> <li>PERCENT: Percent.</li> <li>AMOUNT: The same as budget amount.</li> </ul> 
expenseBudget.<br>thresholdRules[].<br>amount | **string**<br><p>Amount of the rule.</p> <ul> <li>Must be less than 100 if type is PERCENT.</li> <li>Must be less than budget's amount if type is AMOUNT.</li> </ul> 
expenseBudget.<br>thresholdRules[].<br>notificationUserAccountIds[] | **string**<br><p>IDs of the <a href="/docs/iam/api-ref/UserAccount#representation">UserAccount</a>. Specified users will be be notified if the threshold exceeds.</p> 
expenseBudget.<br>filter | **object**<br>Filter that can be used for specific resources selection. Only consumption cost of selected resources are used for the budget calculation.
expenseBudget.<br>filter.<br>serviceIds[] | **string**<br><p>IDs of the <a href="/docs/billing/api-ref/Service#representation">Service</a>. Only consumption of resources corresponding to the given services is used for the budget calculation. Empty sequence means no services filters.</p> 
expenseBudget.<br>filter.<br>cloudFoldersFilters[] | **object**<br><p>Cloud and folders consumption filter. Only consumption within specified clouds and folders is used for the budget calculation. Empty sequence means no cloud and folders filters.</p> 
expenseBudget.<br>filter.<br>cloudFoldersFilters[].<br>cloudId | **string**<br><p>ID of the <a href="/docs/resource-manager/api-ref/Cloud#representation">Cloud</a>. Only consumption within specified cloud is used for the budget calculation.</p> 
expenseBudget.<br>filter.<br>cloudFoldersFilters[].<br>folderIds[] | **string**<br><p>IDs of the <a href="/docs/resource-manager/api-ref/Folder#representation">Folder</a>. Only consumption within specified folders of the given cloud is used for the budget calculation. Empty sequence means no folders filters and the whole cloud consumption will be used.</p> 
expenseBudget.<br>endDate | **string**<br><p>End date of the budget. Must be the last day of a month and must be formatted like YYYY-MM-DD.</p> 
expenseBudget.<br>resetPeriod | **string**<br>Periodic start type that resets budget after specified period is finished. First time budget is calculated in the current period, i.e. current month, quarter or year. <br>`expenseBudget` includes only one of the fields `resetPeriod`, `startDate`<br><br><ul> <li>MONTHLY: Reset budget every month.</li> <li>QUARTER: Reset budget every quarter.</li> <li>ANNUALLY: Reset budget every year.</li> </ul> 
expenseBudget.<br>startDate | **string** <br>`expenseBudget` includes only one of the fields `resetPeriod`, `startDate`<br><br><p>Custom start date of the budget. Must be the first day of a month and must be formatted like YYYY-MM-DD.</p> 
balanceBudget | **object**<br>Balance budget specification. <br> includes only one of the fields `costBudget`, `expenseBudget`, `balanceBudget`<br>
balanceBudget.<br>amount | **string**<br><p>Max balance threshold of the budget. Amount currency is the same as corresponding <a href="/docs/billing/api-ref/BillingAccount#representation">BillingAccount.currency</a>.</p> 
balanceBudget.<br>notificationUserAccountIds[] | **string**<br><p>IDs of the <a href="/docs/iam/api-ref/UserAccount#representation">UserAccount</a>. Specified users will be be notified if the budget exceeds.</p> 
balanceBudget.<br>thresholdRules[] | **object**<br><p>List of the ``ThresholdRule``. Rules define intermediate balance thresholds of the budget.</p> 
balanceBudget.<br>thresholdRules[].<br>type | **string**<br><p>Type of the rule.</p> <p>Define the unit of the [ThesholdRule.amount].</p> <ul> <li>PERCENT: Percent.</li> <li>AMOUNT: The same as budget amount.</li> </ul> 
balanceBudget.<br>thresholdRules[].<br>amount | **string**<br><p>Amount of the rule.</p> <ul> <li>Must be less than 100 if type is PERCENT.</li> <li>Must be less than budget's amount if type is AMOUNT.</li> </ul> 
balanceBudget.<br>thresholdRules[].<br>notificationUserAccountIds[] | **string**<br><p>IDs of the <a href="/docs/iam/api-ref/UserAccount#representation">UserAccount</a>. Specified users will be be notified if the threshold exceeds.</p> 
balanceBudget.<br>startDate | **string**<br><p>Start_date of the budget. Must be the first day of a month and must be formatted like YYYY-MM-DD.</p> 
balanceBudget.<br>endDate | **string**<br><p>End date of the budget. Must be the last day of a month and must be formatted like YYYY-MM-DD.</p> 