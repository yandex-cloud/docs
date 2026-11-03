[Документация Yandex Cloud](../../../index.md) > [Yandex DataLens](../../index.md) > DataLens Public API > [DataLens API (англ.)](../index.md) > [DataTransfers](index.md) > 🚧 [Experimental] Get data transfer logs

<div class="openapi">

# 🚧 [Experimental] Get data transfer logs

<!-- markdownlint-disable-file -->

Returns replication or operation logs for a transfer, with filtering and pagination.

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
https://api.datalens.tech/rpc/getDataTransferLogs
```

</div>

</div>

</div>

### Headers

#|
|| **Name** | **Description** ||
||

_x-dl-api-version_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

API version header.

_Const:_{.json-schema-reset .json-schema-value} `3`

_Example:_{.json-schema-reset .json-schema-example} `3`
{.table-cell}
||
|#{.json-schema-properties}

<div class="openapi-entity">

### Body

{% cut "application/json" %}

```json translate=no
{
  "logEntity": {
    "transferId": "example",
    "title": "example",
    "replicationLog": {},
    "operationLog": {
      "operationId": "example"
    },
    "fromTime": {
      "seconds": "example",
      "nanos": 0.5
    },
    "toTime": {
      "seconds": "example",
      "nanos": 0.5
    },
    "logsOrder": "LOGS_ORDER_UNSPECIFIED"
  },
  "pageSize": "example",
  "pageToken": "example",
  "criteria": {
    "since": {
      "seconds": "example",
      "nanos": 0.5
    },
    "until": {
      "seconds": "example",
      "nanos": 0.5
    },
    "levels": [
      "LEVEL_UNSPECIFIED"
    ],
    "logsOrder": "LOGS_ORDER_UNSPECIFIED"
  }
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_logEntity_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Title of the log entity.

_Min length:_{.json-schema-reset .json-schema-assertion} `1`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_transferId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the transfer whose logs to read.

_Min length:_{.json-schema-reset .json-schema-assertion} `1`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_fromTime_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: object &#124; null

Start of the time range covered by the log entity.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "seconds": "example",
  "nanos": 0.5
}
```

{% endcut %}
{.table-cell}
||
||

_logsOrder_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Order in which log events are returned.

_Enum:_{.json-schema-reset .json-schema-value} `LOGS_ORDER_UNSPECIFIED`, `FROM_PAST_TO_FUTURE`, `FROM_FUTURE_TO_PAST`
{.table-cell}
||
||

_operationLog_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_operationId_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

ID of the transfer operation.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Selects logs of the specified operation.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "operationId": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_replicationLog_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object" %}

#|
|#{.json-schema-properties}

{% endcut %}

Selects replication logs.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
||

_toTime_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: object &#124; null

End of the time range covered by the log entity.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "seconds": "example",
  "nanos": 0.5
}
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Transfer log entity to read.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "transferId": "example",
  "title": "example",
  "replicationLog": {},
  "operationLog": {
    "operationId": "example"
  },
  "fromTime": {
    "seconds": "example",
    "nanos": 0.5
  },
  "toTime": {
    "seconds": "example",
    "nanos": 0.5
  },
  "logsOrder": "LOGS_ORDER_UNSPECIFIED"
}
```

{% endcut %}
{.table-cell}
||
||

_criteria_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_levels_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [DataTransferLogLevel](#entity-DataTransferLogLevel)[]

Log severity levels to include.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  "LEVEL_UNSPECIFIED"
]
```

{% endcut %}
{.table-cell}
||
||

_logsOrder_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Order in which log events are returned.

_Enum:_{.json-schema-reset .json-schema-value} `LOGS_ORDER_UNSPECIFIED`, `FROM_PAST_TO_FUTURE`, `FROM_FUTURE_TO_PAST`
{.table-cell}
||
||

_since_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: object &#124; null

Start of the time range to retrieve log events for.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "seconds": "example",
  "nanos": 0.5
}
```

{% endcut %}
{.table-cell}
||
||

_until_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: object &#124; null

End of the time range to retrieve log events for.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "seconds": "example",
  "nanos": 0.5
}
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Log event filters. Cannot be combined with pageToken.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "since": {
    "seconds": "example",
    "nanos": 0.5
  },
  "until": {
    "seconds": "example",
    "nanos": 0.5
  },
  "levels": [
    "LEVEL_UNSPECIFIED"
  ],
  "logsOrder": "LOGS_ORDER_UNSPECIFIED"
}
```

{% endcut %}
{.table-cell}
||
||

_pageSize_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Maximum number of log events, encoded as a string.

_Pattern:_{.json-schema-reset .json-schema-assertion} `^\d+$`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_pageToken_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Page token from a preceding response. Cannot be combined with criteria.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

</div>

<div class="openapi-entity">

### DataTransferLogLevel {#entity-DataTransferLogLevel}

Severity level of the log event.

**Type**: string

_Enum:_{.json-schema-reset .json-schema-value} `LEVEL_UNSPECIFIED`, `TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR`, `FATAL`

</div>

## Responses

<div class="openapi__response__code__200">

## 200 OK

Response

<div class="openapi-entity">

### Body

{% cut "application/json" %}

```json translate=no
{
  "logEvents": [
    {
      "logGroupId": "example",
      "streamName": "example",
      "createdAt": {
        "seconds": "example",
        "nanos": 0.5
      },
      "message": "example",
      "level": "LEVEL_UNSPECIFIED",
      "payload": "example"
    }
  ],
  "nextPageToken": "example",
  "previousPageToken": "example"
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_logEvents_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: [DataTransferLogEvent](#entity-DataTransferLogEvent)[]

Log events matching the request.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "logGroupId": "example",
    "streamName": "example",
    "createdAt": {
      "seconds": "example",
      "nanos": 0.5
    },
    "message": "example",
    "level": "LEVEL_UNSPECIFIED",
    "payload": "example"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_nextPageToken_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Token for the next page of log events.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_previousPageToken_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Token for the previous page of log events.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

</div>

<div class="openapi-entity">

### DataTransferLogEvent {#entity-DataTransferLogEvent}

#|
|| **Name** | **Description** ||
||

_createdAt_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_seconds_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Number of seconds since the Unix epoch.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_nanos_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: number

Fractional seconds in nanoseconds.
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Time when the log event was created.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "seconds": "example",
  "nanos": 0.5
}
```

{% endcut %}
{.table-cell}
||
||

_level_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: [DataTransferLogLevel](#entity-DataTransferLogLevel)

Severity level of the log event.

_Enum:_{.json-schema-reset .json-schema-value} `LEVEL_UNSPECIFIED`, `TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR`, `FATAL`
{.table-cell}
||
||

_logGroupId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the log group.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_message_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Log event message.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_payload_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Additional log event data encoded as a string.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_streamName_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Name of the log stream.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "logGroupId": "example",
  "streamName": "example",
  "createdAt": {
    "seconds": "example",
    "nanos": 0.5
  },
  "message": "example",
  "level": "LEVEL_UNSPECIFIED",
  "payload": "example"
}
```

{% endcut %}

</div>

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.