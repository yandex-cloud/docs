---
editable: false
sourcePath: en/_api-ref/billing/api-ref/Customer/list.md
---

# Method list
Retrieves the list of customers associated with the specified reseller.
 

 
## HTTP request {#https-request}
```
GET https://billing.{{ api-host }}/billing/v1/customers
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
resellerId | <p>Required. ID of the reseller.</p> <p>The maximum string length in characters is 50.</p> 
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than <a href="/docs/billing/api-ref/Customer/list#query_params">pageSize</a>, the service returns a <a href="/docs/billing/api-ref/Customer/list#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests.</p> <p>The maximum value is 1000.</p> 
pageToken | <p>Page token. To get the next page of results, set <a href="/docs/billing/api-ref/Customer/list#query_params">pageToken</a> to the <a href="/docs/billing/api-ref/Customer/list#responses">nextPageToken</a> returned by a previous list request.</p> <p>The maximum string length in characters is 100.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "customers": [
    {
      "id": "string",
      "billingAccountId": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
customers[] | **object**<br><p>List of customers.</p> 
customers[].<br>id | **string**<br><p>ID of the customer.</p> 
customers[].<br>billingAccountId | **string**<br><p>ID of the <a href="/docs/billing/api-ref/BillingAccount#representation">BillingAccount</a> assigned to the customer.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/billing/api-ref/Customer/list#query_params">pageSize</a>, use <a href="/docs/billing/api-ref/Customer/list#responses">nextPageToken</a> as the value for the <a href="/docs/billing/api-ref/Customer/list#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/billing/api-ref/Customer/list#responses">nextPageToken</a> to continue paging through the results.</p> 