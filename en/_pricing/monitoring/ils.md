| Service | Price per 1 million values, <br>with VAT |
| ----- | ----- |
| Reading any metric values via the API<br/>(up to 50 million values) | {{ sku|ILS|monitoring.point.dgauge.read|string }} |
| Reading any metric values via the API<br/>(over 50 million values) | {{ sku|ILS|monitoring.point.dgauge.read|pricingRate.50|string }} |
| Writing custom metric values via the API<br/>(up to 50 million values) | {{ sku|ILS|monitoring.point.dgauge.write|string }} |
| Writing custom metric values via the API<br/>(over 50 million values) | {{ sku|ILS|monitoring.point.dgauge.write|pricingRate.50|string }} |
| Writing {{ yandex-cloud }} resource metric values | {{ sku|ILS|monitoring.point.dgauge.store|string }} |