---
editable: false
sourcePath: en/_api-ref/billing/v1/api-ref/Sku/list.md
---

# Billing API, REST: Sku.list
Retrieves the list of SKUs.
 

 
## HTTP request {#https-request}
```
GET https://billing.{{ api-host }}/billing/v1/skus
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
currency | <p>Required. Currency of the prices. Can be one of the following:</p> <ul> <li>``RUB``</li> <li>``USD``</li> <li>``KZT``</li> </ul> 
billingAccountId | <p>Optional ID of the billing account. If specified, contract prices for a particular billing account are included in the response. To get the billing account ID, use <a href="/docs/billing/api-ref/BillingAccount/list">list</a> request.</p> 
filter | <p>A filter expression that filters resources listed in the response. The expression must specify:</p> <ol> <li>The field name. Currently you can use filtering only on the <a href="/docs/billing/api-ref/Sku#representation">Sku.id</a> and <a href="/docs/billing/api-ref/Sku#representation">Sku.serviceId</a> field.</li> <li>An ``=`` operator.</li> <li>The value in double quotes (``"``). Must be 3-63 characters long and match the regular expression ``[a-z][-a-z0-9]{1,61}[a-z0-9]``.</li> </ol> <p>The maximum string length in characters is 1000.</p> 
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than <a href="/docs/billing/api-ref/Sku/list#query_params">pageSize</a>, the service returns a <a href="/docs/billing/api-ref/Sku/list#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests.</p> <p>The maximum value is 1000.</p> 
pageToken | <p>Page token. To get the next page of results, set <a href="/docs/billing/api-ref/Sku/list#query_params">pageToken</a> to the <a href="/docs/billing/api-ref/Sku/list#responses">nextPageToken</a> returned by a previous list request.</p> <p>The maximum string length in characters is 100.</p> 
 
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
skus[] | **object**<br><p>List of skus.</p> 
skus[].<br>id | **string**<br><p>ID of the SKU.</p> 
skus[].<br>name | **string**<br><p>Name of the SKU.</p> 
skus[].<br>description | **string**<br><p>Description of the sku.</p> 
skus[].<br>serviceId | **string**<br><p>ID of the service that sku belongs to.</p> 
skus[].<br>pricingUnit | **string**<br><p>Pricing unit of the SKU, e.g. ``core*hour``, ``gbyte*hour``.</p> 
skus[].<br>pricingVersions[] | **object**<br><p>List of pricing versions.</p> 
skus[].<br>pricingVersions[].<br>type | **string**<br><p>Type of the pricing version.</p> <p>Type of the pricing version.</p> <ul> <li>STREET_PRICE: Regular price.</li> <li>CONTRACT_PRICE: Price is overridden by a contract. Defined in the scope of a billing account.</li> </ul> 
skus[].<br>pricingVersions[].<br>effectiveTime | **string** (date-time)<br><p>Timestamp pricing version is active since inclusive. The pricing version is active until next pricing version effective time exclusive.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
skus[].<br>pricingVersions[].<br>pricingExpressions[] | **object**<br><p>List of pricing expressions.</p> 
skus[].<br>pricingVersions[].<br>pricingExpressions[].<br>rates[] | **object**<br><p>List of rates.</p> 
skus[].<br>pricingVersions[].<br>pricingExpressions[].<br>rates[].<br>startPricingQuantity | **string**<br><p>Start of the pricing quantity interval. The end of the interval is the start pricing quantity of the next rate.</p> 
skus[].<br>pricingVersions[].<br>pricingExpressions[].<br>rates[].<br>unitPrice | **string**<br><p>Unit price for the pricing quantity interval.</p> 
skus[].<br>pricingVersions[].<br>pricingExpressions[].<br>rates[].<br>currency | **string**<br><p>Currency of the unit price. Can be one of the following:</p> <ul> <li>``RUB``</li> <li>``USD``</li> <li>``KZT``</li> </ul> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/billing/api-ref/Sku/list#query_params">pageSize</a>, use <a href="/docs/billing/api-ref/Sku/list#responses">nextPageToken</a> as the value for the <a href="/docs/billing/api-ref/Sku/list#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/billing/api-ref/Sku/list#responses">nextPageToken</a> to continue paging through the results.</p> 