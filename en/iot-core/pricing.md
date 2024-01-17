---
title: "{{ iot-full-name }} pricing policy"
description: "This article describes the {{ iot-name }} pricing policy."
editable: false
---

# {{ iot-name }} pricing

## What is included in the {{ iot-name }} cost {#rules}

In {{ iot-name }}, you are charged for the number of messages. The message count is rounded up using the following formula:

```
Message Count = Command Size / 1 KB
```

For example:
* If the command size is 800 B, it is a single message.
* If the command size is 2,800 B (2.73 KB), it is three messages.

{% note info %}

The [broker](concepts/index.md#broker) is at the [Preview](../overview/concepts/launch-stages.md) stage. Messages sent through it are free of charge.

{% endnote %}

{% include [not-charged-iot.md](../_includes/pricing/price-formula/not-charged-iot.md) %}

{% include [free-tier.md](../_includes/pricing/price-formula/free-tier.md) %}

### Example of cost calculation {#price-example}

{% include [prices-example](../_includes/iot-core/prices-example.md) %}

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




{% include [usd.md](../_pricing/iot-core/usd.md) %}
