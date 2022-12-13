---
editable: false
---

# Billing API, REST: BillingAccount.get
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
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
countryCode | **string**<br><p>ISO 3166-1 alpha-2 country code of the billing account.</p> 
currency | **string**<br><p>Currency of the billing account. Can be one of the following:</p> <ul> <li>``RUB``</li> <li>``USD``</li> <li>``KZT``</li> </ul> 
active | **boolean** (boolean)<br><p>Represents whether corresponding billable objects can be used or not.</p> 
balance | **string**<br><p>Current balance of the billing account.</p> 