---
editable: false
---

# DataLens API: Update connection

## HTTP request

```
POST https://api.datalens.tech/rpc/updateConnection
```

## Body parameters

**Request schema: application/json**

```json
{
  "connectionId": "string",
  "data": {
    "<oneOf>": [
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
      {
        "cache_ttl_sec": "integer | null",
        "created_at": "string",
        "credentials": "string",
        "description": "string | null",
        "id": "string",
        "key": "string",
        "project_id": "string",
        "raw_sql_level": "string",
        "updated_at": "string",
        "workbook_id": "string | null"
      },
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
        "portal": "string",
        "token": "string",
        "updated_at": "string",
        "workbook_id": "string | null"
      },
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
      {
        "created_at": "string",
        "description": "string | null",
        "id": "string",
        "key": "string",
        "raw_sql_level": "string",
        "updated_at": "string",
        "workbook_id": "string | null"
      },
      {
        "created_at": "string",
        "description": "string | null",
        "id": "string",
        "key": "string",
        "raw_sql_level": "string",
        "updated_at": "string",
        "workbook_id": "string | null"
      },
      {
        "created_at": "string",
        "description": "string | null",
        "id": "string",
        "key": "string",
        "raw_sql_level": "string",
        "updated_at": "string",
        "workbook_id": "string | null"
      },
      {
        "created_at": "string",
        "description": "string | null",
        "id": "string",
        "key": "string",
        "raw_sql_level": "string",
        "updated_at": "string",
        "workbook_id": "string | null"
      },
      {
        "created_at": "string",
        "description": "string | null",
        "id": "string",
        "key": "string",
        "raw_sql_level": "string",
        "updated_at": "string",
        "workbook_id": "string | null"
      },
      {
        "created_at": "string",
        "description": "string | null",
        "id": "string",
        "key": "string",
        "raw_sql_level": "string",
        "updated_at": "string",
        "workbook_id": "string | null"
      },
      {
        "created_at": "string",
        "description": "string | null",
        "id": "string",
        "key": "string",
        "raw_sql_level": "string",
        "updated_at": "string",
        "workbook_id": "string | null"
      },
      {
        "created_at": "string",
        "description": "string | null",
        "id": "string",
        "key": "string",
        "raw_sql_level": "string",
        "updated_at": "string",
        "workbook_id": "string | null"
      },
      {
        "created_at": "string",
        "description": "string | null",
        "id": "string",
        "key": "string",
        "raw_sql_level": "string",
        "updated_at": "string",
        "workbook_id": "string | null"
      },
      {
        "created_at": "string",
        "description": "string | null",
        "id": "string",
        "key": "string",
        "meta": {
          "string": "unknown"
        },
        "mp_product_id": "string",
        "updated_at": "string",
        "workbook_id": "string | null"
      },
      {
        "created_at": "string",
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
      {
        "alias": "string",
        "cache_ttl_sec": "integer | null",
        "created_at": "string",
        "data_export_forbidden": "unknown",
        "description": "string | null",
        "host": "string",
        "id": "string",
        "key": "string",
        "meta": {
          "string": "unknown"
        },
        "port": "integer",
        "raw_sql_level": "string",
        "secure": "boolean",
        "token": "string",
        "updated_at": "string",
        "workbook_id": "string | null"
      },
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
      {
        "access_token": "string",
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
      {
        "access_token": "string",
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
        "updated_at": "string",
        "workbook_id": "string | null"
      },
      {
        "access_token": "string",
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
      {
        "cache_ttl_sec": "integer | null",
        "cloud_id": "string | null",
        "created_at": "string",
        "delegation_is_set": "boolean | null",
        "description": "string | null",
        "folder_id": "string",
        "id": "string",
        "key": "string",
        "meta": {
          "string": "unknown"
        },
        "service_account_id": "string",
        "updated_at": "string",
        "workbook_id": "string | null"
      },
      {
        "access_token": "string",
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
      {
        "created_at": "string",
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
      {
        "account_name": "string",
        "client_id": "string",
        "client_secret": "string",
        "created_at": "string",
        "data_export_forbidden": "unknown",
        "db_name": "string",
        "description": "string | null",
        "id": "string",
        "key": "string",
        "raw_sql_level": "string",
        "refresh_token": "string",
        "refresh_token_expire_time": "string | null",
        "schema": "string",
        "updated_at": "string",
        "user_name": "string",
        "user_role": "string | null",
        "warehouse": "string",
        "workbook_id": "string | null"
      },
      {
        "created_at": "string",
        "data_export_forbidden": "unknown",
        "description": "string | null",
        "id": "string",
        "key": "string",
        "meta": {
          "string": "unknown"
        },
        "project_id": "string",
        "updated_at": "string",
        "workbook_id": "string | null"
      },
      {
        "auth_type": "unknown",
        "cache_ttl_sec": "integer | null",
        "cloud_id": "string | null",
        "created_at": "string",
        "data_export_forbidden": "unknown",
        "db_name": "string | null",
        "delegation_is_set": "boolean | null",
        "description": "string | null",
        "folder_id": "string | null",
        "host": "string",
        "id": "string",
        "jwt": "string | null",
        "key": "string",
        "listing_sources": "unknown",
        "mdb_cluster_id": "string | null",
        "meta": {
          "string": "unknown"
        },
        "password": "string | null",
        "port": "integer | null",
        "raw_sql_level": "string",
        "service_account_id": "string | null",
        "ssl_ca": "unknown",
        "ssl_enable": "unknown",
        "updated_at": "string",
        "username": "string | null",
        "workbook_id": "string | null"
      },
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
      {
        "auth_type": "string | null",
        "cache_ttl_sec": "integer | null",
        "cloud_id": "string | null",
        "created_at": "string",
        "data_export_forbidden": "unknown",
        "db_name": "string",
        "delegation_is_set": "boolean | null",
        "description": "string | null",
        "folder_id": "string",
        "host": "string",
        "id": "string",
        "key": "string",
        "mdb_cluster_id": "string | null",
        "mdb_folder_id": "string | null",
        "port": "integer",
        "raw_sql_level": "string",
        "service_account_id": "string",
        "ssl_ca": "unknown",
        "ssl_enable": "unknown",
        "token": "string | null",
        "updated_at": "string",
        "username": "string | null",
        "workbook_id": "string | null"
      },
      {
        "cache_ttl_sec": "integer | null",
        "cloud_id": "string | null",
        "created_at": "string",
        "data_export_forbidden": "unknown",
        "delegation_is_set": "boolean | null",
        "description": "string | null",
        "folder_id": "string",
        "id": "string",
        "key": "string",
        "raw_sql_level": "string",
        "service_account_id": "string",
        "updated_at": "string",
        "workbook_id": "string | null"
      }
    ]
  }
}
```

#|
||Field | Description ||
|| connectionId | **string**

