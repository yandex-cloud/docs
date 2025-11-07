| Service | Price per 1,000,000 requests, <br>without VAT |
| ----- | ----- |
| Requests to API gateways, up to 100,000 requests per month | {{ sku|USD|api-gateway.requests.v1|string }} |
| Requests to the API gateway, over 100,000 requests per month | {{ sku|USD|api-gateway.requests.v1|pricingRate.0.1|string }} |