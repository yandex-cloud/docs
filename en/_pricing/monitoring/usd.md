| Service | Price per 1,000,000 values, <br>without VAT |
| ----- | ----- |
| Reading metric values through the API<br/>(up to 50,000,000 values) | {{ sku|USD|monitoring.point.api.read|string }} |
| Reading metric values through the API<br/>(over 50,000,000 values) | {{ sku|USD|monitoring.point.api.read|pricingRate.50|string }} |
| Exporting metric values in {{ prometheus-name }} format through the API<br/>(up to 50,000,000 values) | {{ sku|USD|monitoring.point.prometheus.export|string }} |
| Exporting metric values in {{ prometheus-name }} format through the API<br/>(over 50,000,000 values) | {{ sku|USD|monitoring.point.prometheus.export|pricingRate.50|string }} |
| Writing values for custom metrics through the API<br/>(up to 50,000,000 values) | {{ sku|USD|monitoring.point.write|string }} |
| Writing values for custom metrics through the API<br/>(over 50,000,000 values) | {{ sku|USD|monitoring.point.write|pricingRate.50|string }} |
| Writing values for {{ yandex-cloud }} resource metrics | {{ sku|USD|monitoring.point.dgauge.store|string }} |