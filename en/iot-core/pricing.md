---
title: '{{ iot-full-name }} pricing policy'
description: This article covers the {{ iot-name }} pricing policy.
editable: false
---

# {{ iot-name }} pricing policy



{% include [without-use-calculator](../_includes/pricing/without-use-calculator.md) %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

## What goes into the cost of using {{ iot-name }} {#rules}

In {{ iot-name }}, you are charged for the number of messages. The message count is rounded up using the following formula: 

```text
Message Count = Command Size / 1 KB
```

Here is an example:
* If the command size is 800 B, it is a single message.
* If the command size is 2,800 B (2.73 KB), it is three messages.

{% note info %}

The [broker](concepts/index.md#broker) is at the [Preview](../overview/concepts/launch-stages.md) stage. Messages sent through it are free of charge.

{% endnote %}

{% include [not-charged-iot.md](../_includes/pricing/price-formula/not-charged-iot.md) %}

{% include [free-tier.md](../_includes/pricing/price-formula/free-tier.md) %}

### Cost calculation example {#price-example}

{% include [prices-example](../_includes/iot-core/prices-example.md) %}

## Payable commands {#mqtt-commands}

### MQTT {#mqtt}

List of commands charged under {{ iot-name }}: 
* `CONNECT`: Connect a client (device or registry) to the service's MQTT server.
* `PUBLISH`: Send a message from the client (device or registry) to the service's MQTT server.
* `SUBSCRIBE`: Subscribe the client (device or registry) to messages from the service's MQTT server.
* `PUBLISH`: Send a message from the service's MQTT server to the client (device or registry).
* `PINGREQ`: Check the connection from the client (device or registry) to the service's MQTT server.

## Prices for the Russia region {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

### Data size {#volumes}



{% include notitle [usd.md](../_pricing/iot-core/usd.md) %}

