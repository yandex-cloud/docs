Услуга | Цена за 1 млн запросов,<br>вкл. НДС
----- | -----
Первые 100 000 запросов в месяц | {{ sku|ILS|ymq.queue.std.requests|string }}
Запросы к стандартным очередям | {{ sku|ILS|ymq.queue.std.requests|pricingRate.0.1|string }}
Запросы к очередям FIFO | {{ sku|ILS|ymq.queue.fifo.requests|pricingRate.0.1|string }}
