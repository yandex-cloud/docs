---
editable: false
sourcePath: en/_api-ref/billing/api-ref/BillingAccount/list.md
---

# Method list
Retrieves the list of billing accounts available for current user.
 

 
## HTTP request {#https-request}
```
GET https://billing.{{ api-host }}/billing/v1/billingAccounts
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | The maximum number of results per page to return. If the number of available results is larger than [pageSize](/docs/billing/api-ref/BillingAccount/list#query_params), the service returns a [nextPageToken](/docs/billing/api-ref/BillingAccount/list#responses) that can be used to get the next page of results in subsequent list requests.  The maximum value is 1000.
pageToken | Page token. To get the next page of results, set [pageToken](/docs/billing/api-ref/BillingAccount/list#query_params) to the [nextPageToken](/docs/billing/api-ref/BillingAccount/list#responses) returned by a previous list request.  The maximum string length in characters is 100.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "billingAccounts": [
    {
      "id": "string",
      "name": "string",
      "createdAt": "string",
      "countryCode": "string",
      "currency": "string",
      "active": true,
      "balance": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
billingAccounts[] | **object**<br><p>A BillingAccount resource. For more information, see <a href="/docs/billing/concepts/billing-account">BillingAccount</a>.</p> 
billingAccounts[].<br>id | **string**<br><p>ID of the billing account.</p> 
billingAccounts[].<br>name | **string**<br><p>Name of the billing account.</p> 
billingAccounts[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
billingAccounts[].<br>countryCode | **string**<br><p>ISO 3166-1 alpha-2 country code of the billing account.</p> 
billingAccounts[].<br>currency | **string**<br><p>Currency of the billing account. Can be one of the following:</p> <ul> <li>``RUB``</li> <li>``USD``</li> <li>``KZT``</li> </ul> 
billingAccounts[].<br>active | **boolean** (boolean)<br><p>Represents whether corresponding billable objects can be used or not.</p> 
billingAccounts[].<br>balance | **string**<br><p>Current balance of the billing account.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/billing/api-ref/BillingAccount/list#query_params">pageSize</a>, use <a href="/docs/billing/api-ref/BillingAccount/list#responses">nextPageToken</a> as the value for the <a href="/docs/billing/api-ref/BillingAccount/list#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/billing/api-ref/BillingAccount/list#responses">nextPageToken</a> to continue paging through the results.</p> 