---
title: How to send a message using Mosquitto in {{ iot-full-name }}
description: Follow this guide to send a message to the MQTT server using Mosquitto.
noIndex: true
canonical: '{{ link-docs }}/tutorials/iot/mosquitto/mosquitto-publish'
---

# Sending a message using Mosquitto

{% include notitle [mosquitto-publish-intro](../../_tutorials/applied/mosquitto-publish-intro.md) %}

To receive messages, you need to subscribe to the sender. For information about how to do this, see [{#T}](mosquitto-subscribe.md).

On how to make sure a message has been successfully sent and delivered, see [{#T}](message-delivery-check.md).

{% include [mosquitto-publish](../../_tutorials/applied/mosquitto-publish.md) %}
