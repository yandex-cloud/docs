---
editable: false
apiPlayground:
  - url: https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/{clusterId}:logs
    method: get
    path:
      type: object
      properties:
        clusterId:
          description: |-
            **string**
            Required field. ID of the ClickHouse cluster to request logs for.
            To get the ClickHouse cluster ID, use a [ClusterService.List](/docs/managed-clickhouse/api-ref/Cluster/list#List) request.
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
            Columns from logs table to request.
            If no columns are specified, entire log records are returned.
          type: array
          items:
            type: string
        serviceType:
          description: |-
            **enum** (ServiceType)
            Required field. Type of the service to request logs about.
            - `SERVICE_TYPE_UNSPECIFIED`
            - `CLICKHOUSE`: Logs of ClickHouse activity.
            - `CLICKHOUSE_KEEPER`: Logs of ClickHouse Keeper activity.
          type: string
          enum:
            - SERVICE_TYPE_UNSPECIFIED
            - CLICKHOUSE
            - CLICKHOUSE_KEEPER
        fromTime:
          description: |-
            **string** (date-time)
            Start timestamp for the logs request, in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.
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
            End timestamp for the logs request, in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.
            String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
            `0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.
            To work with values in this field, use the APIs described in the
            [Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
            In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).
          type: string
          format: date-time
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of results per page to return. If the number of available
            results is larger than `pageSize`, the service returns a [ListClusterLogsResponse.nextPageToken](/docs/managed-clickhouse/api-ref/Cluster/listLogs#yandex.cloud.mdb.clickhouse.v1.ListClusterLogsResponse)
            that can be used to get the next page of results in subsequent list requests.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token.  To get the next page of results, set `pageToken` to the [ListClusterLogsResponse.nextPageToken](/docs/managed-clickhouse/api-ref/Cluster/listLogs#yandex.cloud.mdb.clickhouse.v1.ListClusterLogsResponse)
            returned by the previous list request.
          type: string
      required:
        - serviceType
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/mdb/clickhouse/v1/api-ref/Cluster/listLogs.md
---

# Managed Service for ClickHouse API, REST: Cluster.ListLogs

Retrieves logs for the specified ClickHouse cluster.

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/{clusterId}:logs
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the ClickHouse cluster to request logs for.
To get the ClickHouse cluster ID, use a [ClusterService.List](/docs/managed-clickhouse/api-ref/Cluster/list#List) request. ||
|#

## Query parameters {#yandex.cloud.mdb.clickhouse.v1.ListClusterLogsRequest}

#|
||Field | Description ||
|| columnFilter[] | **string**

Columns from logs table to request.
If no columns are specified, entire log records are returned. ||
|| serviceType | **enum** (ServiceType)

Required field. Type of the service to request logs about.

- `SERVICE_TYPE_UNSPECIFIED`
- `CLICKHOUSE`: Logs of ClickHouse activity.
- `CLICKHOUSE_KEEPER`: Logs of ClickHouse Keeper activity. ||
|| fromTime | **string** (date-time)

Start timestamp for the logs request, in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| toTime | **string** (date-time)

End timestamp for the logs request, in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`, the service returns a [ListClusterLogsResponse.nextPageToken](#yandex.cloud.mdb.clickhouse.v1.ListClusterLogsResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| pageToken | **string**

Page token.  To get the next page of results, set `pageToken` to the [ListClusterLogsResponse.nextPageToken](#yandex.cloud.mdb.clickhouse.v1.ListClusterLogsResponse)
returned by the previous list request. ||
|#

## Response {#yandex.cloud.mdb.clickhouse.v1.ListClusterLogsResponse}

**HTTP Code: 200 - OK**

```json
{
  "logs": [
    {
      "timestamp": "string",
      "message": "object"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| logs[] | **[LogRecord](#yandex.cloud.mdb.clickhouse.v1.LogRecord)**

Requested log records. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListClusterLogsRequest.pageSize](#yandex.cloud.mdb.clickhouse.v1.ListClusterLogsRequest), use the `nextPageToken` as the value
for the [ListClusterLogsRequest.pageToken](#yandex.cloud.mdb.clickhouse.v1.ListClusterLogsRequest) query parameter in the next list request.
Each subsequent list request will have its own `nextPageToken` to continue paging through the results.
This value is interchangeable with the [StreamLogRecord.nextRecordToken](/docs/managed-clickhouse/api-ref/Cluster/streamLogs#yandex.cloud.mdb.clickhouse.v1.StreamLogRecord) from StreamLogs method. ||
|#

## LogRecord {#yandex.cloud.mdb.clickhouse.v1.LogRecord}

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