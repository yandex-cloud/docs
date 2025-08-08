---
editable: false
apiPlayground:
  - url: https://{{ api-host-mdb }}/managed-kafka/v1/clusters/{clusterId}:stream_logs
    method: get
    path:
      type: object
      properties:
        clusterId:
          description: |-
            **string**
            Required field. ID of the Apache Kafka® cluster.
            To get the Apache Kafka® cluster ID, make a [ClusterService.List](/docs/managed-kafka/api-ref/Cluster/list#List) request.
          type: string
      required:
        - clusterId
      additionalProperties: false
    query:
      type: object
      properties:
        columnFilter:
          description: |-
            **string**
            Columns from logs table to get in the response.
            If no columns are specified, full log records are returned.
          type: array
          items:
            type: string
        fromTime:
          description: |-
            **string** (date-time)
            Start timestamp for the logs request.
            String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
            `0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.
            To work with values in this field, use the APIs described in the
            [Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
            In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).
          type: string
          format: date-time
        toTime:
          description: |-
            **string** (date-time)
            End timestamp for the logs request.
            If this field is not set, all existing logs will be sent and then the new ones as they appear.
            In essence it has `tail -f` semantics.
            String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
            `0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.
            To work with values in this field, use the APIs described in the
            [Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
            In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).
          type: string
          format: date-time
        recordToken:
          description: |-
            **string**
            Record token.
            Set `recordToken` to the [StreamLogRecord.nextRecordToken](/docs/managed-kafka/api-ref/Cluster/streamLogs#yandex.cloud.mdb.kafka.v1.StreamLogRecord) returned by a previous [ClusterService.StreamLogs](#StreamLogs) request to start streaming from next log record.
          type: string
        filter:
          description: |-
            **string**
            A filter expression that filters resources listed in the response.
            The expression must specify:
            1. The field name to filter by. Currently filtering can be applied to the `hostname` field.
            2. An `=` operator.
            3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`.
            Example of a filter: `message.hostname='node1.db.cloud.yandex.net'`
          type: string
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/mdb/kafka/v1/api-ref/Cluster/streamLogs.md
---

# Managed Service for Apache Kafka® API, REST: Cluster.StreamLogs

Same as [ListLogs](/docs/managed-kafka/api-ref/Cluster/listLogs#ListLogs) but using server-side streaming. Also allows for `tail -f` semantics.

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-kafka/v1/clusters/{clusterId}:stream_logs
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the Apache Kafka® cluster.

To get the Apache Kafka® cluster ID, make a [ClusterService.List](/docs/managed-kafka/api-ref/Cluster/list#List) request. ||
|#

## Query parameters {#yandex.cloud.mdb.kafka.v1.StreamClusterLogsRequest}

#|
||Field | Description ||
|| columnFilter[] | **string**

Columns from logs table to get in the response.

If no columns are specified, full log records are returned. ||
|| fromTime | **string** (date-time)

Start timestamp for the logs request.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| toTime | **string** (date-time)

End timestamp for the logs request.

If this field is not set, all existing logs will be sent and then the new ones as they appear.
In essence it has `tail -f` semantics.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| recordToken | **string**

Record token.

Set `recordToken` to the [StreamLogRecord.nextRecordToken](#yandex.cloud.mdb.kafka.v1.StreamLogRecord) returned by a previous [ClusterService.StreamLogs](#StreamLogs) request to start streaming from next log record. ||
|| filter | **string**

A filter expression that filters resources listed in the response.

The expression must specify:
1. The field name to filter by. Currently filtering can be applied to the `hostname` field.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`.

Example of a filter: `message.hostname='node1.db.cloud.yandex.net'` ||
|#

## Response {#yandex.cloud.mdb.kafka.v1.StreamLogRecord}

**HTTP Code: 200 - OK**

```json
{
  "record": {
    "timestamp": "string",
    "message": "object"
  },
  "nextRecordToken": "string"
}
```

#|
||Field | Description ||
|| record | **[LogRecord](#yandex.cloud.mdb.kafka.v1.LogRecord)**

One of the requested log records. ||
|| nextRecordToken | **string**

This token allows you to continue streaming logs starting from the exact same record.

To continue streaming, specify value of `nextRecordToken` as value for [StreamClusterLogsRequest.recordToken](#yandex.cloud.mdb.kafka.v1.StreamClusterLogsRequest) parameter in the next StreamLogs request.

This value is interchangeable with [ListClusterLogsResponse.nextPageToken](/docs/managed-kafka/api-ref/Cluster/listLogs#yandex.cloud.mdb.kafka.v1.ListClusterLogsResponse) from ListLogs method. ||
|#

## LogRecord {#yandex.cloud.mdb.kafka.v1.LogRecord}

A single log record.

#|
||Field | Description ||
|| timestamp | **string** (date-time)

Log record timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| message | **object** (map<**string**, **string**>)

Contents of the log record. ||
|#