---
editable: false
---
# Pricing for {{ iot-name }}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

## What goes into the cost of using {{ iot-name }} {#rules}

In {{ iot-name }}, you're charged for the message count. The message count is rounded up using the following formula:

```
Message Count = Command Size / 1 KB 
```

For example:

- If the command size is 800 B, it's a single message.
- If the command size is 2800 B (2.73 KB), it's three messages.

## Payable commands {#mqtt-commands}

### MQTT {#mqtt}

List of commands charged under {{ iot-name }}:

- `CONNECT`: Connect a client (device or registry) to the service MQTT broker.
- `PUBLISH`: Send a message from the client (device or registry) to the service MQTT broker.
- `SUBSCRIBE`: Subscribe the client (device or registry) to messages from the service MQTT broker.
- `PUBLISH`: Send a message from the service MQTT broker to the client (device or registry).
- `PINGREQ`: Check the connection from the client (device or registry) to the service MQTT broker.

## Pricing {#prices}

### Amount of data {#volumes}

{% list tabs %}

- Prices in USD

    | Resource category | Cost of 1 million, without VAT |
    | ----- | ----- |
    | The first 100 000 message per month | Not charged |
    | Message count, up to 1 million| $0.923076 |
    | Message count, from 1 million to 5 million | $0.833333 |
    | Message count, 5 million or more | $0.743589  |

- Prices in roubles

    | Resource category | Cost of 1 million, with VAT |
    | ----- | ----- |
    | The first 100 000 message per month  | Not charged |
    | Message count, up to 1 million | ₽72.00 |
    | Message count, from 1 million to 5 million | ₽65.00 |
    | Message count, 5 million or more | ₽58.00  |

{% endlist %}