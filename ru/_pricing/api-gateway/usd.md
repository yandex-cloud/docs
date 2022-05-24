### API gateway requests {#request}

| Service | Price per 1 million requests, <br>without VAT |
| ----- | ----- |
| Requests to API gateways, up to 100,000 requests per month | {{ sku|USD|api-gateway.requests.v1|string }} |
| Requests to the API gateway, more than 100,000 requests per month | {{ sku|USD|api-gateway.requests.v1|pricingRate.0.1|string }} |

You pay for the actual number of invocations. For example, the cost of ten thousand invocations is `$0.009600`, if price per 1 million requests (without VAT) is `$0.960000`.
