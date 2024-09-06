| Service | Cost per 1 million values, <br>without VAT |
| ----- | ----- |
| Reading any metric values via the API<br/>(up to 50 million values) | {{ sku|USD|monitoring.point.api.read|string }} |
| Reading any metric values via the API<br/>(over 50 million values) | {{ sku|USD|monitoring.point.api.read|pricingRate.50|string }} |
| Writing custom metric values via the API<br/>(up to 50 million values) | {{ sku|USD|monitoring.point.write|string }} |
| Writing custom metric values via the API<br/>(over 50 million values) | {{ sku|USD|monitoring.point.write|pricingRate.50|string }} |
| Writing {{ yandex-cloud }} resource metric values | {{ sku|USD|monitoring.point.dgauge.store|string }} |