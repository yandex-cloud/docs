---
editable: false
sourcePath: en/_api-ref/billing/api-ref/BillingAccount/listBillableObjectBindings.md
---


# Method listBillableObjectBindings
Retrieves the list of billable object bindings associated with the specified billing account.
 

 
## HTTP request {#https-request}
```
GET https://billing.api.cloud.yandex.net/billing/v1/billingAccounts/{billingAccountId}/billableObjectBindings
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
billingAccountId | Required. ID of the billing account to list associated billable object bindings. To get the billing account ID, use [list](/docs/billing/api-ref/BillingAccount/list) request.  The maximum string length in characters is 50.
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | The maximum number of results per page to return. If the number of available results is larger than [pageSize](/docs/billing/api-ref/BillingAccount/listBillableObjectBindings#query_params), the service returns a [nextPageToken](/docs/billing/api-ref/BillingAccount/listBillableObjectBindings#responses) that can be used to get the next page of results in subsequent list requests.  The maximum value is 1000.
pageToken | Page token. To get the next page of results, set [pageToken](/docs/billing/api-ref/BillingAccount/listBillableObjectBindings#query_params) to the [nextPageToken](/docs/billing/api-ref/BillingAccount/listBillableObjectBindings#responses) returned by a previous list request.  The maximum string length in characters is 100.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "billableObjectBindings": [
    {
      "effectiveTime": "string",
      "billableObject": {
        "id": "string",
        "type": "string"
      }
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
billableObjectBindings[] | **object**<br><p>Represents a binding of the BillableObject to a BillingAccount.</p> 
billableObjectBindings[].<br>effectiveTime | **string** (date-time)<br><p>Timestamp when binding was created.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
billableObjectBindings[].<br>billableObject | **object**<br><p>Object that is bound to billing account.</p> <p>Represents a link to an object in other service. This object is being billed in the scope of a billing account.</p> 
billableObjectBindings[].<br>billableObject.<br>id | **string**<br><p>ID of the object in other service.</p> 
billableObjectBindings[].<br>billableObject.<br>type | **string**<br><p>Billable object type. Can be one of the following:</p> <ul> <li>``cloud``</li> </ul> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/billing/api-ref/BillingAccount/listBillableObjectBindings#query_params">pageSize</a>, use <a href="/docs/billing/api-ref/BillingAccount/listBillableObjectBindings#responses">nextPageToken</a> as the value for the <a href="/docs/billing/api-ref/BillingAccount/listBillableObjectBindings#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/billing/api-ref/BillingAccount/listBillableObjectBindings#responses">nextPageToken</a> to continue paging through the results.</p> 