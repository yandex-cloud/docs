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

{% include [pricing-egress-traffic.md](../_includes/pricing/pricing-egress-traffic.md) %}