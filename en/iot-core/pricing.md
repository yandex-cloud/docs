---
editable: false
---

# Pricing for {{ iot-name }}

## What goes into the cost of using {{ iot-name }} {#rules}

In {{ iot-name }}, you're charged for the message count. The message count is rounded up using the following formula:

```
Message Count = Command Size / 1 KB
```

{% note info %}

The [broker](concepts/index.md#broker) is at the [Preview](../overview/concepts/launch-stages.md) stage. Messages sent via it are free of charge.

{% endnote %}

For example:
* If the command size is 800 B, it's a single message.
* If the command size is 2800 B (2.73 KB), it's three messages.

{% include [not-charged-iot.md](../_includes/pricing/price-formula/not-charged-iot.md) %}

{% include [free-tier.md](../_includes/pricing/price-formula/free-tier.md) %}

## Payable commands {#mqtt-commands}

### MQTT {#mqtt}

List of commands charged under {{ iot-name }}:

* `CONNECT`: Connect a client (device or registry) to the service MQTT server.
* `PUBLISH`: Send a message from the client (device or registry) to the service MQTT server.
* `SUBSCRIBE`: Subscribe the client (device or registry) to messages from the service MQTT server.
* `PUBLISH`: Send a message from the service MQTT server to the client (device or registry).
* `PINGREQ`: Check the connection from the client (device or registry) to the service MQTT server.

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