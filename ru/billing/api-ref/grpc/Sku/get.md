---
editable: false
sourcePath: en/_api-ref-grpc/billing/v1/api-ref/grpc/Sku/get.md
---

# Billing API, gRPC: SkuService.Get {#Get}

Returns the specified SKU.

## gRPC request

**rpc Get ([GetSkuRequest](#yandex.cloud.billing.v1.GetSkuRequest)) returns ([Sku](#yandex.cloud.billing.v1.Sku))**

## GetSkuRequest {#yandex.cloud.billing.v1.GetSkuRequest}

```json
{
  "id": "string",
  "currency": "string",
  "billingAccountId": "string"
}
```

#|
||Field | Description ||
|| id | **string**

Required field. ID of the SKU to return.
To get the SKU ID, use [SkuService.List](/docs/billing/api-ref/grpc/Sku/list#List) request. ||
|| currency | **string**

Required field. Currency of the SKU.
Can be one of the following:
* `RUB`
* `USD`
* `KZT` ||
|| billingAccountId | **string**

Optional ID of the billing account.
If specified, contract prices for a particular billing account are included in the response.
To get the billing account ID, use [BillingAccountService.List](/docs/billing/api-ref/grpc/BillingAccount/list#List) request. ||
|#

## Sku {#yandex.cloud.billing.v1.Sku}

```json
{
  "id": "string",
  "name": "string",
  "description": "string",
  "serviceId": "string",
  "pricingUnit": "string",
  "pricingVersions": [
    {
      "type": "PricingVersionType",
      "effectiveTime": "google.protobuf.Timestamp",
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
|| type | enum **PricingVersionType**

Type of the pricing version.

- `PRICING_VERSION_TYPE_UNSPECIFIED`
- `STREET_PRICE`: Regular price.
- `CONTRACT_PRICE`: Price is overridden by a contract. Defined in the scope of a billing account. ||
|| effectiveTime | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp pricing version is active since inclusive.
The pricing version is active until next pricing version effective time exclusive. ||
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