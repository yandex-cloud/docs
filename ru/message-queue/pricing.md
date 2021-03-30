---
editable: false
---

# Правила тарификации для {{ message-queue-name }}

## Из чего складывается стоимость использования Message Queue {#rules}

В рамках сервиса {{ message-queue-name }} тарифицируется количество запросов к [стандартным очередям](concepts/queue.md#standard-queues) и [очередям FIFO](concepts/queue.md#fifo-queues), а также исходящий трафик.

### Запросы к очередям {#requests-to-queues}

{% if region == "ru"%}

{% include [rub.md](../_pricing/message-queue/rub.md) %}

{% endif %}

{% if region == "pre-kz"%}

{% include [kzt.md](../_pricing/message-queue/kzt.md) %}

{% endif %}

{% if region == "int"%}

{% include [usd.md](../_pricing/message-queue/usd.md) %}

{% endif %}

Оплачивается фактическое количество запросов. Например, стоимость тысячи запросов составит `0,03048 ₽` при цене `30,48 ₽` за 1 млн запросов.

При тарификации каждые 64 КБ данных запроса считаются отдельным запросом. Например, запрос размером 63 КБ будет тарифицирован как один запрос, а 65 КБ (64 + 1) — уже как два запроса.

{% include [pricing-egress-traffic.md](../_includes/pricing/pricing-egress-traffic.md) %}
