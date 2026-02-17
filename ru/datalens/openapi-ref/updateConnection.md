---
editable: false
---

# DataLens API: Update connection

## HTTP request

Updates the specified connection.

```
POST https://api.datalens.yandex.net/rpc/updateConnection
```

## Body parameters

**Request schema: application/json**

```json
{
  "connectionId": "string",
  "data": {
    "<oneOf>": [
      // `appmetrica_api2` to update AppMetrica connection 
      {
        "accuracy": "number | null",
        "counter_id": "string",
        "created_at": "string",
        "data_export_forbidden": "unknown",
        "description": "string | null",
        "id": "string",
        "key": "string",
        "meta": {
          "string": "unknown"
        },
        "token": "string",
        "updated_at": "string",
        "workbook_id": "string | null"
      },
      // `ch_over_yt2` to update CHYT with authentication by OAuth token connection
      {
        "additional_cluster": "string",
        "alias": "string",
        "cache_ttl_sec": "integer | null",
        "cluster": "string",
        "created_at": "string",
        "data_export_forbidden": "unknown",
        "description": "string | null",
        "id": "string",
        "key": "string",
        "meta": {
          "string": "unknown"
        },
        "raw_sql_level": "string",
        "token": "string",
        "updated_at": "string",
        "workbook_id": "string | null"
      },
      // `ch_over_yt_user_auth2` to update CHYT with authentication as user connection
      {
        "additional_cluster": "string",
        "alias": "string",
        "cache_ttl_sec": "integer | null",
        "cluster": "string",
        "created_at": "string",
        "data_export_forbidden": "unknown",
        "description": "string | null",
        "id": "string",
        "key": "string",
        "meta": {
          "string": "unknown"
        },
        "raw_sql_level": "string",
        "updated_at": "string",
        "workbook_id": "string | null"
      },
      // `clickhouse2` to update ClickHouse connection
      {
        "cache_ttl_sec": "integer | null",
        "connection_manager_cloud_id": "string | null",
        "connection_manager_connection_id": "string | null",
        "connection_manager_delegation_is_set": "boolean | null",
        "connection_manager_folder_id": "string | null",
        "created_at": "string",
        "data_export_forbidden": "unknown",
        "db_name": "string | null",
        "description": "string | null",
        "host": "string",
        "id": "string",
        "key": "string",
        "mdb_cluster_id": "string | null",
        "mdb_folder_id": "string | null",
        "meta": {
          "string": "unknown"
        },
        "password": "string | null",
        "port": "integer",
        "raw_sql_level": "string",
        "readonly": "integer",
        "secure": "unknown",
        "ssl_ca": "unknown",
        "updated_at": "string",
        "username": "string | null",
        "workbook_id": "string | null"
      },
      // `greenplum2` to update Greenplum connection
      {
        "cache_ttl_sec": "integer | null",
        "created_at": "string",
        "data_export_forbidden": "unknown",
        "db_name": "string | null",
        "description": "string | null",
        "enforce_collate": "string",
        "host": "string",
        "id": "string",
        "key": "string",
        "mdb_cluster_id": "string | null",
        "mdb_folder_id": "string | null",
        "meta": {
          "string": "unknown"
        },
        "password": "string",
        "port": "integer",
        "raw_sql_level": "string",
        "ssl_ca": "unknown",
        "ssl_enable": "unknown",
        "updated_at": "string",
        "username": "string",
        "workbook_id": "string | null"
      },
      // `gsheets2` to update Google Sheets connection
      {
        "cache_ttl_sec": "integer | null",
        "created_at": "string",
        "data_export_forbidden": "unknown",
        "description": "string | null",
        "id": "string",
        "key": "string",
        "meta": {
          "string": "unknown"
        },
        "updated_at": "string",
        "url": "string",
        "workbook_id": "string | null"
      },
      // `json_api2` to update API Connector connection
      {
        "allowed_methods": [
          "string"
        ],
        "created_at": "string",
        "description": "string | null",
        "host": "string",
        "id": "string",
        "key": "string",
        "meta": {
          "string": "unknown"
        },
        "path": "string | null",
        "plain_headers": "object | null",
        "port": "integer",
        "secret_headers": "object | null",
        "secure": "boolean",
        "tvm_dst_id": "integer | null",
        "updated_at": "string",
        "workbook_id": "string | null"
      },
      // `metrika_api2` to update Yandex Metrica API connection
      {
        "accuracy": "number | null",
        "counter_id": "string",
        "created_at": "string",
        "data_export_forbidden": "unknown",
        "description": "string | null",
        "id": "string",
        "key": "string",
        "meta": {
          "string": "unknown"
        },
        "token": "string",
        "updated_at": "string",
        "workbook_id": "string | null"
      },
      // `mssql2` to update Microsoft SQL Server connection
      {
        "cache_ttl_sec": "integer | null",
        "created_at": "string",
        "data_export_forbidden": "unknown",
        "db_name": "string | null",
        "description": "string | null",
        "host": "string",
        "id": "string",
        "key": "string",
        "meta": {
          "string": "unknown"
        },
        "password": "string",
        "port": "integer",
        "raw_sql_level": "string",
        "updated_at": "string",
        "username": "string",
        "workbook_id": "string | null"
      },
      // `mysql2` to update MySQL connection
      {
        "cache_ttl_sec": "integer | null",
        "connection_manager_cloud_id": "string | null",
        "connection_manager_connection_id": "string | null",
        "connection_manager_delegation_is_set": "boolean | null",
        "connection_manager_folder_id": "string | null",
        "created_at": "string",
        "data_export_forbidden": "unknown",
        "db_name": "string | null",
        "description": "string | null",
        "host": "string",
        "id": "string",
        "key": "string",
        "mdb_cluster_id": "string | null",
        "mdb_folder_id": "string | null",
        "meta": {
          "string": "unknown"
        },
        "password": "string | null",
        "port": "integer",
        "raw_sql_level": "string",
        "ssl_ca": "unknown",
        "ssl_enable": "unknown",
        "updated_at": "string",
        "username": "string | null",
        "workbook_id": "string | null"
      },
      // `oracle2` to update Oracle Database connection
      {
        "cache_ttl_sec": "integer | null",
        "created_at": "string",
        "data_export_forbidden": "unknown",
        "db_connect_method": "string",
        "db_name": "string | null",
        "description": "string | null",
        "host": "string",
        "id": "string",
        "key": "string",
        "meta": {
          "string": "unknown"
        },
        "password": "string",
        "port": "integer",
        "raw_sql_level": "string",
        "ssl_ca": "unknown",
        "ssl_enable": "unknown",
        "updated_at": "string",
        "username": "string",
        "workbook_id": "string | null"
      },
      // `postgres2` to update PostgreSQL connection
      {
        "cache_ttl_sec": "integer | null",
        "connection_manager_cloud_id": "string | null",
        "connection_manager_connection_id": "string | null",
        "connection_manager_delegation_is_set": "boolean | null",
        "connection_manager_folder_id": "string | null",
        "created_at": "string",
        "data_export_forbidden": "unknown",
        "db_name": "string | null",
        "description": "string | null",
        "enforce_collate": "string",
        "host": "string",
        "id": "string",
        "key": "string",
        "mdb_cluster_id": "string | null",
        "mdb_folder_id": "string | null",
        "meta": {
          "string": "unknown"
        },
        "password": "string | null",
        "port": "integer",
        "raw_sql_level": "string",
        "ssl_ca": "unknown",
        "ssl_enable": "unknown",
        "updated_at": "string",
        "username": "string | null",
        "workbook_id": "string | null"
      },
      // `promql2` to update Prometheus connection
      {
        "cache_ttl_sec": "integer | null",
        "created_at": "string",
        "data_export_forbidden": "unknown",
        "db_name": "string | null",
        "description": "string | null",
        "host": "string",
        "id": "string",
        "key": "string",
        "meta": {
          "string": "unknown"
        },
        "password": "string | null",
        "path": "string | null",
        "port": "integer",
        "secure": "boolean",
        "updated_at": "string",
        "username": "string | null",
        "workbook_id": "string | null"
      },
      // `usage_tracking_ya_team2` to update DataLens Usage Tracking connection
      {
        "created_at": "string",
        "description": "string | null",
        "id": "string",
        "key": "string",
        "meta": {
          "string": "unknown"
        },
        "updated_at": "string",
        "workbook_id": "string | null"
      },
      // `ydb2` to update YDB connection
      {
        "auth_type": "string | null",
        "cache_ttl_sec": "integer | null",
        "created_at": "string",
        "data_export_forbidden": "unknown",
        "db_name": "string",
        "description": "string | null",
        "host": "string",
        "id": "string",
        "key": "string",
        "port": "integer",
        "raw_sql_level": "string",
        "ssl_ca": "unknown",
        "ssl_enable": "unknown",
        "token": "string | null",
        "updated_at": "string",
        "username": "string | null",
        "workbook_id": "string | null"
      }
    ]
  }
}
```

