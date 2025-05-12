| Service | Price per million values, <br>without VAT |
----- | -----
| Writing metric values via the {{ prometheus-name }} Remote API<br/>(up to 50 million values) | {{ sku|USD|monitoring.prometheus.point.remote_api.write|string }} |
| Writing metric values via the {{ prometheus-name }} Remote API<br/>(50 million to 10 billion values) | {{ sku|USD|monitoring.prometheus.point.remote_api.write|pricingRate.50|string }} |
| Writing metric values via the {{ prometheus-name }} Remote API<br/>(over 10 billion values) | {{ sku|USD|monitoring.prometheus.point.remote_api.write|pricingRate.10000|string }} |
| Reading metric values via the {{ prometheus-name }} Remote API | {{ sku|USD|monitoring.prometheus.point.remote_api.read|string }} |
