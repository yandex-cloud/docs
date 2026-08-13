<div class="openapi">

# Create connection

<!-- markdownlint-disable-file -->

Creates a new connection.

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
https://api.datalens.tech/rpc/createConnection
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

_Const:_{.json-schema-reset .json-schema-value} `2`

_Example:_{.json-schema-reset .json-schema-example} `2`
{.table-cell}
||
|#{.json-schema-properties}

<div class="openapi-entity">

### Body

{% cut "application/json" %}

```json translate=no
{
  "accuracy": null,
  "collection_id": "null",
  "counter_id": "example",
  "data_export_forbidden": "off",
  "description": "",
  "dir_path": "example",
  "name": "example",
  "token": "example",
  "type": "appmetrica_api",
  "workbook_id": "null"
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
|#{.json-schema-properties}

{% cut "**One of 29 types**" %}{.json-schema-combinators data-marker=or}

- **appmetrica_api**

  **Type**: [appmetrica_api](#entity-appmetrica_api)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "accuracy": null,
    "collection_id": "null",
    "counter_id": "example",
    "data_export_forbidden": "off",
    "description": "",
    "dir_path": "example",
    "name": "example",
    "token": "example",
    "type": "appmetrica_api",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **bigquery**

  **Type**: [bigquery](#entity-bigquery)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "cache_invalidation_throttling_interval_sec": null,
    "cache_ttl_sec": null,
    "collection_id": "null",
    "credentials": "example",
    "description": "",
    "dir_path": "example",
    "name": "example",
    "project_id": "example",
    "raw_sql_level": "off",
    "type": "bigquery",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **bitrix24**

  **Type**: [bitrix24](#entity-bitrix24)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "cache_invalidation_throttling_interval_sec": null,
    "cache_ttl_sec": null,
    "collection_id": "null",
    "data_export_forbidden": "off",
    "description": "",
    "dir_path": "example",
    "name": "example",
    "portal": "example",
    "token": "example",
    "type": "bitrix24",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **ch_billing_analytics**

  **Type**: [ch_billing_analytics](#entity-ch_billing_analytics)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "collection_id": "null",
    "description": "",
    "dir_path": "example",
    "name": "example",
    "type": "ch_billing_analytics",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **ch_ya_music_podcast_stats**

  **Type**: [ch_ya_music_podcast_stats](#entity-ch_ya_music_podcast_stats)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "collection_id": "null",
    "description": "",
    "dir_path": "example",
    "name": "example",
    "token": "example",
    "type": "ch_ya_music_podcast_stats",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **chyt**

  **Type**: [chyt](#entity-chyt)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "alias": "example",
    "cache_invalidation_throttling_interval_sec": null,
    "cache_ttl_sec": null,
    "collection_id": "null",
    "data_export_forbidden": "off",
    "description": "",
    "dir_path": "example",
    "host": "example",
    "name": "example",
    "port": 0,
    "raw_sql_level": "off",
    "secure": true,
    "token": "example",
    "type": "chyt",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **clickhouse**

  **Type**: [clickhouse](#entity-clickhouse)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "cache_invalidation_throttling_interval_sec": null,
    "cache_ttl_sec": null,
    "collection_id": "null",
    "connection_manager_cloud_id": "example",
    "connection_manager_connection_id": "example",
    "connection_manager_delegation_is_set": true,
    "connection_manager_folder_id": "example",
    "data_export_forbidden": "off",
    "db_name": "example",
    "description": "",
    "dir_path": "example",
    "experimental_features": "off",
    "host": "example",
    "mdb_cluster_id": "example",
    "mdb_folder_id": "example",
    "name": "example",
    "password": "example",
    "port": 0,
    "raw_sql_level": "off",
    "readonly": 2,
    "secure": null,
    "ssl_ca": null,
    "ssl_ca_verify": "on",
    "type": "clickhouse",
    "username": "example",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **equeo**

  **Type**: [equeo](#entity-equeo)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "access_token": "example",
    "collection_id": "null",
    "description": "",
    "dir_path": "example",
    "name": "example",
    "type": "equeo",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **extractor1c**

  **Type**: [extractor1c](#entity-extractor1c)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "access_token": "example",
    "collection_id": "null",
    "description": "",
    "dir_path": "example",
    "name": "example",
    "type": "extractor1c",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **greenplum**

  **Type**: [greenplum](#entity-greenplum)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "cache_invalidation_throttling_interval_sec": null,
    "cache_ttl_sec": null,
    "collection_id": "null",
    "data_export_forbidden": "off",
    "db_name": "example",
    "description": "",
    "dir_path": "example",
    "enforce_collate": "auto",
    "host": "example",
    "mdb_cluster_id": "example",
    "mdb_folder_id": "example",
    "name": "example",
    "password": "example",
    "port": 0,
    "raw_sql_level": "off",
    "ssl_ca": null,
    "ssl_enable": "off",
    "type": "greenplum",
    "username": "example",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **gsheets**

  **Type**: [gsheets](#entity-gsheets)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "cache_invalidation_throttling_interval_sec": null,
    "cache_ttl_sec": null,
    "collection_id": "null",
    "data_export_forbidden": "off",
    "description": "",
    "dir_path": "example",
    "name": "example",
    "type": "gsheets",
    "url": "example",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **json_api**

  **Type**: [json_api](#entity-json_api)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "allowed_methods": [
      "GET"
    ],
    "collection_id": "null",
    "description": "",
    "dir_path": "example",
    "host": "example",
    "name": "example",
    "path": "example",
    "plain_headers": {},
    "port": 0,
    "secret_headers": {},
    "secure": true,
    "type": "json_api",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **kontur_market**

  **Type**: [kontur_market](#entity-kontur_market)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "access_token": "example",
    "collection_id": "null",
    "description": "",
    "dir_path": "example",
    "name": "example",
    "type": "kontur_market",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **metrika_api**

  **Type**: [metrika_api](#entity-metrika_api)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "accuracy": null,
    "collection_id": "null",
    "counter_id": "example",
    "data_export_forbidden": "off",
    "description": "",
    "dir_path": "example",
    "name": "example",
    "token": "example",
    "type": "metrika_api",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **monitoring**

  **Type**: [monitoring](#entity-monitoring)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "cache_invalidation_throttling_interval_sec": null,
    "cache_ttl_sec": null,
    "cloud_id": "example",
    "collection_id": "null",
    "delegation_is_set": true,
    "description": "",
    "dir_path": "example",
    "folder_id": "example",
    "name": "example",
    "service_account_id": "example",
    "type": "monitoring",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **moysklad**

  **Type**: [moysklad](#entity-moysklad)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "access_token": "example",
    "collection_id": "null",
    "description": "",
    "dir_path": "example",
    "name": "example",
    "type": "moysklad",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **mssql**

  **Type**: [mssql](#entity-mssql)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "cache_invalidation_throttling_interval_sec": null,
    "cache_ttl_sec": null,
    "collection_id": "null",
    "data_export_forbidden": "off",
    "db_name": "example",
    "description": "",
    "dir_path": "example",
    "host": "example",
    "name": "example",
    "password": "example",
    "port": 0,
    "raw_sql_level": "off",
    "type": "mssql",
    "username": "example",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **mysql**

  **Type**: [mysql](#entity-mysql)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "cache_invalidation_throttling_interval_sec": null,
    "cache_ttl_sec": null,
    "collection_id": "null",
    "connection_manager_cloud_id": "example",
    "connection_manager_connection_id": "example",
    "connection_manager_delegation_is_set": true,
    "connection_manager_folder_id": "example",
    "data_export_forbidden": "off",
    "db_name": "example",
    "description": "",
    "dir_path": "example",
    "enforce_collate": "off",
    "host": "example",
    "mdb_cluster_id": "example",
    "mdb_folder_id": "example",
    "name": "example",
    "password": "example",
    "port": 0,
    "raw_sql_level": "off",
    "ssl_ca": null,
    "ssl_enable": "off",
    "type": "mysql",
    "username": "example",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **oracle**

  **Type**: [oracle](#entity-oracle)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "cache_invalidation_throttling_interval_sec": null,
    "cache_ttl_sec": null,
    "collection_id": "null",
    "data_export_forbidden": "off",
    "db_connect_method": "sid",
    "db_name": "example",
    "description": "",
    "dir_path": "example",
    "host": "example",
    "name": "example",
    "password": "example",
    "port": 0,
    "raw_sql_level": "off",
    "ssl_ca": null,
    "ssl_enable": "off",
    "type": "oracle",
    "username": "example",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **postgres**

  **Type**: [postgres](#entity-postgres)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "cache_invalidation_throttling_interval_sec": null,
    "cache_ttl_sec": null,
    "collection_id": "null",
    "connection_manager_cloud_id": "example",
    "connection_manager_connection_id": "example",
    "connection_manager_delegation_is_set": true,
    "connection_manager_folder_id": "example",
    "data_export_forbidden": "off",
    "db_name": "example",
    "description": "",
    "dir_path": "example",
    "enforce_collate": "auto",
    "host": "example",
    "mdb_cluster_id": "example",
    "mdb_folder_id": "example",
    "name": "example",
    "password": "example",
    "port": 0,
    "raw_sql_level": "off",
    "ssl_ca": null,
    "ssl_enable": "off",
    "type": "postgres",
    "username": "example",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **promql**

  **Type**: [promql](#entity-promql)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "auth_header": "example",
    "auth_type": "password",
    "cache_invalidation_throttling_interval_sec": null,
    "cache_ttl_sec": null,
    "collection_id": "null",
    "data_export_forbidden": "off",
    "db_name": "example",
    "description": "",
    "dir_path": "example",
    "host": "example",
    "name": "example",
    "password": "example",
    "path": "example",
    "port": 0,
    "secure": true,
    "type": "promql",
    "username": "example",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **smb_heatmaps**

  **Type**: [smb_heatmaps](#entity-smb_heatmaps)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "collection_id": "null",
    "description": "",
    "dir_path": "example",
    "name": "example",
    "token": "example",
    "type": "smb_heatmaps",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **snowflake**

  **Type**: [snowflake](#entity-snowflake)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "account_name": "example",
    "client_id": "example",
    "client_secret": "example",
    "collection_id": "null",
    "data_export_forbidden": "off",
    "db_name": "example",
    "description": "",
    "dir_path": "example",
    "name": "example",
    "raw_sql_level": "off",
    "refresh_token": "example",
    "refresh_token_expire_time": "2025-01-01T00:00:00Z",
    "schema": "example",
    "type": "snowflake",
    "user_name": "example",
    "user_role": "example",
    "warehouse": "example",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **speechsense**

  **Type**: [speechsense](#entity-speechsense)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "auth_type": "user_credentials",
    "cloud_id": "null",
    "collection_id": "null",
    "data_export_forbidden": "off",
    "delegation_is_set": null,
    "description": "",
    "dir_path": "example",
    "folder_id": "null",
    "name": "example",
    "project_id": "example",
    "service_account_id": "null",
    "type": "speechsense",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **trino**

  **Type**: [trino](#entity-trino)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "auth_type": null,
    "cache_invalidation_throttling_interval_sec": null,
    "cache_ttl_sec": null,
    "cloud_id": "example",
    "collection_id": "null",
    "data_export_forbidden": "off",
    "db_name": "example",
    "delegation_is_set": true,
    "description": "",
    "dir_path": "example",
    "folder_id": "example",
    "host": "example",
    "jwt": "example",
    "listing_sources": null,
    "mdb_cluster_id": "example",
    "name": "example",
    "password": "example",
    "port": 0,
    "raw_sql_level": "off",
    "service_account_id": "example",
    "ssl_ca": null,
    "ssl_enable": "off",
    "type": "trino",
    "username": "example",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **usage_analytics_detailed**

  **Type**: [usage_analytics_detailed](#entity-usage_analytics_detailed)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "collection_id": "null",
    "description": "",
    "dir_path": "example",
    "name": "example",
    "type": "usage_analytics_detailed",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **usage_analytics_light**

  **Type**: [usage_analytics_light](#entity-usage_analytics_light)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "collection_id": "null",
    "description": "",
    "dir_path": "example",
    "name": "example",
    "type": "usage_analytics_light",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **ydb**

  **Type**: [ydb](#entity-ydb)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "auth_type": "anonymous",
    "cache_invalidation_throttling_interval_sec": null,
    "cache_ttl_sec": null,
    "cloud_id": "example",
    "collection_id": "null",
    "data_export_forbidden": "off",
    "db_name": "example",
    "delegation_is_set": true,
    "description": "",
    "dir_path": "example",
    "folder_id": "example",
    "host": "example",
    "mdb_cluster_id": "example",
    "mdb_folder_id": "example",
    "name": "example",
    "port": 0,
    "raw_sql_level": "off",
    "service_account_id": "example",
    "ssl_ca": null,
    "ssl_enable": "on",
    "token": "example",
    "type": "ydb",
    "username": "example",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **yq**

  **Type**: [yq](#entity-yq)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "cache_invalidation_throttling_interval_sec": null,
    "cache_ttl_sec": null,
    "cloud_id": "example",
    "collection_id": "null",
    "data_export_forbidden": "off",
    "delegation_is_set": true,
    "description": "",
    "dir_path": "example",
    "folder_id": "example",
    "name": "example",
    "raw_sql_level": "off",
    "service_account_id": "example",
    "type": "yq",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

{% endcut %}

</div>

<div class="openapi-entity">

### appmetrica_api {#entity-appmetrica_api}

#|
|| **Name** | **Description** ||
||

_counter_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_dir_path_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_token_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_accuracy_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: number &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_collection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_data_export_forbidden_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Default:_{.json-schema-reset .json-schema-value} `off`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} ``
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `appmetrica_api`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_workbook_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "accuracy": null,
  "collection_id": "null",
  "counter_id": "example",
  "data_export_forbidden": "off",
  "description": "",
  "dir_path": "example",
  "name": "example",
  "token": "example",
  "type": "appmetrica_api",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### bigquery {#entity-bigquery}

#|
|| **Name** | **Description** ||
||

_credentials_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_dir_path_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_project_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_cache_invalidation_throttling_interval_sec_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_cache_ttl_sec_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_collection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} ``
{.table-cell}
||
||

_raw_sql_level_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `off`, `subselect`, `template`, `dashsql`
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `bigquery`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_workbook_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "cache_invalidation_throttling_interval_sec": null,
  "cache_ttl_sec": null,
  "collection_id": "null",
  "credentials": "example",
  "description": "",
  "dir_path": "example",
  "name": "example",
  "project_id": "example",
  "raw_sql_level": "off",
  "type": "bigquery",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### bitrix24 {#entity-bitrix24}

#|
|| **Name** | **Description** ||
||

_dir_path_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_portal_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_token_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_cache_invalidation_throttling_interval_sec_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_cache_ttl_sec_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_collection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_data_export_forbidden_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Default:_{.json-schema-reset .json-schema-value} `off`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} ``
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `bitrix24`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_workbook_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "cache_invalidation_throttling_interval_sec": null,
  "cache_ttl_sec": null,
  "collection_id": "null",
  "data_export_forbidden": "off",
  "description": "",
  "dir_path": "example",
  "name": "example",
  "portal": "example",
  "token": "example",
  "type": "bitrix24",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### ch_billing_analytics {#entity-ch_billing_analytics}

#|
|| **Name** | **Description** ||
||

_dir_path_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_collection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} ``
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `ch_billing_analytics`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_workbook_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "collection_id": "null",
  "description": "",
  "dir_path": "example",
  "name": "example",
  "type": "ch_billing_analytics",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### ch_ya_music_podcast_stats {#entity-ch_ya_music_podcast_stats}

#|
|| **Name** | **Description** ||
||

_dir_path_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_token_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_collection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} ``
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `ch_ya_music_podcast_stats`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_workbook_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "collection_id": "null",
  "description": "",
  "dir_path": "example",
  "name": "example",
  "token": "example",
  "type": "ch_ya_music_podcast_stats",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### chyt {#entity-chyt}

#|
|| **Name** | **Description** ||
||

_alias_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_dir_path_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_host_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_port_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: integer
{.table-cell}
||
||

_token_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_cache_invalidation_throttling_interval_sec_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_cache_ttl_sec_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_collection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_data_export_forbidden_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Default:_{.json-schema-reset .json-schema-value} `off`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} ``
{.table-cell}
||
||

_raw_sql_level_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `off`, `subselect`, `template`, `dashsql`
{.table-cell}
||
||

_secure_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `chyt`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_workbook_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "alias": "example",
  "cache_invalidation_throttling_interval_sec": null,
  "cache_ttl_sec": null,
  "collection_id": "null",
  "data_export_forbidden": "off",
  "description": "",
  "dir_path": "example",
  "host": "example",
  "name": "example",
  "port": 0,
  "raw_sql_level": "off",
  "secure": true,
  "token": "example",
  "type": "chyt",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### clickhouse {#entity-clickhouse}

#|
|| **Name** | **Description** ||
||

_dir_path_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_host_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_port_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: integer
{.table-cell}
||
||

_cache_invalidation_throttling_interval_sec_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_cache_ttl_sec_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_collection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_connection_manager_cloud_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_manager_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_manager_delegation_is_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean &#124; null
{.table-cell}
||
||

_connection_manager_folder_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_data_export_forbidden_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Default:_{.json-schema-reset .json-schema-value} `off`
{.table-cell}
||
||

_db_name_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} ``
{.table-cell}
||
||

_experimental_features_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Default:_{.json-schema-reset .json-schema-value} `off`
{.table-cell}
||
||

_mdb_cluster_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_mdb_folder_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_password_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_raw_sql_level_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `off`, `subselect`, `template`, `dashsql`
{.table-cell}
||
||

_readonly_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer

_Default:_{.json-schema-reset .json-schema-value} `2`
{.table-cell}
||
||

_secure_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
||

_ssl_ca_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_ssl_ca_verify_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Default:_{.json-schema-reset .json-schema-value} `on`
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `clickhouse`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_username_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_workbook_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "cache_invalidation_throttling_interval_sec": null,
  "cache_ttl_sec": null,
  "collection_id": "null",
  "connection_manager_cloud_id": "example",
  "connection_manager_connection_id": "example",
  "connection_manager_delegation_is_set": true,
  "connection_manager_folder_id": "example",
  "data_export_forbidden": "off",
  "db_name": "example",
  "description": "",
  "dir_path": "example",
  "experimental_features": "off",
  "host": "example",
  "mdb_cluster_id": "example",
  "mdb_folder_id": "example",
  "name": "example",
  "password": "example",
  "port": 0,
  "raw_sql_level": "off",
  "readonly": 2,
  "secure": null,
  "ssl_ca": null,
  "ssl_ca_verify": "on",
  "type": "clickhouse",
  "username": "example",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### equeo {#entity-equeo}

#|
|| **Name** | **Description** ||
||

_access_token_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_dir_path_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_collection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} ``
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `equeo`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_workbook_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "access_token": "example",
  "collection_id": "null",
  "description": "",
  "dir_path": "example",
  "name": "example",
  "type": "equeo",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### extractor1c {#entity-extractor1c}

#|
|| **Name** | **Description** ||
||

_access_token_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_dir_path_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_collection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} ``
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `extractor1c`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_workbook_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "access_token": "example",
  "collection_id": "null",
  "description": "",
  "dir_path": "example",
  "name": "example",
  "type": "extractor1c",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### greenplum {#entity-greenplum}

#|
|| **Name** | **Description** ||
||

_dir_path_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_host_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_password_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_port_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: integer
{.table-cell}
||
||

_username_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_cache_invalidation_throttling_interval_sec_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_cache_ttl_sec_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_collection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_data_export_forbidden_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Default:_{.json-schema-reset .json-schema-value} `off`
{.table-cell}
||
||

_db_name_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} ``
{.table-cell}
||
||

_enforce_collate_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `auto`

_Enum:_{.json-schema-reset .json-schema-value} `auto`, `on`, `off`
{.table-cell}
||
||

_mdb_cluster_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_mdb_folder_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_raw_sql_level_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `off`, `subselect`, `template`, `dashsql`
{.table-cell}
||
||

_ssl_ca_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_ssl_enable_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Default:_{.json-schema-reset .json-schema-value} `off`
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `greenplum`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_workbook_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "cache_invalidation_throttling_interval_sec": null,
  "cache_ttl_sec": null,
  "collection_id": "null",
  "data_export_forbidden": "off",
  "db_name": "example",
  "description": "",
  "dir_path": "example",
  "enforce_collate": "auto",
  "host": "example",
  "mdb_cluster_id": "example",
  "mdb_folder_id": "example",
  "name": "example",
  "password": "example",
  "port": 0,
  "raw_sql_level": "off",
  "ssl_ca": null,
  "ssl_enable": "off",
  "type": "greenplum",
  "username": "example",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### gsheets {#entity-gsheets}

#|
|| **Name** | **Description** ||
||

_dir_path_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_url_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_cache_invalidation_throttling_interval_sec_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_cache_ttl_sec_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_collection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_data_export_forbidden_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Default:_{.json-schema-reset .json-schema-value} `off`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} ``
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `gsheets`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_workbook_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "cache_invalidation_throttling_interval_sec": null,
  "cache_ttl_sec": null,
  "collection_id": "null",
  "data_export_forbidden": "off",
  "description": "",
  "dir_path": "example",
  "name": "example",
  "type": "gsheets",
  "url": "example",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### json_api {#entity-json_api}

#|
|| **Name** | **Description** ||
||

_allowed_methods_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string[]

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  "GET"
]
```