#|
||Field | Description ||
|| connectionId | **string**

Required field. ID of the connection to update. You can find it in the connection settings in DataLens interface. ||
|| data | One of **[appmetrica_api2](#appmetrica_api2)** \| **[ch_over_yt2](#ch_over_yt2)** \| **[ch_over_yt_user_auth2](#ch_over_yt_user_auth2)** \| **[clickhouse2](#clickhouse2)** \| **[greenplum2](#greenplum2)** \| **[gsheets2](#gsheets2)** \| **[json_api2](#json_api2)** \| **[metrika_api2](#metrika_api2)** \| **[mssql2](#mssql2)** \| **[mysql2](#mysql2)** \| **[oracle2](#oracle2)** \| **[postgres2](#postgres2)** \| **[promql2](#promql2)** \| **[usage_tracking_ya_team2](#usage_tracking_ya_team2)** \| **[ydb2](#ydb2)** 

Type of the connection to update. ||
|#

## appmetrica_api2 {#appmetrica_api2}

#|
||Field | Description ||
|| accuracy | **number \| null**

Accuracy of the metric data. ||
|| counter_id | **string**

Required field. AppMetrica counter (app) ID. ||
|| created_at | **string** 

Timestamp when the connection was created. ||
|| data_export_forbidden | **unknown** 

Indicates if data export is forbidden. ||
|| description | **string \| null** 

Description of the connection. ||
|| id | **string**

Unique identifier of the connection. ||
|| key | **string**

Key used to identify the connection. Indicates the path and name of the connection. ||
|| meta | **object** (map<**string**, **unknown**>)

Metadata associated with the connection. ||
|| token | **string**

Required field. OAuth token of the connection. ||
|| updated_at | **string**

Timestamp when the connection was last updated. ||
|| workbook_id | **string \| null** 

ID of the workbook the connection belongs to. If navigation across folders is enabled and the connection belongs to a folder, the value must be `null`. ||
|#

## ch_over_yt2 {#ch_over_yt2}

#|
||Field | Description ||
|| additional_cluster | **string**

Backup cluster from the connection. ||
|| alias | **string**

Required field. CHYT clique alias. ||
|| cache_ttl_sec | **integer \| null** 

Cache time-to-live in seconds. ||
|| cluster | **string**

Required field. Cluster from the connection. ||
|| created_at | **string** 

Timestamp when the connection was created. ||
|| data_export_forbidden | **unknown** 

Indicates if data export is forbidden. ||
|| description | **string \| null** 

Description of the connection. ||
|| id | **string** 

Unique identifier of the connection. ||
|| key | **string**

Key used to identify the connection. Indicates the path and name of the connection. ||
|| meta | **object** (map<**string**, **unknown**>)

Metadata associated with the connection. ||
|| raw_sql_level | **enum**

Raw SQL level:

- `off` — The option is disabled.
- `subselect` — Allowed subqueries in datasets.
- `template` — Allowed subqueries in datasets and source parameterization.
- `dashsql` — Allowed subqueries in datasets, source parameterization, and QL charts. ||
|| token | **string**

Required field. OAuth token from the connection. ||
|| updated_at | **string** 

Timestamp when the connection was last updated. ||
|| workbook_id | **string \| null** 

ID of the workbook the connection belongs to. If navigation across folders is enabled and the connection belongs to a folder, the value must be `null`. ||
|#

## ch_over_yt_user_auth2 {#ch_over_yt_user_auth2}

#|
||Field | Description ||
|| additional_cluster | **string** 

Backup cluster from the connection. ||
|| alias | **string**

Required field. CHYT clique alias. ||
|| cache_ttl_sec | **integer \| null** 

Cache time-to-live in seconds. ||
|| cluster | **string**

Required field. Cluster from the connection. ||
|| created_at | **string** 

Timestamp when the connection was created. ||
|| data_export_forbidden | **unknown** 

Indicates if data export is forbidden. ||
|| description | **string \| null** 

Description of the connection. ||
|| id | **string** 

Unique identifier of the connection. ||
|| key | **string** 

Key used to identify the connection. Indicates the path and name of the connection. ||
|| meta | **object** (map<**string**, **unknown**>) 

Metadata associated with the connection. ||
|| name | **string**

Required field. Name of the connection. ||
|| raw_sql_level | **enum**

Raw SQL level:

- `off` — The option is disabled.
- `subselect` — Allowed subqueries in datasets.
- `template` — Allowed subqueries in datasets and source parameterization.
- `dashsql` — Allowed subqueries in datasets, source parameterization, and QL charts. ||
|| updated_at | **string** 

Timestamp when the connection was last updated. ||
|| workbook_id | **string \| null** 

ID of the workbook the connection belongs to. If navigation across folders is enabled and the connection belongs to a folder, the value must be `null`. ||
|#

## clickhouse2 {#clickhouse2}

#|
||Field | Description ||
|| cache_ttl_sec | **integer \| null** 

Cache time-to-live in seconds. ||
|| connection_manager_cloud_id | **string \| null** 

ID of the cloud where the connection to the cluster was created in Connection Manager. ||
|| connection_manager_connection_id | **string \| null** 

Connection ID from Connection Manager. ||
|| connection_manager_delegation_is_set | **boolean \| null** 

Type of connection management. If true, connections are created automatically by a managed database cluster. Else connections are created by a user or a third-party service. ||
|| connection_manager_folder_id | **string \| null** 

ID of the folder where the connection to the cluster was created in Connection Manager. ||
|| created_at | **string**

Timestamp when the connection was created. ||
|| data_export_forbidden | **unknown** 

Indicates if data export is forbidden. ||
|| db_name | **string \| null** 

Database name. ||
|| description | **string \| null** 

Description of the connection. ||
|| host | **string**

Required field. Host name. ||
|| id | **string** 

Unique identifier of the connection. ||
|| key | **string** 

Key used to identify the connection. Indicates the path and name of the connection. ||
|| mdb_cluster_id | **string \| null** 

ID of the MDB cluster. ||
|| mdb_folder_id | **string \| null** 

ID of the MDB folder. ||
|| meta | **object** (map<**string**, **unknown**>) 

Metadata associated with the connection. ||
|| name | **string**

Required field. Name of the connection. ||
|| password | **string \| null** 

Password for the connection. ||
|| port | **integer**

Required field. Connection port. The default port is 8443. ||
|| raw_sql_level | **enum**

Raw SQL level:

- `off` — The option is disabled.
- `subselect` — Allowed subqueries in datasets.
- `template` — Allowed subqueries in datasets and source parameterization.
- `dashsql` — Allowed subqueries in datasets, source parameterization, and QL charts. ||
|| readonly | **integer** 

Read-only flag. ||
|| secure | **unknown** 

Secure connection flag. ||
|| ssl_ca | **unknown** 

SSL certificate authority. ||
|| updated_at | **string** 

Timestamp when the connection was last updated. ||
|| username | **string \| null** 

Username for the connection. ||
|| workbook_id | **string \| null** 

ID of the workbook the connection belongs to. If navigation across folders is enabled and the connection belongs to a folder, the value must be `null`. ||
|#

## greenplum2 {#greenplum2}

#|
||Field | Description ||
|| cache_ttl_sec | **integer \| null** 

Cache time-to-live in seconds. ||
|| created_at | **string** 

Timestamp when the connection was created. ||
|| data_export_forbidden | **unknown** 

Indicates if data export is forbidden. ||
|| db_name | **string \| null** 

Database name. ||
|| description | **string \| null** 

Description of the connection. ||
|| enforce_collate | **enum**

Mode of setting collate in a query:
- `auto` — Default setting is used, DataLens decides whether to enable the `en_US` locale.
- `on` — DataLens setting is used, the `en_US` locale is specified for individual expressions in a query.
- `off` — Applies the default setting. DataLens uses database-level locale settings. ||
|| host | **string**

Required field. Host name. ||
|| id | **string** 

Unique identifier of the connection. ||
|| key | **string** 

Key used to identify the connection. Indicates the path and name of the connection. ||
|| mdb_cluster_id | **string \| null** 

ID of the MDB cluster. ||
|| mdb_folder_id | **string \| null** 

ID of the MDB folder. ||
|| meta | **object** (map<**string**, **unknown**>) 

Metadata associated with the connection. ||
|| password | **string**

Required field. Password for the connection. ||
|| port | **integer**

Required field. Connection port. ||
|| raw_sql_level | **enum**

Raw SQL level:

- `off` — The option is disabled.
- `subselect` — Allowed subqueries in datasets.
- `template` — Allowed subqueries in datasets and source parameterization.
- `dashsql` — Allowed subqueries in datasets, source parameterization, and QL charts. ||
|| ssl_ca | **unknown** 

SSL certificate authority. ||
|| ssl_enable | **unknown** 

SSL flag. ||
|| updated_at | **string** 

Timestamp when the connection was last updated. ||
|| username | **string**

Required field. Username for the connection. ||
|| workbook_id | **string \| null** 

ID of the workbook the connection belongs to. If navigation across folders is enabled and the connection belongs to a folder, the value must be `null`. ||
|#

## gsheets2 {#gsheets2}

#|
||Field | Description ||
|| cache_ttl_sec | **integer \| null** 

Cache time-to-live in seconds. ||
|| created_at | **string** 

Timestamp when the connection was created. ||
|| data_export_forbidden | **unknown** 

Indicates if data export is forbidden. ||
|| description | **string \| null** 

Description of the connection. ||
|| id | **string** 

Unique identifier of the connection. ||
|| key | **string** 

Key used to identify the connection. Indicates the path and name of the connection. ||
|| meta | **object** (map<**string**, **unknown**>) 

Metadata associated with the connection. ||
|| updated_at | **string** 

Timestamp when the connection was last updated. ||
|| url | **string**

Required field. Path to the Google Sheets file. ||
|| workbook_id | **string \| null** 

ID of the workbook the connection belongs to. If navigation across folders is enabled and the connection belongs to a folder, the value must be `null`. ||
|#

## json_api2 {#json_api2}

#|
||Field | Description ||
|| allowed_methods[] | **enum**

Required field. A method to send an HTTP request to the API. The available methods are:

- `GET`
- `POST` ||
|| created_at | **string** 

Timestamp when the connection was created. ||
|| description | **string \| null** 

Description of the connection. ||
|| host | **string**

Required field. Host name. ||
|| id | **string** 

Unique identifier of the connection. ||
|| key | **string** 

Key used to identify the connection. Indicates the path and name of the connection. ||
|| meta | **object** (map<**string**, **unknown**>) 

Metadata associated with the connection. ||
|| path | **string \| null** 

Path to the API (part of the URL without a protocol, host name, or port). ||
|| plain_headers | **object \| null** 

Public request headers represented by key-value pair. ||
|| port | **integer**

Required field. Connection port. ||
|| secret_headers | **object \| null** 

Private request headers represented by key-value pair. For private headers value will return `null`. ||
|| secure | **boolean** 

Secure connection flag. ||
|| tvm_dst_id | **integer \| null** 
ID for TVM authentication. ||
|| updated_at | **string** 

Timestamp when the connection was last updated. ||
|| workbook_id | **string \| null** 

ID of the workbook the connection belongs to. If navigation across folders is enabled and the connection belongs to a folder, the value must be `null`. ||
|#

## metrika_api2 {#metrika_api2}

#|
||Field | Description ||
|| accuracy | **number \| null** 

Accuracy of the metric data. ||
|| counter_id | **string**

Required field. AppMetrica counter (app) ID. ||
|| created_at | **string** 

Timestamp when the connection was created. ||
|| data_export_forbidden | **unknown** 

Indicates if data export is forbidden. ||
|| description | **string \| null** 

Description of the connection. ||
|| id | **string** 

Unique identifier of the connection. ||
|| key | **string** 

Key used to identify the connection. Indicates the path and name of the connection. ||
|| meta | **object** (map<**string**, **unknown**>) 

Metadata associated with the connection. ||
|| token | **string**

Required field. OAuth token from the connection. ||
|| updated_at | **string** 

Timestamp when the connection was last updated. ||
|| workbook_id | **string \| null** 

ID of the workbook the connection belongs to. If navigation across folders is enabled and the connection belongs to a folder, the value must be `null`. ||
|#

## mssql2 {#mssql2}

#|
||Field | Description ||
|| cache_ttl_sec | **integer \| null** 

Cache time-to-live in seconds. ||
|| created_at | **string** 

Timestamp when the connection was created. ||
|| data_export_forbidden | **unknown** 

Indicates if data export is forbidden. ||
|| db_name | **string \| null** 

Database name. ||
|| description | **string \| null** 

Description of the connection. ||
|| host | **string**

Required field. Host name. ||
|| id | **string** 

Unique identifier of the connection. ||
|| key | **string** 

Key used to identify the connection. Indicates the path and name of the connection. ||
|| meta | **object** (map<**string**, **unknown**>) 

Metadata associated with the connection. ||
|| password | **string**

Required field. Password for the connection. ||
|| port | **integer**

Required field. Connection port. ||
|| raw_sql_level | **enum**

Raw SQL level:

- `off` — The option is disabled.
- `subselect` — Allowed subqueries in datasets.
- `template` — Allowed subqueries in datasets and source parameterization.
- `dashsql` — Allowed subqueries in datasets, source parameterization, and QL charts. ||
|| updated_at | **string** 

Timestamp when the connection was last updated. ||
|| username | **string**

Required field. Username for the connection. ||
|| workbook_id | **string \| null** 

ID of the workbook the connection belongs to. If navigation across folders is enabled and the connection belongs to a folder, the value must be `null`. ||
|#

## mysql2 {#mysql2}

#|
||Field | Description ||
|| cache_ttl_sec | **integer \| null** 

Cache time-to-live in seconds. ||
|| connection_manager_cloud_id | **string \| null** 

ID of the cloud where the connection to the cluster was created in Connection Manager. ||
|| connection_manager_connection_id | **string \| null** 

Connection ID from Connection Manager. ||
|| connection_manager_delegation_is_set | **boolean \| null** 

Type of connection management. If true, connections are created automatically by a managed database cluster. Else connections are created by a user or a third-party service. ||
|| connection_manager_folder_id | **string \| null** 

ID of the folder where the connection to the cluster was created in Connection Manager. ||
|| created_at | **string** 

Timestamp when the connection was created. ||
|| data_export_forbidden | **unknown** 

Indicates if data export is forbidden. ||
|| db_name | **string \| null** 

Database name. ||
|| description | **string \| null** 

Description of the connection. ||
|| host | **string**

Required field. Host name. ||
|| id | **string** 

Unique identifier of the connection. ||
|| key | **string** 

Key used to identify the connection. Indicates the path and name of the connection. ||
|| mdb_cluster_id | **string \| null** 

ID of the MDB cluster. ||
|| mdb_folder_id | **string \| null** 

ID of the MDB folder. ||
|| meta | **object** (map<**string**, **unknown**>) 

Metadata associated with the connection. ||
|| password | **string \| null** 

Password for the connection. ||
|| port | **integer**

Required field. Connection port. ||
|| raw_sql_level | **enum**

Raw SQL level:

- `off` — The option is disabled.
- `subselect` — Allowed subqueries in datasets.
- `template` — Allowed subqueries in datasets and source parameterization.
- `dashsql` — Allowed subqueries in datasets, source parameterization, and QL charts. ||
|| ssl_ca | **unknown** 

SSL certificate authority. ||
|| ssl_enable | **unknown** 

SSL flag. ||
|| updated_at | **string** 

Timestamp when the connection was last updated. ||
|| username | **string \| null** 

Username for the connection. ||
|| workbook_id | **string \| null** 

ID of the workbook the connection belongs to. If navigation across folders is enabled and the connection belongs to a folder, the value must be `null`. ||
|#

## oracle2 {#oracle2}

#|
||Field | Description ||
|| cache_ttl_sec | **integer \| null** 

Cache time-to-live in seconds. ||
|| created_at | **string**

Timestamp when the connection was created. ||
|| data_export_forbidden | **unknown** 

Indicates if data export is forbidden. ||
|| db_connect_method | **enum**

Required field. Specified service name or the system ID of the database.

- `sid` — system ID.
- `service_name` — service name. ||
|| db_name | **string \| null** 

Database name. ||
|| description | **string \| null** 

Description of the connection. ||
|| host | **string**

Required field. Host name. ||
|| id | **string** 

Unique identifier of the connection. ||
|| key | **string** 

Key used to identify the connection. Indicates the path and name of the connection. ||
|| meta | **object** (map<**string**, **unknown**>) 

Metadata associated with the connection. ||
|| password | **string**

Required field. Password for the connection. ||
|| port | **integer**

Required field. Connection port. ||
|| raw_sql_level | **enum**

Raw SQL level:

- `off` — The option is disabled.
- `subselect` — Allowed subqueries in datasets.
- `template` — Allowed subqueries in datasets and source parameterization.
- `dashsql` — Allowed subqueries in datasets, source parameterization, and QL charts. ||
|| ssl_ca | **unknown** 

SSL certificate authority. ||
|| ssl_enable | **unknown** 

SSL flag. ||
|| updated_at | **string** 

Timestamp when the connection was last updated. ||
|| username | **string**

Required field. Username for the connection. ||
|| workbook_id | **string \| null** 

ID of the workbook the connection belongs to. If navigation across folders is enabled and the connection belongs to a folder, the value must be `null`. ||
|#

## postgres2 {#postgres2}

#|
||Field | Description ||
|| cache_ttl_sec | **integer \| null** 

Cache time-to-live in seconds. ||
|| connection_manager_cloud_id | **string \| null** 

ID of the cloud where the connection to the cluster was created in Connection Manager. ||
|| connection_manager_connection_id | **string \| null** 

Connection ID from Connection Manager. ||
|| connection_manager_delegation_is_set | **boolean \| null** 

Type of connection management. If true, connections are created automatically by a managed database cluster. Else connections are created by a user or a third-party service. ||
|| connection_manager_folder_id | **string \| null** 

ID of the folder where the connection to the cluster was created in Connection Manager. ||
|| created_at | **string** 

Timestamp when the connection was created. ||
|| data_export_forbidden | **unknown** 

Indicates if data export is forbidden. ||
|| db_name | **string \| null** 

Database name. ||
|| description | **string \| null** 

Description of the connection. ||
|| enforce_collate | **enum**

Mode of setting collate in a query:
- `auto` — Default setting is used, DataLens decides whether to enable the `en_US` locale.
- `on` — DataLens setting is used, the `en_US` locale is specified for individual expressions in a query.
- `off` — Applies the default setting. DataLens uses database-level locale settings. ||
|| host | **string**

Required field. Host name. ||
|| id | **string** 

Unique identifier of the connection. ||
|| key | **string** 

Key used to identify the connection. Indicates the path and name of the connection. ||
|| mdb_cluster_id | **string \| null** 

ID of the MDB cluster. ||
|| mdb_folder_id | **string \| null** 

ID of the MDB folder. ||
|| meta | **object** (map<**string**, **unknown**>) 

Metadata associated with the connection. ||
|| password | **string \| null** 

Password for the connection. ||
|| port | **integer**

Required field. Connection port. ||
|| raw_sql_level | **enum**

Raw SQL level:

- `off` — The option is disabled.
- `subselect` — Allowed subqueries in datasets.
- `template` — Allowed subqueries in datasets and source parameterization.
- `dashsql` — Allowed subqueries in datasets, source parameterization, and QL charts. ||
|| ssl_ca | **unknown** 

SSL certificate authority. ||
|| ssl_enable | **unknown** 

SSL flag. ||
|| updated_at | **string** 

Timestamp when the connection was last updated. ||
|| username | **string \| null** 

Username for the connection. ||
|| workbook_id | **string \| null** 

ID of the workbook the connection belongs to. If navigation across folders is enabled and the connection belongs to a folder, the value must be `null`. ||
|#

## promql2 {#promql2}

#|
||Field | Description ||
|| cache_ttl_sec | **integer \| null** 

Cache time-to-live in seconds. ||
|| created_at | **string** 

Timestamp when the connection was created. ||
|| data_export_forbidden | **unknown** 

Indicates if data export is forbidden. ||
|| db_name | **string \| null** 

Database name. ||
|| description | **string \| null** 

Description of the connection. ||
|| host | **string**

Required field. Host name. ||
|| id | **string** 

Unique identifier of the connection. ||
|| key | **string** 

Key used to identify the connection. Indicates the path and name of the connection. ||
|| meta | **object** (map<**string**, **unknown**>) 

Metadata associated with the connection. ||
|| password | **string \| null** 

Password for the connection. ||
|| path | **string \| null** ||
|| port | **integer**

Required field. Connection port. ||
|| secure | **boolean** 

Secure connection flag. ||
|| updated_at | **string** 

Timestamp when the connection was last updated. ||
|| username | **string \| null** 

Username for the connection. ||
|| workbook_id | **string \| null** 

ID of the workbook the connection belongs to. If navigation across folders is enabled and the connection belongs to a folder, the value must be `null`. ||
|#


## usage_tracking_ya_team2 {#usage_tracking_ya_team2}

#|
||Field | Description ||
|| created_at | **string** 

Timestamp when the connection was created. ||
|| description | **string \| null** 

Description of the connection. ||
|| id | **string** 

Unique identifier of the connection. ||
|| key | **string** 

Key used to identify the connection. Indicates the path and name of the connection. ||
|| meta | **object** (map<**string**, **unknown**>) 

Metadata associated with the connection. ||
|| updated_at | **string** 

Timestamp when the connection was last updated. ||
|| workbook_id | **string \| null** 

ID of the workbook the connection belongs to. If navigation across folders is enabled and the connection belongs to a folder, the value must be `null`. ||
|#

## ydb2 {#ydb2}

#|
||Field | Description ||
|| auth_type | **enum**

Authentication type:
- `anonymous` — anonymously.
- `password` — with password.
- `oauth` — with OAuth token.
- `null` — not specified. ||
|| cache_ttl_sec | **integer \| null** 

Cache time-to-live in seconds. ||
|| created_at | **string** 

Timestamp when the connection was created. ||
|| data_export_forbidden | **unknown** 

Indicates if data export is forbidden. ||
|| db_name | **string**

Required field. Database name. ||
|| description | **string \| null** 

Description of the connection. ||
|| host | **string**

Required field. Host name. ||
|| id | **string** 

Unique identifier of the connection. ||
|| key | **string** 

Key used to identify the connection. Indicates the path and name of the connection. ||
|| port | **integer**

Required field. Connection port. ||
|| raw_sql_level | **enum**

Raw SQL level:

- `off` — The option is disabled.
- `subselect` — Allowed subqueries in datasets.
- `template` — Allowed subqueries in datasets and source parameterization.
- `dashsql` — Allowed subqueries in datasets, source parameterization, and QL charts. ||
|| ssl_ca | **unknown** 

SSL certificate authority. ||
|| ssl_enable | **unknown** 

SSL flag. ||
|| token | **string \| null** 

OAuth token from the connection. ||
|| updated_at | **string** 

Timestamp when the connection was last updated. ||
|| username | **string \| null** 

Username for the connection. ||
|| workbook_id | **string \| null** 

ID of the workbook the connection belongs to. If navigation across folders is enabled and the connection belongs to a folder, the value must be `null`. ||
|#

## Response {#200}

**HTTP Code: 200**

Response

**Response schema: application/json**

```json
{
  "<oneOf>": [
    // When AppMetrica connection was updated
    {
      "accuracy": "number | null",
      "counter_id": "string",
      "created_at": "string",
      "data_export_forbidden": "unknown",
      "description": "string | null",
      "id": "string",
      "key": "string",
      "meta": {
        "string": "unknown"
      },
      "name": "string",
      "token": "string",
      "type": "appmetrica_api",
      "updated_at": "string"
    },
    // When CHYT with authentication by OAuth token connection was updated
    {
      "additional_cluster": "string",
      "alias": "string",
      "cache_ttl_sec": "integer | null",
      "cluster": "string",
      "created_at": "string",
      "data_export_forbidden": "unknown",
      "description": "string | null",
      "id": "string",
      "key": "string",
      "meta": {
        "string": "unknown"
      },
      "name": "string",
      "raw_sql_level": "string",
      "token": "string",
      "type": "ch_over_yt",
      "updated_at": "string"
    },
    // When CHYT with authentication as user was updated
    {
      "additional_cluster": "string",
      "alias": "string",
      "cache_ttl_sec": "integer | null",
      "cluster": "string",
      "created_at": "string",
      "data_export_forbidden": "unknown",
      "description": "string | null",
      "id": "string",
      "key": "string",
      "meta": {
        "string": "unknown"
      },
      "name": "string",
      "raw_sql_level": "string",
      "type": "ch_over_yt_user_auth",
      "updated_at": "string"
    },
    // When ClickHouse connection was updated
    {
      "cache_ttl_sec": "integer | null",
      "connection_manager_cloud_id": "string | null",
      "connection_manager_connection_id": "string | null",
      "connection_manager_delegation_is_set": "boolean | null",
      "connection_manager_folder_id": "string | null",
      "created_at": "string",
      "data_export_forbidden": "unknown",
      "db_name": "string | null",
      "description": "string | null",
      "host": "string",
      "id": "string",
      "key": "string",
      "mdb_cluster_id": "string | null",
      "mdb_folder_id": "string | null",
      "meta": {
        "string": "unknown"
      },
      "name": "string",
      "password": "string | null",
      "port": "integer",
      "raw_sql_level": "string",
      "readonly": "integer",
      "secure": "unknown",
      "ssl_ca": "unknown",
      "type": "clickhouse",
      "updated_at": "string",
      "username": "string | null"
    },
    // When Greenplum connection was updated
    {
      "cache_ttl_sec": "integer | null",
      "created_at": "string",
      "data_export_forbidden": "unknown",
      "db_name": "string | null",
      "description": "string | null",
      "enforce_collate": "string",
      "host": "string",
      "id": "string",
      "key": "string",
      "mdb_cluster_id": "string | null",
      "mdb_folder_id": "string | null",
      "meta": {
        "string": "unknown"
      },
      "name": "string",
      "password": "string",
      "port": "integer",
      "raw_sql_level": "string",
      "ssl_ca": "unknown",
      "ssl_enable": "unknown",
      "type": "greenplum",
      "updated_at": "string",
      "username": "string"
    },
    // When Google Sheets connection was updated
    {
      "cache_ttl_sec": "integer | null",
      "created_at": "string",
      "data_export_forbidden": "unknown",
      "description": "string | null",
      "id": "string",
      "key": "string",
      "meta": {
        "string": "unknown"
      },
      "name": "string",
      "type": "gsheets",
      "updated_at": "string",
      "url": "string"
    },
    // When API Connector connection was updated
    {
      "allowed_methods": [
        "string"
      ],
      "created_at": "string",
      "description": "string | null",
      "host": "string",
      "id": "string",
      "key": "string",
      "meta": {
        "string": "unknown"
      },
      "name": "string",
      "path": "string | null",
      "plain_headers": "object | null",
      "port": "integer",
      "secret_headers": "object | null",
      "secure": "boolean",
      "tvm_dst_id": "integer | null",
      "type": "json_api",
      "updated_at": "string"
    },
    // When Yandex Metrica API connection was updated
    {
      "accuracy": "number | null",
      "counter_id": "string",
      "created_at": "string",
      "data_export_forbidden": "unknown",
      "description": "string | null",
      "id": "string",
      "key": "string",
      "meta": {
        "string": "unknown"
      },
      "name": "string",
      "token": "string",
      "type": "metrika_api",
      "updated_at": "string"
    },
    // When Microsoft SQL Server connection was updated
    {
      "cache_ttl_sec": "integer | null",
      "created_at": "string",
      "data_export_forbidden": "unknown",
      "db_name": "string | null",
      "description": "string | null",
      "host": "string",
      "id": "string",
      "key": "string",
      "meta": {
        "string": "unknown"
      },
      "name": "string",
      "password": "string",
      "port": "integer",
      "raw_sql_level": "string",
      "type": "mssql",
      "updated_at": "string",
      "username": "string"
    },
    // When MySQL connection was updated
    {
      "cache_ttl_sec": "integer | null",
      "connection_manager_cloud_id": "string | null",
      "connection_manager_connection_id": "string | null",
      "connection_manager_delegation_is_set": "boolean | null",
      "connection_manager_folder_id": "string | null",
      "created_at": "string",
      "data_export_forbidden": "unknown",
      "db_name": "string | null",
      "description": "string | null",
      "host": "string",
      "id": "string",
      "key": "string",
      "mdb_cluster_id": "string | null",
      "mdb_folder_id": "string | null",
      "meta": {
        "string": "unknown"
      },
      "name": "string",
      "password": "string | null",
      "port": "integer",
      "raw_sql_level": "string",
      "ssl_ca": "unknown",
      "ssl_enable": "unknown",
      "type": "mysql",
      "updated_at": "string",
      "username": "string | null"
    },
    // When Oracle Database connection was updated
    {
      "cache_ttl_sec": "integer | null",
      "created_at": "string",
      "data_export_forbidden": "unknown",
      "db_connect_method": "string",
      "db_name": "string | null",
      "description": "string | null",
      "host": "string",
      "id": "string",
      "key": "string",
      "meta": {
        "string": "unknown"
      },
      "name": "string",
      "password": "string",
      "port": "integer",
      "raw_sql_level": "string",
      "ssl_ca": "unknown",
      "ssl_enable": "unknown",
      "type": "oracle",
      "updated_at": "string",
      "username": "string"
    },
    // When PostgreSQL connection was updated
    {
      "cache_ttl_sec": "integer | null",
      "connection_manager_cloud_id": "string | null",
      "connection_manager_connection_id": "string | null",
      "connection_manager_delegation_is_set": "boolean | null",
      "connection_manager_folder_id": "string | null",
      "created_at": "string",
      "data_export_forbidden": "unknown",
      "db_name": "string | null",
      "description": "string | null",
      "enforce_collate": "string",
      "host": "string",
      "id": "string",
      "key": "string",
      "mdb_cluster_id": "string | null",
      "mdb_folder_id": "string | null",
      "meta": {
        "string": "unknown"
      },
      "name": "string",
      "password": "string | null",
      "port": "integer",
      "raw_sql_level": "string",
      "ssl_ca": "unknown",
      "ssl_enable": "unknown",
      "type": "postgres",
      "updated_at": "string",
      "username": "string | null"
    },
    // When Prometheus connection was updated
    {
      "cache_ttl_sec": "integer | null",
      "created_at": "string",
      "data_export_forbidden": "unknown",
      "db_name": "string | null",
      "description": "string | null",
      "host": "string",
      "id": "string",
      "key": "string",
      "meta": {
        "string": "unknown"
      },
      "name": "string",
      "password": "string | null",
      "path": "string | null",
      "port": "integer",
      "secure": "boolean",
      "type": "promql",
      "updated_at": "string",
      "username": "string | null"
    },
    // When DataLens Usage Tracking connection was updated
    {
      "created_at": "string",
      "description": "string | null",
      "id": "string",
      "key": "string",
      "meta": {
        "string": "unknown"
      },
      "name": "string",
      "type": "usage_tracking_ya_team",
      "updated_at": "string"
    },
    // When YDB connection was updated
    {
      "auth_type": "string | null",
      "cache_ttl_sec": "integer | null",
      "created_at": "string",
      "data_export_forbidden": "unknown",
      "db_name": "string",
      "description": "string | null",
      "host": "string",
      "id": "string",
      "key": "string",
      "name": "string",
      "port": "integer",
      "raw_sql_level": "string",
      "ssl_ca": "unknown",
      "ssl_enable": "unknown",
      "token": "string | null",
      "type": "ydb",
      "updated_at": "string",
      "username": "string | null"
    }
  ]
}
```

One of:

> When the AppMetrica connection was updated. For details, see [documentation](https://docs.yandex-team.ru/cloud/datalens/operations/connection/create-appmetrica).

#|
||Field | Description ||
|| accuracy | **number \| null**

Accuracy of the metric data. ||
|| counter_id | **string**

Required field. AppMetrica counter (app) ID. ||
|| created_at | **string** 

Timestamp when the connection was created. ||
|| data_export_forbidden | **unknown** 

Indicates if data export is forbidden. ||
|| description | **string \| null** 

Description of the connection. ||
|| id | **string**

Unique identifier of the connection. ||
|| key | **string**

Key used to identify the connection. Indicates the path and name of the connection. ||
|| meta | **object** (map<**string**, **unknown**>)

Metadata associated with the connection. ||
|| name | **string**

Required field. Name of the connection. ||
|| token | **string**

Required field. OAuth token of the connection. ||
|| type | **appmetrica_api** (const)

Type of the connection. ||
|| updated_at | **string**

Timestamp when the connection was last updated. ||
|#

> When the CHYT with authentication by OAuth token connection was updated. For details, see [documentation](https://docs.yandex-team.ru/cloud/datalens/operations/connection/chyt/create-chyt).

#|
||Field | Description ||
|| additional_cluster | **string**

Backup cluster from the connection. ||
|| alias | **string**

Required field. CHYT clique alias. ||
|| cache_ttl_sec | **integer \| null** 

Cache time-to-live in seconds. ||
|| cluster | **string**

Required field. Cluster from the connection. ||
|| created_at | **string** 

Timestamp when the connection was created. ||
|| data_export_forbidden | **unknown** 

Indicates if data export is forbidden. ||
|| description | **string \| null** 

Description of the connection. ||
|| id | **string** 

Unique identifier of the connection. ||
|| key | **string**

Key used to identify the connection. Indicates the path and name of the connection. ||
|| meta | **object** (map<**string**, **unknown**>)

Metadata associated with the connection. ||
|| name | **string**

Required field. Name of the connection. ||
|| raw_sql_level | **enum**

Raw SQL level:

- `off` — The option is disabled.
- `subselect` — Allowed subqueries in datasets.
- `template` — Allowed subqueries in datasets and source parameterization.
- `dashsql` — Allowed subqueries in datasets, source parameterization, and QL charts. ||
|| token | **string**

Required field. OAuth token from the connection. ||
|| type | **ch_over_yt** (const) 

Type of the connection. ||
|| updated_at | **string** 

Timestamp when the connection was last updated. ||
|#

> When the CHYT with authentication as user connection was updated. For details, see [documentation](https://docs.yandex-team.ru/cloud/datalens/operations/connection/chyt/create-chyt).

#|
||Field | Description ||
|| additional_cluster | **string** 

Backup cluster from the connection. ||
|| alias | **string**

Required field. CHYT clique alias. ||
|| cache_ttl_sec | **integer \| null** 

Cache time-to-live in seconds. ||
|| cluster | **string**

Required field. Cluster from the connection. ||
|| created_at | **string** 

Timestamp when the connection was created. ||
|| data_export_forbidden | **unknown** 

Indicates if data export is forbidden. ||
|| description | **string \| null** 

Description of the connection. ||
|| id | **string** 

Unique identifier of the connection. ||
|| key | **string** 

Key used to identify the connection. Indicates the path and name of the connection. ||
|| meta | **object** (map<**string**, **unknown**>) 

Metadata associated with the connection. ||
|| name | **string**

Required field. Name of the connection. ||
|| raw_sql_level | **enum**

Raw SQL level:

- `off` — The option is disabled.
- `subselect` — Allowed subqueries in datasets.
- `template` — Allowed subqueries in datasets and source parameterization.
- `dashsql` — Allowed subqueries in datasets, source parameterization, and QL charts. ||
|| type | **ch_over_yt_user_auth** (const) 

Type of the connection. ||
|| updated_at | **string** 

Timestamp when the connection was last updated. ||
|#

> When the ClickHouse connection was updated. For details, see [documentation](https://docs.yandex-team.ru/cloud/datalens/operations/connection/create-clickhouse).

#|
||Field | Description ||
|| cache_ttl_sec | **integer \| null** 

Cache time-to-live in seconds. ||
|| connection_manager_cloud_id | **string \| null** 

ID of the cloud where the connection to the cluster was created in Connection Manager. ||
|| connection_manager_connection_id | **string \| null** 

Connection ID from Connection Manager. ||
|| connection_manager_delegation_is_set | **boolean \| null** 

Type of connection management. If true, connections are created automatically by a managed database cluster. Else connections are created by a user or a third-party service. ||
|| connection_manager_folder_id | **string \| null** 

ID of the folder where the connection to the cluster was created in Connection Manager. ||
|| created_at | **string**

Timestamp when the connection was created. ||
|| data_export_forbidden | **unknown** 

Indicates if data export is forbidden. ||
|| db_name | **string \| null** 

Database name. ||
|| description | **string \| null** 

Description of the connection. ||
|| host | **string**

Required field. Host name. ||
|| id | **string** 

Unique identifier of the connection. ||
|| key | **string** 

Key used to identify the connection. Indicates the path and name of the connection. ||
|| mdb_cluster_id | **string \| null** 

ID of the MDB cluster. ||
|| mdb_folder_id | **string \| null** 

ID of the MDB folder. ||
|| meta | **object** (map<**string**, **unknown**>) 

Metadata associated with the connection. ||
|| name | **string**

Required field. Name of the connection. ||
|| password | **string \| null** 

Password for the connection. ||
|| port | **integer**

Required field. Connection port. The default port is 8443. ||
|| raw_sql_level | **enum**

Raw SQL level:

- `off` — The option is disabled.
- `subselect` — Allowed subqueries in datasets.
- `template` — Allowed subqueries in datasets and source parameterization.
- `dashsql` — Allowed subqueries in datasets, source parameterization, and QL charts. ||
|| readonly | **integer** 

Read-only flag. ||
|| secure | **unknown** 

Secure connection flag. ||
|| ssl_ca | **unknown** 

SSL certificate authority. ||
|| type | **clickhouse** (const) 

Type of the connection. ||
|| updated_at | **string** 

Timestamp when the connection was last updated. ||
|| username | **string \| null** 

Username for the connection. ||
|#

> When the Greenplum connection was updated. For details, see [documentation](https://docs.yandex-team.ru/cloud/datalens/operations/connection/create-greenplum).

#|
||Field | Description ||
|| cache_ttl_sec | **integer \| null** 

Cache time-to-live in seconds. ||
|| created_at | **string** 

Timestamp when the connection was created. ||
|| data_export_forbidden | **unknown** 

Indicates if data export is forbidden. ||
|| db_name | **string \| null** 

Database name. ||
|| description | **string \| null** 

Description of the connection. ||
|| enforce_collate | **enum**

Mode of setting collate in a query:
- `auto` — Default setting is used, DataLens decides whether to enable the `en_US` locale.
- `on` — DataLens setting is used, the `en_US` locale is specified for individual expressions in a query.
- `off` — Applies the default setting. DataLens uses database-level locale settings. ||
|| host | **string**

Required field. Host name. ||
|| id | **string** 

Unique identifier of the connection. ||
|| key | **string** 

Key used to identify the connection. Indicates the path and name of the connection. ||
|| mdb_cluster_id | **string \| null** 

ID of the MDB cluster. ||
|| mdb_folder_id | **string \| null** 

ID of the MDB folder. ||
|| meta | **object** (map<**string**, **unknown**>) 

Metadata associated with the connection. ||
|| name | **string**

Required field. Name of the connection. ||
|| password | **string**

Required field. Password for the connection. ||
|| port | **integer**

Required field. Connection port. ||
|| raw_sql_level | **enum**

Raw SQL level:

- `off` — The option is disabled.
- `subselect` — Allowed subqueries in datasets.
- `template` — Allowed subqueries in datasets and source parameterization.
- `dashsql` — Allowed subqueries in datasets, source parameterization, and QL charts. ||
|| ssl_ca | **unknown** 

SSL certificate authority. ||
|| ssl_enable | **unknown** 

SSL flag. ||
|| type | **greenplum** (const) 

Type of the connection. ||
|| updated_at | **string** 

Timestamp when the connection was last updated. ||
|| username | **string**

Required field. Username for the connection. ||
|#

> When the Google Sheets connection was updated. For details, see [documentation](https://docs.yandex-team.ru/cloud/datalens/operations/connection/create-google-sheets).

#|
||Field | Description ||
|| cache_ttl_sec | **integer \| null** 

Cache time-to-live in seconds. ||
|| created_at | **string** 

Timestamp when the connection was created. ||
|| data_export_forbidden | **unknown** 

Indicates if data export is forbidden. ||
|| description | **string \| null** 

Description of the connection. ||
|| id | **string** 

Unique identifier of the connection. ||
|| key | **string** 

Key used to identify the connection. Indicates the path and name of the connection. ||
|| meta | **object** (map<**string**, **unknown**>) 

Metadata associated with the connection. ||
|| name | **string**

Required field. Name of the connection. ||
|| type | **gsheets** (const) 

Type of the connection. ||
|| updated_at | **string** 

Timestamp when the connection was last updated. ||
|| url | **string**

Required field. Path to the Google Sheets file. ||
|#

> When the API Connector connection was updated. For details, see [documentation](https://docs.yandex-team.ru/cloud/datalens/operations/connection/create-api-connector).

#|
||Field | Description ||
|| allowed_methods[] | **enum**

Required field. A method to send an HTTP request to the API. The available methods are:

- `GET`
- `POST` ||
|| created_at | **string** 

Timestamp when the connection was created. ||
|| description | **string \| null** 

Description of the connection. ||
|| host | **string**

Required field. Host name. ||
|| id | **string** 

Unique identifier of the connection. ||
|| key | **string** 

Key used to identify the connection. Indicates the path and name of the connection. ||
|| meta | **object** (map<**string**, **unknown**>) 

Metadata associated with the connection. ||
|| name | **string**

Required field. Name of the connection. ||
|| path | **string \| null** 

Path to the API (part of the URL without a protocol, host name, or port). ||
|| plain_headers | **object \| null** 

Public request headers represented by key-value pair. ||
|| port | **integer**

Required field. Connection port. ||
|| secret_headers | **object \| null** 

Private request headers represented by key-value pair. For private headers value will return `null`. ||
|| secure | **boolean** 

Secure connection flag. ||
|| tvm_dst_id | **integer \| null** 
ID for TVM authentication. ||
|| type | **json_api** (const) 

Type of the connection. ||
|| updated_at | **string** 

Timestamp when the connection was last updated. ||
|#

> When the Yandex Metrica API connection was updated. For details, see [documentation](https://docs.yandex-team.ru/cloud/datalens/operations/connection/create-api-connector).

#|
||Field | Description ||
|| accuracy | **number \| null** 

Accuracy of the metric data. ||
|| counter_id | **string**

Required field. AppMetrica counter (app) ID. ||
|| created_at | **string** 

Timestamp when the connection was created. ||
|| data_export_forbidden | **unknown** 

Indicates if data export is forbidden. ||
|| description | **string \| null** 

Description of the connection. ||
|| id | **string** 

Unique identifier of the connection. ||
|| key | **string** 

Key used to identify the connection. Indicates the path and name of the connection. ||
|| meta | **object** (map<**string**, **unknown**>) 

Metadata associated with the connection. ||
|| name | **string**

Required field. Name of the connection. ||
|| token | **string**

Required field. OAuth token from the connection. ||
|| type | **metrika_api** (const) 

Type of the connection. ||
|| updated_at | **string** 

Timestamp when the connection was last updated. ||
|#

> When the Microsoft SQL Server connection was updated. For details, see [documentation](https://docs.yandex-team.ru/cloud/datalens/operations/connection/create-mssql-server).

#|
||Field | Description ||
|| cache_ttl_sec | **integer \| null** 

Cache time-to-live in seconds. ||
|| created_at | **string** 

Timestamp when the connection was created. ||
|| data_export_forbidden | **unknown** 

Indicates if data export is forbidden. ||
|| db_name | **string \| null** 

Database name. ||
|| description | **string \| null** 

Description of the connection. ||
|| host | **string**

Required field. Host name. ||
|| id | **string** 

Unique identifier of the connection. ||
|| key | **string** 

Key used to identify the connection. Indicates the path and name of the connection. ||
|| meta | **object** (map<**string**, **unknown**>) 

Metadata associated with the connection. ||
|| name | **string**

Required field. Name of the connection. ||
|| password | **string**

Required field. Password for the connection. ||
|| port | **integer**

Required field. Connection port. ||
|| raw_sql_level | **enum**

Raw SQL level:

- `off` — The option is disabled.
- `subselect` — Allowed subqueries in datasets.
- `template` — Allowed subqueries in datasets and source parameterization.
- `dashsql` — Allowed subqueries in datasets, source parameterization, and QL charts. ||
|| type | **mssql** (const) 

Type of the connection. ||
|| updated_at | **string** 

Timestamp when the connection was last updated. ||
|| username | **string**

Required field. Username for the connection. ||
|#

> When the MySQL connection was updated. For details, see [documentation](https://docs.yandex-team.ru/cloud/datalens/operations/connection/create-mysql).

#|
||Field | Description ||
|| cache_ttl_sec | **integer \| null** 

Cache time-to-live in seconds. ||
|| connection_manager_cloud_id | **string \| null** 

ID of the cloud where the connection to the cluster was created in Connection Manager. ||
|| connection_manager_connection_id | **string \| null** 

Connection ID from Connection Manager. ||
|| connection_manager_delegation_is_set | **boolean \| null** 

Type of connection management. If true, connections are created automatically by a managed database cluster. Else connections are created by a user or a third-party service. ||
|| connection_manager_folder_id | **string \| null** 

ID of the folder where the connection to the cluster was created in Connection Manager. ||
|| created_at | **string** 

Timestamp when the connection was created. ||
|| data_export_forbidden | **unknown** 

Indicates if data export is forbidden. ||
|| db_name | **string \| null** 

Database name. ||
|| description | **string \| null** 

Description of the connection. ||
|| host | **string**

Required field. Host name. ||
|| id | **string** 

Unique identifier of the connection. ||
|| key | **string** 

Key used to identify the connection. Indicates the path and name of the connection. ||
|| mdb_cluster_id | **string \| null** 

ID of the MDB cluster. ||
|| mdb_folder_id | **string \| null** 

ID of the MDB folder. ||
|| meta | **object** (map<**string**, **unknown**>) 

Metadata associated with the connection. ||
|| name | **string**

Required field. Name of the connection. ||
|| password | **string \| null** 

Password for the connection. ||
|| port | **integer**

Required field. Connection port. ||
|| raw_sql_level | **enum**

Raw SQL level:

- `off` — The option is disabled.
- `subselect` — Allowed subqueries in datasets.
- `template` — Allowed subqueries in datasets and source parameterization.
- `dashsql` — Allowed subqueries in datasets, source parameterization, and QL charts. ||
|| ssl_ca | **unknown** 

SSL certificate authority. ||
|| ssl_enable | **unknown** 

SSL flag. ||
|| type | **mysql** (const) 

Type of the connection. ||
|| updated_at | **string** 

Timestamp when the connection was last updated. ||
|| username | **string \| null** 

Username for the connection. ||
|#

> When the Oracle connection was updated. For details, see [documentation](https://docs.yandex-team.ru/cloud/datalens/operations/connection/create-oracle).

#|
||Field | Description ||
|| cache_ttl_sec | **integer \| null** 

Cache time-to-live in seconds. ||
|| created_at | **string**

Timestamp when the connection was created. ||
|| data_export_forbidden | **unknown** 

Indicates if data export is forbidden. ||
|| db_connect_method | **enum**

Required field. Specified service name or the system ID of the database.

- `sid` — system ID.
- `service_name` — service name. ||
|| db_name | **string \| null** 

Database name. ||
|| description | **string \| null** 

Description of the connection. ||
|| host | **string**

Required field. Host name. ||
|| id | **string** 

Unique identifier of the connection. ||
|| key | **string** 

Key used to identify the connection. Indicates the path and name of the connection. ||
|| meta | **object** (map<**string**, **unknown**>) 

Metadata associated with the connection. ||
|| name | **string**

Required field. Name of the connection. ||
|| password | **string**

Required field. Password for the connection. ||
|| port | **integer**

Required field. Connection port. ||
|| raw_sql_level | **enum**

Raw SQL level:

- `off` — The option is disabled.
- `subselect` — Allowed subqueries in datasets.
- `template` — Allowed subqueries in datasets and source parameterization.
- `dashsql` — Allowed subqueries in datasets, source parameterization, and QL charts. ||
|| ssl_ca | **unknown** 

SSL certificate authority. ||
|| ssl_enable | **unknown** 

SSL flag. ||
|| type | **oracle** (const) 

Type of the connection. ||
|| updated_at | **string** 

Timestamp when the connection was last updated. ||
|| username | **string**

Required field. Username for the connection. ||
|#

> When the PostgreSQL connection was updated. For details, see [documentation](https://docs.yandex-team.ru/cloud/datalens/operations/connection/create-postgresql).

#|
||Field | Description ||
|| cache_ttl_sec | **integer \| null** 

Cache time-to-live in seconds. ||
|| connection_manager_cloud_id | **string \| null** 

ID of the cloud where the connection to the cluster was created in Connection Manager. ||
|| connection_manager_connection_id | **string \| null** 

Connection ID from Connection Manager. ||
|| connection_manager_delegation_is_set | **boolean \| null** 

Type of connection management. If true, connections are created automatically by a managed database cluster. Else connections are created by a user or a third-party service. ||
|| connection_manager_folder_id | **string \| null** 

ID of the folder where the connection to the cluster was created in Connection Manager. ||
|| created_at | **string** 

Timestamp when the connection was created. ||
|| data_export_forbidden | **unknown** 

Indicates if data export is forbidden. ||
|| db_name | **string \| null** 

Database name. ||
|| description | **string \| null** 

Description of the connection. ||
|| enforce_collate | **enum**

Mode of setting collate in a query:
- `auto` — Default setting is used, DataLens decides whether to enable the `en_US` locale.
- `on` — DataLens setting is used, the `en_US` locale is specified for individual expressions in a query.
- `off` — Applies the default setting. DataLens uses database-level locale settings. ||
|| host | **string**

Required field. Host name. ||
|| id | **string** 

Unique identifier of the connection. ||
|| key | **string** 

Key used to identify the connection. Indicates the path and name of the connection. ||
|| mdb_cluster_id | **string \| null** 

ID of the MDB cluster. ||
|| mdb_folder_id | **string \| null** 

ID of the MDB folder. ||
|| meta | **object** (map<**string**, **unknown**>) 

Metadata associated with the connection. ||
|| name | **string**

Required field. Name of the connection. ||
|| password | **string \| null** 

Password for the connection. ||
|| port | **integer**

Required field. Connection port. ||
|| raw_sql_level | **enum**

Raw SQL level:

- `off` — The option is disabled.
- `subselect` — Allowed subqueries in datasets.
- `template` — Allowed subqueries in datasets and source parameterization.
- `dashsql` — Allowed subqueries in datasets, source parameterization, and QL charts. ||
|| ssl_ca | **unknown** 

SSL certificate authority. ||
|| ssl_enable | **unknown** 

SSL flag. ||
|| type | **postgres** (const) 

Type of the connection. ||
|| updated_at | **string** 

Timestamp when the connection was last updated. ||
|| username | **string \| null** 

Username for the connection. ||
|#

> When the Prometheus connection was updated. For details, see [documentation](https://docs.yandex-team.ru/cloud/datalens/operations/connection/create-prometheus).

#|
||Field | Description ||
|| cache_ttl_sec | **integer \| null** 

Cache time-to-live in seconds. ||
|| created_at | **string** 

Timestamp when the connection was created. ||
|| data_export_forbidden | **unknown** 

Indicates if data export is forbidden. ||
|| db_name | **string \| null** 

Database name. ||
|| description | **string \| null** 

Description of the connection. ||
|| host | **string**

Required field. Host name. ||
|| id | **string** 

Unique identifier of the connection. ||
|| key | **string** 

Key used to identify the connection. Indicates the path and name of the connection. ||
|| meta | **object** (map<**string**, **unknown**>) 

Metadata associated with the connection. ||
|| name | **string**

Required field. Name of the connection. ||
|| password | **string \| null** 

Password for the connection. ||
|| path | **string \| null** ||
|| port | **integer**

Required field. Connection port. ||
|| secure | **boolean** 

Secure connection flag. ||
|| type | **promql** (const) 

Type of the connection. ||
|| updated_at | **string** 

Timestamp when the connection was last updated. ||
|| username | **string \| null** 

Username for the connection. ||
|#


> When the Usage Tracking connection was updated. For details, see [documentation](https://docs.yandex-team.ru/cloud/datalens/concepts/datalens-usage-analytics).

#|
||Field | Description ||
|| created_at | **string** 

Timestamp when the connection was created. ||
|| description | **string \| null** 

Description of the connection. ||
|| id | **string** 

Unique identifier of the connection. ||
|| key | **string** 

Key used to identify the connection. Indicates the path and name of the connection. ||
|| meta | **object** (map<**string**, **unknown**>) 

Metadata associated with the connection. ||
|| name | **string**

Required field. Name of the connection. ||
|| type | **usage_tracking_ya_team** (const) 

Type of the connection. ||
|| updated_at | **string** 

Timestamp when the connection was last updated. ||
|#

> When the YDB connection was updated. For details, see [documentation](https://docs.yandex-team.ru/cloud/datalens/operations/connection/create-ydb).

#|
||Field | Description ||
|| auth_type | **enum**

Authentication type:
- `anonymous` — anonymously.
- `password` — with password.
- `oauth` — with OAuth token.
- `null` — not specified. ||
|| cache_ttl_sec | **integer \| null** 

Cache time-to-live in seconds. ||
|| created_at | **string** 

Timestamp when the connection was created. ||
|| data_export_forbidden | **unknown** 

Indicates if data export is forbidden. ||
|| db_name | **string**

Required field. Database name. ||
|| description | **string \| null** 

Description of the connection. ||
|| host | **string**

Required field. Host name. ||
|| id | **string** 

Unique identifier of the connection. ||
|| key | **string** 

Key used to identify the connection. Indicates the path and name of the connection. ||
|| name | **string**

Required field. Name of the connection. ||
|| port | **integer**

Required field. Connection port. ||
|| raw_sql_level | **enum**

Raw SQL level:

- `off` — The option is disabled.
- `subselect` — Allowed subqueries in datasets.
- `template` — Allowed subqueries in datasets and source parameterization.
- `dashsql` — Allowed subqueries in datasets, source parameterization, and QL charts. ||
|| ssl_ca | **unknown** 

SSL certificate authority. ||
|| ssl_enable | **unknown** 

SSL flag. ||
|| token | **string \| null** 

OAuth token from the connection. ||
|| type | **ydb** (const) 

Type of the connection. ||
|| updated_at | **string** 

Timestamp when the connection was last updated. ||
|| username | **string \| null** 

Username for the connection. ||
|#

> When something went wrong and the connection was not updated.

#|
||Field | Description ||
|| Empty | > ||
|#