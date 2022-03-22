### API gateway requests {#request}

| Service | Price per 1 million requests, without VAT | |
| --- | --- | --- |
| | **Up until April 12, 2022** | **Starting April 13, 2022** |
| Requests to API gateways, up to 100,000 requests per month | {{ sku|RUB|api-gateway.requests.v1|string }} | {{ sku|RUB|api-gateway.requests.v1|string }} |
| Requests to the API gateway, more than 100,000 requests per month | {{ sku|RUB|api-gateway.requests.v1|pricingRate.0.1|string }}| ₽120 |

You pay for the actual number of invocations.

>For example, the cost of ten thousand invocations is `₽0.75`, if price per 1 million requests (with VAT) is `₽75`.