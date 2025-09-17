| Service | Price per 1,000 requests,<br/>without VAT |
|---------|-----------------------------------------|
| **[API v1](../../search-api/concepts/index.md#api-v1) requests** | |
| Night-time synchronous requests, first 1,000 requests per month | {{ sku|USD|searchapi.requests.night.v1|int|string }} |
| Night-time synchronous requests, over 1,000 requests per month | {{ sku|USD|searchapi.requests.night.v1|pricingRate.1|string }} |
| Daytime synchronous requests | {{ sku|USD|searchapi.requests.day.v1|string }} |
| **[API v2](../../search-api/concepts/index.md#api-v2) requests** | |
| Synchronous requests | {{ sku|USD|searchapi.requests.sync.v3|string }} |
| Deferred requests | {{ sku|USD|searchapi.requests.async.v3|string }}  |
| Synchronous requests with [generative response](../../search-api/concepts/generative-response.md) | {% calc [currency=USD] {{ sku|USD|searchapi.generative.requests.v3|number }} × 1000 %} |

{% note warning %}

The prices below will apply starting October 1, 2025.

{% endnote %}

| Service | Price per 1,000 requests,<br/>without VAT |
|---------|-------------------------------------|
| **[API v2](../../search-api/concepts/index.md#api-v2) requests** | |
| Daytime synchronous requests | $3.999998 |
| Daytime deferred requests | $0.250000 |
| Night-time synchronous requests | $2.999999 |
| Night-time deferred requests | $0.208333 |
| Image search requests | $7.500000 |
| Synchronous requests with [generative response](../../search-api/concepts/generative-response.md) | {% calc [currency=USD] {{ sku|USD|searchapi.generative.requests.v3|number }} × 1000 %} |