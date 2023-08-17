---
editable: false
sourcePath: en/_api-ref/billing/v1/api-ref/Sku/index.md
---

# Billing API, REST: Sku methods
A set of methods for managing Sku resources.
## JSON Representation {#representation}
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
 
Field | Description
--- | ---
id | **string**<br><p>ID of the SKU.</p> 
name | **string**<br><p>Name of the SKU.</p> 
description | **string**<br><p>Description of the sku.</p> 
serviceId | **string**<br><p>ID of the service that sku belongs to.</p> 
pricingUnit | **string**<br><p>Pricing unit of the SKU, e.g. ``core*hour``, ``gbyte*hour``.</p> 
pricingVersions[] | **object**<br><p>List of pricing versions.</p> 
pricingVersions[].<br>type | **string**<br><p>Type of the pricing version.</p> <p>Type of the pricing version.</p> <ul> <li>STREET_PRICE: Regular price.</li> <li>CONTRACT_PRICE: Price is overridden by a contract. Defined in the scope of a billing account.</li> </ul> 
pricingVersions[].<br>effectiveTime | **string** (date-time)<br><p>Timestamp pricing version is active since inclusive. The pricing version is active until next pricing version effective time exclusive.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
pricingVersions[].<br>pricingExpressions[] | **object**<br><p>List of pricing expressions.</p> 
pricingVersions[].<br>pricingExpressions[].<br>rates[] | **object**<br><p>List of rates.</p> 
pricingVersions[].<br>pricingExpressions[].<br>rates[].<br>startPricingQuantity | **string**<br><p>Start of the pricing quantity interval. The end of the interval is the start pricing quantity of the next rate.</p> 
pricingVersions[].<br>pricingExpressions[].<br>rates[].<br>unitPrice | **string**<br><p>Unit price for the pricing quantity interval.</p> 
pricingVersions[].<br>pricingExpressions[].<br>rates[].<br>currency | **string**<br><p>Currency of the unit price. Can be one of the following:</p> <ul> <li>``RUB``</li> <li>``USD``</li> <li>``KZT``</li> </ul> 

## Methods {#methods}
Method | Description
--- | ---
[get](get.md) | Returns the specified SKU.
[list](list.md) | Retrieves the list of SKUs.