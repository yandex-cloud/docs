---
editable: false
---

# Pricing for {{ iot-name }}

## What goes into the cost of using {{ iot-name }} {#rules}

In {{ iot-name }}, you're charged for the number of messages. The message count is rounded up using the following formula:

```
Message Count = Command Size / 1 KB
```

For example:
* If the command size is 800 B, it's a single message.
* If the command size is 2800 B (2.73 KB), it's three messages.

{% note info %}

The [broker](concepts/index.md#broker) is at the [Preview](../overview/concepts/launch-stages.md) stage. Messages sent through it are free of charge.

{% endnote %}

{% include [not-charged-iot.md](../_includes/pricing/price-formula/not-charged-iot.md) %}

{% include [free-tier.md](../_includes/pricing/price-formula/free-tier.md) %}

### Example of cost calculation {#price-example}

Calculation of the cost of usage for {{ iot-name }} if during a month:
* 2,000,000 commands were sent
* The size of each command was 1500 B.

> (1500 / 1024) × 2,000,000
>
> 4,000,000 messages were sent in total.

{% if region == "ru" %}

According to the pricing policy:
* 100,000 messages are free of charge.
* 900,000 messages are rated at ₽115.2 per million messages.
* 3,000,000 messages are rated at ₽104 per million messages.

Cost calculation:
> 900,000 / 1,000,000 × ₽115.2 + 3,000,000/1,000,000 × ₽104
>
> Total: ₽415.68

{% endif %}

{% if region == "kz" %}

According to the pricing policy:
* 100,000 messages are free of charge.
* 900,000 messages are rated at ₸115.2 per million messages.
* 3,000,000 messages are rated at ₸520 per million messages.

Cost calculation:
> 900,000/1,000,000 × ₸576 + 3,000,000/1,000,000 × ₸520
>
> Total: ₸2078.4

{% endif %}

{% if region == "int" %}

According to the pricing policy:
* 100,000 messages are free of charge.
* 900,000 messages are rated at $0.923076 per million messages.
* 3,000,000 messages are rated at $0.833333 per million messages.

Cost calculation:
> 900,000/1,000,000 × $0.923076 + 3,000,000/1,000,000 × $0.833333
>
> Total: $3.330767

{% endif %}

## Payable commands {#mqtt-commands}

### MQTT {#mqtt}

List of commands charged under {{ iot-name }}:
* `CONNECT`: Connect a client (device or registry) to the MQTT server of the service.
* `PUBLISH`: Send a message from the client (device or registry) to the MQTT server of the service.
* `SUBSCRIBE`: Subscribe the client (device or registry) to messages from the MQTT server of the service.
* `PUBLISH`: Send a message from the MQTT server of the service to the client (device or registry).
* `PINGREQ`: Check the connection from the client (device or registry) to the MQTT server of the service.

## Pricing {#prices}

### Amount of data {#volumes}

{% if region == "ru" %}

{% include [rub.md](../_pricing/iot-core/rub.md) %}

{% endif %}

{% if region == "kz" %}

{% include [kzt.md](../_pricing/iot-core/kzt.md) %}

{% endif %}

{% if region == "int" %}

{% include [usd.md](../_pricing/iot-core/usd.md) %}

{% endif %}