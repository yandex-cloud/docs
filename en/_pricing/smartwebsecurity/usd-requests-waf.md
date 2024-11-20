| Number of requests per month, million | Cost per million requests, without VAT |
| --- | --- |
| Up to 0.01 (10,000 requests) inclusive | Free |
| From 0.01 to 1 inclusive | {{ sku|USD|sws.waf.requests.v1|pricingRate.0.01|string }}  |
| From 1 to 10 inclusive | {{ sku|USD|sws.waf.requests.v1|pricingRate.1|string }} |
| From 10 to 100 inclusive | {{ sku|USD|sws.waf.requests.v1|pricingRate.10|string }} |
| From 100 to 1,000 inclusive | {{ sku|USD|sws.waf.requests.v1|pricingRate.100|string }} |
| From 1,000 to 10,000 inclusive | {{ sku|USD|sws.waf.requests.v1|pricingRate.1000|string }} |
| Over 10,000 | {{ sku|USD|sws.waf.requests.v1|pricingRate.10000|string }} |