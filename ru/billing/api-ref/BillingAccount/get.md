---
editable: false
sourcePath: en/_api-ref/billing/api-ref/BillingAccount/get.md
---

# Method get
Returns the specified billing account.
 

 
## HTTP request {#https-request}
```
GET https://billing.{{ api-host }}/billing/v1/billingAccounts/{id}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
id | <p>Required. ID of the billing account to return. To get the billing account ID, use <a href="/docs/billing/api-ref/BillingAccount/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "name": "string",
  "createdAt": "string",
  "countryCode": "string",
  "currency": "string",
  "active": true,
  "balance": "string"
}
```
A BillingAccount resource. For more information, see [BillingAccount](/docs/billing/concepts/billing-account).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the billing account.</p> 
name | **string**<br><p>Name of the billing account.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
countryCode | **string**<br><p>ISO 3166-1 alpha-2 country code of the billing account.</p> 
currency | **string**<br><p>Currency of the billing account. Can be one of the following:</p> <ul> <li>``RUB``</li> <li>``USD``</li> <li>``KZT``</li> </ul> 
active | **boolean** (boolean)<br><p>Represents whether corresponding billable objects can be used or not.</p> 
balance | **string**<br><p>Current balance of the billing account.</p> 