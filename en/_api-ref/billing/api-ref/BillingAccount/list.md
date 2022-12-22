---
editable: false
---

# Billing API, REST: BillingAccount.list
Retrieves the list of billing accounts available for current user.
 

 
## HTTP request {#https-request}
```
GET https://billing.{{ api-host }}/billing/v1/billingAccounts
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than <a href="/docs/billing/api-ref/BillingAccount/list#query_params">pageSize</a>, the service returns a <a href="/docs/billing/api-ref/BillingAccount/list#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests.</p> <p>The maximum value is 1000.</p> 
pageToken | <p>Page token. To get the next page of results, set <a href="/docs/billing/api-ref/BillingAccount/list#query_params">pageToken</a> to the <a href="/docs/billing/api-ref/BillingAccount/list#responses">nextPageToken</a> returned by a previous list request.</p> <p>The maximum string length in characters is 100.</p> 
 
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
billingAccounts[] | **object**<br><p>List of billing accounts.</p> 
billingAccounts[].<br>id | **string**<br><p>ID of the billing account.</p> 
billingAccounts[].<br>name | **string**<br><p>Name of the billing account.</p> 
billingAccounts[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
billingAccounts[].<br>countryCode | **string**<br><p>ISO 3166-1 alpha-2 country code of the billing account.</p> 
billingAccounts[].<br>currency | **string**<br><p>Currency of the billing account. Can be one of the following:</p> <ul> <li>``RUB``</li> <li>``USD``</li> <li>``KZT``</li> </ul> 
billingAccounts[].<br>active | **boolean** (boolean)<br><p>Represents whether corresponding billable objects can be used or not.</p> 
billingAccounts[].<br>balance | **string**<br><p>Current balance of the billing account.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/billing/api-ref/BillingAccount/list#query_params">pageSize</a>, use <a href="/docs/billing/api-ref/BillingAccount/list#responses">nextPageToken</a> as the value for the <a href="/docs/billing/api-ref/BillingAccount/list#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/billing/api-ref/BillingAccount/list#responses">nextPageToken</a> to continue paging through the results.</p> 