| Service | Cost per 1 million requests, without VAT |
| ----- | ----- |
| 100000 requests or less per month | {{ sku|USD|ymq.queue.std.requests|string }} |
| Requests to standard queues | {{ sku|USD|ymq.queue.std.requests|pricingRate.0.1|string }} |
| Requests to FIFO queues | {{ sku|USD|ymq.queue.fifo.requests|pricingRate.0.1|string }} |
