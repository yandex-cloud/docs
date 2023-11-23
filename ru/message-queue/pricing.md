---
title: "Правила тарификации для {{ message-queue-full-name }}"
description: "В статье содержатся правила тарификации сервиса {{ message-queue-name }}."
editable: false
---

# Правила тарификации для {{ message-queue-name }}

## Из чего складывается стоимость использования Message Queue {#rules}

В рамках сервиса {{ message-queue-name }} тарифицируется количество запросов к [стандартным очередям](concepts/queue.md#standard-queues) и [очередям FIFO](concepts/queue.md#fifo-queues), а также исходящий трафик.

{% include [not-charged-queue.md](../_includes/pricing/price-formula/not-charged-queue.md) %}

{% include [free-tier.md](../_includes/pricing/price-formula/free-tier.md) %}

### Запросы к очередям {#requests-to-queues}



{% include [rub.md](../_pricing/message-queue/rub.md) %}






Оплачивается фактическое количество запросов.  Например, стоимость тысячи запросов составит 0,04876 ₽ при цене 48,7600 ₽ за 1 млн запросов. 

При тарификации каждые 64 КБ данных запроса считаются отдельным запросом. Например, запрос размером 63 КБ будет тарифицирован как один запрос, а 65 КБ (64 + 1) — уже как два запроса.



{% include [rub-egress-traffic.md](../_pricing/rub-egress-traffic.md) %}





