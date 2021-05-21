Service | Rate for 1 million requests, with VAT
----- | -----
The first 100 000 requests per month | {{ sku|RUB|ymq.queue.std.requests|string }} 
Requests to standard queues | {{ sku|RUB|ymq.queue.std.requests|pricingRate.0.1|string }}
Requests to FIFO queues | {{ sku|RUB|ymq.queue.fifo.requests|pricingRate.0.1|string }}
