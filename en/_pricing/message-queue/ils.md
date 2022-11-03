Service | Rate for 1 million requests, with VAT
----- | -----
The first 100 000 requests per month | {{ sku|ILS|ymq.queue.std.requests|string }} 
Requests to standard queues | {{ sku|ILS|ymq.queue.std.requests|pricingRate.0.1|string }}
Requests to FIFO queues | {{ sku|ILS|ymq.queue.fifo.requests|pricingRate.0.1|string }}
