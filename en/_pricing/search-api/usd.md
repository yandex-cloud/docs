| Service | Cost per 1,000 requests,<br/>without VAT |
|---------|-----------------------------------------|
| Night-time requests, first 1,000 requests per month | {{ sku|USD|searchapi.requests.night.v1|int|string }} |
| Night-time requests, over 1,000 requests per month | {{ sku|USD|searchapi.requests.night.v1|pricingRate.1|string }} |
| Daytime requests | {{ sku|USD|searchapi.requests.day.v1|string }} |