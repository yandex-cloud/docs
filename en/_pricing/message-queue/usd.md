| Service | Rate for 1 million requests, without VAT |
| ----- | ----- |
| The first 100 000 requests per month | {{ sku|USD|ymq.queue.std.requests|string }} |
| Requests to standard queues | {{ sku|USD|ymq.queue.std.requests|pricingRate.0.1|string }} |
| Requests to FIFO queues | {{ sku|USD|ymq.queue.fifo.requests|string }} |
