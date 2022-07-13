---
editable: false
sourcePath: en/_api-ref/billing/api-ref/BillingAccount/listBillableObjectBindings.md
---

# Method listBillableObjectBindings
Retrieves the list of billable object bindings associated with the specified billing account.
 

 
## HTTP request {#https-request}
```
GET https://billing.{{ api-host }}/billing/v1/billingAccounts/{billingAccountId}/billableObjectBindings
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
billingAccountId | <p>Required. ID of the billing account to list associated billable object bindings. To get the billing account ID, use <a href="/docs/billing/api-ref/BillingAccount/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than <a href="/docs/billing/api-ref/BillingAccount/listBillableObjectBindings#query_params">pageSize</a>, the service returns a <a href="/docs/billing/api-ref/BillingAccount/listBillableObjectBindings#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests.</p> <p>The maximum value is 1000.</p> 
pageToken | <p>Page token. To get the next page of results, set <a href="/docs/billing/api-ref/BillingAccount/listBillableObjectBindings#query_params">pageToken</a> to the <a href="/docs/billing/api-ref/BillingAccount/listBillableObjectBindings#responses">nextPageToken</a> returned by a previous list request.</p> <p>The maximum string length in characters is 100.</p> 
 
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
billableObjectBindings[] | **object**<br><p>List of billable object bindings.</p> 
billableObjectBindings[].<br>effectiveTime | **string** (date-time)<br><p>Timestamp when binding was created.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
billableObjectBindings[].<br>billableObject | **object**<br><p>Object that is bound to billing account.</p> <p>Represents a link to an object in other service. This object is being billed in the scope of a billing account.</p> 
billableObjectBindings[].<br>billableObject.<br>id | **string**<br><p>ID of the object in other service.</p> 
billableObjectBindings[].<br>billableObject.<br>type | **string**<br><p>Billable object type. Can be one of the following:</p> <ul> <li>``cloud``</li> </ul> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/billing/api-ref/BillingAccount/listBillableObjectBindings#query_params">pageSize</a>, use <a href="/docs/billing/api-ref/BillingAccount/listBillableObjectBindings#responses">nextPageToken</a> as the value for the <a href="/docs/billing/api-ref/BillingAccount/listBillableObjectBindings#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/billing/api-ref/BillingAccount/listBillableObjectBindings#responses">nextPageToken</a> to continue paging through the results.</p> 