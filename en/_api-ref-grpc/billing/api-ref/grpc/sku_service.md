---
editable: false
---

# Billing API, gRPC: SkuService

A set of methods for managing Sku resources.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified SKU. |
| [List](#List) | Retrieves the list of SKUs. |

## Calls SkuService {#calls}

## Get {#Get}

Returns the specified SKU.

**rpc Get ([GetSkuRequest](#GetSkuRequest)) returns ([Sku](#Sku))**

### GetSkuRequest {#GetSkuRequest}

Field | Description
--- | ---
id | **string**<br>Required. ID of the SKU to return. To get the SKU ID, use [SkuService.List](#List) request. The maximum string length in characters is 50.
currency | **string**<br>Required. Currency of the SKU. Can be one of the following: <ul><li>`RUB` </li><li>`USD` </li><li>`KZT`</li></ul> 
billing_account_id | **string**<br>Optional ID of the billing account. If specified, contract prices for concrete billing account are included in the response. To get the billing account ID, use [BillingAccountService.List](./billing_account_service#List) request. 


### Sku {#Sku}

Field | Description
--- | ---
id | **string**<br>ID of the SKU. 
name | **string**<br>Name of the SKU. 
description | **string**<br>Description of the sku. 
service_id | **string**<br>ID of the service that sku belongs to. 
pricing_unit | **string**<br>Pricing unit of the SKU, e.g. `core*hour`, `gbyte*hour`. 
pricing_versions[] | **[PricingVersion](#PricingVersion)**<br>List of pricing versions. 


### PricingVersion {#PricingVersion}

Field | Description
--- | ---
type | enum **PricingVersionType**<br>Type of the pricing version. <ul><li>`STREET_PRICE`: Regular price.</li><li>`CONTRACT_PRICE`: Price is overridden by a contract. Defined in the scope of a billing account.</li></ul>
effective_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Timestamp pricing version is active since inclusive. The pricing version is active until next pricing version effective time exclusive. 
pricing_expressions[] | **[PricingExpression](#PricingExpression)**<br>List of pricing expressions. 


### PricingExpression {#PricingExpression}

Field | Description
--- | ---
rates[] | **[Rate](#Rate)**<br>List of rates. 


### Rate {#Rate}

Field | Description
--- | ---
start_pricing_quantity | **string**<br>Start of the pricing quantity interval. The end of the interval is the start pricing quantity of the next rate. 
unit_price | **string**<br>Unit price for the pricing quantity interval. 
currency | **string**<br>Currency of the unit price. Can be one of the following: <ul><li>`RUB` </li><li>`USD` </li><li>`KZT`</li></ul> 


## List {#List}

Retrieves the list of SKUs.

**rpc List ([ListSkusRequest](#ListSkusRequest)) returns ([ListSkusResponse](#ListSkusResponse))**

### ListSkusRequest {#ListSkusRequest}

Field | Description
--- | ---
currency | **string**<br>Required. Currency of the prices. Can be one of the following: <ul><li>`RUB` </li><li>`USD` </li><li>`KZT`</li></ul> 
billing_account_id | **string**<br>Optional ID of the billing account. If specified, contract prices for concrete billing account are included in the response. To get the billing account ID, use [BillingAccountService.List](./billing_account_service#List) request. 
filter | **string**<br>A filter expression that filters resources listed in the response. The expression must specify: <ol><li>The field name. Currently you can use filtering only on the [yandex.cloud.billing.v1.Sku.id](#Sku) and [yandex.cloud.billing.v1.Sku.service_id](#Sku) field. </li><li>An `=` operator. </li><li>The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`.</li></ol> The maximum string length in characters is 1000.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListSkusResponse.next_page_token](#ListSkusResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListSkusResponse.next_page_token](#ListSkusResponse) returned by a previous list request. The maximum string length in characters is 100.


### ListSkusResponse {#ListSkusResponse}

Field | Description
--- | ---
skus[] | **[Sku](#Sku1)**<br>List of skus. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListSkusRequest.page_size](#ListSkusRequest), use `next_page_token` as the value for the [ListSkusRequest.page_token](#ListSkusRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Sku {#Sku1}

Field | Description
--- | ---
id | **string**<br>ID of the SKU. 
name | **string**<br>Name of the SKU. 
description | **string**<br>Description of the sku. 
service_id | **string**<br>ID of the service that sku belongs to. 
pricing_unit | **string**<br>Pricing unit of the SKU, e.g. `core*hour`, `gbyte*hour`. 
pricing_versions[] | **[PricingVersion](#PricingVersion1)**<br>List of pricing versions. 


### PricingVersion {#PricingVersion1}

Field | Description
--- | ---
type | enum **PricingVersionType**<br>Type of the pricing version. <ul><li>`STREET_PRICE`: Regular price.</li><li>`CONTRACT_PRICE`: Price is overridden by a contract. Defined in the scope of a billing account.</li></ul>
effective_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Timestamp pricing version is active since inclusive. The pricing version is active until next pricing version effective time exclusive. 
pricing_expressions[] | **[PricingExpression](#PricingExpression1)**<br>List of pricing expressions. 


### PricingExpression {#PricingExpression1}

Field | Description
--- | ---
rates[] | **[Rate](#Rate1)**<br>List of rates. 


### Rate {#Rate1}

Field | Description
--- | ---
start_pricing_quantity | **string**<br>Start of the pricing quantity interval. The end of the interval is the start pricing quantity of the next rate. 
unit_price | **string**<br>Unit price for the pricing quantity interval. 
currency | **string**<br>Currency of the unit price. Can be one of the following: <ul><li>`RUB` </li><li>`USD` </li><li>`KZT`</li></ul> 


