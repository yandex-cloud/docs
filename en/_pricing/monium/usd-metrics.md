| Service | Price per 1,000,000 values, <br>without VAT |
| ----- | ----- |
| Writing values for custom metrics through the API | $0.0026 |
| Reading metric values through the API<br/>(up to 50,000,000 values) | {{ sku|USD|monitoring.point.api.read|string }} |
| Reading metric values through the API<br/>(over 50,000,000 values) | {{ sku|USD|monitoring.point.api.read|pricingRate.50|string }} |
| Exporting metric values in {{ prometheus-name }} format through the API<br/>(up to 50,000,000 values) | {{ sku|USD|monitoring.point.prometheus.export|string }} |
| Exporting metric values in {{ prometheus-name }} format through the API<br/>(over 50,000,000 values) | {{ sku|USD|monitoring.point.prometheus.export|pricingRate.50|string }} |
| Writing metric values via {{ prometheus-name }} Remote API<br/>(up to 50,000,000 values) | Not charged |
| Writing metric values via {{ prometheus-name }} Remote API<br/>(from 50,000,000 to 10,000,000,000 values) | $0.019 |
| Writing metric values via {{ prometheus-name }} Remote API<br/>(over 10,000,000,000 values) | $0.0054 |
| Reading metric values via {{ prometheus-name }} Remote API | Not charged |
| Writing values for {{ yandex-cloud }} resource metrics | Not charged |