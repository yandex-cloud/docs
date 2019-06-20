---
editable: false
---

# Правила тарификации для {{ message-queue-name }}

## Из чего складывается стоимость использования Message Queue

В рамках сервиса {{ message-queue-name }} тарифицируется количество запросов к [стандартным очередям](concepts/queue.md#standard-queues) и [очередям FIFO](concepts/queue.md#fifo-queues), а также исходящий трафик.

### Запросы к очередям

Услуга | Цена за 1 млн запросов <br>вкл. НДС
----- | -----
Запросы к стандартным очередям | 30,48 ₽
Запросы к очередям FIFO | 38,22 ₽

Оплачивается фактическое количество запросов. Например, стоимость тысячи запросов составит `0,03048 ₽`.

{% include [pricing-egress-traffic.md](../_includes/pricing/pricing-egress-traffic.md) %}