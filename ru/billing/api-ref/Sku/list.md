---
editable: false
sourcePath: en/_api-ref/billing/v1/api-ref/Sku/list.md
---

# Billing API, REST: Sku.List

Retrieves the list of SKUs.

## HTTP request

```
GET https://billing.{{ api-host }}/billing/v1/skus
```

## Query parameters {#yandex.cloud.billing.v1.ListSkusRequest}

#|
||Field | Description ||
|| currency | **string**

Required field. Currency of the prices.
Can be one of the following:
* `RUB`
* `USD`
* `KZT` ||
|| billingAccountId | **string**

Optional ID of the billing account.
If specified, contract prices for a particular billing account are included in the response.
To get the billing account ID, use [BillingAccountService.List](/docs/billing/api-ref/BillingAccount/list#List) request. ||
|| filter | **string**

A filter expression that filters resources listed in the response.
The expression must specify:
1. The field name. Currently you can use filtering only on the [yandex.cloud.billing.v1.Sku.id](#yandex.cloud.billing.v1.Sku) and [yandex.cloud.billing.v1.Sku.serviceId](#yandex.cloud.billing.v1.Sku) field.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`.
E.g. `filter=serviceId="dn28hpu6268356q0j8mk"`. ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`,
the service returns a [ListSkusResponse.nextPageToken](#yandex.cloud.billing.v1.ListSkusResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| pageToken | **string**

Page token. To get the next page of results,
set `pageToken` to the [ListSkusResponse.nextPageToken](#yandex.cloud.billing.v1.ListSkusResponse)
returned by a previous list request. ||
|#

## Response {#yandex.cloud.billing.v1.ListSkusResponse}

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

#|
||Field | Description ||
|| skus[] | **[Sku](#yandex.cloud.billing.v1.Sku)**

List of skus. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListSkusRequest.pageSize](#yandex.cloud.billing.v1.ListSkusRequest), use
`nextPageToken` as the value
for the [ListSkusRequest.pageToken](#yandex.cloud.billing.v1.ListSkusRequest) query parameter
in the next list request. Each subsequent list request will have its own
`nextPageToken` to continue paging through the results. ||
|#

## Sku {#yandex.cloud.billing.v1.Sku}

A Stock keeping unit resource.

#|
||Field | Description ||
|| id | **string**

ID of the SKU. ||
|| name | **string**

Name of the SKU. ||
|| description | **string**

Description of the sku. ||
|| serviceId | **string**

ID of the service that sku belongs to. ||
|| pricingUnit | **string**

Pricing unit of the SKU, e.g. `core*hour`, `gbyte*hour`. ||
|| pricingVersions[] | **[PricingVersion](#yandex.cloud.billing.v1.PricingVersion)**

List of pricing versions. ||
|#

## PricingVersion {#yandex.cloud.billing.v1.PricingVersion}

Pricing version of the SKU.
Defines current and past prices for the sku.

#|
||Field | Description ||
|| type | **enum** (PricingVersionType)

Type of the pricing version.

- `PRICING_VERSION_TYPE_UNSPECIFIED`
- `STREET_PRICE`: Regular price.
- `CONTRACT_PRICE`: Price is overridden by a contract. Defined in the scope of a billing account. ||
|| effectiveTime | **string** (date-time)

Timestamp pricing version is active since inclusive.
The pricing version is active until next pricing version effective time exclusive.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| pricingExpressions[] | **[PricingExpression](#yandex.cloud.billing.v1.PricingExpression)**

List of pricing expressions. ||
|#

## PricingExpression {#yandex.cloud.billing.v1.PricingExpression}

Pricing expression of the pricing version.
Defines price for the sku.

#|
||Field | Description ||
|| rates[] | **[Rate](#yandex.cloud.billing.v1.Rate)**

List of rates. ||
|#

## Rate {#yandex.cloud.billing.v1.Rate}

Rate of the pricing expression.
Define unit price for pricing quantity interval.

#|
||Field | Description ||
|| startPricingQuantity | **string**

Start of the pricing quantity interval. The end of the interval is the start pricing quantity of the next rate. ||
|| unitPrice | **string**

Unit price for the pricing quantity interval. ||
|| currency | **string**

Currency of the unit price.
Can be one of the following:
* `RUB`
* `USD`
* `KZT` ||
|#