{% endcut %}
{.table-cell}
||
||

_dir_path_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_host_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_port_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: integer
{.table-cell}
||
||

_collection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} ``
{.table-cell}
||
||

_path_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_plain_headers_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: object &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
||

_secret_headers_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: object &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
||

_secure_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `json_api`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_workbook_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "allowed_methods": [
    "GET"
  ],
  "collection_id": "null",
  "description": "",
  "dir_path": "example",
  "host": "example",
  "name": "example",
  "path": "example",
  "plain_headers": {},
  "port": 0,
  "secret_headers": {},
  "secure": true,
  "type": "json_api",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### kontur_market {#entity-kontur_market}

#|
|| **Name** | **Description** ||
||

_access_token_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_dir_path_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_collection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} ``
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `kontur_market`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_workbook_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "access_token": "example",
  "collection_id": "null",
  "description": "",
  "dir_path": "example",
  "name": "example",
  "type": "kontur_market",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### metrika_api {#entity-metrika_api}

#|
|| **Name** | **Description** ||
||

_counter_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_dir_path_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_token_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_accuracy_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: number &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_collection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_data_export_forbidden_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Default:_{.json-schema-reset .json-schema-value} `off`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} ``
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `metrika_api`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_workbook_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "accuracy": null,
  "collection_id": "null",
  "counter_id": "example",
  "data_export_forbidden": "off",
  "description": "",
  "dir_path": "example",
  "name": "example",
  "token": "example",
  "type": "metrika_api",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### monitoring {#entity-monitoring}

