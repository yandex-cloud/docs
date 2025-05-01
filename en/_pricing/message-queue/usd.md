| Service | Cost per 1 million requests, without VAT |
| ----- | ----- |
| 100000 requests or less per month | {{ sku|USD|ymq.queue.std.requests|string }} |
| Requests to standard queues | {{ sku|USD|ymq.queue.std.requests|pricingRate.0.1|string }} |
| Requests to FIFO queues | {{ sku|USD|ymq.queue.fifo.requests|pricingRate.0.1|string }} |

You pay for the actual number of requests. For example, the cost per one thousand requests is {% calc [currency=USD] 0,001 × {{ sku|USD|ymq.queue.std.requests|pricingRate.0.1|number }} %}, while the cost of 1M requests is {{ sku|USD|ymq.queue.std.requests|pricingRate.0.1|string }}.
