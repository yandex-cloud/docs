---
editable: false
---

# Method list
Retrieves the list of budgets corresponding to the specified billing account.
 

 
## HTTP request {#https-request}
```
GET https://billing.{{ api-host }}/billing/v1/budgets
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
billingAccountId | <p>Required. ID of the billing account to list budgets corresponding to. To get the billing account ID, use <a href="/docs/billing/api-ref/BillingAccount/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than <a href="/docs/billing/api-ref/Budget/list#query_params">pageSize</a>, the service returns a <a href="/docs/billing/api-ref/Budget/list#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests.</p> <p>The maximum value is 1000.</p> 
pageToken | <p>Page token. To get the next page of results, set <a href="/docs/billing/api-ref/Budget/list#query_params">pageToken</a> to the <a href="/docs/billing/api-ref/Budget/list#responses">nextPageToken</a> returned by a previous list request.</p> <p>The maximum string length in characters is 100.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "budgets": [
    {
      "id": "string",
      "name": "string",
      "createdAt": "string",
      "billingAccountId": "string",
      "status": "string",

      // `budgets[]` includes only one of the fields `costBudget`, `expenseBudget`, `balanceBudget`
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

        // `budgets[].costBudget` includes only one of the fields `resetPeriod`, `startDate`
        "resetPeriod": "string",
        "startDate": "string",
        // end of the list of possible fields`budgets[].costBudget`

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

        // `budgets[].expenseBudget` includes only one of the fields `resetPeriod`, `startDate`
        "resetPeriod": "string",
        "startDate": "string",
        // end of the list of possible fields`budgets[].expenseBudget`

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
      // end of the list of possible fields`budgets[]`

    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
budgets[] | **object**<br><p>List of budgets.</p> 
budgets[].<br>id | **string**<br><p>ID of the budget.</p> 
budgets[].<br>name | **string**<br><p>Name of the budget.</p> 
budgets[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
budgets[].<br>billingAccountId | **string**<br><p>ID of the billing account that the budget belongs to.</p> 
budgets[].<br>status | **string**<br>Status of the budget.<br><ul> <li>CREATING: The budget is being created.</li> <li>ACTIVE: The budget is active.</li> <li>FINISHED: The budget is finished.</li> </ul> 
budgets[].<br>costBudget | **object**<br>Cost budget specification. <br>`budgets[]` includes only one of the fields `costBudget`, `expenseBudget`, `balanceBudget`<br>
budgets[].<br>costBudget.<br>amount | **string**<br><p>Max cost threshold of the budget. Amount currency is the same as corresponding <a href="/docs/billing/api-ref/BillingAccount#representation">BillingAccount.currency</a>.</p> 
budgets[].<br>costBudget.<br>notificationUserAccountIds[] | **string**<br><p>IDs of the <a href="/docs/iam/api-ref/UserAccount#representation">UserAccount</a>. Specified users will be be notified if the budget exceeds.</p> 
budgets[].<br>costBudget.<br>thresholdRules[] | **object**<br><p>List of the ``ThresholdRule``. Rules define intermediate cost thresholds of the budget.</p> 
budgets[].<br>costBudget.<br>thresholdRules[].<br>type | **string**<br><p>Type of the rule.</p> <p>Define the unit of the [ThesholdRule.amount].</p> <ul> <li>PERCENT: Percent.</li> <li>AMOUNT: The same as budget amount.</li> </ul> 
budgets[].<br>costBudget.<br>thresholdRules[].<br>amount | **string**<br><p>Amount of the rule.</p> <ul> <li>Must be less than 100 if type is PERCENT.</li> <li>Must be less than budget's amount if type is AMOUNT.</li> </ul> 
budgets[].<br>costBudget.<br>thresholdRules[].<br>notificationUserAccountIds[] | **string**<br><p>IDs of the <a href="/docs/iam/api-ref/UserAccount#representation">UserAccount</a>. Specified users will be be notified if the threshold exceeds.</p> 
budgets[].<br>costBudget.<br>filter | **object**<br>Filter that can be used for specific resources selection. Only consumption expense of selected resources are used for the budget calculation.
budgets[].<br>costBudget.<br>filter.<br>serviceIds[] | **string**<br><p>IDs of the <a href="/docs/billing/api-ref/Service#representation">Service</a>. Only consumption of resources corresponding to the given services is used for the budget calculation. Empty sequence means no services filters.</p> 
budgets[].<br>costBudget.<br>filter.<br>cloudFoldersFilters[] | **object**<br><p>Cloud and folders consumption filter. Only consumption within specified clouds and folders is used for the budget calculation. Empty sequence means no cloud and folders filters.</p> 
budgets[].<br>costBudget.<br>filter.<br>cloudFoldersFilters[].<br>cloudId | **string**<br><p>ID of the <a href="/docs/resource-manager/api-ref/Cloud#representation">Cloud</a>. Only consumption within specified cloud is used for the budget calculation.</p> 
budgets[].<br>costBudget.<br>filter.<br>cloudFoldersFilters[].<br>folderIds[] | **string**<br><p>IDs of the <a href="/docs/resource-manager/api-ref/Folder#representation">Folder</a>. Only consumption within specified folders of the given cloud is used for the budget calculation. Empty sequence means no folders filters and the whole cloud consumption will be used.</p> 
budgets[].<br>costBudget.<br>endDate | **string**<br><p>End date of the budget. Must be the last day of a month and must be formatted like YYYY-MM-DD.</p> 
budgets[].<br>costBudget.<br>resetPeriod | **string**<br>Periodic start type that resets budget after specified period is finished. First time budget is calculated in the current period, i.e. current month, quarter or year. <br>`budgets[].costBudget` includes only one of the fields `resetPeriod`, `startDate`<br><br><ul> <li>MONTHLY: Reset budget every month.</li> <li>QUARTER: Reset budget every quarter.</li> <li>ANNUALLY: Reset budget every year.</li> </ul> 
budgets[].<br>costBudget.<br>startDate | **string** <br>`budgets[].costBudget` includes only one of the fields `resetPeriod`, `startDate`<br><br><p>Custom start date of the budget. Must be the first day of a month and must be formatted like YYYY-MM-DD.</p> 
budgets[].<br>expenseBudget | **object**<br>Expense budget specification. <br>`budgets[]` includes only one of the fields `costBudget`, `expenseBudget`, `balanceBudget`<br>
budgets[].<br>expenseBudget.<br>amount | **string**<br><p>Max expense threshold of the budget. Amount currency is the same as corresponding <a href="/docs/billing/api-ref/BillingAccount#representation">BillingAccount.currency</a>.</p> 
budgets[].<br>expenseBudget.<br>notificationUserAccountIds[] | **string**<br><p>IDs of the <a href="/docs/iam/api-ref/UserAccount#representation">UserAccount</a>. Specified users will be be notified if the budget exceeds.</p> 
budgets[].<br>expenseBudget.<br>thresholdRules[] | **object**<br><p>List of the ``ThresholdRule``. Rules define intermediate expense thresholds of the budget.</p> 
budgets[].<br>expenseBudget.<br>thresholdRules[].<br>type | **string**<br><p>Type of the rule.</p> <p>Define the unit of the [ThesholdRule.amount].</p> <ul> <li>PERCENT: Percent.</li> <li>AMOUNT: The same as budget amount.</li> </ul> 
budgets[].<br>expenseBudget.<br>thresholdRules[].<br>amount | **string**<br><p>Amount of the rule.</p> <ul> <li>Must be less than 100 if type is PERCENT.</li> <li>Must be less than budget's amount if type is AMOUNT.</li> </ul> 
budgets[].<br>expenseBudget.<br>thresholdRules[].<br>notificationUserAccountIds[] | **string**<br><p>IDs of the <a href="/docs/iam/api-ref/UserAccount#representation">UserAccount</a>. Specified users will be be notified if the threshold exceeds.</p> 
budgets[].<br>expenseBudget.<br>filter | **object**<br>Filter that can be used for specific resources selection. Only consumption cost of selected resources are used for the budget calculation.
budgets[].<br>expenseBudget.<br>filter.<br>serviceIds[] | **string**<br><p>IDs of the <a href="/docs/billing/api-ref/Service#representation">Service</a>. Only consumption of resources corresponding to the given services is used for the budget calculation. Empty sequence means no services filters.</p> 
budgets[].<br>expenseBudget.<br>filter.<br>cloudFoldersFilters[] | **object**<br><p>Cloud and folders consumption filter. Only consumption within specified clouds and folders is used for the budget calculation. Empty sequence means no cloud and folders filters.</p> 
budgets[].<br>expenseBudget.<br>filter.<br>cloudFoldersFilters[].<br>cloudId | **string**<br><p>ID of the <a href="/docs/resource-manager/api-ref/Cloud#representation">Cloud</a>. Only consumption within specified cloud is used for the budget calculation.</p> 
budgets[].<br>expenseBudget.<br>filter.<br>cloudFoldersFilters[].<br>folderIds[] | **string**<br><p>IDs of the <a href="/docs/resource-manager/api-ref/Folder#representation">Folder</a>. Only consumption within specified folders of the given cloud is used for the budget calculation. Empty sequence means no folders filters and the whole cloud consumption will be used.</p> 
budgets[].<br>expenseBudget.<br>endDate | **string**<br><p>End date of the budget. Must be the last day of a month and must be formatted like YYYY-MM-DD.</p> 
budgets[].<br>expenseBudget.<br>resetPeriod | **string**<br>Periodic start type that resets budget after specified period is finished. First time budget is calculated in the current period, i.e. current month, quarter or year. <br>`budgets[].expenseBudget` includes only one of the fields `resetPeriod`, `startDate`<br><br><ul> <li>MONTHLY: Reset budget every month.</li> <li>QUARTER: Reset budget every quarter.</li> <li>ANNUALLY: Reset budget every year.</li> </ul> 
budgets[].<br>expenseBudget.<br>startDate | **string** <br>`budgets[].expenseBudget` includes only one of the fields `resetPeriod`, `startDate`<br><br><p>Custom start date of the budget. Must be the first day of a month and must be formatted like YYYY-MM-DD.</p> 
budgets[].<br>balanceBudget | **object**<br>Balance budget specification. <br>`budgets[]` includes only one of the fields `costBudget`, `expenseBudget`, `balanceBudget`<br>
budgets[].<br>balanceBudget.<br>amount | **string**<br><p>Max balance threshold of the budget. Amount currency is the same as corresponding <a href="/docs/billing/api-ref/BillingAccount#representation">BillingAccount.currency</a>.</p> 
budgets[].<br>balanceBudget.<br>notificationUserAccountIds[] | **string**<br><p>IDs of the <a href="/docs/iam/api-ref/UserAccount#representation">UserAccount</a>. Specified users will be be notified if the budget exceeds.</p> 
budgets[].<br>balanceBudget.<br>thresholdRules[] | **object**<br><p>List of the ``ThresholdRule``. Rules define intermediate balance thresholds of the budget.</p> 
budgets[].<br>balanceBudget.<br>thresholdRules[].<br>type | **string**<br><p>Type of the rule.</p> <p>Define the unit of the [ThesholdRule.amount].</p> <ul> <li>PERCENT: Percent.</li> <li>AMOUNT: The same as budget amount.</li> </ul> 
budgets[].<br>balanceBudget.<br>thresholdRules[].<br>amount | **string**<br><p>Amount of the rule.</p> <ul> <li>Must be less than 100 if type is PERCENT.</li> <li>Must be less than budget's amount if type is AMOUNT.</li> </ul> 
budgets[].<br>balanceBudget.<br>thresholdRules[].<br>notificationUserAccountIds[] | **string**<br><p>IDs of the <a href="/docs/iam/api-ref/UserAccount#representation">UserAccount</a>. Specified users will be be notified if the threshold exceeds.</p> 
budgets[].<br>balanceBudget.<br>startDate | **string**<br><p>Start_date of the budget. Must be the first day of a month and must be formatted like YYYY-MM-DD.</p> 
budgets[].<br>balanceBudget.<br>endDate | **string**<br><p>End date of the budget. Must be the last day of a month and must be formatted like YYYY-MM-DD.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/billing/api-ref/Budget/list#query_params">pageSize</a>, use <a href="/docs/billing/api-ref/Budget/list#responses">nextPageToken</a> as the value for the <a href="/docs/billing/api-ref/Budget/list#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/billing/api-ref/Budget/list#responses">nextPageToken</a> to continue paging through the results.</p> 