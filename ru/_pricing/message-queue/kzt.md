Услуга | Цена за 1 млн запросов,<br>вкл. НДС
----- | -----
Первые 100 000 запросов в месяц | {{ sku|KZT|ymq.queue.std.requests|string }}
Запросы к стандартным очередям | {{ sku|KZT|ymq.queue.std.requests|pricingRate.0.1|string }}
Запросы к очередям FIFO | {{ sku|KZT|ymq.queue.fifo.requests|pricingRate.0.1|string }}

Оплачивается фактическое количество запросов. Например, стоимость тысячи запросов составит {% calc [currency=KZT] 0,001 × {{ sku|KZT|ymq.queue.std.requests|pricingRate.0.1|number }} %} при цене {{ sku|KZT|ymq.queue.std.requests|pricingRate.0.1|string }} за 1 млн запросов.
