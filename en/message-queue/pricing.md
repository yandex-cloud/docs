---
editable: false
---

# Pricing for {{ message-queue-name }}

## What goes into the cost of using Yandex Message Queue {#rules}

{{ message-queue-name }} charges for the number of requests to [standard queues](concepts/queue.md#standard-queues) and [FIFO queues](concepts/queue.md#fifo-queues), as well as for outgoing traffic.

{% include [not-charged-queue.md](../_includes/pricing/price-formula/not-charged-queue.md) %}

{% include [free-tier.md](../_includes/pricing/price-formula/free-tier.md) %}

### Requests to queues {#requests-to-queues}





{% include [usd.md](../_pricing/message-queue/usd.md) %}




Payment is made for the actual number of requests. For example, the cost per thousand requests is $0.00039008 while the cost of 1M requests is $0.390080. 

For pricing purposes, every 64 KB of request data is considered a separate request. For example, a 63 KB request is charged as one request, while a 65 KB request is charged as two requests (64 + 1).





{% include [usd-egress-traffic.md](../_pricing/usd-egress-traffic.md) %}



