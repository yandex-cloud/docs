| Service | Price per 1 million requests, <br>without VAT |
| ----- | ----- |
| Requests to API gateways, up to 100000 requests per month | {{ sku|USD|api-gateway.requests.v1|string }} |
| Requests to the API gateway, more than 100000 requests per month | {{ sku|USD|api-gateway.requests.v1|pricingRate.0.1|string }} |

You pay for the actual number of invocations.

> For example, if 1000000 requests cost $0.960000, then 10000 calls over the included number cost $0.009600.