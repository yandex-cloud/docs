---
editable: false
sourcePath: en/_api-ref/billing/api-ref/BillingAccount/index.md
---


# BillingAccount
A set of methods for managing BillingAccount resources.
## JSON Representation {#representation}
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
 
Field | Description
--- | ---
id | **string**<br><p>ID of the billing account.</p> 
name | **string**<br><p>Name of the billing account.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
countryCode | **string**<br><p>ISO 3166-1 alpha-2 country code of the billing account.</p> 
currency | **string**<br><p>Currency of the billing account. Can be one of the following:</p> <ul> <li>``RUB``</li> <li>``USD``</li> <li>``KZT``</li> </ul> 
active | **boolean** (boolean)<br><p>Represents whether corresponding billable objects can be used or not.</p> 
balance | **string**<br><p>Current balance of the billing account.</p> 

## Methods {#methods}
Method | Description
--- | ---
[bindBillableObject](bindBillableObject.md) | Binds billable object to the specified billing account.
[get](get.md) | Returns the specified billing account.
[list](list.md) | Retrieves the list of billing accounts available for current user.
[listAccessBindings](listAccessBindings.md) | Lists access bindings for the specified billing account.
[listBillableObjectBindings](listBillableObjectBindings.md) | Retrieves the list of billable object bindings associated with the specified billing account.
[updateAccessBindings](updateAccessBindings.md) | Updates access bindings for the specified billing account.