---
editable: false
---

# Правила тарификации для {{ message-queue-name }}

## Из чего складывается стоимость использования Message Queue {#rules}

В рамках сервиса {{ message-queue-name }} тарифицируется количество запросов к [стандартным очередям](concepts/queue.md#standard-queues) и [очередям FIFO](concepts/queue.md#fifo-queues), а также исходящий трафик.

{% include [not-charged-queue.md](../_includes/pricing/price-formula/not-charged-queue.md) %}

{% include [free-tier.md](../_includes/pricing/price-formula/free-tier.md) %}

### Запросы к очередям {#requests-to-queues}

{% if product == "yandex-cloud" %}

{% if region == "ru"%}

{% include [rub.md](../_pricing/message-queue/rub.md) %}

{% endif %}

{% if region == "kz"%}

{% include [kzt.md](../_pricing/message-queue/kzt.md) %}

{% endif %}

{% if region == "int"%}

{% include [usd.md](../_pricing/message-queue/usd.md) %}

{% endif %}

{% endif %}

{% if product == "cloud-il" %}

{% include [ils.md](../_pricing/message-queue/ils.md) %}

{% endif %}

Оплачивается фактическое количество запросов. {% if product == "yandex-cloud" %}{% if region == "ru" %} Например, стоимость тысячи запросов составит 0,04876 ₽ при цене 48,7600 ₽ за 1 млн запросов. {% endif %}{% if region == "kz" %} Например, стоимость тысячи запросов составит 0,2438 ₸ при цене 243,8000 ₸ за 1 млн запросов. {% endif %}{% if region == "int" %} Например, стоимость тысячи запросов составит 0,00039008 $ при цене 0,390080 $ за 1 млн запросов. {% endif %}{% endif %}{% if product == "cloud-il" %}Например, стоимость тысячи запросов составит 0,0024759 ₪ при цене 2,4759 ₪ за 1 млн запросов.{% endif %}

При тарификации каждые 64 КБ данных запроса считаются отдельным запросом. Например, запрос размером 63 КБ будет тарифицирован как один запрос, а 65 КБ (64 + 1) — уже как два запроса.

{% if product == "yandex-cloud" %}

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

{% if product == "cloud-il" %}

{% include [ils-egress-traffic.md](../_pricing/ils-egress-traffic.md) %}

{% endif %}