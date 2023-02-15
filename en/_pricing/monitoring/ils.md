| Service | Price per 1 million values, <br>including VAT |
----- | -----
| Reading metric values via the API<br/>(up to 50 million values) | {{ sku|ILS|monitoring.point.dgauge.read|string }} |
| Reading metric values via the API<br/>(over 50 million values) | {{ sku|ILS|monitoring.point.dgauge.read|pricingRate.50|string }} |
| Writing values for custom metrics via the API<br/>(up to 50 million values) | {{ sku|ILS|monitoring.point.dgauge.write|string }} |
| Writing values for custom metrics via the API<br/>(over 50 million values) | {{ sku|ILS|monitoring.point.dgauge.write|pricingRate.50|string }} |
| Writing values for {{ yandex-cloud }} resource metrics | {{ sku|ILS|monitoring.point.dgauge.store|string }} |