#|
|| **Name** | **Description** ||
||

_cloud_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_dir_path_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_folder_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_service_account_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_cache_invalidation_throttling_interval_sec_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_cache_ttl_sec_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_collection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_delegation_is_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean &#124; null
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} ``
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `monitoring`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_workbook_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "cache_invalidation_throttling_interval_sec": null,
  "cache_ttl_sec": null,
  "cloud_id": "example",
  "collection_id": "null",
  "delegation_is_set": true,
  "description": "",
  "dir_path": "example",
  "folder_id": "example",
  "name": "example",
  "service_account_id": "example",
  "type": "monitoring",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### moysklad {#entity-moysklad}

#|
|| **Name** | **Description** ||
||

_access_token_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_dir_path_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_collection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} ``
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `moysklad`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_workbook_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "access_token": "example",
  "collection_id": "null",
  "description": "",
  "dir_path": "example",
  "name": "example",
  "type": "moysklad",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### mssql {#entity-mssql}

#|
|| **Name** | **Description** ||
||

_dir_path_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_host_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_password_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_port_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: integer
{.table-cell}
||
||

_username_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_cache_invalidation_throttling_interval_sec_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_cache_ttl_sec_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_collection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_data_export_forbidden_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Default:_{.json-schema-reset .json-schema-value} `off`
{.table-cell}
||
||

_db_name_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} ``
{.table-cell}
||
||

_raw_sql_level_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `off`, `subselect`, `template`, `dashsql`
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `mssql`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_workbook_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "cache_invalidation_throttling_interval_sec": null,
  "cache_ttl_sec": null,
  "collection_id": "null",
  "data_export_forbidden": "off",
  "db_name": "example",
  "description": "",
  "dir_path": "example",
  "host": "example",
  "name": "example",
  "password": "example",
  "port": 0,
  "raw_sql_level": "off",
  "type": "mssql",
  "username": "example",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### mysql {#entity-mysql}

#|
|| **Name** | **Description** ||
||

_dir_path_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_host_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_port_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: integer
{.table-cell}
||
||

_cache_invalidation_throttling_interval_sec_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_cache_ttl_sec_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_collection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_connection_manager_cloud_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_manager_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_manager_delegation_is_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean &#124; null
{.table-cell}
||
||

_connection_manager_folder_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_data_export_forbidden_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Default:_{.json-schema-reset .json-schema-value} `off`
{.table-cell}
||
||

