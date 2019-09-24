---
editable: false
---
# Pricing policy for {{ message-queue-name }}

## What goes into the cost of using Message Queue

When using Yandex Message Queue, you are charged for the requests to [standard](concepts/queue.md#standard-queues) and [FIFO](concepts/queue.md#fifo-queues) queues and the amount of outgoing traffic.

### Requests to queues

{% list tabs %}

- Prices in USD
  
  | Service | Rate for 1 mil. requests, without VAT |
  | ----- | ----- |
  | Requests to standard queues | $0,390769 |
  | Requests to FIFO queues | $0,490000 |
  
- Prices in roubles
  
  Service | Rate for 1 mil. requests, with VAT
  ----- | -----
  Requests to standard queues | ₽30.48
  Requests to FIFO queues | ₽38.22
  
{% endlist %}

You are charged for an actual number of requests. E.g., the cost of 1000 requests to standard queue will be `$0,000390769`.

Every 64 KB of request data are charged as a separate request. E.g., a request with a 63 KB size will be charged as one request, and a request with a 65 KB (64 + 1) size will be charged as two requests.

{% include [pricing-egress-traffic.md](../_includes/pricing/pricing-egress-traffic.md) %}