---
editable: false
---

# Pricing for {{ message-queue-name }}

## What goes into the cost of using Yandex Message Queue {#rules}

{{ message-queue-name }} charges for the number of requests to [standard queues](concepts/queue.md#standard-queues) and [FIFO queues](concepts/queue.md#fifo-queues), as well as for outgoing traffic.

{% include [not-charged-queue.md](../_includes/pricing/price-formula/not-charged-queue.md) %}

{% include [free-tier.md](../_includes/pricing/price-formula/free-tier.md) %}

### Requests to queues {#requests-to-queues}

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

Payment is made for the actual number of requests. {% if product == "yandex-cloud" %}{% if region == "ru" %} For example, the cost per thousand requests is ₽0.04876 while the cost of 1M requests is ₽48.7600. {% endif %}{% if region == "kz" %} For example, the cost per thousand requests is ₸0.2438 while the cost of 1M requests is ₸243.8000. {% endif %}{% if region == "int" %} For example, the cost per thousand requests is $0.00039008 while the cost of 1M requests is $0.390080. {% endif %}{% endif %}{% if product == "cloud-il" %}For example, the cost per thousand requests is ₪0.0024759 while the cost of 1M requests is ₪2.4759.{% endif %}

For pricing purposes, every 64 KB of request data is considered a separate request. For example, a 63 KB request is charged as one request, while a 65 KB request is charged as two requests (64 + 1).

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