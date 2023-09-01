| Data<br/>retention period | Cost of storing<br/>data with a<br/>throughput<br/>limit per shard of 128 KB/s,<br/>without VAT | Cost of storing<br/>data with a<br/>throughput<br/>limit per shard of 512 KB/s,<br/>without VAT | Cost of storing<br/>data with a<br/>throughput<br/>limit per shard of 1 MB/s,<br/>without VAT |
---|---|---|---
| 1 hour, the first 744 hours of use per month | {{ sku|USD|yds.reserved_resources.128k.1h|string }} | Not provided | Not provided |
| 1 hour, over 744 hours of use per month^*^ | {{ sku|USD|yds.reserved_resources.128k.1h|pricingRate.744|string }} | Not provided | Not provided |
| 4 hours | {{ sku|USD|yds.reserved_resources.128k.4h|string }} | {{ sku|USD|yds.reserved_resources.512k.4h|string }} | {{ sku|USD|yds.reserved_resources.1m.4h|string }} |
| 12 hours | {{ sku|USD|yds.reserved_resources.128k.12h|string }} | {{ sku|USD|yds.reserved_resources.512k.12h|string }} | {{ sku|USD|yds.reserved_resources.1m.12h|string }} |
| 24 hours | {{ sku|USD|yds.reserved_resources.128k.24h|string }} | {{ sku|USD|yds.reserved_resources.512k.24h|string }} | {{ sku|USD|yds.reserved_resources.1m.24h|string }} |

^*^ The time of resource usage by multiple streams is summed up. For example, if two streams are running 24/7 during a month, the time of resource usage will be 2 × 24 × 30 = 1.440 hours. The first 744 hours are free of charge. They will be used up by the two streams in half a month. After that, you will start to be charged for the service.