_db_name_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} ``
{.table-cell}
||
||

_enforce_collate_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `auto`, `on`, `off`
{.table-cell}
||
||

_mdb_cluster_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_mdb_folder_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_password_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_raw_sql_level_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `off`, `subselect`, `template`, `dashsql`
{.table-cell}
||
||

_ssl_ca_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_ssl_enable_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Default:_{.json-schema-reset .json-schema-value} `off`
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `mysql`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_username_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_workbook_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "cache_invalidation_throttling_interval_sec": null,
  "cache_ttl_sec": null,
  "collection_id": "null",
  "connection_manager_cloud_id": "example",
  "connection_manager_connection_id": "example",
  "connection_manager_delegation_is_set": true,
  "connection_manager_folder_id": "example",
  "data_export_forbidden": "off",
  "db_name": "example",
  "description": "",
  "dir_path": "example",
  "enforce_collate": "off",
  "host": "example",
  "mdb_cluster_id": "example",
  "mdb_folder_id": "example",
  "name": "example",
  "password": "example",
  "port": 0,
  "raw_sql_level": "off",
  "ssl_ca": null,
  "ssl_enable": "off",
  "type": "mysql",
  "username": "example",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### oracle {#entity-oracle}

#|
|| **Name** | **Description** ||
||

_db_connect_method_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Enum:_{.json-schema-reset .json-schema-value} `sid`, `service_name`
{.table-cell}
||
||

_dir_path_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_host_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_password_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_port_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: integer
{.table-cell}
||
||

_username_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_cache_invalidation_throttling_interval_sec_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_cache_ttl_sec_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_collection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_data_export_forbidden_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Default:_{.json-schema-reset .json-schema-value} `off`
{.table-cell}
||
||

_db_name_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} ``
{.table-cell}
||
||

_raw_sql_level_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `off`, `subselect`, `template`, `dashsql`
{.table-cell}
||
||

_ssl_ca_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_ssl_enable_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Default:_{.json-schema-reset .json-schema-value} `off`
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `oracle`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_workbook_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "cache_invalidation_throttling_interval_sec": null,
  "cache_ttl_sec": null,
  "collection_id": "null",
  "data_export_forbidden": "off",
  "db_connect_method": "sid",
  "db_name": "example",
  "description": "",
  "dir_path": "example",
  "host": "example",
  "name": "example",
  "password": "example",
  "port": 0,
  "raw_sql_level": "off",
  "ssl_ca": null,
  "ssl_enable": "off",
  "type": "oracle",
  "username": "example",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### postgres {#entity-postgres}

#|
|| **Name** | **Description** ||
||

_dir_path_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_host_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_port_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: integer
{.table-cell}
||
||

_cache_invalidation_throttling_interval_sec_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_cache_ttl_sec_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_collection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_connection_manager_cloud_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_manager_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_manager_delegation_is_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean &#124; null
{.table-cell}
||
||

_connection_manager_folder_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_data_export_forbidden_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Default:_{.json-schema-reset .json-schema-value} `off`
{.table-cell}
||
||

_db_name_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} ``
{.table-cell}
||
||

_enforce_collate_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `auto`

_Enum:_{.json-schema-reset .json-schema-value} `auto`, `on`, `off`
{.table-cell}
||
||

_mdb_cluster_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_mdb_folder_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_password_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_raw_sql_level_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `off`, `subselect`, `template`, `dashsql`
{.table-cell}
||
||

_ssl_ca_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_ssl_enable_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Default:_{.json-schema-reset .json-schema-value} `off`
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `postgres`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_username_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_workbook_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "cache_invalidation_throttling_interval_sec": null,
  "cache_ttl_sec": null,
  "collection_id": "null",
  "connection_manager_cloud_id": "example",
  "connection_manager_connection_id": "example",
  "connection_manager_delegation_is_set": true,
  "connection_manager_folder_id": "example",
  "data_export_forbidden": "off",
  "db_name": "example",
  "description": "",
  "dir_path": "example",
  "enforce_collate": "auto",
  "host": "example",
  "mdb_cluster_id": "example",
  "mdb_folder_id": "example",
  "name": "example",
  "password": "example",
  "port": 0,
  "raw_sql_level": "off",
  "ssl_ca": null,
  "ssl_enable": "off",
  "type": "postgres",
  "username": "example",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### promql {#entity-promql}

#|
|| **Name** | **Description** ||
||

_dir_path_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_host_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_port_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: integer
{.table-cell}
||
||

_auth_header_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_auth_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Default:_{.json-schema-reset .json-schema-value} `password`
{.table-cell}
||
||

_cache_invalidation_throttling_interval_sec_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_cache_ttl_sec_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_collection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_data_export_forbidden_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Default:_{.json-schema-reset .json-schema-value} `off`
{.table-cell}
||
||

_db_name_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} ``
{.table-cell}
||
||

_password_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_path_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_secure_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `promql`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_username_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_workbook_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "auth_header": "example",
  "auth_type": "password",
  "cache_invalidation_throttling_interval_sec": null,
  "cache_ttl_sec": null,
  "collection_id": "null",
  "data_export_forbidden": "off",
  "db_name": "example",
  "description": "",
  "dir_path": "example",
  "host": "example",
  "name": "example",
  "password": "example",
  "path": "example",
  "port": 0,
  "secure": true,
  "type": "promql",
  "username": "example",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### smb_heatmaps {#entity-smb_heatmaps}

#|
|| **Name** | **Description** ||
||

_dir_path_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_token_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_collection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} ``
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `smb_heatmaps`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_workbook_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "collection_id": "null",
  "description": "",
  "dir_path": "example",
  "name": "example",
  "token": "example",
  "type": "smb_heatmaps",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### snowflake {#entity-snowflake}

#|
|| **Name** | **Description** ||
||

_account_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_client_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_client_secret_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_db_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_dir_path_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_schema_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_user_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_warehouse_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_collection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_data_export_forbidden_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Default:_{.json-schema-reset .json-schema-value} `off`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} ``
{.table-cell}
||
||

_raw_sql_level_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `off`, `subselect`, `template`, `dashsql`
{.table-cell}
||
||

_refresh_token_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_refresh_token_expire_time_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `2025-01-01T00:00:00Z`
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `snowflake`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_user_role_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_workbook_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "account_name": "example",
  "client_id": "example",
  "client_secret": "example",
  "collection_id": "null",
  "data_export_forbidden": "off",
  "db_name": "example",
  "description": "",
  "dir_path": "example",
  "name": "example",
  "raw_sql_level": "off",
  "refresh_token": "example",
  "refresh_token_expire_time": "2025-01-01T00:00:00Z",
  "schema": "example",
  "type": "snowflake",
  "user_name": "example",
  "user_role": "example",
  "warehouse": "example",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### speechsense {#entity-speechsense}

#|
|| **Name** | **Description** ||
||

_dir_path_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_project_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_auth_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Default:_{.json-schema-reset .json-schema-value} `user_credentials`
{.table-cell}
||
||

_cloud_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_collection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_data_export_forbidden_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Default:_{.json-schema-reset .json-schema-value} `off`
{.table-cell}
||
||

_delegation_is_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} ``
{.table-cell}
||
||

_folder_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_service_account_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `speechsense`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_workbook_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "auth_type": "user_credentials",
  "cloud_id": "null",
  "collection_id": "null",
  "data_export_forbidden": "off",
  "delegation_is_set": null,
  "description": "",
  "dir_path": "example",
  "folder_id": "null",
  "name": "example",
  "project_id": "example",
  "service_account_id": "null",
  "type": "speechsense",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### trino {#entity-trino}

#|
|| **Name** | **Description** ||
||

_dir_path_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_host_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_listing_sources_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_auth_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
||

_cache_invalidation_throttling_interval_sec_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_cache_ttl_sec_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_cloud_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_collection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_data_export_forbidden_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Default:_{.json-schema-reset .json-schema-value} `off`
{.table-cell}
||
||

_db_name_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_delegation_is_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean &#124; null
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} ``
{.table-cell}
||
||

_folder_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_jwt_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_mdb_cluster_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_password_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_port_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer &#124; null
{.table-cell}
||
||

_raw_sql_level_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `off`, `subselect`, `template`, `dashsql`
{.table-cell}
||
||

