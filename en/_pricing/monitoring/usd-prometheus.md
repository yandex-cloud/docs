Service | Price per 1,000,000 values, <br>without VAT
----- | -----
| Writing metric values through the {{ prometheus-name }} Remote API<br/>(up to 50,000,000 values) | {{ sku|USD|monitoring.prometheus.point.remote_api.write|string }} |
| Writing metric values through the {{ prometheus-name }} Remote API<br/>(from 50,000,000 to 10,000,000,000 values) | {{ sku|USD|monitoring.prometheus.point.remote_api.write|pricingRate.50|string }} |
| Writing metric values through the {{ prometheus-name }} Remote API<br/>(over 10,000,000,000 values) | {{ sku|USD|monitoring.prometheus.point.remote_api.write|pricingRate.10000|string }} |
| Reading metric values through the {{ prometheus-name }} Remote API | {{ sku|USD|monitoring.prometheus.point.remote_api.read|string }} |