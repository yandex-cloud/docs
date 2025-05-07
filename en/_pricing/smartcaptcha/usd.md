| Service | Price per 1,000 requests, <br>without VAT |
| ----- | ----- |
| Requests to the {{ captcha-name }} API, up to 10,000 per month | {{ sku|USD|smart_captcha.check.requests.v1|string }} |
| Requests to the {{ captcha-name }} API, from 10,001 to 100,000 per month | {{ sku|USD|smart_captcha.check.requests.v1|pricingRate.10|string }} |
| Requests to the {{ captcha-name }} API, more than 100,000 per month | {{ sku|USD|smart_captcha.check.requests.v1|pricingRate.100|string }} |