---
editable: false
sourcePath: en/_api-ref/billing/api-ref/Sku/list.md
---


# Method list
Retrieves the list of SKUs.
 

 
## HTTP request {#https-request}
```
GET https://billing.api.cloud.yandex.net/billing/v1/skus
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
currency | Required. Currency of the prices. Can be one of the following: * `RUB` * `USD` * `KZT`
billingAccountId | Optional ID of the billing account. If specified, contract prices for concrete billing account are included in the response. To get the billing account ID, use [list](/docs/billing/api-ref/BillingAccount/list) request.
filter | A filter expression that filters resources listed in the response. The expression must specify: 1. The field name. Currently you can use filtering only on the [Sku.id](/docs/billing/api-ref/Sku#representation) and [Sku.serviceId](/docs/billing/api-ref/Sku#representation) field. 2. An `=` operator. 3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`.  The maximum string length in characters is 1000.
pageSize | The maximum number of results per page to return. If the number of available results is larger than [pageSize](/docs/billing/api-ref/Sku/list#query_params), the service returns a [nextPageToken](/docs/billing/api-ref/Sku/list#responses) that can be used to get the next page of results in subsequent list requests.  The maximum value is 1000.
pageToken | Page token. To get the next page of results, set [pageToken](/docs/billing/api-ref/Sku/list#query_params) to the [nextPageToken](/docs/billing/api-ref/Sku/list#responses) returned by a previous list request.  The maximum string length in characters is 100.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "skus": [
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
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
skus[] | **object**<br><p>A Stock keeping unit resource.</p> 
skus[].<br>id | **string**<br><p>ID of the SKU.</p> 
skus[].<br>name | **string**<br><p>Name of the SKU.</p> 
skus[].<br>description | **string**<br><p>Description of the sku.</p> 
skus[].<br>serviceId | **string**<br><p>ID of the service that sku belongs to.</p> 
skus[].<br>pricingUnit | **string**<br><p>Pricing unit of the SKU, e.g. ``core*hour``, ``gbyte*hour``.</p> 
skus[].<br>pricingVersions[] | **object**<br><p>Pricing version of the SKU. Defines current and past prices for the sku.</p> 
skus[].<br>pricingVersions[].<br>type | **string**<br><p>Type of the pricing version.</p> <p>Type of the pricing version.</p> <ul> <li>STREET_PRICE: Regular price.</li> <li>CONTRACT_PRICE: Price is overridden by a contract. Defined in the scope of a billing account.</li> </ul> 
skus[].<br>pricingVersions[].<br>effectiveTime | **string** (date-time)<br><p>Timestamp pricing version is active since inclusive. The pricing version is active until next pricing version effective time exclusive.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
skus[].<br>pricingVersions[].<br>pricingExpressions[] | **object**<br><p>Pricing expression of the pricing version. Defines price for the sku.</p> 
skus[].<br>pricingVersions[].<br>pricingExpressions[].<br>rates[] | **object**<br><p>Rate of the pricing expression. Define unit price for pricing quantity interval.</p> 
skus[].<br>pricingVersions[].<br>pricingExpressions[].<br>rates[].<br>startPricingQuantity | **string**<br><p>Start of the pricing quantity interval. The end of the interval is the start pricing quantity of the next rate.</p> 
skus[].<br>pricingVersions[].<br>pricingExpressions[].<br>rates[].<br>unitPrice | **string**<br><p>Unit price for the pricing quantity interval.</p> 
skus[].<br>pricingVersions[].<br>pricingExpressions[].<br>rates[].<br>currency | **string**<br><p>Currency of the unit price. Can be one of the following:</p> <ul> <li>``RUB``</li> <li>``USD``</li> <li>``KZT``</li> </ul> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/billing/api-ref/Sku/list#query_params">pageSize</a>, use <a href="/docs/billing/api-ref/Sku/list#responses">nextPageToken</a> as the value for the <a href="/docs/billing/api-ref/Sku/list#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/billing/api-ref/Sku/list#responses">nextPageToken</a> to continue paging through the results.</p> 