_service_account_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_ssl_ca_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_ssl_enable_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Default:_{.json-schema-reset .json-schema-value} `off`
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `trino`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_username_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_workbook_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "auth_type": null,
  "cache_invalidation_throttling_interval_sec": null,
  "cache_ttl_sec": null,
  "cloud_id": "example",
  "collection_id": "null",
  "data_export_forbidden": "off",
  "db_name": "example",
  "delegation_is_set": true,
  "description": "",
  "dir_path": "example",
  "folder_id": "example",
  "host": "example",
  "jwt": "example",
  "listing_sources": null,
  "mdb_cluster_id": "example",
  "name": "example",
  "password": "example",
  "port": 0,
  "raw_sql_level": "off",
  "service_account_id": "example",
  "ssl_ca": null,
  "ssl_enable": "off",
  "type": "trino",
  "username": "example",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### usage_analytics_detailed {#entity-usage_analytics_detailed}

#|
|| **Name** | **Description** ||
||

_dir_path_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_collection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} ``
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `usage_analytics_detailed`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_workbook_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "collection_id": "null",
  "description": "",
  "dir_path": "example",
  "name": "example",
  "type": "usage_analytics_detailed",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### usage_analytics_light {#entity-usage_analytics_light}

#|
|| **Name** | **Description** ||
||

_dir_path_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_collection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} ``
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `usage_analytics_light`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_workbook_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "collection_id": "null",
  "description": "",
  "dir_path": "example",
  "name": "example",
  "type": "usage_analytics_light",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### ydb {#entity-ydb}

#|
|| **Name** | **Description** ||
||

_cloud_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_db_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_dir_path_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_folder_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_host_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_port_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: integer
{.table-cell}
||
||

_service_account_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_auth_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `anonymous`, `password`, `oauth`, `null`

_Example:_{.json-schema-reset .json-schema-example} `anonymous`
{.table-cell}
||
||

_cache_invalidation_throttling_interval_sec_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_cache_ttl_sec_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_collection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_data_export_forbidden_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Default:_{.json-schema-reset .json-schema-value} `off`
{.table-cell}
||
||

_delegation_is_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean &#124; null
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} ``
{.table-cell}
||
||

_mdb_cluster_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_mdb_folder_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_raw_sql_level_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `off`, `subselect`, `template`, `dashsql`
{.table-cell}
||
||

_ssl_ca_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_ssl_enable_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Default:_{.json-schema-reset .json-schema-value} `on`
{.table-cell}
||
||

_token_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `ydb`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_username_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_workbook_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "auth_type": "anonymous",
  "cache_invalidation_throttling_interval_sec": null,
  "cache_ttl_sec": null,
  "cloud_id": "example",
  "collection_id": "null",
  "data_export_forbidden": "off",
  "db_name": "example",
  "delegation_is_set": true,
  "description": "",
  "dir_path": "example",
  "folder_id": "example",
  "host": "example",
  "mdb_cluster_id": "example",
  "mdb_folder_id": "example",
  "name": "example",
  "port": 0,
  "raw_sql_level": "off",
  "service_account_id": "example",
  "ssl_ca": null,
  "ssl_enable": "on",
  "token": "example",
  "type": "ydb",
  "username": "example",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### yq {#entity-yq}

#|
|| **Name** | **Description** ||
||

_cloud_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_dir_path_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_folder_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_service_account_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_cache_invalidation_throttling_interval_sec_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_cache_ttl_sec_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_collection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_data_export_forbidden_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Default:_{.json-schema-reset .json-schema-value} `off`
{.table-cell}
||
||

_delegation_is_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean &#124; null
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} ``
{.table-cell}
||
||

