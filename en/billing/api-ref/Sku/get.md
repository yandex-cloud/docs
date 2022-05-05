---
editable: false
sourcePath: en/_api-ref/billing/api-ref/Sku/get.md
---

# Method get
Returns the specified SKU.
 

 
## HTTP request {#https-request}
```
GET https://billing.{{ api-host }}/billing/v1/skus/{id}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
id | Required. ID of the SKU to return. To get the SKU ID, use [list](/docs/billing/api-ref/Sku/list) request.  The maximum string length in characters is 50.
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
currency | Required. Currency of the SKU. Can be one of the following: * `RUB` * `USD` * `KZT`
billingAccountId | Optional ID of the billing account. If specified, contract prices for concrete billing account are included in the response. To get the billing account ID, use [list](/docs/billing/api-ref/BillingAccount/list) request.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "name": "string",
  "description": "string",
  "serviceId": "string",
  "pricingUnit": "string",
  "pricingVersions": [
    {
      "type": "string",
      "effectiveTime": "string",
      "pricingExpressions": [
        {
          "rates": [
            {
              "startPricingQuantity": "string",
              "unitPrice": "string",
              "currency": "string"
            }
          ]
        }
      ]
    }
  ]
}
```
A Stock keeping unit resource.
 
Field | Description
--- | ---
id | **string**<br><p>ID of the SKU.</p> 
name | **string**<br><p>Name of the SKU.</p> 
description | **string**<br><p>Description of the sku.</p> 
serviceId | **string**<br><p>ID of the service that sku belongs to.</p> 
pricingUnit | **string**<br><p>Pricing unit of the SKU, e.g. ``core*hour``, ``gbyte*hour``.</p> 
pricingVersions[] | **object**<br><p>Pricing version of the SKU. Defines current and past prices for the sku.</p> 
pricingVersions[].<br>type | **string**<br><p>Type of the pricing version.</p> <p>Type of the pricing version.</p> <ul> <li>STREET_PRICE: Regular price.</li> <li>CONTRACT_PRICE: Price is overridden by a contract. Defined in the scope of a billing account.</li> </ul> 
pricingVersions[].<br>effectiveTime | **string** (date-time)<br><p>Timestamp pricing version is active since inclusive. The pricing version is active until next pricing version effective time exclusive.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
pricingVersions[].<br>pricingExpressions[] | **object**<br><p>Pricing expression of the pricing version. Defines price for the sku.</p> 
pricingVersions[].<br>pricingExpressions[].<br>rates[] | **object**<br><p>Rate of the pricing expression. Define unit price for pricing quantity interval.</p> 
pricingVersions[].<br>pricingExpressions[].<br>rates[].<br>startPricingQuantity | **string**<br><p>Start of the pricing quantity interval. The end of the interval is the start pricing quantity of the next rate.</p> 
pricingVersions[].<br>pricingExpressions[].<br>rates[].<br>unitPrice | **string**<br><p>Unit price for the pricing quantity interval.</p> 
pricingVersions[].<br>pricingExpressions[].<br>rates[].<br>currency | **string**<br><p>Currency of the unit price. Can be one of the following:</p> <ul> <li>``RUB``</li> <li>``USD``</li> <li>``KZT``</li> </ul> 