Required field.  ||
|| data | One of **[appmetrica_api2](#appmetrica_api2)** \| **[bigquery2](#bigquery2)** \| **[bitrix242](#bitrix242)** \| **[ch_billing_analytics2](#ch_billing_analytics2)** \| **[ch_frozen_bumpy_roads2](#ch_frozen_bumpy_roads2)** \| **[ch_frozen_covid2](#ch_frozen_covid2)** \| **[ch_frozen_demo2](#ch_frozen_demo2)** \| **[ch_frozen_dtp2](#ch_frozen_dtp2)** \| **[ch_frozen_gkh2](#ch_frozen_gkh2)** \| **[ch_frozen_horeca2](#ch_frozen_horeca2)** \| **[ch_frozen_samples2](#ch_frozen_samples2)** \| **[ch_frozen_transparency2](#ch_frozen_transparency2)** \| **[ch_frozen_weather2](#ch_frozen_weather2)** \| **[ch_geo_filtered2](#ch_geo_filtered2)** \| **[ch_ya_music_podcast_stats2](#ch_ya_music_podcast_stats2)** \| **[chyt2](#chyt2)** \| **[clickhouse2](#clickhouse2)** \| **[equeo2](#equeo2)** \| **[extractor1c2](#extractor1c2)** \| **[greenplum2](#greenplum2)** \| **[gsheets2](#gsheets2)** \| **[json_api2](#json_api2)** \| **[kontur_market2](#kontur_market2)** \| **[metrika_api2](#metrika_api2)** \| **[monitoring2](#monitoring2)** \| **[moysklad2](#moysklad2)** \| **[mssql2](#mssql2)** \| **[mysql2](#mysql2)** \| **[oracle2](#oracle2)** \| **[postgres2](#postgres2)** \| **[promql2](#promql2)** \| **[smb_heatmaps2](#smb_heatmaps2)** \| **[snowflake2](#snowflake2)** \| **[speechsense2](#speechsense2)** \| **[trino2](#trino2)** \| **[usage_analytics_detailed2](#usage_analytics_detailed2)** \| **[usage_analytics_light2](#usage_analytics_light2)** \| **[ydb2](#ydb2)** \| **[yq2](#yq2)** ||
|#

## appmetrica_api2 {#appmetrica_api2}

#|
||Field | Description ||
|| accuracy | **number \| null** ||
|| counter_id | **string**

Required field.  ||
|| created_at | **string** ||
|| data_export_forbidden | **unknown** ||
|| description | **string \| null** ||
|| id | **string** ||
|| key | **string** ||
|| meta | **object** (map<**string**, **unknown**>) ||
|| token | **string**

Required field.  ||
|| updated_at | **string** ||
|| workbook_id | **string \| null** ||
|#

## bigquery2 {#bigquery2}

#|
||Field | Description ||
|| cache_ttl_sec | **integer \| null** ||
|| created_at | **string** ||
|| credentials | **string**

Required field.  ||
|| description | **string \| null** ||
|| id | **string** ||
|| key | **string** ||
|| project_id | **string**

Required field.  ||
|| raw_sql_level | **enum**

- `off`
- `subselect`
- `template`
- `dashsql` ||
|| updated_at | **string** ||
|| workbook_id | **string \| null** ||
|#

## bitrix242 {#bitrix242}

#|
||Field | Description ||
|| cache_ttl_sec | **integer \| null** ||
|| created_at | **string** ||
|| data_export_forbidden | **unknown** ||
|| description | **string \| null** ||
|| id | **string** ||
|| key | **string** ||
|| meta | **object** (map<**string**, **unknown**>) ||
|| portal | **string**

Required field.  ||
|| token | **string**

Required field.  ||
|| updated_at | **string** ||
|| workbook_id | **string \| null** ||
|#

## ch_billing_analytics2 {#ch_billing_analytics2}

#|
||Field | Description ||
|| created_at | **string** ||
|| description | **string \| null** ||
|| id | **string** ||
|| key | **string** ||
|| meta | **object** (map<**string**, **unknown**>) ||
|| updated_at | **string** ||
|| workbook_id | **string \| null** ||
|#

## ch_frozen_bumpy_roads2 {#ch_frozen_bumpy_roads2}

#|
||Field | Description ||
|| created_at | **string** ||
|| description | **string \| null** ||
|| id | **string** ||
|| key | **string** ||
|| raw_sql_level | **enum**

- `off`
- `subselect`
- `template`
- `dashsql` ||
|| updated_at | **string** ||
|| workbook_id | **string \| null** ||
|#

## ch_frozen_covid2 {#ch_frozen_covid2}

#|
||Field | Description ||
|| created_at | **string** ||
|| description | **string \| null** ||
|| id | **string** ||
|| key | **string** ||
|| raw_sql_level | **enum**

- `off`
- `subselect`
- `template`
- `dashsql` ||
|| updated_at | **string** ||
|| workbook_id | **string \| null** ||
|#

## ch_frozen_demo2 {#ch_frozen_demo2}

#|
||Field | Description ||
|| created_at | **string** ||
|| description | **string \| null** ||
|| id | **string** ||
|| key | **string** ||
|| raw_sql_level | **enum**

- `off`
- `subselect`
- `template`
- `dashsql` ||
|| updated_at | **string** ||
|| workbook_id | **string \| null** ||
|#

## ch_frozen_dtp2 {#ch_frozen_dtp2}

#|
||Field | Description ||
|| created_at | **string** ||
|| description | **string \| null** ||
|| id | **string** ||
|| key | **string** ||
|| raw_sql_level | **enum**

- `off`
- `subselect`
- `template`
- `dashsql` ||
|| updated_at | **string** ||
|| workbook_id | **string \| null** ||
|#

## ch_frozen_gkh2 {#ch_frozen_gkh2}

#|
||Field | Description ||
|| created_at | **string** ||
|| description | **string \| null** ||
|| id | **string** ||
|| key | **string** ||
|| raw_sql_level | **enum**

- `off`
- `subselect`
- `template`
- `dashsql` ||
|| updated_at | **string** ||
|| workbook_id | **string \| null** ||
|#

## ch_frozen_horeca2 {#ch_frozen_horeca2}

#|
||Field | Description ||
|| created_at | **string** ||
|| description | **string \| null** ||
|| id | **string** ||
|| key | **string** ||
|| raw_sql_level | **enum**

- `off`
- `subselect`
- `template`
- `dashsql` ||
|| updated_at | **string** ||
|| workbook_id | **string \| null** ||
|#

## ch_frozen_samples2 {#ch_frozen_samples2}

#|
||Field | Description ||
|| created_at | **string** ||
|| description | **string \| null** ||
|| id | **string** ||
|| key | **string** ||
|| raw_sql_level | **enum**

- `off`
- `subselect`
- `template`
- `dashsql` ||
|| updated_at | **string** ||
|| workbook_id | **string \| null** ||
|#

## ch_frozen_transparency2 {#ch_frozen_transparency2}

#|
||Field | Description ||
|| created_at | **string** ||
|| description | **string \| null** ||
|| id | **string** ||
|| key | **string** ||
|| raw_sql_level | **enum**

- `off`
- `subselect`
- `template`
- `dashsql` ||
|| updated_at | **string** ||
|| workbook_id | **string \| null** ||
|#

## ch_frozen_weather2 {#ch_frozen_weather2}

#|
||Field | Description ||
|| created_at | **string** ||
|| description | **string \| null** ||
|| id | **string** ||
|| key | **string** ||
|| raw_sql_level | **enum**

- `off`
- `subselect`
- `template`
- `dashsql` ||
|| updated_at | **string** ||
|| workbook_id | **string \| null** ||
|#

## ch_geo_filtered2 {#ch_geo_filtered2}

#|
||Field | Description ||
|| created_at | **string** ||
|| description | **string \| null** ||
|| id | **string** ||
|| key | **string** ||
|| meta | **object** (map<**string**, **unknown**>) ||
|| mp_product_id | **string** ||
|| updated_at | **string** ||
|| workbook_id | **string \| null** ||
|#

## ch_ya_music_podcast_stats2 {#ch_ya_music_podcast_stats2}

#|
||Field | Description ||
|| created_at | **string** ||
|| description | **string \| null** ||
|| id | **string** ||
|| key | **string** ||
|| meta | **object** (map<**string**, **unknown**>) ||
|| token | **string**

Required field.  ||
|| updated_at | **string** ||
|| workbook_id | **string \| null** ||
|#

## chyt2 {#chyt2}

#|
||Field | Description ||
|| alias | **string**

Required field.  ||
|| cache_ttl_sec | **integer \| null** ||
|| created_at | **string** ||
|| data_export_forbidden | **unknown** ||
|| description | **string \| null** ||
|| host | **string**

Required field.  ||
|| id | **string** ||
|| key | **string** ||
|| meta | **object** (map<**string**, **unknown**>) ||
|| port | **integer**

Required field.  ||
|| raw_sql_level | **enum**

- `off`
- `subselect`
- `template`
- `dashsql` ||
|| secure | **boolean** ||
|| token | **string**

Required field.  ||
|| updated_at | **string** ||
|| workbook_id | **string \| null** ||
|#

## clickhouse2 {#clickhouse2}

#|
||Field | Description ||
|| cache_ttl_sec | **integer \| null** ||
|| connection_manager_cloud_id | **string \| null** ||
|| connection_manager_connection_id | **string \| null** ||
|| connection_manager_delegation_is_set | **boolean \| null** ||
|| connection_manager_folder_id | **string \| null** ||
|| created_at | **string** ||
|| data_export_forbidden | **unknown** ||
|| db_name | **string \| null** ||
|| description | **string \| null** ||
|| host | **string**

Required field.  ||
|| id | **string** ||
|| key | **string** ||
|| mdb_cluster_id | **string \| null** ||
|| mdb_folder_id | **string \| null** ||
|| meta | **object** (map<**string**, **unknown**>) ||
|| password | **string \| null** ||
|| port | **integer**

Required field.  ||
|| raw_sql_level | **enum**

- `off`
- `subselect`
- `template`
- `dashsql` ||
|| readonly | **integer** ||
|| secure | **unknown** ||
|| ssl_ca | **unknown** ||
|| updated_at | **string** ||
|| username | **string \| null** ||
|| workbook_id | **string \| null** ||
|#

## equeo2 {#equeo2}

#|
||Field | Description ||
|| access_token | **string**

Required field.  ||
|| created_at | **string** ||
|| description | **string \| null** ||
|| id | **string** ||
|| key | **string** ||
|| meta | **object** (map<**string**, **unknown**>) ||
|| updated_at | **string** ||
|| workbook_id | **string \| null** ||
|#

## extractor1c2 {#extractor1c2}

#|
||Field | Description ||
|| access_token | **string**

Required field.  ||
|| created_at | **string** ||
|| description | **string \| null** ||
|| id | **string** ||
|| key | **string** ||
|| meta | **object** (map<**string**, **unknown**>) ||
|| updated_at | **string** ||
|| workbook_id | **string \| null** ||
|#

## greenplum2 {#greenplum2}

#|
||Field | Description ||
|| cache_ttl_sec | **integer \| null** ||
|| created_at | **string** ||
|| data_export_forbidden | **unknown** ||
|| db_name | **string \| null** ||
|| description | **string \| null** ||
|| enforce_collate | **enum**

- `auto`
- `on`
- `off` ||
|| host | **string**

Required field.  ||
|| id | **string** ||
|| key | **string** ||
|| mdb_cluster_id | **string \| null** ||
|| mdb_folder_id | **string \| null** ||
|| meta | **object** (map<**string**, **unknown**>) ||
|| password | **string**

Required field.  ||
|| port | **integer**

Required field.  ||
|| raw_sql_level | **enum**

- `off`
- `subselect`
- `template`
- `dashsql` ||
|| ssl_ca | **unknown** ||
|| ssl_enable | **unknown** ||
|| updated_at | **string** ||
|| username | **string**

Required field.  ||
|| workbook_id | **string \| null** ||
|#

## gsheets2 {#gsheets2}

#|
||Field | Description ||
|| cache_ttl_sec | **integer \| null** ||
|| created_at | **string** ||
|| data_export_forbidden | **unknown** ||
|| description | **string \| null** ||
|| id | **string** ||
|| key | **string** ||
|| meta | **object** (map<**string**, **unknown**>) ||
|| updated_at | **string** ||
|| url | **string**

Required field.  ||
|| workbook_id | **string \| null** ||
|#

## json_api2 {#json_api2}

#|
||Field | Description ||
|| allowed_methods[] | **enum**

Required field. 

- `GET`
- `POST` ||
|| created_at | **string** ||
|| description | **string \| null** ||
|| host | **string**

Required field.  ||
|| id | **string** ||
|| key | **string** ||
|| meta | **object** (map<**string**, **unknown**>) ||
|| path | **string \| null** ||
|| plain_headers | **object \| null** ||
|| port | **integer**

Required field.  ||
|| secret_headers | **object \| null** ||
|| secure | **boolean** ||
|| updated_at | **string** ||
|| workbook_id | **string \| null** ||
|#

## kontur_market2 {#kontur_market2}

#|
||Field | Description ||
|| access_token | **string**

Required field.  ||
|| created_at | **string** ||
|| description | **string \| null** ||
|| id | **string** ||
|| key | **string** ||
|| meta | **object** (map<**string**, **unknown**>) ||
|| updated_at | **string** ||
|| workbook_id | **string \| null** ||
|#

## metrika_api2 {#metrika_api2}

#|
||Field | Description ||
|| accuracy | **number \| null** ||
|| counter_id | **string**

Required field.  ||
|| created_at | **string** ||
|| data_export_forbidden | **unknown** ||
|| description | **string \| null** ||
|| id | **string** ||
|| key | **string** ||
|| meta | **object** (map<**string**, **unknown**>) ||
|| token | **string**

Required field.  ||
|| updated_at | **string** ||
|| workbook_id | **string \| null** ||
|#

## monitoring2 {#monitoring2}

#|
||Field | Description ||
|| cache_ttl_sec | **integer \| null** ||
|| cloud_id | **string \| null**

Required field.  ||
|| created_at | **string** ||
|| delegation_is_set | **boolean \| null** ||
|| description | **string \| null** ||
|| folder_id | **string**

Required field.  ||
|| id | **string** ||
|| key | **string** ||
|| meta | **object** (map<**string**, **unknown**>) ||
|| service_account_id | **string**

Required field.  ||
|| updated_at | **string** ||
|| workbook_id | **string \| null** ||
|#

## moysklad2 {#moysklad2}

#|
||Field | Description ||
|| access_token | **string**

Required field.  ||
|| created_at | **string** ||
|| description | **string \| null** ||
|| id | **string** ||
|| key | **string** ||
|| meta | **object** (map<**string**, **unknown**>) ||
|| updated_at | **string** ||
|| workbook_id | **string \| null** ||
|#

## mssql2 {#mssql2}

#|
||Field | Description ||
|| cache_ttl_sec | **integer \| null** ||
|| created_at | **string** ||
|| data_export_forbidden | **unknown** ||
|| db_name | **string \| null** ||
|| description | **string \| null** ||
|| host | **string**

Required field.  ||
|| id | **string** ||
|| key | **string** ||
|| meta | **object** (map<**string**, **unknown**>) ||
|| password | **string**

Required field.  ||
|| port | **integer**

Required field.  ||
|| raw_sql_level | **enum**

- `off`
- `subselect`
- `template`
- `dashsql` ||
|| updated_at | **string** ||
|| username | **string**

Required field.  ||
|| workbook_id | **string \| null** ||
|#

## mysql2 {#mysql2}

#|
||Field | Description ||
|| cache_ttl_sec | **integer \| null** ||
|| connection_manager_cloud_id | **string \| null** ||
|| connection_manager_connection_id | **string \| null** ||
|| connection_manager_delegation_is_set | **boolean \| null** ||
|| connection_manager_folder_id | **string \| null** ||
|| created_at | **string** ||
|| data_export_forbidden | **unknown** ||
|| db_name | **string \| null** ||
|| description | **string \| null** ||
|| host | **string**

Required field.  ||
|| id | **string** ||
|| key | **string** ||
|| mdb_cluster_id | **string \| null** ||
|| mdb_folder_id | **string \| null** ||
|| meta | **object** (map<**string**, **unknown**>) ||
|| password | **string \| null** ||
|| port | **integer**

Required field.  ||
|| raw_sql_level | **enum**

- `off`
- `subselect`
- `template`
- `dashsql` ||
|| ssl_ca | **unknown** ||
|| ssl_enable | **unknown** ||
|| updated_at | **string** ||
|| username | **string \| null** ||
|| workbook_id | **string \| null** ||
|#

## oracle2 {#oracle2}

#|
||Field | Description ||
|| cache_ttl_sec | **integer \| null** ||
|| created_at | **string** ||
|| data_export_forbidden | **unknown** ||
|| db_connect_method | **enum**

Required field. 

- `sid`
- `service_name` ||
|| db_name | **string \| null** ||
|| description | **string \| null** ||
|| host | **string**

Required field.  ||
|| id | **string** ||
|| key | **string** ||
|| meta | **object** (map<**string**, **unknown**>) ||
|| password | **string**

Required field.  ||
|| port | **integer**

Required field.  ||
|| raw_sql_level | **enum**

- `off`
- `subselect`
- `template`
- `dashsql` ||
|| ssl_ca | **unknown** ||
|| ssl_enable | **unknown** ||
|| updated_at | **string** ||
|| username | **string**

Required field.  ||
|| workbook_id | **string \| null** ||
|#

## postgres2 {#postgres2}

#|
||Field | Description ||
|| cache_ttl_sec | **integer \| null** ||
|| connection_manager_cloud_id | **string \| null** ||
|| connection_manager_connection_id | **string \| null** ||
|| connection_manager_delegation_is_set | **boolean \| null** ||
|| connection_manager_folder_id | **string \| null** ||
|| created_at | **string** ||
|| data_export_forbidden | **unknown** ||
|| db_name | **string \| null** ||
|| description | **string \| null** ||
|| enforce_collate | **enum**

- `auto`
- `on`
- `off` ||
|| host | **string**

Required field.  ||
|| id | **string** ||
|| key | **string** ||
|| mdb_cluster_id | **string \| null** ||
|| mdb_folder_id | **string \| null** ||
|| meta | **object** (map<**string**, **unknown**>) ||
|| password | **string \| null** ||
|| port | **integer**

Required field.  ||
|| raw_sql_level | **enum**

- `off`
- `subselect`
- `template`
- `dashsql` ||
|| ssl_ca | **unknown** ||
|| ssl_enable | **unknown** ||
|| updated_at | **string** ||
|| username | **string \| null** ||
|| workbook_id | **string \| null** ||
|#

## promql2 {#promql2}

#|
||Field | Description ||
|| cache_ttl_sec | **integer \| null** ||
|| created_at | **string** ||
|| data_export_forbidden | **unknown** ||
|| db_name | **string \| null** ||
|| description | **string \| null** ||
|| host | **string**

Required field.  ||
|| id | **string** ||
|| key | **string** ||
|| meta | **object** (map<**string**, **unknown**>) ||
|| password | **string \| null** ||
|| path | **string \| null** ||
|| port | **integer**

Required field.  ||
|| secure | **boolean** ||
|| updated_at | **string** ||
|| username | **string \| null** ||
|| workbook_id | **string \| null** ||
|#

## smb_heatmaps2 {#smb_heatmaps2}

#|
||Field | Description ||
|| created_at | **string** ||
|| description | **string \| null** ||
|| id | **string** ||
|| key | **string** ||
|| meta | **object** (map<**string**, **unknown**>) ||
|| token | **string**

Required field.  ||
|| updated_at | **string** ||
|| workbook_id | **string \| null** ||
|#

## snowflake2 {#snowflake2}

#|
||Field | Description ||
|| account_name | **string**

Required field.  ||
|| client_id | **string**

Required field.  ||
|| client_secret | **string**

Required field.  ||
|| created_at | **string** ||
|| data_export_forbidden | **unknown** ||
|| db_name | **string**

Required field.  ||
|| description | **string \| null** ||
|| id | **string** ||
|| key | **string** ||
|| raw_sql_level | **enum**

- `off`
- `subselect`
- `template`
- `dashsql` ||
|| refresh_token | **string** ||
|| refresh_token_expire_time | **string \| null** (date-time) ||
|| schema | **string**

Required field.  ||
|| updated_at | **string** ||
|| user_name | **string**

Required field.  ||
|| user_role | **string \| null** ||
|| warehouse | **string**

Required field.  ||
|| workbook_id | **string \| null** ||
|#

## speechsense2 {#speechsense2}

#|
||Field | Description ||
|| created_at | **string** ||
|| data_export_forbidden | **unknown** ||
|| description | **string \| null** ||
|| id | **string** ||
|| key | **string** ||
|| meta | **object** (map<**string**, **unknown**>) ||
|| project_id | **string**

Required field.  ||
|| updated_at | **string** ||
|| workbook_id | **string \| null** ||
|#

## trino2 {#trino2}

#|
||Field | Description ||
|| auth_type | **unknown** ||
|| cache_ttl_sec | **integer \| null** ||
|| cloud_id | **string \| null** ||
|| created_at | **string** ||
|| data_export_forbidden | **unknown** ||
|| db_name | **string \| null** ||
|| delegation_is_set | **boolean \| null** ||
|| description | **string \| null** ||
|| folder_id | **string \| null** ||
|| host | **string**

Required field.  ||
|| id | **string** ||
|| jwt | **string \| null** ||
|| key | **string** ||
|| listing_sources | **unknown**

Required field.  ||
|| mdb_cluster_id | **string \| null** ||
|| meta | **object** (map<**string**, **unknown**>) ||
|| password | **string \| null** ||
|| port | **integer \| null** ||
|| raw_sql_level | **enum**

- `off`
- `subselect`
- `template`
- `dashsql` ||
|| service_account_id | **string \| null** ||
|| ssl_ca | **unknown** ||
|| ssl_enable | **unknown** ||
|| updated_at | **string** ||
|| username | **string \| null** ||
|| workbook_id | **string \| null** ||
|#

## usage_analytics_detailed2 {#usage_analytics_detailed2}

#|
||Field | Description ||
|| created_at | **string** ||
|| description | **string \| null** ||
|| id | **string** ||
|| key | **string** ||
|| meta | **object** (map<**string**, **unknown**>) ||
|| updated_at | **string** ||
|| workbook_id | **string \| null** ||
|#

## usage_analytics_light2 {#usage_analytics_light2}

#|
||Field | Description ||
|| created_at | **string** ||
|| description | **string \| null** ||
|| id | **string** ||
|| key | **string** ||
|| meta | **object** (map<**string**, **unknown**>) ||
|| updated_at | **string** ||
|| workbook_id | **string \| null** ||
|#

## ydb2 {#ydb2}

#|
||Field | Description ||
|| auth_type | **enum**

- `anonymous`
- `password`
- `oauth`
- `null` ||
|| cache_ttl_sec | **integer \| null** ||
|| cloud_id | **string \| null**

Required field.  ||
|| created_at | **string** ||
|| data_export_forbidden | **unknown** ||
|| db_name | **string**

Required field.  ||
|| delegation_is_set | **boolean \| null** ||
|| description | **string \| null** ||
|| folder_id | **string**

Required field.  ||
|| host | **string**

Required field.  ||
|| id | **string** ||
|| key | **string** ||
|| mdb_cluster_id | **string \| null** ||
|| mdb_folder_id | **string \| null** ||
|| port | **integer**

Required field.  ||
|| raw_sql_level | **enum**

- `off`
- `subselect`
- `template`
- `dashsql` ||
|| service_account_id | **string**

Required field.  ||
|| ssl_ca | **unknown** ||
|| ssl_enable | **unknown** ||
|| token | **string \| null** ||
|| updated_at | **string** ||
|| username | **string \| null** ||
|| workbook_id | **string \| null** ||
|#

## yq2 {#yq2}

#|
||Field | Description ||
|| cache_ttl_sec | **integer \| null** ||
|| cloud_id | **string \| null**

Required field.  ||
|| created_at | **string** ||
|| data_export_forbidden | **unknown** ||
|| delegation_is_set | **boolean \| null** ||
|| description | **string \| null** ||
|| folder_id | **string**

Required field.  ||
|| id | **string** ||
|| key | **string** ||
|| raw_sql_level | **enum**

- `off`
- `subselect`
- `template`
- `dashsql` ||
|| service_account_id | **string**

Required field.  ||
|| updated_at | **string** ||
|| workbook_id | **string \| null** ||
|#

## Response {#200}

**HTTP Code: 200**

Response

**Response schema: application/json**

```json
{
  "<oneOf>": [
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
    {
      "cache_ttl_sec": "integer | null",
      "created_at": "string",
      "credentials": "string",
      "description": "string | null",
      "id": "string",
      "key": "string",
      "name": "string",
      "project_id": "string",
      "raw_sql_level": "string",
      "type": "bigquery",
      "updated_at": "string"
    },
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
      "portal": "string",
      "token": "string",
      "type": "bitrix24",
      "updated_at": "string"
    },
    {
      "created_at": "string",
      "description": "string | null",
      "id": "string",
      "key": "string",
      "meta": {
        "string": "unknown"
      },
      "name": "string",
      "type": "ch_billing_analytics",
      "updated_at": "string"
    },
    {
      "created_at": "string",
      "description": "string | null",
      "id": "string",
      "key": "string",
      "name": "string",
      "raw_sql_level": "string",
      "type": "ch_frozen_bumpy_roads",
      "updated_at": "string"
    },
    {
      "created_at": "string",
      "description": "string | null",
      "id": "string",
      "key": "string",
      "name": "string",
      "raw_sql_level": "string",
      "type": "ch_frozen_covid",
      "updated_at": "string"
    },
    {
      "created_at": "string",
      "description": "string | null",
      "id": "string",
      "key": "string",
      "name": "string",
      "raw_sql_level": "string",
      "type": "ch_frozen_demo",
      "updated_at": "string"
    },
    {
      "created_at": "string",
      "description": "string | null",
      "id": "string",
      "key": "string",
      "name": "string",
      "raw_sql_level": "string",
      "type": "ch_frozen_dtp",
      "updated_at": "string"
    },
    {
      "created_at": "string",
      "description": "string | null",
      "id": "string",
      "key": "string",
      "name": "string",
      "raw_sql_level": "string",
      "type": "ch_frozen_gkh",
      "updated_at": "string"
    },
    {
      "created_at": "string",
      "description": "string | null",
      "id": "string",
      "key": "string",
      "name": "string",
      "raw_sql_level": "string",
      "type": "ch_frozen_horeca",
      "updated_at": "string"
    },
    {
      "created_at": "string",
      "description": "string | null",
      "id": "string",
      "key": "string",
      "name": "string",
      "raw_sql_level": "string",
      "type": "ch_frozen_samples",
      "updated_at": "string"
    },
    {
      "created_at": "string",
      "description": "string | null",
      "id": "string",
      "key": "string",
      "name": "string",
      "raw_sql_level": "string",
      "type": "ch_frozen_transparency",
      "updated_at": "string"
    },
    {
      "created_at": "string",
      "description": "string | null",
      "id": "string",
      "key": "string",
      "name": "string",
      "raw_sql_level": "string",
      "type": "ch_frozen_weather",
      "updated_at": "string"
    },
    {
      "created_at": "string",
      "description": "string | null",
      "id": "string",
      "key": "string",
      "meta": {
        "string": "unknown"
      },
      "mp_product_id": "string",
      "name": "string",
      "type": "ch_geo_filtered",
      "updated_at": "string"
    },
    {
      "created_at": "string",
      "description": "string | null",
      "id": "string",
      "key": "string",
      "meta": {
        "string": "unknown"
      },
      "name": "string",
      "token": "string",
      "type": "ch_ya_music_podcast_stats",
      "updated_at": "string"
    },
    {
      "alias": "string",
      "cache_ttl_sec": "integer | null",
      "created_at": "string",
      "data_export_forbidden": "unknown",
      "description": "string | null",
      "host": "string",
      "id": "string",
      "key": "string",
      "meta": {
        "string": "unknown"
      },
      "name": "string",
      "port": "integer",
      "raw_sql_level": "string",
      "secure": "boolean",
      "token": "string",
      "type": "chyt",
      "updated_at": "string"
    },
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
    {
      "access_token": "string",
      "created_at": "string",
      "description": "string | null",
      "id": "string",
      "key": "string",
      "meta": {
        "string": "unknown"
      },
      "name": "string",
      "type": "equeo",
      "updated_at": "string"
    },
    {
      "access_token": "string",
      "created_at": "string",
      "description": "string | null",
      "id": "string",
      "key": "string",
      "meta": {
        "string": "unknown"
      },
      "name": "string",
      "type": "extractor1c",
      "updated_at": "string"
    },
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
      "type": "json_api",
      "updated_at": "string"
    },
    {
      "access_token": "string",
      "created_at": "string",
      "description": "string | null",
      "id": "string",
      "key": "string",
      "meta": {
        "string": "unknown"
      },
      "name": "string",
      "type": "kontur_market",
      "updated_at": "string"
    },
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
    {
      "cache_ttl_sec": "integer | null",
      "cloud_id": "string | null",
      "created_at": "string",
      "delegation_is_set": "boolean | null",
      "description": "string | null",
      "folder_id": "string",
      "id": "string",
      "key": "string",
      "meta": {
        "string": "unknown"
      },
      "name": "string",
      "service_account_id": "string",
      "type": "monitoring",
      "updated_at": "string"
    },
    {
      "access_token": "string",
      "created_at": "string",
      "description": "string | null",
      "id": "string",
      "key": "string",
      "meta": {
        "string": "unknown"
      },
      "name": "string",
      "type": "moysklad",
      "updated_at": "string"
    },
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
    {
      "created_at": "string",
      "description": "string | null",
      "id": "string",
      "key": "string",
      "meta": {
        "string": "unknown"
      },
      "name": "string",
      "token": "string",
      "type": "smb_heatmaps",
      "updated_at": "string"
    },
    {
      "account_name": "string",
      "client_id": "string",
      "client_secret": "string",
      "created_at": "string",
      "data_export_forbidden": "unknown",
      "db_name": "string",
      "description": "string | null",
      "id": "string",
      "key": "string",
      "name": "string",
      "raw_sql_level": "string",
      "refresh_token": "string",
      "refresh_token_expire_time": "string | null",
      "schema": "string",
      "type": "snowflake",
      "updated_at": "string",
      "user_name": "string",
      "user_role": "string | null",
      "warehouse": "string"
    },
    {
      "created_at": "string",
      "data_export_forbidden": "unknown",
      "description": "string | null",
      "id": "string",
      "key": "string",
      "meta": {
        "string": "unknown"
      },
      "name": "string",
      "project_id": "string",
      "type": "speechsense",
      "updated_at": "string"
    },
    {
      "auth_type": "unknown",
      "cache_ttl_sec": "integer | null",
      "cloud_id": "string | null",
      "created_at": "string",
      "data_export_forbidden": "unknown",
      "db_name": "string | null",
      "delegation_is_set": "boolean | null",
      "description": "string | null",
      "folder_id": "string | null",
      "host": "string",
      "id": "string",
      "jwt": "string | null",
      "key": "string",
      "listing_sources": "unknown",
      "mdb_cluster_id": "string | null",
      "meta": {
        "string": "unknown"
      },
      "name": "string",
      "password": "string | null",
      "port": "integer | null",
      "raw_sql_level": "string",
      "service_account_id": "string | null",
      "ssl_ca": "unknown",
      "ssl_enable": "unknown",
      "type": "trino",
      "updated_at": "string",
      "username": "string | null"
    },
    {
      "created_at": "string",
      "description": "string | null",
      "id": "string",
      "key": "string",
      "meta": {
        "string": "unknown"
      },
      "name": "string",
      "type": "usage_analytics_detailed",
      "updated_at": "string"
    },
    {
      "created_at": "string",
      "description": "string | null",
      "id": "string",
      "key": "string",
      "meta": {
        "string": "unknown"
      },
      "name": "string",
      "type": "usage_analytics_light",
      "updated_at": "string"
    },
    {
      "auth_type": "string | null",
      "cache_ttl_sec": "integer | null",
      "cloud_id": "string | null",
      "created_at": "string",
      "data_export_forbidden": "unknown",
      "db_name": "string",
      "delegation_is_set": "boolean | null",
      "description": "string | null",
      "folder_id": "string",
      "host": "string",
      "id": "string",
      "key": "string",
      "mdb_cluster_id": "string | null",
      "mdb_folder_id": "string | null",
      "name": "string",
      "port": "integer",
      "raw_sql_level": "string",
      "service_account_id": "string",
      "ssl_ca": "unknown",
      "ssl_enable": "unknown",
      "token": "string | null",
      "type": "ydb",
      "updated_at": "string",
      "username": "string | null"
    },
    {
      "cache_ttl_sec": "integer | null",
      "cloud_id": "string | null",
      "created_at": "string",
      "data_export_forbidden": "unknown",
      "delegation_is_set": "boolean | null",
      "description": "string | null",
      "folder_id": "string",
      "id": "string",
      "key": "string",
      "name": "string",
      "raw_sql_level": "string",
      "service_account_id": "string",
      "type": "yq",
      "updated_at": "string"
    }
  ]
}
```

One of:

#|
||Field | Description ||
|| accuracy | **number \| null** ||
|| counter_id | **string**

Required field.  ||
|| created_at | **string** ||
|| data_export_forbidden | **unknown** ||
|| description | **string \| null** ||
|| id | **string** ||
|| key | **string** ||
|| meta | **object** (map<**string**, **unknown**>) ||
|| name | **string**

Required field.  ||
|| token | **string**

Required field.  ||
|| type | **appmetrica_api** (const) ||
|| updated_at | **string** ||
|#

>

#|
||Field | Description ||
|| cache_ttl_sec | **integer \| null** ||
|| created_at | **string** ||
|| credentials | **string**

Required field.  ||
|| description | **string \| null** ||
|| id | **string** ||
|| key | **string** ||
|| name | **string**

Required field.  ||
|| project_id | **string**

Required field.  ||
|| raw_sql_level | **enum**

- `off`
- `subselect`
- `template`
- `dashsql` ||
|| type | **bigquery** (const) ||
|| updated_at | **string** ||
|#

>

#|
||Field | Description ||
|| cache_ttl_sec | **integer \| null** ||
|| created_at | **string** ||
|| data_export_forbidden | **unknown** ||
|| description | **string \| null** ||
|| id | **string** ||
|| key | **string** ||
|| meta | **object** (map<**string**, **unknown**>) ||
|| name | **string**

Required field.  ||
|| portal | **string**

Required field.  ||
|| token | **string**

Required field.  ||
|| type | **bitrix24** (const) ||
|| updated_at | **string** ||
|#

>

#|
||Field | Description ||
|| created_at | **string** ||
|| description | **string \| null** ||
|| id | **string** ||
|| key | **string** ||
|| meta | **object** (map<**string**, **unknown**>) ||
|| name | **string**

Required field.  ||
|| type | **ch_billing_analytics** (const) ||
|| updated_at | **string** ||
|#

>

#|
||Field | Description ||
|| created_at | **string** ||
|| description | **string \| null** ||
|| id | **string** ||
|| key | **string** ||
|| name | **string**

Required field.  ||
|| raw_sql_level | **enum**

- `off`
- `subselect`
- `template`
- `dashsql` ||
|| type | **ch_frozen_bumpy_roads** (const) ||
|| updated_at | **string** ||
|#

>

#|
||Field | Description ||
|| created_at | **string** ||
|| description | **string \| null** ||
|| id | **string** ||
|| key | **string** ||
|| name | **string**

Required field.  ||
|| raw_sql_level | **enum**

- `off`
- `subselect`
- `template`
- `dashsql` ||
|| type | **ch_frozen_covid** (const) ||
|| updated_at | **string** ||
|#

>

#|
||Field | Description ||
|| created_at | **string** ||
|| description | **string \| null** ||
|| id | **string** ||
|| key | **string** ||
|| name | **string**

Required field.  ||
|| raw_sql_level | **enum**

- `off`
- `subselect`
- `template`
- `dashsql` ||
|| type | **ch_frozen_demo** (const) ||
|| updated_at | **string** ||
|#

>

#|
||Field | Description ||
|| created_at | **string** ||
|| description | **string \| null** ||
|| id | **string** ||
|| key | **string** ||
|| name | **string**

Required field.  ||
|| raw_sql_level | **enum**

- `off`
- `subselect`
- `template`
- `dashsql` ||
|| type | **ch_frozen_dtp** (const) ||
|| updated_at | **string** ||
|#

>

#|
||Field | Description ||
|| created_at | **string** ||
|| description | **string \| null** ||
|| id | **string** ||
|| key | **string** ||
|| name | **string**

Required field.  ||
|| raw_sql_level | **enum**

- `off`
- `subselect`
- `template`
- `dashsql` ||
|| type | **ch_frozen_gkh** (const) ||
|| updated_at | **string** ||
|#

>

#|
||Field | Description ||
|| created_at | **string** ||
|| description | **string \| null** ||
|| id | **string** ||
|| key | **string** ||
|| name | **string**

Required field.  ||
|| raw_sql_level | **enum**

- `off`
- `subselect`
- `template`
- `dashsql` ||
|| type | **ch_frozen_horeca** (const) ||
|| updated_at | **string** ||
|#

>

#|
||Field | Description ||
|| created_at | **string** ||
|| description | **string \| null** ||
|| id | **string** ||
|| key | **string** ||
|| name | **string**

Required field.  ||
|| raw_sql_level | **enum**

- `off`
- `subselect`
- `template`
- `dashsql` ||
|| type | **ch_frozen_samples** (const) ||
|| updated_at | **string** ||
|#

>

#|
||Field | Description ||
|| created_at | **string** ||
|| description | **string \| null** ||
|| id | **string** ||
|| key | **string** ||
|| name | **string**

Required field.  ||
|| raw_sql_level | **enum**

- `off`
- `subselect`
- `template`
- `dashsql` ||
|| type | **ch_frozen_transparency** (const) ||
|| updated_at | **string** ||
|#

>

#|
||Field | Description ||
|| created_at | **string** ||
|| description | **string \| null** ||
|| id | **string** ||
|| key | **string** ||
|| name | **string**

Required field.  ||
|| raw_sql_level | **enum**

- `off`
- `subselect`
- `template`
- `dashsql` ||
|| type | **ch_frozen_weather** (const) ||
|| updated_at | **string** ||
|#

>

#|
||Field | Description ||
|| created_at | **string** ||
|| description | **string \| null** ||
|| id | **string** ||
|| key | **string** ||
|| meta | **object** (map<**string**, **unknown**>) ||
|| mp_product_id | **string** ||
|| name | **string**

Required field.  ||
|| type | **ch_geo_filtered** (const) ||
|| updated_at | **string** ||
|#

>

#|
||Field | Description ||
|| created_at | **string** ||
|| description | **string \| null** ||
|| id | **string** ||
|| key | **string** ||
|| meta | **object** (map<**string**, **unknown**>) ||
|| name | **string**

Required field.  ||
|| token | **string**

Required field.  ||
|| type | **ch_ya_music_podcast_stats** (const) ||
|| updated_at | **string** ||
|#

>

#|
||Field | Description ||
|| alias | **string**

Required field.  ||
|| cache_ttl_sec | **integer \| null** ||
|| created_at | **string** ||
|| data_export_forbidden | **unknown** ||
|| description | **string \| null** ||
|| host | **string**

Required field.  ||
|| id | **string** ||
|| key | **string** ||
|| meta | **object** (map<**string**, **unknown**>) ||
|| name | **string**

Required field.  ||
|| port | **integer**

Required field.  ||
|| raw_sql_level | **enum**

- `off`
- `subselect`
- `template`
- `dashsql` ||
|| secure | **boolean** ||
|| token | **string**

Required field.  ||
|| type | **chyt** (const) ||
|| updated_at | **string** ||
|#

>

#|
||Field | Description ||
|| cache_ttl_sec | **integer \| null** ||
|| connection_manager_cloud_id | **string \| null** ||
|| connection_manager_connection_id | **string \| null** ||
|| connection_manager_delegation_is_set | **boolean \| null** ||
|| connection_manager_folder_id | **string \| null** ||
|| created_at | **string** ||
|| data_export_forbidden | **unknown** ||
|| db_name | **string \| null** ||
|| description | **string \| null** ||
|| host | **string**

Required field.  ||
|| id | **string** ||
|| key | **string** ||
|| mdb_cluster_id | **string \| null** ||
|| mdb_folder_id | **string \| null** ||
|| meta | **object** (map<**string**, **unknown**>) ||
|| name | **string**

Required field.  ||
|| password | **string \| null** ||
|| port | **integer**

Required field.  ||
|| raw_sql_level | **enum**

- `off`
- `subselect`
- `template`
- `dashsql` ||
|| readonly | **integer** ||
|| secure | **unknown** ||
|| ssl_ca | **unknown** ||
|| type | **clickhouse** (const) ||
|| updated_at | **string** ||
|| username | **string \| null** ||
|#

>

#|
||Field | Description ||
|| access_token | **string**

Required field.  ||
|| created_at | **string** ||
|| description | **string \| null** ||
|| id | **string** ||
|| key | **string** ||
|| meta | **object** (map<**string**, **unknown**>) ||
|| name | **string**

Required field.  ||
|| type | **equeo** (const) ||
|| updated_at | **string** ||
|#

>

#|
||Field | Description ||
|| access_token | **string**

Required field.  ||
|| created_at | **string** ||
|| description | **string \| null** ||
|| id | **string** ||
|| key | **string** ||
|| meta | **object** (map<**string**, **unknown**>) ||
|| name | **string**

Required field.  ||
|| type | **extractor1c** (const) ||
|| updated_at | **string** ||
|#

>

#|
||Field | Description ||
|| cache_ttl_sec | **integer \| null** ||
|| created_at | **string** ||
|| data_export_forbidden | **unknown** ||
|| db_name | **string \| null** ||
|| description | **string \| null** ||
|| enforce_collate | **enum**

- `auto`
- `on`
- `off` ||
|| host | **string**

Required field.  ||
|| id | **string** ||
|| key | **string** ||
|| mdb_cluster_id | **string \| null** ||
|| mdb_folder_id | **string \| null** ||
|| meta | **object** (map<**string**, **unknown**>) ||
|| name | **string**

Required field.  ||
|| password | **string**

Required field.  ||
|| port | **integer**

Required field.  ||
|| raw_sql_level | **enum**

- `off`
- `subselect`
- `template`
- `dashsql` ||
|| ssl_ca | **unknown** ||
|| ssl_enable | **unknown** ||
|| type | **greenplum** (const) ||
|| updated_at | **string** ||
|| username | **string**

Required field.  ||
|#

>

#|
||Field | Description ||
|| cache_ttl_sec | **integer \| null** ||
|| created_at | **string** ||
|| data_export_forbidden | **unknown** ||
|| description | **string \| null** ||
|| id | **string** ||
|| key | **string** ||
|| meta | **object** (map<**string**, **unknown**>) ||
|| name | **string**

Required field.  ||
|| type | **gsheets** (const) ||
|| updated_at | **string** ||
|| url | **string**

Required field.  ||
|#

>

#|
||Field | Description ||
|| allowed_methods[] | **enum**

Required field. 

- `GET`
- `POST` ||
|| created_at | **string** ||
|| description | **string \| null** ||
|| host | **string**

Required field.  ||
|| id | **string** ||
|| key | **string** ||
|| meta | **object** (map<**string**, **unknown**>) ||
|| name | **string**

Required field.  ||
|| path | **string \| null** ||
|| plain_headers | **object \| null** ||
|| port | **integer**

Required field.  ||
|| secret_headers | **object \| null** ||
|| secure | **boolean** ||
|| type | **json_api** (const) ||
|| updated_at | **string** ||
|#

>

#|
||Field | Description ||
|| access_token | **string**

Required field.  ||
|| created_at | **string** ||
|| description | **string \| null** ||
|| id | **string** ||
|| key | **string** ||
|| meta | **object** (map<**string**, **unknown**>) ||
|| name | **string**

Required field.  ||
|| type | **kontur_market** (const) ||
|| updated_at | **string** ||
|#

>

#|
||Field | Description ||
|| accuracy | **number \| null** ||
|| counter_id | **string**

Required field.  ||
|| created_at | **string** ||
|| data_export_forbidden | **unknown** ||
|| description | **string \| null** ||
|| id | **string** ||
|| key | **string** ||
|| meta | **object** (map<**string**, **unknown**>) ||
|| name | **string**

Required field.  ||
|| token | **string**

Required field.  ||
|| type | **metrika_api** (const) ||
|| updated_at | **string** ||
|#

>

#|
||Field | Description ||
|| cache_ttl_sec | **integer \| null** ||
|| cloud_id | **string \| null**

Required field.  ||
|| created_at | **string** ||
|| delegation_is_set | **boolean \| null** ||
|| description | **string \| null** ||
|| folder_id | **string**

Required field.  ||
|| id | **string** ||
|| key | **string** ||
|| meta | **object** (map<**string**, **unknown**>) ||
|| name | **string**

Required field.  ||
|| service_account_id | **string**

Required field.  ||
|| type | **monitoring** (const) ||
|| updated_at | **string** ||
|#

>

#|
||Field | Description ||
|| access_token | **string**

Required field.  ||
|| created_at | **string** ||
|| description | **string \| null** ||
|| id | **string** ||
|| key | **string** ||
|| meta | **object** (map<**string**, **unknown**>) ||
|| name | **string**

Required field.  ||
|| type | **moysklad** (const) ||
|| updated_at | **string** ||
|#

>

#|
||Field | Description ||
|| cache_ttl_sec | **integer \| null** ||
|| created_at | **string** ||
|| data_export_forbidden | **unknown** ||
|| db_name | **string \| null** ||
|| description | **string \| null** ||
|| host | **string**

Required field.  ||
|| id | **string** ||
|| key | **string** ||
|| meta | **object** (map<**string**, **unknown**>) ||
|| name | **string**

Required field.  ||
|| password | **string**

Required field.  ||
|| port | **integer**

Required field.  ||
|| raw_sql_level | **enum**

- `off`
- `subselect`
- `template`
- `dashsql` ||
|| type | **mssql** (const) ||
|| updated_at | **string** ||
|| username | **string**

Required field.  ||
|#

>

#|
||Field | Description ||
|| cache_ttl_sec | **integer \| null** ||
|| connection_manager_cloud_id | **string \| null** ||
|| connection_manager_connection_id | **string \| null** ||
|| connection_manager_delegation_is_set | **boolean \| null** ||
|| connection_manager_folder_id | **string \| null** ||
|| created_at | **string** ||
|| data_export_forbidden | **unknown** ||
|| db_name | **string \| null** ||
|| description | **string \| null** ||
|| host | **string**

Required field.  ||
|| id | **string** ||
|| key | **string** ||
|| mdb_cluster_id | **string \| null** ||
|| mdb_folder_id | **string \| null** ||
|| meta | **object** (map<**string**, **unknown**>) ||
|| name | **string**

Required field.  ||
|| password | **string \| null** ||
|| port | **integer**

Required field.  ||
|| raw_sql_level | **enum**

- `off`
- `subselect`
- `template`
- `dashsql` ||
|| ssl_ca | **unknown** ||
|| ssl_enable | **unknown** ||
|| type | **mysql** (const) ||
|| updated_at | **string** ||
|| username | **string \| null** ||
|#

>

#|
||Field | Description ||
|| cache_ttl_sec | **integer \| null** ||
|| created_at | **string** ||
|| data_export_forbidden | **unknown** ||
|| db_connect_method | **enum**

Required field. 

- `sid`
- `service_name` ||
|| db_name | **string \| null** ||
|| description | **string \| null** ||
|| host | **string**

Required field.  ||
|| id | **string** ||
|| key | **string** ||
|| meta | **object** (map<**string**, **unknown**>) ||
|| name | **string**

Required field.  ||
|| password | **string**

Required field.  ||
|| port | **integer**

Required field.  ||
|| raw_sql_level | **enum**

- `off`
- `subselect`
- `template`
- `dashsql` ||
|| ssl_ca | **unknown** ||
|| ssl_enable | **unknown** ||
|| type | **oracle** (const) ||
|| updated_at | **string** ||
|| username | **string**

Required field.  ||
|#

>

#|
||Field | Description ||
|| cache_ttl_sec | **integer \| null** ||
|| connection_manager_cloud_id | **string \| null** ||
|| connection_manager_connection_id | **string \| null** ||
|| connection_manager_delegation_is_set | **boolean \| null** ||
|| connection_manager_folder_id | **string \| null** ||
|| created_at | **string** ||
|| data_export_forbidden | **unknown** ||
|| db_name | **string \| null** ||
|| description | **string \| null** ||
|| enforce_collate | **enum**

- `auto`
- `on`
- `off` ||
|| host | **string**

Required field.  ||
|| id | **string** ||
|| key | **string** ||
|| mdb_cluster_id | **string \| null** ||
|| mdb_folder_id | **string \| null** ||
|| meta | **object** (map<**string**, **unknown**>) ||
|| name | **string**

Required field.  ||
|| password | **string \| null** ||
|| port | **integer**

Required field.  ||
|| raw_sql_level | **enum**

- `off`
- `subselect`
- `template`
- `dashsql` ||
|| ssl_ca | **unknown** ||
|| ssl_enable | **unknown** ||
|| type | **postgres** (const) ||
|| updated_at | **string** ||
|| username | **string \| null** ||
|#

>

#|
||Field | Description ||
|| cache_ttl_sec | **integer \| null** ||
|| created_at | **string** ||
|| data_export_forbidden | **unknown** ||
|| db_name | **string \| null** ||
|| description | **string \| null** ||
|| host | **string**

Required field.  ||
|| id | **string** ||
|| key | **string** ||
|| meta | **object** (map<**string**, **unknown**>) ||
|| name | **string**

Required field.  ||
|| password | **string \| null** ||
|| path | **string \| null** ||
|| port | **integer**

Required field.  ||
|| secure | **boolean** ||
|| type | **promql** (const) ||
|| updated_at | **string** ||
|| username | **string \| null** ||
|#

>

#|
||Field | Description ||
|| created_at | **string** ||
|| description | **string \| null** ||
|| id | **string** ||
|| key | **string** ||
|| meta | **object** (map<**string**, **unknown**>) ||
|| name | **string**

Required field.  ||
|| token | **string**

Required field.  ||
|| type | **smb_heatmaps** (const) ||
|| updated_at | **string** ||
|#

>

#|
||Field | Description ||
|| account_name | **string**

Required field.  ||
|| client_id | **string**

Required field.  ||
|| client_secret | **string**

Required field.  ||
|| created_at | **string** ||
|| data_export_forbidden | **unknown** ||
|| db_name | **string**

Required field.  ||
|| description | **string \| null** ||
|| id | **string** ||
|| key | **string** ||
|| name | **string**

Required field.  ||
|| raw_sql_level | **enum**

- `off`
- `subselect`
- `template`
- `dashsql` ||
|| refresh_token | **string** ||
|| refresh_token_expire_time | **string \| null** (date-time) ||
|| schema | **string**

Required field.  ||
|| type | **snowflake** (const) ||
|| updated_at | **string** ||
|| user_name | **string**

Required field.  ||
|| user_role | **string \| null** ||
|| warehouse | **string**

Required field.  ||
|#

>

#|
||Field | Description ||
|| created_at | **string** ||
|| data_export_forbidden | **unknown** ||
|| description | **string \| null** ||
|| id | **string** ||
|| key | **string** ||
|| meta | **object** (map<**string**, **unknown**>) ||
|| name | **string**

Required field.  ||
|| project_id | **string**

Required field.  ||
|| type | **speechsense** (const) ||
|| updated_at | **string** ||
|#

>

#|
||Field | Description ||
|| auth_type | **unknown** ||
|| cache_ttl_sec | **integer \| null** ||
|| cloud_id | **string \| null** ||
|| created_at | **string** ||
|| data_export_forbidden | **unknown** ||
|| db_name | **string \| null** ||
|| delegation_is_set | **boolean \| null** ||
|| description | **string \| null** ||
|| folder_id | **string \| null** ||
|| host | **string**

Required field.  ||
|| id | **string** ||
|| jwt | **string \| null** ||
|| key | **string** ||
|| listing_sources | **unknown**

Required field.  ||
|| mdb_cluster_id | **string \| null** ||
|| meta | **object** (map<**string**, **unknown**>) ||
|| name | **string**

Required field.  ||
|| password | **string \| null** ||
|| port | **integer \| null** ||
|| raw_sql_level | **enum**

- `off`
- `subselect`
- `template`
- `dashsql` ||
|| service_account_id | **string \| null** ||
|| ssl_ca | **unknown** ||
|| ssl_enable | **unknown** ||
|| type | **trino** (const) ||
|| updated_at | **string** ||
|| username | **string \| null** ||
|#

>

#|
||Field | Description ||
|| created_at | **string** ||
|| description | **string \| null** ||
|| id | **string** ||
|| key | **string** ||
|| meta | **object** (map<**string**, **unknown**>) ||
|| name | **string**

Required field.  ||
|| type | **usage_analytics_detailed** (const) ||
|| updated_at | **string** ||
|#

>

#|
||Field | Description ||
|| created_at | **string** ||
|| description | **string \| null** ||
|| id | **string** ||
|| key | **string** ||
|| meta | **object** (map<**string**, **unknown**>) ||
|| name | **string**

Required field.  ||
|| type | **usage_analytics_light** (const) ||
|| updated_at | **string** ||
|#

>

#|
||Field | Description ||
|| auth_type | **enum**

- `anonymous`
- `password`
- `oauth`
- `null` ||
|| cache_ttl_sec | **integer \| null** ||
|| cloud_id | **string \| null**

Required field.  ||
|| created_at | **string** ||
|| data_export_forbidden | **unknown** ||
|| db_name | **string**

Required field.  ||
|| delegation_is_set | **boolean \| null** ||
|| description | **string \| null** ||
|| folder_id | **string**

Required field.  ||
|| host | **string**

Required field.  ||
|| id | **string** ||
|| key | **string** ||
|| mdb_cluster_id | **string \| null** ||
|| mdb_folder_id | **string \| null** ||
|| name | **string**

Required field.  ||
|| port | **integer**

Required field.  ||
|| raw_sql_level | **enum**

- `off`
- `subselect`
- `template`
- `dashsql` ||
|| service_account_id | **string**

Required field.  ||
|| ssl_ca | **unknown** ||
|| ssl_enable | **unknown** ||
|| token | **string \| null** ||
|| type | **ydb** (const) ||
|| updated_at | **string** ||
|| username | **string \| null** ||
|#

>

#|
||Field | Description ||
|| cache_ttl_sec | **integer \| null** ||
|| cloud_id | **string \| null**

Required field.  ||
|| created_at | **string** ||
|| data_export_forbidden | **unknown** ||
|| delegation_is_set | **boolean \| null** ||
|| description | **string \| null** ||
|| folder_id | **string**

Required field.  ||
|| id | **string** ||
|| key | **string** ||
|| name | **string**

Required field.  ||
|| raw_sql_level | **enum**

- `off`
- `subselect`
- `template`
- `dashsql` ||
|| service_account_id | **string**

Required field.  ||
|| type | **yq** (const) ||
|| updated_at | **string** ||
|#

>

#|
||Field | Description ||
|| Empty | > ||
|#