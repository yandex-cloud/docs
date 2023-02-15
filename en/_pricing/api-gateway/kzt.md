### API gateway requests {#request}

| Service | Price per 1 million requests, including VAT |
| --- | --- |
| API gateway requests, up to 100000 requests per month | {{ sku|KZT|api-gateway.requests.v1|string }} |
| Requests to API gateways, over 100000 requests per month | {{ sku|KZT|api-gateway.requests.v1|pricingRate.0.1|string }} |

You pay for the actual number of invocations.

> For example, if 1000000 requests cost ₸600, then 10000 calls over the included number cost ₸6.