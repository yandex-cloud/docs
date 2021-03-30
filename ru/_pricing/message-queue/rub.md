Услуга | Цена за 1 млн запросов,<br>вкл. НДС
----- | -----
Первые 100 000 запросов в месяц | {{ sku|RUB|ymq.queue.std.requests|string }}
Запросы к стандартным очередям | {{ sku|RUB|ymq.queue.std.requests|pricingRate.0.1|string }}
Запросы к очередям FIFO | {{ sku|RUB|ymq.queue.fifo.requests|string }}
