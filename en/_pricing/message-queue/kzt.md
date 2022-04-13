Service | Rate for 1 million requests, with VAT
----- | -----
The first 100 000 requests per month | {{ sku|KZT|ymq.queue.std.requests|string }} 
Requests to standard queues | {{ sku|KZT|ymq.queue.std.requests|pricingRate.0.1|string }}
Requests to FIFO queues | {{ sku|KZT|ymq.queue.fifo.requests|pricingRate.0.1|string }}