_raw_sql_level_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `off`, `subselect`, `template`, `dashsql`
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `yq`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_workbook_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "cache_invalidation_throttling_interval_sec": null,
  "cache_ttl_sec": null,
  "cloud_id": "example",
  "collection_id": "null",
  "data_export_forbidden": "off",
  "delegation_is_set": true,
  "description": "",
  "dir_path": "example",
  "folder_id": "example",
  "name": "example",
  "raw_sql_level": "off",
  "service_account_id": "example",
  "type": "yq",
  "workbook_id": "null"
}
```

{% endcut %}

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
  "id": "example"
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

</div>

<div class="openapi-entity">

### appmetrica_api {#entity-appmetrica_api1}

#|
|| **Name** | **Description** ||
||

_counter_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_dir_path_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_accuracy_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: number &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_collection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_created_at_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_data_export_forbidden_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Default:_{.json-schema-reset .json-schema-value} `off`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} ``
{.table-cell}
||
||

_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_key_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_meta_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_[additional]_{.json-schema-reset .json-schema-additional-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `appmetrica_api`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_updated_at_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_workbook_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "accuracy": null,
  "collection_id": "null",
  "counter_id": "example",
  "created_at": "example",
  "data_export_forbidden": "off",
  "description": "",
  "dir_path": "example",
  "id": "example",
  "key": "example",
  "meta": {},
  "name": "example",
  "type": "appmetrica_api",
  "updated_at": "example",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### bigquery {#entity-bigquery1}

#|
|| **Name** | **Description** ||
||

_dir_path_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_project_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_cache_invalidation_throttling_interval_sec_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_cache_ttl_sec_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_collection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_created_at_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} ``
{.table-cell}
||
||

_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_key_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_raw_sql_level_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `off`, `subselect`, `template`, `dashsql`
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `bigquery`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_updated_at_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_workbook_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "cache_invalidation_throttling_interval_sec": null,
  "cache_ttl_sec": null,
  "collection_id": "null",
  "created_at": "example",
  "description": "",
  "dir_path": "example",
  "id": "example",
  "key": "example",
  "name": "example",
  "project_id": "example",
  "raw_sql_level": "off",
  "type": "bigquery",
  "updated_at": "example",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### bitrix24 {#entity-bitrix241}

#|
|| **Name** | **Description** ||
||

_dir_path_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_portal_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_cache_invalidation_throttling_interval_sec_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_cache_ttl_sec_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_collection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_created_at_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_data_export_forbidden_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Default:_{.json-schema-reset .json-schema-value} `off`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} ``
{.table-cell}
||
||

_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_key_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_meta_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_[additional]_{.json-schema-reset .json-schema-additional-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `bitrix24`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_updated_at_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_workbook_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "cache_invalidation_throttling_interval_sec": null,
  "cache_ttl_sec": null,
  "collection_id": "null",
  "created_at": "example",
  "data_export_forbidden": "off",
  "description": "",
  "dir_path": "example",
  "id": "example",
  "key": "example",
  "meta": {},
  "name": "example",
  "portal": "example",
  "type": "bitrix24",
  "updated_at": "example",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### ch_billing_analytics {#entity-ch_billing_analytics1}

#|
|| **Name** | **Description** ||
||

_dir_path_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_collection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_created_at_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} ``
{.table-cell}
||
||

_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_key_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_meta_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_[additional]_{.json-schema-reset .json-schema-additional-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `ch_billing_analytics`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_updated_at_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_workbook_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "collection_id": "null",
  "created_at": "example",
  "description": "",
  "dir_path": "example",
  "id": "example",
  "key": "example",
  "meta": {},
  "name": "example",
  "type": "ch_billing_analytics",
  "updated_at": "example",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### ch_ya_music_podcast_stats {#entity-ch_ya_music_podcast_stats1}

#|
|| **Name** | **Description** ||
||

_dir_path_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_collection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_created_at_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} ``
{.table-cell}
||
||

_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_key_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_meta_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_[additional]_{.json-schema-reset .json-schema-additional-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `ch_ya_music_podcast_stats`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_updated_at_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_workbook_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "collection_id": "null",
  "created_at": "example",
  "description": "",
  "dir_path": "example",
  "id": "example",
  "key": "example",
  "meta": {},
  "name": "example",
  "type": "ch_ya_music_podcast_stats",
  "updated_at": "example",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### chyt {#entity-chyt1}

#|
|| **Name** | **Description** ||
||

_alias_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_dir_path_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_host_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_port_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: integer
{.table-cell}
||
||

_cache_invalidation_throttling_interval_sec_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_cache_ttl_sec_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_collection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_created_at_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_data_export_forbidden_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Default:_{.json-schema-reset .json-schema-value} `off`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} ``
{.table-cell}
||
||

_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_key_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_meta_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_[additional]_{.json-schema-reset .json-schema-additional-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
||

_raw_sql_level_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `off`, `subselect`, `template`, `dashsql`
{.table-cell}
||
||

_secure_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `chyt`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_updated_at_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_workbook_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "alias": "example",
  "cache_invalidation_throttling_interval_sec": null,
  "cache_ttl_sec": null,
  "collection_id": "null",
  "created_at": "example",
  "data_export_forbidden": "off",
  "description": "",
  "dir_path": "example",
  "host": "example",
  "id": "example",
  "key": "example",
  "meta": {},
  "name": "example",
  "port": 0,
  "raw_sql_level": "off",
  "secure": true,
  "type": "chyt",
  "updated_at": "example",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### clickhouse {#entity-clickhouse1}

#|
|| **Name** | **Description** ||
||

_dir_path_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_host_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_port_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: integer
{.table-cell}
||
||

_cache_invalidation_throttling_interval_sec_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_cache_ttl_sec_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_collection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_connection_manager_cloud_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_manager_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_manager_delegation_is_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean &#124; null
{.table-cell}
||
||

_connection_manager_folder_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_created_at_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_data_export_forbidden_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Default:_{.json-schema-reset .json-schema-value} `off`
{.table-cell}
||
||

_db_name_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} ``
{.table-cell}
||
||

_experimental_features_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Default:_{.json-schema-reset .json-schema-value} `off`
{.table-cell}
||
||

_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_key_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_mdb_cluster_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_mdb_folder_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_meta_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_[additional]_{.json-schema-reset .json-schema-additional-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
||

_raw_sql_level_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `off`, `subselect`, `template`, `dashsql`
{.table-cell}
||
||

_readonly_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer

_Default:_{.json-schema-reset .json-schema-value} `2`
{.table-cell}
||
||

_secure_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
||

_ssl_ca_verify_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Default:_{.json-schema-reset .json-schema-value} `on`
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `clickhouse`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_updated_at_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_username_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_workbook_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "cache_invalidation_throttling_interval_sec": null,
  "cache_ttl_sec": null,
  "collection_id": "null",
  "connection_manager_cloud_id": "example",
  "connection_manager_connection_id": "example",
  "connection_manager_delegation_is_set": true,
  "connection_manager_folder_id": "example",
  "created_at": "example",
  "data_export_forbidden": "off",
  "db_name": "example",
  "description": "",
  "dir_path": "example",
  "experimental_features": "off",
  "host": "example",
  "id": "example",
  "key": "example",
  "mdb_cluster_id": "example",
  "mdb_folder_id": "example",
  "meta": {},
  "name": "example",
  "port": 0,
  "raw_sql_level": "off",
  "readonly": 2,
  "secure": null,
  "ssl_ca_verify": "on",
  "type": "clickhouse",
  "updated_at": "example",
  "username": "example",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### equeo {#entity-equeo1}

#|
|| **Name** | **Description** ||
||

_dir_path_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_collection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_created_at_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} ``
{.table-cell}
||
||

_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_key_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_meta_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_[additional]_{.json-schema-reset .json-schema-additional-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `equeo`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_updated_at_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_workbook_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "collection_id": "null",
  "created_at": "example",
  "description": "",
  "dir_path": "example",
  "id": "example",
  "key": "example",
  "meta": {},
  "name": "example",
  "type": "equeo",
  "updated_at": "example",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### extractor1c {#entity-extractor1c1}

#|
|| **Name** | **Description** ||
||

_dir_path_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_collection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_created_at_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} ``
{.table-cell}
||
||

_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_key_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_meta_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_[additional]_{.json-schema-reset .json-schema-additional-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `extractor1c`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_updated_at_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_workbook_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "collection_id": "null",
  "created_at": "example",
  "description": "",
  "dir_path": "example",
  "id": "example",
  "key": "example",
  "meta": {},
  "name": "example",
  "type": "extractor1c",
  "updated_at": "example",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### greenplum {#entity-greenplum1}

#|
|| **Name** | **Description** ||
||

_dir_path_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_host_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_port_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: integer
{.table-cell}
||
||

_username_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_cache_invalidation_throttling_interval_sec_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_cache_ttl_sec_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_collection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_created_at_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_data_export_forbidden_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Default:_{.json-schema-reset .json-schema-value} `off`
{.table-cell}
||
||

_db_name_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} ``
{.table-cell}
||
||

_enforce_collate_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `auto`

_Enum:_{.json-schema-reset .json-schema-value} `auto`, `on`, `off`
{.table-cell}
||
||

_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_key_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_mdb_cluster_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_mdb_folder_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_meta_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_[additional]_{.json-schema-reset .json-schema-additional-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
||

_raw_sql_level_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `off`, `subselect`, `template`, `dashsql`
{.table-cell}
||
||

_ssl_enable_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Default:_{.json-schema-reset .json-schema-value} `off`
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `greenplum`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_updated_at_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_workbook_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "cache_invalidation_throttling_interval_sec": null,
  "cache_ttl_sec": null,
  "collection_id": "null",
  "created_at": "example",
  "data_export_forbidden": "off",
  "db_name": "example",
  "description": "",
  "dir_path": "example",
  "enforce_collate": "auto",
  "host": "example",
  "id": "example",
  "key": "example",
  "mdb_cluster_id": "example",
  "mdb_folder_id": "example",
  "meta": {},
  "name": "example",
  "port": 0,
  "raw_sql_level": "off",
  "ssl_enable": "off",
  "type": "greenplum",
  "updated_at": "example",
  "username": "example",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### gsheets {#entity-gsheets1}

#|
|| **Name** | **Description** ||
||

_dir_path_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_url_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_cache_invalidation_throttling_interval_sec_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_cache_ttl_sec_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_collection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_created_at_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_data_export_forbidden_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Default:_{.json-schema-reset .json-schema-value} `off`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} ``
{.table-cell}
||
||

_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_key_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_meta_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_[additional]_{.json-schema-reset .json-schema-additional-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `gsheets`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_updated_at_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_workbook_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "cache_invalidation_throttling_interval_sec": null,
  "cache_ttl_sec": null,
  "collection_id": "null",
  "created_at": "example",
  "data_export_forbidden": "off",
  "description": "",
  "dir_path": "example",
  "id": "example",
  "key": "example",
  "meta": {},
  "name": "example",
  "type": "gsheets",
  "updated_at": "example",
  "url": "example",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### json_api {#entity-json_api1}

#|
|| **Name** | **Description** ||
||

_allowed_methods_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string[]

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  "GET"
]
```

{% endcut %}
{.table-cell}
||
||

_dir_path_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_host_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_port_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: integer
{.table-cell}
||
||

_collection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_created_at_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} ``
{.table-cell}
||
||

_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_key_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_meta_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_[additional]_{.json-schema-reset .json-schema-additional-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
||

_path_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_plain_headers_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: object &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
||

_secret_headers_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: object &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
||

_secure_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `json_api`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_updated_at_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_workbook_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "allowed_methods": [
    "GET"
  ],
  "collection_id": "null",
  "created_at": "example",
  "description": "",
  "dir_path": "example",
  "host": "example",
  "id": "example",
  "key": "example",
  "meta": {},
  "name": "example",
  "path": "example",
  "plain_headers": {},
  "port": 0,
  "secret_headers": {},
  "secure": true,
  "type": "json_api",
  "updated_at": "example",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### kontur_market {#entity-kontur_market1}

#|
|| **Name** | **Description** ||
||

_dir_path_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_collection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_created_at_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} ``
{.table-cell}
||
||

_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_key_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_meta_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_[additional]_{.json-schema-reset .json-schema-additional-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `kontur_market`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_updated_at_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_workbook_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "collection_id": "null",
  "created_at": "example",
  "description": "",
  "dir_path": "example",
  "id": "example",
  "key": "example",
  "meta": {},
  "name": "example",
  "type": "kontur_market",
  "updated_at": "example",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### metrika_api {#entity-metrika_api1}

#|
|| **Name** | **Description** ||
||

_counter_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_dir_path_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_accuracy_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: number &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_collection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_created_at_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_data_export_forbidden_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Default:_{.json-schema-reset .json-schema-value} `off`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} ``
{.table-cell}
||
||

_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_key_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_meta_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_[additional]_{.json-schema-reset .json-schema-additional-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `metrika_api`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_updated_at_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_workbook_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "accuracy": null,
  "collection_id": "null",
  "counter_id": "example",
  "created_at": "example",
  "data_export_forbidden": "off",
  "description": "",
  "dir_path": "example",
  "id": "example",
  "key": "example",
  "meta": {},
  "name": "example",
  "type": "metrika_api",
  "updated_at": "example",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### monitoring {#entity-monitoring1}

#|
|| **Name** | **Description** ||
||

_cloud_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_dir_path_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_folder_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_service_account_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_cache_invalidation_throttling_interval_sec_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_cache_ttl_sec_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_collection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_created_at_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_delegation_is_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean &#124; null
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} ``
{.table-cell}
||
||

