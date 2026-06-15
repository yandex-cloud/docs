---
title: '{{ iot-full-name }}. FAQ'
description: How do I get my activity logs in {{ iot-full-name }}? Find answers to this and other questions in this article.
---

# General questions about {{ iot-name }}

{% include [iot-sunset-warning](../../_includes/iot-core/sunset-warning.md) %}

{% include [logs](../../_qa/logs.md) %}

#### How do I test message delivery? {#check-message-was-delivered}

To make sure the MQTT server has received a [sent message](../operations/publish.md), specify additional debugging parameters in the send message command. As a result, you will get a detailed command output.

To test {{ iot-full-name }}, use messaging and device subscription at the same time. If you subscribe a [registry](../concepts/index.md#registry) to a [device topic](../concepts/topic/devices-topic.md) and send a message to this topic, the registry will receive the message.

For more information, see [{#T}](../tutorials/message-delivery-check.md).
