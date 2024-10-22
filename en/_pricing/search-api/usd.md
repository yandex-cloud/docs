| Service | Cost per 1,000 requests,<br/>without VAT |
|---------|-----------------------------------------|
| Night-time synchronous requests, first 1,000 requests per month | {{ sku|USD|searchapi.requests.night.v1|int|string }} |
| Night-time synchronous requests, over 1,000 requests per month | {{ sku|USD|searchapi.requests.night.v1|pricingRate.1|string }} |
| Daytime synchronous requests | {{ sku|USD|searchapi.requests.day.v1|string }} |

{% note warning %}

The pricing below will apply starting November 1, 2024.

{% endnote %}

| Service | Cost per 1,000 requests,<br/>without VAT |
|---------|--------------------------------------------|
| Deferred requests | $0.20  |