_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_key_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_meta_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_[additional]_{.json-schema-reset .json-schema-additional-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `monitoring`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_updated_at_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_workbook_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "cache_invalidation_throttling_interval_sec": null,
  "cache_ttl_sec": null,
  "cloud_id": "example",
  "collection_id": "null",
  "created_at": "example",
  "delegation_is_set": true,
  "description": "",
  "dir_path": "example",
  "folder_id": "example",
  "id": "example",
  "key": "example",
  "meta": {},
  "name": "example",
  "service_account_id": "example",
  "type": "monitoring",
  "updated_at": "example",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### moysklad {#entity-moysklad1}

#|
|| **Name** | **Description** ||
||

_dir_path_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_collection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_created_at_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} ``
{.table-cell}
||
||

_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_key_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_meta_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_[additional]_{.json-schema-reset .json-schema-additional-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `moysklad`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_updated_at_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_workbook_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "collection_id": "null",
  "created_at": "example",
  "description": "",
  "dir_path": "example",
  "id": "example",
  "key": "example",
  "meta": {},
  "name": "example",
  "type": "moysklad",
  "updated_at": "example",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### mssql {#entity-mssql1}

#|
|| **Name** | **Description** ||
||

_dir_path_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_host_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_port_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: integer
{.table-cell}
||
||

_username_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_cache_invalidation_throttling_interval_sec_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_cache_ttl_sec_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_collection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_created_at_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_data_export_forbidden_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Default:_{.json-schema-reset .json-schema-value} `off`
{.table-cell}
||
||

_db_name_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} ``
{.table-cell}
||
||

_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_key_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_meta_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_[additional]_{.json-schema-reset .json-schema-additional-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
||

_raw_sql_level_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `off`, `subselect`, `template`, `dashsql`
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `mssql`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_updated_at_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_workbook_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "cache_invalidation_throttling_interval_sec": null,
  "cache_ttl_sec": null,
  "collection_id": "null",
  "created_at": "example",
  "data_export_forbidden": "off",
  "db_name": "example",
  "description": "",
  "dir_path": "example",
  "host": "example",
  "id": "example",
  "key": "example",
  "meta": {},
  "name": "example",
  "port": 0,
  "raw_sql_level": "off",
  "type": "mssql",
  "updated_at": "example",
  "username": "example",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### mysql {#entity-mysql1}

#|
|| **Name** | **Description** ||
||

_dir_path_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_host_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_port_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: integer
{.table-cell}
||
||

_cache_invalidation_throttling_interval_sec_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_cache_ttl_sec_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_collection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_connection_manager_cloud_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_manager_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_manager_delegation_is_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean &#124; null
{.table-cell}
||
||

_connection_manager_folder_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_created_at_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_data_export_forbidden_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Default:_{.json-schema-reset .json-schema-value} `off`
{.table-cell}
||
||

_db_name_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} ``
{.table-cell}
||
||

_enforce_collate_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `auto`, `on`, `off`
{.table-cell}
||
||

_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_key_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_mdb_cluster_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_mdb_folder_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_meta_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_[additional]_{.json-schema-reset .json-schema-additional-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
||

_raw_sql_level_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `off`, `subselect`, `template`, `dashsql`
{.table-cell}
||
||

_ssl_enable_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Default:_{.json-schema-reset .json-schema-value} `off`
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `mysql`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_updated_at_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_username_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_workbook_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "cache_invalidation_throttling_interval_sec": null,
  "cache_ttl_sec": null,
  "collection_id": "null",
  "connection_manager_cloud_id": "example",
  "connection_manager_connection_id": "example",
  "connection_manager_delegation_is_set": true,
  "connection_manager_folder_id": "example",
  "created_at": "example",
  "data_export_forbidden": "off",
  "db_name": "example",
  "description": "",
  "dir_path": "example",
  "enforce_collate": "off",
  "host": "example",
  "id": "example",
  "key": "example",
  "mdb_cluster_id": "example",
  "mdb_folder_id": "example",
  "meta": {},
  "name": "example",
  "port": 0,
  "raw_sql_level": "off",
  "ssl_enable": "off",
  "type": "mysql",
  "updated_at": "example",
  "username": "example",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### oracle {#entity-oracle1}

#|
|| **Name** | **Description** ||
||

_db_connect_method_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Enum:_{.json-schema-reset .json-schema-value} `sid`, `service_name`
{.table-cell}
||
||

_dir_path_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_host_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_port_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: integer
{.table-cell}
||
||

_username_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_cache_invalidation_throttling_interval_sec_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_cache_ttl_sec_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_collection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_created_at_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_data_export_forbidden_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Default:_{.json-schema-reset .json-schema-value} `off`
{.table-cell}
||
||

_db_name_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} ``
{.table-cell}
||
||

_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_key_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_meta_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_[additional]_{.json-schema-reset .json-schema-additional-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
||

_raw_sql_level_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `off`, `subselect`, `template`, `dashsql`
{.table-cell}
||
||

_ssl_enable_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Default:_{.json-schema-reset .json-schema-value} `off`
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `oracle`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_updated_at_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_workbook_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "cache_invalidation_throttling_interval_sec": null,
  "cache_ttl_sec": null,
  "collection_id": "null",
  "created_at": "example",
  "data_export_forbidden": "off",
  "db_connect_method": "sid",
  "db_name": "example",
  "description": "",
  "dir_path": "example",
  "host": "example",
  "id": "example",
  "key": "example",
  "meta": {},
  "name": "example",
  "port": 0,
  "raw_sql_level": "off",
  "ssl_enable": "off",
  "type": "oracle",
  "updated_at": "example",
  "username": "example",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### postgres {#entity-postgres1}

#|
|| **Name** | **Description** ||
||

_dir_path_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_host_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_port_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: integer
{.table-cell}
||
||

_cache_invalidation_throttling_interval_sec_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_cache_ttl_sec_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_collection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_connection_manager_cloud_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_manager_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_manager_delegation_is_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean &#124; null
{.table-cell}
||
||

_connection_manager_folder_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_created_at_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_data_export_forbidden_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Default:_{.json-schema-reset .json-schema-value} `off`
{.table-cell}
||
||

_db_name_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} ``
{.table-cell}
||
||

_enforce_collate_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `auto`

_Enum:_{.json-schema-reset .json-schema-value} `auto`, `on`, `off`
{.table-cell}
||
||

_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_key_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_mdb_cluster_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_mdb_folder_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_meta_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_[additional]_{.json-schema-reset .json-schema-additional-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
||

_raw_sql_level_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `off`, `subselect`, `template`, `dashsql`
{.table-cell}
||
||

_ssl_enable_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Default:_{.json-schema-reset .json-schema-value} `off`
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `postgres`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_updated_at_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_username_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_workbook_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "cache_invalidation_throttling_interval_sec": null,
  "cache_ttl_sec": null,
  "collection_id": "null",
  "connection_manager_cloud_id": "example",
  "connection_manager_connection_id": "example",
  "connection_manager_delegation_is_set": true,
  "connection_manager_folder_id": "example",
  "created_at": "example",
  "data_export_forbidden": "off",
  "db_name": "example",
  "description": "",
  "dir_path": "example",
  "enforce_collate": "auto",
  "host": "example",
  "id": "example",
  "key": "example",
  "mdb_cluster_id": "example",
  "mdb_folder_id": "example",
  "meta": {},
  "name": "example",
  "port": 0,
  "raw_sql_level": "off",
  "ssl_enable": "off",
  "type": "postgres",
  "updated_at": "example",
  "username": "example",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### promql {#entity-promql1}

#|
|| **Name** | **Description** ||
||

_dir_path_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_host_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_port_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: integer
{.table-cell}
||
||

_auth_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Default:_{.json-schema-reset .json-schema-value} `password`
{.table-cell}
||
||

_cache_invalidation_throttling_interval_sec_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_cache_ttl_sec_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_collection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_created_at_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_data_export_forbidden_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Default:_{.json-schema-reset .json-schema-value} `off`
{.table-cell}
||
||

_db_name_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} ``
{.table-cell}
||
||

_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_key_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_meta_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_[additional]_{.json-schema-reset .json-schema-additional-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
||

_path_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_secure_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `promql`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_updated_at_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_username_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_workbook_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "auth_type": "password",
  "cache_invalidation_throttling_interval_sec": null,
  "cache_ttl_sec": null,
  "collection_id": "null",
  "created_at": "example",
  "data_export_forbidden": "off",
  "db_name": "example",
  "description": "",
  "dir_path": "example",
  "host": "example",
  "id": "example",
  "key": "example",
  "meta": {},
  "name": "example",
  "path": "example",
  "port": 0,
  "secure": true,
  "type": "promql",
  "updated_at": "example",
  "username": "example",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### smb_heatmaps {#entity-smb_heatmaps1}

#|
|| **Name** | **Description** ||
||

_dir_path_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_collection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_created_at_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} ``
{.table-cell}
||
||

