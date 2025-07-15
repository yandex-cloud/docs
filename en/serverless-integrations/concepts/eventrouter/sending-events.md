---
title: Sending events to a {{ er-full-name }} bus
description: This section describes methods of sending events to an {{ er-name }} bus, directly or via connectors.
keywords:
  - eventrouter
  - event router
  - bus
  - Bus
  - Event Bus
  - event bus
  - connector
  - rule
---

# Sending events to the bus

Events can be sent to the [bus](./bus.md) using the following methods:

Method of sending to the bus  | Event generation method  | Message batching
--- | --- | ---
[Sending](../../operations/eventrouter/bus/data-put.md) directly using the [put](../../../serverless-integrations/eventrouter/api-ref/grpc/Event/put.md) API method | The events are prepared by the user | No
Sending through a [connector](../../concepts/eventrouter/connector.md) with a `Timer` source | The user specifies the data that will go to the bus in the connector settings | No
[Sending](../../operations/eventrouter/bus/data-send.md) through a connector with a `API {{ er-name }}` source using the [send](../../../serverless-integrations/eventrouter/api-ref/grpc/Event/send.md) API method | The events are prepared by the user | Yes
Sending through a connector with a `{{ yds-full-name }}` source | Events come from a [data stream](../../../data-streams/concepts/glossary.md#stream-concepts) | No
Sending through a connector with a `{{ message-queue-full-name }}` source | Events come from a [message queue](../../../message-queue/concepts/queue.md) | Yes

## See also {#see-also}

* [{#T}](../../operations/eventrouter/bus/data-put.md)
* [{#T}](../../operations/eventrouter/bus/data-send.md)
