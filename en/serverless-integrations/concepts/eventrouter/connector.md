---
title: '{{ er-full-name }} connector'
description: An {{ er-name }} connector is a customizable component made to receive events from external sources.
keywords:
  - eventrouter
  - event router
  - bus
  - connector
  - Source
  - Event source
  - Event Source
---

# Connector

A _connector_ is a customizable component made to receive events from external sources and forward those events to a [bus](bus.md).

Supported sources:

* [Timer](#timer)
* [API {{ er-name }}](#from-api)
* [{{ yds-full-name }}](../../../data-streams/index.yaml)
* [{{ message-queue-full-name }}](../../../message-queue/index.yaml)


## Timer {#timer}

Timer is a source type that triggers scheduled event generation. The schedule is set in cron expression format. By default, cron expression uses [UTC+0](https://en.wikipedia.org/wiki/Coordinated_Universal_Time), but you can specify a different time zone in timer settings.

If timer settings do not specify the data to provide to the bus, nothing is sent to the input of the [target](./rule.md#target) specified in the [rule](./rule.md).

To learn more about the cron expression format, see [{#T}](../cron.md).


## {{ er-name }} API {#from-api}

The {{ er-name }} API is a source type that enables using the [{{ er-name }} API](../../api-ref/eventrouter/authentication.md) to [send](./sending-events.md) user events to the bus.

To send events [via an {{ er-name }} API connector](../../operations/eventrouter/bus/data-send.md), use the `EventService/Send` gRPC API [call](../../../serverless-integrations/eventrouter/api-ref/grpc/Event/send.md) or the `yc serverless eventrouter send-event` {{ yandex-cloud }} CLI [command](../../../cli/cli-ref/serverless/cli-ref/eventrouter/send-event.md).

As opposed to sending messages [directly to the bus](../../operations/eventrouter/bus/data-put.md), the {{ er-name }} API connector enables you to:
* Grant users and [service accounts](../../../iam/concepts/users/service-accounts.md) granular permissions to send events via the specified connector.
* Terminate event sending by [stopping](../../operations/eventrouter/connector/stop.md) the connector.
* Group events before sending them to the bus.
