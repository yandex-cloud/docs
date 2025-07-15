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

Timer is a source type that triggers scheduled event generation. The schedule is set in [cron expression](#cron-expression) format. By default, cron expression uses [UTC+0](https://en.wikipedia.org/wiki/Coordinated_Universal_Time), but you can specify a different time zone in timer settings.

If timer settings do not specify the data to provide to the bus, nothing is sent to the input of the [target](./rule.md#target) specified in the [rule](./rule.md).

### Cron expression format {#cron-expression}

Cron expression field order: `Seconds Minutes Hours Day-of-month Month Day-of-week Year`.

### Possible field values {#field-and-value}

{% note info %}

Special characters, as well as months and days of the week, are case-insensitive: `MON` is the same as `mon`.

{% endnote %}

Name <br>fields | Required <br>field | Acceptable <br>values | Supported <br>special <br>characters
--- | --- | --- | ---
`Seconds`, seconds | Yes | 0-59 | `,`, `-`, `*`, `/`
`Minutes`, minutes | Yes | 0-59 | `,`, `-`, `*`, `/`
`Hours`, hours | Yes| 0-23 | `,`, `-`, `*`, `/`
`Day of month`, day of the month| Yes | 1-31 | `,`, `-`, `*`, `?`, `/`, `L`, `W`
`Month`, month| Yes | 1-12, <br>JAN-DEC | `,`, `-`, `*`, `/`
`Day of week`, day of the week| Yes | 1-7, <br>SUN-SAT | `,`, `-`, `*`, `?`, `/`, `L`, `#`
`Year`, year| No | empty, 1970-2099 | `,`, `-`, `*`, `/`

### Special characters {#special-characters}

You can use the following special characters in cron expressions:

* `*`: Selects all values in the field.

    > The `*` character in the `Minutes` field: The timer starts `every minute`.

* `?`: Selects any field value. You cannot specify `Day of month` and `Day of week` at the same time. If you have entered a value in one of these fields, put `?` in the other one.

    > `10` in `Day of month` and `?` in `Day of week`: The timer starts every tenth day of the month.

* `-` : Selects a range of values.

    > The `10-12` range in `Hours`: The timer starts at 10 a.m., 11 a.m., and 12 p.m.

* `,`: Selects multiple values.

    > `MON,WED,FRI` in the `Day of week` field: The timer starts on Monday, Wednesday, and Friday.

* `/`: Increment the value.

    > `0/15` in the `Minutes` field: The timer starts at 0, 15, 30, and 45 minutes past each hour.

* `L`: This character functions differently in the two fields where it is used:

    * In the `Day of month` field, it means the last day of the month.
    * In the `Day of week` field, it means the last day of the week, `7` (Saturday, `SAT`).

    > `L` in the `Day of month` field: The timer starts on January 31, February 28, and so on.

* `W`: Selects the weekday nearest to the specified date.

    > `15W` in the `Day of month` field: The timer starts on the weekday nearest to the 15th day of the month. If the 15th day is Saturday, the timer starts on Friday the 14th.

    {% note info %}

    The `L` and `W` characters in the `Day of month` field also merge into the `LW` combination: The timer starts on the last weekday of the month.

    {% endnote %}

* `#`: Selects the Nth day of the month.

    > `6#3` in the `Day of week` field: The timer starts on the third Friday of the month (6 for Friday; 3 for third Friday of the month).

### Examples of cron expressions {#examples}

Cron expression | Description
--- | ---
`*/5 * * * * ? *` | The timer starts every 5 seconds.
`0 * * * * ? *` | The timer starts every minute.
`0 0 * ? * * *`| The timer starts every hour.
`0 15 10 ? * * *` | The timer starts every day at 10:15.


## {{ er-name }} API {#from-api}

The {{ er-name }} API is a source type that enables using the [{{ er-name }} API](../../api-ref/eventrouter/authentication.md) to [send](./sending-events.md) user events to the bus.

To send events [via an {{ er-name }} API connector](../../operations/eventrouter/bus/data-send.md), use the `EventService/Send` gRPC API [call](../../../serverless-integrations/eventrouter/api-ref/grpc/Event/send.md) or the `yc serverless eventrouter send-event` {{ yandex-cloud }} CLI [command](../../../cli/cli-ref/serverless/cli-ref/eventrouter/send-event.md).

As opposed to sending messages [directly to the bus](../../operations/eventrouter/bus/data-put.md), the {{ er-name }} API connector enables you to:
* Grant users and [service accounts](../../../iam/concepts/users/service-accounts.md) granular permissions to send events via the specified connector.
* Terminate event sending by [stopping](../../operations/eventrouter/connector/stop.md) the connector.
* Group events before sending them to the bus.