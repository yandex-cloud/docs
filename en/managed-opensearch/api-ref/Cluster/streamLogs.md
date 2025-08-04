---
editable: false
apiPlayground:
  - '{"url":"https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/{clusterId}:stream_logs","method":"get","path":{"type":"object","properties":{"clusterId":{"description":"**string**\n\nRequired field. ID of the OpenSearch cluster.","type":"string"}},"required":["clusterId"],"additionalProperties":false},"query":{"type":"object","properties":{"columnFilter":{"description":"**string**\n\nColumns from log table to get in the response.\nIf no columns are specified, entire log records are returned.","type":"array","items":{"type":"string"}},"fromTime":{"description":"**string** (date-time)\n\nStart timestamp for the logs request.\n\nString in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from\n`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.\n\nTo work with values in this field, use the APIs described in the\n[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).\nIn some languages, built-in datetime utilities do not support nanosecond precision (9 digits).","type":"string","format":"date-time"},"toTime":{"description":"**string** (date-time)\n\nEnd timestamp for the logs request.\n\nIf this field is not set, all existing logs are sent as well as the new ones as they appear.\n\nIn essence it has `tail -f` semantics.\n\nString in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from\n`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.\n\nTo work with values in this field, use the APIs described in the\n[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).\nIn some languages, built-in datetime utilities do not support nanosecond precision (9 digits).","type":"string","format":"date-time"},"recordToken":{"description":"**string**\n\nRecord token. Set `record_token` to the `next_record_token` returned by the previous [StreamLogs](#StreamLogs)\nrequest to start streaming from the next log record.","type":"string"},"filter":{"description":"**string**\n\nA filter expression that filters resources listed in the response.\n\nThe expression must specify:\n\n1. A field name. Currently filtering can be applied to the [LogRecord.logs.message.hostname] field.\n\n2. A conditional operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values.\n\n3. A value. Must be 1-63 characters long and match the regular expression `^[a-z0-9.-]{1,61}$`.\n\nExamples of a filter:\n* `message.hostname=''node1.db.cloud.yandex.net''`;\n* `message.error_severity IN (\"ERROR\", \"FATAL\", \"PANIC\") AND message.hostname = \"node1.db.cloud.yandex.net\"`.","type":"string"},"serviceType":{"description":"**enum** (ServiceType)\n\nType of the service to request logs about.\n\n- `SERVICE_TYPE_UNSPECIFIED`: Type is not specified.\n- `OPENSEARCH`: OpenSearch logs.\n- `DASHBOARDS`: Dashboards logs.","type":"string","enum":["SERVICE_TYPE_UNSPECIFIED","OPENSEARCH","DASHBOARDS"]}},"additionalProperties":false},"body":null,"definitions":null}'
sourcePath: en/_api-ref/mdb/opensearch/v1/api-ref/Cluster/streamLogs.md
---

# Managed Service for OpenSearch API, REST: Cluster.StreamLogs

Same as ListLogs but using server-side streaming. Also allows for 'tail -f' semantics.

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/{clusterId}:stream_logs
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the OpenSearch cluster. ||
|#

## Query parameters {#yandex.cloud.mdb.opensearch.v1.StreamClusterLogsRequest}

#|
||Field | Description ||
|| columnFilter[] | **string**

Columns from log table to get in the response.
If no columns are specified, entire log records are returned. ||
|| fromTime | **string** (date-time)

Start timestamp for the logs request.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| toTime | **string** (date-time)

End timestamp for the logs request.

If this field is not set, all existing logs are sent as well as the new ones as they appear.

In essence it has `tail -f` semantics.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| recordToken | **string**

Record token. Set `record_token` to the `next_record_token` returned by the previous [StreamLogs](#StreamLogs)
request to start streaming from the next log record. ||
|| filter | **string**

A filter expression that filters resources listed in the response.

The expression must specify:

1. A field name. Currently filtering can be applied to the [LogRecord.logs.message.hostname] field.

2. A conditional operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values.

3. A value. Must be 1-63 characters long and match the regular expression `^[a-z0-9.-]{1,61}$`.

Examples of a filter:
* `message.hostname='node1.db.cloud.yandex.net'`;
* `message.error_severity IN ("ERROR", "FATAL", "PANIC") AND message.hostname = "node1.db.cloud.yandex.net"`. ||
|| serviceType | **enum** (ServiceType)

Type of the service to request logs about.

- `SERVICE_TYPE_UNSPECIFIED`: Type is not specified.
- `OPENSEARCH`: OpenSearch logs.
- `DASHBOARDS`: Dashboards logs. ||
|#

## Response {#yandex.cloud.mdb.opensearch.v1.StreamLogRecord}

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
|| record | **[LogRecord](#yandex.cloud.mdb.opensearch.v1.LogRecord)**

One of the requested log records. ||
|| nextRecordToken | **string**

This token allows you to continue streaming logs starting from the exact same record.

To do that, specify value of `nextRecordToken` as the value for [StreamLogs.record_token] parameter in the next [StreamLogs](#StreamLogs) request.

This value is interchangeable with [ListLogs.next_page_token] from [ListLogs](/docs/managed-opensearch/api-ref/Cluster/listLogs#ListLogs) method. ||
|#

## LogRecord {#yandex.cloud.mdb.opensearch.v1.LogRecord}

#|
||Field | Description ||
|| timestamp | **string** (date-time)

Time when the log was recorded.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| message | **object** (map<**string**, **string**>)

Contents of the log record. ||
|#