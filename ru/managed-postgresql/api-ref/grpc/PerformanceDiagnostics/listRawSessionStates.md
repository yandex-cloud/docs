---
editable: false
sourcePath: en/_api-ref-grpc/mdb/postgresql/v1/api-ref/grpc/PerformanceDiagnostics/listRawSessionStates.md
---

# Managed Service for PostgreSQL API, gRPC: PerformanceDiagnosticsService.ListRawSessionStates {#ListRawSessionStates}

Retrieves raw statistics on sessions. Corresponds to the [pg_stat_activity view](https://www.postgresql.org/docs/current/monitoring-stats.html#MONITORING-PG-STAT-ACTIVITY-VIEW).

## gRPC request

**rpc ListRawSessionStates ([ListRawSessionStatesRequest](#yandex.cloud.mdb.postgresql.v1.ListRawSessionStatesRequest)) returns ([ListRawSessionStatesResponse](#yandex.cloud.mdb.postgresql.v1.ListRawSessionStatesResponse))**

## ListRawSessionStatesRequest {#yandex.cloud.mdb.postgresql.v1.ListRawSessionStatesRequest}

```json
{
  "clusterId": "string",
  "fromTime": "google.protobuf.Timestamp",
  "toTime": "google.protobuf.Timestamp",
  "pageSize": "int64",
  "pageToken": "string"
}
```

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of a PostgreSQL cluster to request session statistics for.

To get a PostgreSQL cluster ID, use the [ClusterService.List](/docs/managed-postgresql/api-ref/grpc/Cluster/list#List) request. ||
|| fromTime | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Beginning of the period for which you need to request data (in the [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format). ||
|| toTime | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

End of the period for which you need to request data (in the [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format). ||
|| pageSize | **int64**

The maximum number of results per page to return. If the number of the results is larger than `pageSize`, the service returns [ListRawSessionStatesResponse.nextPageToken](#yandex.cloud.mdb.postgresql.v1.ListRawSessionStatesResponse). You can use it to get the next page of the results in subsequent requests. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken` to the [ListRawSessionStatesResponse.nextPageToken](#yandex.cloud.mdb.postgresql.v1.ListRawSessionStatesResponse) returned by the previous PostgreSQL session list request. ||
|#

## ListRawSessionStatesResponse {#yandex.cloud.mdb.postgresql.v1.ListRawSessionStatesResponse}

```json
{
  "sessionStates": [
    {
      "time": "google.protobuf.Timestamp",
      "host": "string",
      "pid": "int64",
      "database": "string",
      "user": "string",
      "applicationName": "string",
      "backendStart": "google.protobuf.Timestamp",
      "xactStart": "google.protobuf.Timestamp",
      "queryStart": "google.protobuf.Timestamp",
      "stateChange": "google.protobuf.Timestamp",
      "waitEventType": "string",
      "waitEvent": "string",
      "state": "string",
      "query": "string",
      "backendType": "string",
      "clientAddr": "string",
      "clientHostname": "string",
      "clientPort": "int64",
      "backendXid": "int64",
      "backendXmin": "int64",
      "blockingPids": "string",
      "queryId": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| sessionStates[] | **[SessionState](#yandex.cloud.mdb.postgresql.v1.SessionState)**

List of PostgreSQL sessions. ||
|| nextPageToken | **string**

This token allows you to get the next page of results when requesting the PostgreSQL session list. If the number of the results is larger than [ListRawSessionStatesRequest.pageSize](#yandex.cloud.mdb.postgresql.v1.ListRawSessionStatesRequest), use the `nextPageToken` as the value for the [ListRawSessionStatesRequest.pageToken](#yandex.cloud.mdb.postgresql.v1.ListRawSessionStatesRequest) parameter in the next request. Each subsequent request will have its own `nextPageToken` to continue paging through the results. ||
|#

## SessionState {#yandex.cloud.mdb.postgresql.v1.SessionState}

#|
||Field | Description ||
|| time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time of collecting statistics on sessions (in the [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format). ||
|| host | **string**

Host of the connected client. ||
|| pid | **int64**

Server process ID. For client connections, this is a client connection ID. ||
|| database | **string**

Database ID. ||
|| user | **string**

User ID. ||
|| applicationName | **string**

Application name on the connected client. ||
|| backendStart | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when a given process was started. For client connections, this is the time when the client connected to the server. ||
|| xactStart | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when a transaction of a given process was started. Returns [NULL] if no transaction is active.

If the currently active query is the first of its transaction, the value of this parameter is equal to the value of the `queryStart` parameter. ||
|| queryStart | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when the currently active query was started.

If the `state` parameter does not take the value [active], the parameter returns the time when the lastest query was started. ||
|| stateChange | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when the `state` parameter was last changed. ||
|| waitEventType | **string**

Type of event for which the backend is waiting. Such an event is called a wait event. A backend refers to the process that maintains the client connection.

For the list of wait events, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/monitoring-stats.html#WAIT-EVENT-TABLE). If the backend is not waiting for any event, the parameter returns [NULL]. ||
|| waitEvent | **string**

Wait event name.

For the list of such names, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/monitoring-stats.html#WAIT-EVENT-ACTIVITY-TABLE). If the backend is not waiting for any event, the parameter returns [NULL]. ||
|| state | **string**

Current backend state. For the list of possible values, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/monitoring-stats.html#MONITORING-PG-STAT-ACTIVITY-VIEW). ||
|| query | **string**

Text of the most recent query.

If the `state` parameter takes the value [active], the parameter shows the currently executing query. For the rest of the states, the parameter shows the last query that was executed. By default, the query text is truncated to 1024 bytes. ||
|| backendType | **string**

Current backend type. For the list of possible values, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/monitoring-stats.html#MONITORING-PG-STAT-ACTIVITY-VIEW). ||
|| clientAddr | **string**

IP address of the connected client.

The parameter returns [NULL] in the following cases:
- The client is connected via a Unix socket on the server.
- A given process is internal (for example, autovacuum). ||
|| clientHostname | **string**

Host name of the connected client (relevant for IP connections). ||
|| clientPort | **int64**

TCP port number that the client is using for communication with the server.

Returns [-1] if the client is connected via a Unix socket on the server. Returns [NULL] if a given process is internal (for example, autovacuum). ||
|| backendXid | **int64**

Top-level transaction ID, if any. ||
|| backendXmin | **int64**

Current [xmin horizon]. ||
|| blockingPids | **string**

Process IDs that are blocking a given server process ID. ||
|| queryId | **string**

Query ID. ||
|#