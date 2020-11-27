---
editable: false
---
# Pricing for {{ message-queue-name }}

## What goes into the cost of using Yandex Message Queue {#rules}

{{ message-queue-name }} charges for the number of requests to [standard queues](concepts/queue.md#standard-queues) and [FIFO queues](concepts/queue.md#fifo-queues), as well as for outgoing traffic.

### Requests to queues {#requests-to-queues}

{% list tabs %}

- Prices in USD

  | Service | Rate for 1 million requests, without VAT |
  | ----- | ----- |
  | The first 100 000 requests per month | Not charged |
  | Requests to standard queues | $0.390769 |
  | Requests to FIFO queues | $0.490000 |

- Prices in roubles

  Service | Rate for 1 million requests, with VAT
  ----- | -----
  The first 100 000 requests per month | Not charged 
  Requests to standard queues | ₽30.48
  Requests to FIFO queues | ₽38.22

{% endlist %}

Payment is made for the actual number of requests. For example, the cost per thousand requests is `$0.000390`.

For pricing purposes, every 64 KB of request data is considered a separate request. For example, a 63 KB request is charged as one request, while a 65 KB request is charged as two requests (64 + 1).

{% include [pricing-egress-traffic.md](../_includes/pricing/pricing-egress-traffic.md) %}

