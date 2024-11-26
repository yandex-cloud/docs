---
editable: false
sourcePath: en/_api-ref/mdb/elasticsearch/v1/api-ref/Cluster/listLogs.md
---

# Managed Service for Elasticsearch API, REST: Cluster.ListLogs

Retrieves logs for the specified Elasticsearch cluster.

For more information about logs, see the [Logs](/docs/managed-elasticsearch/operations/cluster-logs) section in the documentation.

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-elasticsearch/v1/clusters/{clusterId}:logs
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the Elasticsearch cluster to request logs for.

To get the Elasticsearch cluster ID, make a [ClusterService.List](/docs/managed-elasticsearch/api-ref/Cluster/list#List) request. ||
|#

## Query parameters {#yandex.cloud.mdb.elasticsearch.v1.ListClusterLogsRequest}

#|
||Field | Description ||
|| columnFilter[] | **string**

Columns from the logs table to request.

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

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| pageSize | **string** (int64)

The maximum number of results per page to return.

If the number of available results is larger than `page_size`, the service returns a [ListClusterLogsResponse.nextPageToken](#yandex.cloud.mdb.elasticsearch.v1.ListClusterLogsResponse) that can be used to get the next page of results in subsequent list requests. ||
|| pageToken | **string**

Page token.

To get the next page of results, set `page_token` to the [ListClusterLogsResponse.nextPageToken](#yandex.cloud.mdb.elasticsearch.v1.ListClusterLogsResponse) returned by the previous list request. ||
|| alwaysNextPageToken | **boolean**

The flag that defines behavior of providing the next page token.

If this flag is set to `true`, this API method will always return [ListClusterLogsResponse.nextPageToken](#yandex.cloud.mdb.elasticsearch.v1.ListClusterLogsResponse), even if current page is empty. ||
|| filter | **string**

A filter expression that filters resources listed in the response.

The expression must specify:
1. The field name to filter by. Currently filtering can be applied to the `hostname` field.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 1-63 characters long and match the regular expression `[a-z0-9.-]{1,61}`.

Example of a filter: `message.hostname='node1.db.cloud.yandex.net'` ||
|| serviceType | **enum** (ServiceType)

Type of the service to request logs about.

- `SERVICE_TYPE_UNSPECIFIED`
- `ELASTICSEARCH`
- `KIBANA` ||
|#

## Response {#yandex.cloud.mdb.elasticsearch.v1.ListClusterLogsResponse}

**HTTP Code: 200 - OK**

```json
{
  "logs": [
    {
      "timestamp": "string",
      "message": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| logs[] | **[LogRecord](#yandex.cloud.mdb.elasticsearch.v1.LogRecord)**

Requested log records. ||
|| nextPageToken | **string**

Token that allows you to get the next page of results for list requests.

If the number of results is larger than [ListClusterLogsRequest.pageSize](#yandex.cloud.mdb.elasticsearch.v1.ListClusterLogsRequest), use `next_page_token` as the value for the [ListClusterLogsRequest.pageToken](#yandex.cloud.mdb.elasticsearch.v1.ListClusterLogsRequest) query parameter in the next list request.
Each subsequent list request will have its own `next_page_token` to continue paging through the results.

This value is interchangeable with [StreamLogRecord.nextRecordToken](/docs/managed-elasticsearch/api-ref/Cluster/streamLogs#yandex.cloud.mdb.elasticsearch.v1.StreamLogRecord) from StreamLogs method. ||
|#

## LogRecord {#yandex.cloud.mdb.elasticsearch.v1.LogRecord}

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
|| message | **string**

Contents of the log record. ||
|#