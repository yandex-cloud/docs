* **Proxy server resources**: 6 resource units × 720 hours × {{ sku|USD|sws.proxy-server.v1|string }} per resource unit per hour = {% calc [currency=USD] 6 × 720 × {{ sku|USD|sws.proxy-server.v1|number }} %}.
* **SolidWall WAF legitimate traffic**: 300 RPS × $3.5 per RPS per month = {% calc [currency=USD] 300 × 3.5 %}.
* **SolidWall WAF additional application**: $36.88525 per month.
* **Requests processed by security profile rules**: 0.99 × {{ sku|USD|sws.requests.v1|pricingRate.0.01|string }} + 9 × {{ sku|USD|sws.requests.v1|pricingRate.1|string }} = {% calc [currency=USD] 0.99 × {{ sku|USD|sws.requests.v1|pricingRate.0.01|number }} + 9 × {{ sku|USD|sws.requests.v1|pricingRate.1|number }} %}.

Total for the proxy server, security profile, and SolidWall WAF for a full month: **{% calc [currency=USD] 6 × 720 × {{ sku|USD|sws.proxy-server.v1|number }} + 300 × 3.5 + 36.88525 + 0.99 × {{ sku|USD|sws.requests.v1|pricingRate.0.01|number }} + 9 × {{ sku|USD|sws.requests.v1|pricingRate.1|number }} %}**, excluding VAT.
