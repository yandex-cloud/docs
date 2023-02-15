| Service | Price per 1 million requests, <br>including VAT |
----- | -----
| 100000 requests or less per month | {{ sku|RUB|ymq.queue.std.requests|string }} |
| Requests to standard queues | {{ sku|RUB|ymq.queue.std.requests|pricingRate.0.1|string }} |
| Requests to FIFO queues | {{ sku|RUB|ymq.queue.fifo.requests|pricingRate.0.1|string }} |
