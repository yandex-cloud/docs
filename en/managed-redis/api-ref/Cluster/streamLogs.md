---
editable: false
sourcePath: en/_api-ref/mdb/redis/v1/api-ref/Cluster/streamLogs.md
---

# Managed Service for Redis API, REST: Cluster.StreamLogs

Same as ListLogs but using server-side streaming. Also allows for 'tail -f' semantics.

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-redis/v1/clusters/{clusterId}:stream_logs
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. Required. ID of the Redis cluster. ||
|#

## Query parameters {#yandex.cloud.mdb.redis.v1.StreamClusterLogsRequest}

#|
||Field | Description ||
|| columnFilter[] | **string**

Columns from logs table to get in the response. ||
|| serviceType | **enum** (ServiceType)

- `SERVICE_TYPE_UNSPECIFIED`
- `REDIS`: Logs of Redis activity. ||
|| fromTime | **string** (date-time)

Start timestamp for the logs request.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| toTime | **string** (date-time)

End timestamp for the logs request.
If this field is not set, all existing logs will be sent and then the new ones as
they appear. In essence it has 'tail -f' semantics.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| recordToken | **string**

Record token. Set `record_token` to the `next_record_token` returned by a previous StreamLogs
request to start streaming from next log record. ||
|| filter | **string**

A filter expression that filters resources listed in the response.
The expression must specify:
1. The field name. Currently filtering can be applied to the [LogRecord.logs.hostname] field
2. An `=` operator.
3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`.
Examples of a filter `message.hostname='node1.db.cloud.yandex.net'`. ||
|#

## Response {#yandex.cloud.mdb.redis.v1.StreamLogRecord}

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
|| record | **[LogRecord](#yandex.cloud.mdb.redis.v1.LogRecord)**

One of the requested log records. ||
|| nextRecordToken | **string**

This token allows you to continue streaming logs starting from the exact
same record. To continue streaming, specify value of `next_record_token`
as value for `record_token` parameter in the next StreamLogs request.
This value is interchangeable with `next_page_token` from ListLogs method. ||
|#

## LogRecord {#yandex.cloud.mdb.redis.v1.LogRecord}

#|
||Field | Description ||
|| timestamp | **string** (date-time)

Log record timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| message | **object** (map<**string**, **string**>)

Contents of the log record. ||
|#