_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_key_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_meta_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_[additional]_{.json-schema-reset .json-schema-additional-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `smb_heatmaps`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_updated_at_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_workbook_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "collection_id": "null",
  "created_at": "example",
  "description": "",
  "dir_path": "example",
  "id": "example",
  "key": "example",
  "meta": {},
  "name": "example",
  "type": "smb_heatmaps",
  "updated_at": "example",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### snowflake {#entity-snowflake1}

#|
|| **Name** | **Description** ||
||

_account_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_client_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_db_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_dir_path_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_schema_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_user_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_warehouse_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_collection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_created_at_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_data_export_forbidden_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Default:_{.json-schema-reset .json-schema-value} `off`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} ``
{.table-cell}
||
||

_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_key_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_raw_sql_level_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `off`, `subselect`, `template`, `dashsql`
{.table-cell}
||
||

_refresh_token_expire_time_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `2025-01-01T00:00:00Z`
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `snowflake`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_updated_at_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_user_role_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_workbook_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "account_name": "example",
  "client_id": "example",
  "collection_id": "null",
  "created_at": "example",
  "data_export_forbidden": "off",
  "db_name": "example",
  "description": "",
  "dir_path": "example",
  "id": "example",
  "key": "example",
  "name": "example",
  "raw_sql_level": "off",
  "refresh_token_expire_time": "2025-01-01T00:00:00Z",
  "schema": "example",
  "type": "snowflake",
  "updated_at": "example",
  "user_name": "example",
  "user_role": "example",
  "warehouse": "example",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### speechsense {#entity-speechsense1}

#|
|| **Name** | **Description** ||
||

_dir_path_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_project_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_auth_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Default:_{.json-schema-reset .json-schema-value} `user_credentials`
{.table-cell}
||
||

_cloud_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_collection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_created_at_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_data_export_forbidden_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Default:_{.json-schema-reset .json-schema-value} `off`
{.table-cell}
||
||

_delegation_is_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} ``
{.table-cell}
||
||

_folder_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_key_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_meta_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_[additional]_{.json-schema-reset .json-schema-additional-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
||

_service_account_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `speechsense`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_updated_at_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_workbook_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "auth_type": "user_credentials",
  "cloud_id": "null",
  "collection_id": "null",
  "created_at": "example",
  "data_export_forbidden": "off",
  "delegation_is_set": null,
  "description": "",
  "dir_path": "example",
  "folder_id": "null",
  "id": "example",
  "key": "example",
  "meta": {},
  "name": "example",
  "project_id": "example",
  "service_account_id": "null",
  "type": "speechsense",
  "updated_at": "example",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### trino {#entity-trino1}

#|
|| **Name** | **Description** ||
||

_dir_path_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_host_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_listing_sources_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_auth_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
||

_cache_invalidation_throttling_interval_sec_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_cache_ttl_sec_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_cloud_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_collection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_created_at_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_data_export_forbidden_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Default:_{.json-schema-reset .json-schema-value} `off`
{.table-cell}
||
||

_db_name_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_delegation_is_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean &#124; null
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} ``
{.table-cell}
||
||

_folder_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_key_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_mdb_cluster_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_meta_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_[additional]_{.json-schema-reset .json-schema-additional-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
||

_port_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer &#124; null
{.table-cell}
||
||

_raw_sql_level_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `off`, `subselect`, `template`, `dashsql`
{.table-cell}
||
||

_service_account_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_ssl_enable_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Default:_{.json-schema-reset .json-schema-value} `off`
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `trino`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_updated_at_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_username_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_workbook_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "auth_type": null,
  "cache_invalidation_throttling_interval_sec": null,
  "cache_ttl_sec": null,
  "cloud_id": "example",
  "collection_id": "null",
  "created_at": "example",
  "data_export_forbidden": "off",
  "db_name": "example",
  "delegation_is_set": true,
  "description": "",
  "dir_path": "example",
  "folder_id": "example",
  "host": "example",
  "id": "example",
  "key": "example",
  "listing_sources": null,
  "mdb_cluster_id": "example",
  "meta": {},
  "name": "example",
  "port": 0,
  "raw_sql_level": "off",
  "service_account_id": "example",
  "ssl_enable": "off",
  "type": "trino",
  "updated_at": "example",
  "username": "example",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### usage_analytics_detailed {#entity-usage_analytics_detailed1}

#|
|| **Name** | **Description** ||
||

_dir_path_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_collection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_created_at_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} ``
{.table-cell}
||
||

_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_key_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_meta_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_[additional]_{.json-schema-reset .json-schema-additional-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `usage_analytics_detailed`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_updated_at_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_workbook_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "collection_id": "null",
  "created_at": "example",
  "description": "",
  "dir_path": "example",
  "id": "example",
  "key": "example",
  "meta": {},
  "name": "example",
  "type": "usage_analytics_detailed",
  "updated_at": "example",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### usage_analytics_light {#entity-usage_analytics_light1}

#|
|| **Name** | **Description** ||
||

_dir_path_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_collection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_created_at_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} ``
{.table-cell}
||
||

_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_key_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_meta_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_[additional]_{.json-schema-reset .json-schema-additional-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `usage_analytics_light`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_updated_at_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_workbook_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "collection_id": "null",
  "created_at": "example",
  "description": "",
  "dir_path": "example",
  "id": "example",
  "key": "example",
  "meta": {},
  "name": "example",
  "type": "usage_analytics_light",
  "updated_at": "example",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### ydb {#entity-ydb1}

#|
|| **Name** | **Description** ||
||

_cloud_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_db_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_dir_path_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_folder_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_host_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_port_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: integer
{.table-cell}
||
||

_service_account_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_auth_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `anonymous`, `password`, `oauth`, `null`

_Example:_{.json-schema-reset .json-schema-example} `anonymous`
{.table-cell}
||
||

_cache_invalidation_throttling_interval_sec_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_cache_ttl_sec_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_collection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_created_at_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_data_export_forbidden_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Default:_{.json-schema-reset .json-schema-value} `off`
{.table-cell}
||
||

_delegation_is_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean &#124; null
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} ``
{.table-cell}
||
||

_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_key_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_mdb_cluster_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_mdb_folder_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_raw_sql_level_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `off`, `subselect`, `template`, `dashsql`
{.table-cell}
||
||

_ssl_enable_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Default:_{.json-schema-reset .json-schema-value} `on`
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `ydb`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_updated_at_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_username_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_workbook_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "auth_type": "anonymous",
  "cache_invalidation_throttling_interval_sec": null,
  "cache_ttl_sec": null,
  "cloud_id": "example",
  "collection_id": "null",
  "created_at": "example",
  "data_export_forbidden": "off",
  "db_name": "example",
  "delegation_is_set": true,
  "description": "",
  "dir_path": "example",
  "folder_id": "example",
  "host": "example",
  "id": "example",
  "key": "example",
  "mdb_cluster_id": "example",
  "mdb_folder_id": "example",
  "name": "example",
  "port": 0,
  "raw_sql_level": "off",
  "service_account_id": "example",
  "ssl_enable": "on",
  "type": "ydb",
  "updated_at": "example",
  "username": "example",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### yq {#entity-yq1}

#|
|| **Name** | **Description** ||
||

_cloud_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_dir_path_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_folder_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_service_account_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_cache_invalidation_throttling_interval_sec_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_cache_ttl_sec_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_collection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_created_at_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_data_export_forbidden_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Default:_{.json-schema-reset .json-schema-value} `off`
{.table-cell}
||
||

_delegation_is_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean &#124; null
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} ``
{.table-cell}
||
||

_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_key_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_raw_sql_level_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `off`, `subselect`, `template`, `dashsql`
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `yq`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_updated_at_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_workbook_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "cache_invalidation_throttling_interval_sec": null,
  "cache_ttl_sec": null,
  "cloud_id": "example",
  "collection_id": "null",
  "created_at": "example",
  "data_export_forbidden": "off",
  "delegation_is_set": true,
  "description": "",
  "dir_path": "example",
  "folder_id": "example",
  "id": "example",
  "key": "example",
  "name": "example",
  "raw_sql_level": "off",
  "service_account_id": "example",
  "type": "yq",
  "updated_at": "example",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.