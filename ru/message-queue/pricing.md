---
editable: false
---

# Правила тарификации для {{ message-queue-name }}

{% if product == "cloud-il" %}

На стадии [Preview](../overview/concepts/launch-stages.md) использование сервиса {{ message-queue-name }} не тарифицируется.

{% endif %}

{% if product == "yandex-cloud" %}

## Из чего складывается стоимость использования Message Queue {#rules}

В рамках сервиса {{ message-queue-name }} тарифицируется количество запросов к [стандартным очередям](concepts/queue.md#standard-queues) и [очередям FIFO](concepts/queue.md#fifo-queues), а также исходящий трафик.

{% include [not-charged-queue.md](../_includes/pricing/price-formula/not-charged-queue.md) %}

{% include [free-tier.md](../_includes/pricing/price-formula/free-tier.md) %}

### Запросы к очередям {#requests-to-queues}

{% if region == "ru"%}

{% include [rub.md](../_pricing/message-queue/rub.md) %}

{% endif %}

{% if region == "kz"%}

{% include [kzt.md](../_pricing/message-queue/kzt.md) %}

{% endif %}

{% if region == "int"%}

{% include [usd.md](../_pricing/message-queue/usd.md) %}

{% endif %}

Оплачивается фактическое количество запросов. {% if region == "ru"%} Например, стоимость тысячи запросов составит `0,03048 ₽` при цене `30,48 ₽` за 1 млн запросов. {% endif %}

При тарификации каждые 64 КБ данных запроса считаются отдельным запросом. Например, запрос размером 63 КБ будет тарифицирован как один запрос, а 65 КБ (64 + 1) — уже как два запроса.

{% if region == "ru" %}

{% include [rub-egress-traffic.md](../_pricing/rub-egress-traffic.md) %}

{% endif %}

{% if region == "kz" %}

{% include [kzt-egress-traffic.md](../_pricing/kzt-egress-traffic.md) %}

{% endif %}

{% if region == "int" %}

{% include [usd-egress-traffic.md](../_pricing/usd-egress-traffic.md) %}

{% endif %}

{% endif %}