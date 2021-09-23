---
editable: false
---

# Method list
Retrieves the list of customers associated with the specified reseller.
 

 
## HTTP request {#https-request}
```
GET https://billing.api.cloud.yandex.net/billing/v1/customers
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
resellerId | Required. ID of the reseller.  The maximum string length in characters is 50.
pageSize | The maximum number of results per page to return. If the number of available results is larger than [pageSize](/docs/billing/api-ref/Customer/list#query_params), the service returns a [nextPageToken](/docs/billing/api-ref/Customer/list#responses) that can be used to get the next page of results in subsequent list requests.  The maximum value is 1000.
pageToken | Page token. To get the next page of results, set [pageToken](/docs/billing/api-ref/Customer/list#query_params) to the [nextPageToken](/docs/billing/api-ref/Customer/list#responses) returned by a previous list request.  The maximum string length in characters is 100.
 
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
customers[] | **object**<br><p>A Customer resource.</p> 
customers[].<br>id | **string**<br><p>ID of the customer.</p> 
customers[].<br>billingAccountId | **string**<br><p>ID of the <a href="/docs/billing/api-ref/BillingAccount#representation">BillingAccount</a> assigned to the customer.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/billing/api-ref/Customer/list#query_params">pageSize</a>, use <a href="/docs/billing/api-ref/Customer/list#responses">nextPageToken</a> as the value for the <a href="/docs/billing/api-ref/Customer/list#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/billing/api-ref/Customer/list#responses">nextPageToken</a> to continue paging through the results.</p> 