---
editable: false
sourcePath: en/_api-ref-grpc/mdb/postgresql/v1/api-ref/grpc/PerformanceDiagnostics/listRawSessionStates.md
---

# Managed Service for PostgreSQL API, gRPC: PerformanceDiagnosticsService.ListRawSessionStates

Retrieves raw statistics on sessions. Corresponds to the [pg_stat_activity view](https://www.postgresql.org/docs/current/monitoring-stats.html#MONITORING-PG-STAT-ACTIVITY-VIEW).

## gRPC request

**rpc ListRawSessionStates ([ListRawSessionStatesRequest](#yandex.cloud.mdb.postgresql.v1.ListRawSessionStatesRequest)) returns ([ListRawSessionStatesResponse](#yandex.cloud.mdb.postgresql.v1.ListRawSessionStatesResponse))**

## ListRawSessionStatesRequest {#yandex.cloud.mdb.postgresql.v1.ListRawSessionStatesRequest}

```json
{
  "cluster_id": "string",
  "from_time": "google.protobuf.Timestamp",
  "to_time": "google.protobuf.Timestamp",
  "page_size": "int64",
  "page_token": "string"
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ID of a PostgreSQL cluster to request session statistics for.

To get a PostgreSQL cluster ID, use the [ClusterService.List](/docs/managed-postgresql/api-ref/grpc/Cluster/list#List) request. ||
|| from_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Beginning of the period for which you need to request data (in the [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format). ||
|| to_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

End of the period for which you need to request data (in the [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format). ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of the results is larger than `page_size`, the service returns [ListRawSessionStatesResponse.next_page_token](#yandex.cloud.mdb.postgresql.v1.ListRawSessionStatesResponse). You can use it to get the next page of the results in subsequent requests. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the [ListRawSessionStatesResponse.next_page_token](#yandex.cloud.mdb.postgresql.v1.ListRawSessionStatesResponse) returned by the previous PostgreSQL session list request. ||
|#

## ListRawSessionStatesResponse {#yandex.cloud.mdb.postgresql.v1.ListRawSessionStatesResponse}

```json
{
  "session_states": [
    {
      "time": "google.protobuf.Timestamp",
      "host": "string",
      "pid": "int64",
      "database": "string",
      "user": "string",
      "application_name": "string",
      "backend_start": "google.protobuf.Timestamp",
      "xact_start": "google.protobuf.Timestamp",
      "query_start": "google.protobuf.Timestamp",
      "state_change": "google.protobuf.Timestamp",
      "wait_event_type": "string",
      "wait_event": "string",
      "state": "string",
      "query": "string",
      "backend_type": "string",
      "client_addr": "string",
      "client_hostname": "string",
      "client_port": "int64",
      "backend_xid": "int64",
      "backend_xmin": "int64",
      "blocking_pids": "string",
      "query_id": "string"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| session_states[] | **[SessionState](#yandex.cloud.mdb.postgresql.v1.SessionState)**

List of PostgreSQL sessions. ||
|| next_page_token | **string**

This token allows you to get the next page of results when requesting the PostgreSQL session list. If the number of the results is larger than [ListRawSessionStatesRequest.page_size](#yandex.cloud.mdb.postgresql.v1.ListRawSessionStatesRequest), use the `next_page_token` as the value for the [ListRawSessionStatesRequest.page_token](#yandex.cloud.mdb.postgresql.v1.ListRawSessionStatesRequest) parameter in the next request. Each subsequent request will have its own `next_page_token` to continue paging through the results. ||
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
|| application_name | **string**

Application name on the connected client. ||
|| backend_start | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when a given process was started. For client connections, this is the time when the client connected to the server. ||
|| xact_start | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when a transaction of a given process was started. Returns [NULL] if no transaction is active.

If the currently active query is the first of its transaction, the value of this parameter is equal to the value of the `query_start` parameter. ||
|| query_start | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when the currently active query was started.

If the `state` parameter does not take the value [active], the parameter returns the time when the lastest query was started. ||
|| state_change | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when the `state` parameter was last changed. ||
|| wait_event_type | **string**

Type of event for which the backend is waiting. Such an event is called a wait event. A backend refers to the process that maintains the client connection.

For the list of wait events, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/monitoring-stats.html#WAIT-EVENT-TABLE). If the backend is not waiting for any event, the parameter returns [NULL]. ||
|| wait_event | **string**

Wait event name.

For the list of such names, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/monitoring-stats.html#WAIT-EVENT-ACTIVITY-TABLE). If the backend is not waiting for any event, the parameter returns [NULL]. ||
|| state | **string**

Current backend state. For the list of possible values, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/monitoring-stats.html#MONITORING-PG-STAT-ACTIVITY-VIEW). ||
|| query | **string**

Text of the most recent query.

If the `state` parameter takes the value [active], the parameter shows the currently executing query. For the rest of the states, the parameter shows the last query that was executed. By default, the query text is truncated to 1024 bytes. ||
|| backend_type | **string**

Current backend type. For the list of possible values, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/monitoring-stats.html#MONITORING-PG-STAT-ACTIVITY-VIEW). ||
|| client_addr | **string**

IP address of the connected client.

The parameter returns [NULL] in the following cases:
- The client is connected via a Unix socket on the server.
- A given process is internal (for example, autovacuum). ||
|| client_hostname | **string**

Host name of the connected client (relevant for IP connections). ||
|| client_port | **int64**

TCP port number that the client is using for communication with the server.

Returns [-1] if the client is connected via a Unix socket on the server. Returns [NULL] if a given process is internal (for example, autovacuum). ||
|| backend_xid | **int64**

Top-level transaction ID, if any. ||
|| backend_xmin | **int64**

Current [xmin horizon]. ||
|| blocking_pids | **string**

Process IDs that are blocking a given server process ID. ||
|| query_id | **string**

Query ID. ||
|#