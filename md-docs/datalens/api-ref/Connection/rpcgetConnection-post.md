[Документация Yandex Cloud](../../../index.md) > [Yandex DataLens](../../index.md) > DataLens Public API > [DataLens API (англ.)](../index.md) > [Connection](index.md) > Get connection

<div class="openapi">

# Get connection

<!-- markdownlint-disable-file -->

Returns the specified connection.

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
https://api.datalens.tech/rpc/getConnection
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
||

_x-dl-audit-mode_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `true`

_Example:_{.json-schema-reset .json-schema-example} ``
{.table-cell}
||
|#{.json-schema-properties}

<div class="openapi-entity">

### Body

{% cut "application/json" %}

```json translate=no
{
  "connectionId": "example",
  "workbookId": "example",
  "bindedDatasetId": "example",
  "rev_id": "example"
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_connectionId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_bindedDatasetId_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_rev_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_workbookId_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

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
  "accuracy": null,
  "collection_id": "null",
  "counter_id": "example",
  "created_at": "example",
  "data_export_forbidden": "off",
  "description": "",
  "id": "example",
  "key": "example",
  "meta": {},
  "name": "example",
  "type": "appmetrica_api",
  "updated_at": "example"
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
|#{.json-schema-properties}

{% cut "**One of 29 types**" %}{.json-schema-combinators data-marker=or}

- **appmetrica_api**

  **Type**: [appmetrica_api1](#entity-appmetrica_api1)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "accuracy": null,
    "collection_id": "null",
    "counter_id": "example",
    "created_at": "example",
    "data_export_forbidden": "off",
    "description": "",
    "id": "example",
    "key": "example",
    "meta": {},
    "name": "example",
    "type": "appmetrica_api",
    "updated_at": "example"
  }
  ```

  {% endcut %}

- **bigquery**

  **Type**: [bigquery1](#entity-bigquery1)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "cache_invalidation_throttling_interval_sec": null,
    "cache_ttl_sec": null,
    "collection_id": "null",
    "created_at": "example",
    "description": "",
    "id": "example",
    "key": "example",
    "name": "example",
    "project_id": "example",
    "raw_sql_level": "off",
    "type": "bigquery",
    "updated_at": "example"
  }
  ```

  {% endcut %}

- **bitrix24**

  **Type**: [bitrix241](#entity-bitrix241)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "cache_invalidation_throttling_interval_sec": null,
    "cache_ttl_sec": null,
    "collection_id": "null",
    "created_at": "example",
    "data_export_forbidden": "off",
    "description": "",
    "id": "example",
    "key": "example",
    "meta": {},
    "name": "example",
    "portal": "example",
    "type": "bitrix24",
    "updated_at": "example"
  }
  ```

  {% endcut %}

- **ch_billing_analytics**

  **Type**: [ch_billing_analytics1](#entity-ch_billing_analytics1)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "collection_id": "null",
    "created_at": "example",
    "description": "",
    "id": "example",
    "key": "example",
    "meta": {},
    "name": "example",
    "type": "ch_billing_analytics",
    "updated_at": "example"
  }
  ```

  {% endcut %}

- **ch_ya_music_podcast_stats**

  **Type**: [ch_ya_music_podcast_stats1](#entity-ch_ya_music_podcast_stats1)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "collection_id": "null",
    "created_at": "example",
    "description": "",
    "id": "example",
    "key": "example",
    "meta": {},
    "name": "example",
    "type": "ch_ya_music_podcast_stats",
    "updated_at": "example"
  }
  ```

  {% endcut %}

- **chyt**

  **Type**: [chyt1](#entity-chyt1)

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
    "host": "example",
    "id": "example",
    "key": "example",
    "meta": {},
    "name": "example",
    "port": 0,
    "raw_sql_level": "off",
    "secure": true,
    "type": "chyt",
    "updated_at": "example"
  }
  ```

  {% endcut %}

- **clickhouse**

  **Type**: [clickhouse1](#entity-clickhouse1)

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
    "username": "example"
  }
  ```

  {% endcut %}

- **equeo**

  **Type**: [equeo1](#entity-equeo1)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "collection_id": "null",
    "created_at": "example",
    "description": "",
    "id": "example",
    "key": "example",
    "meta": {},
    "name": "example",
    "type": "equeo",
    "updated_at": "example"
  }
  ```

  {% endcut %}

- **extractor1c**

  **Type**: [extractor1c1](#entity-extractor1c1)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "collection_id": "null",
    "created_at": "example",
    "description": "",
    "id": "example",
    "key": "example",
    "meta": {},
    "name": "example",
    "type": "extractor1c",
    "updated_at": "example"
  }
  ```

  {% endcut %}

- **greenplum**

  **Type**: [greenplum1](#entity-greenplum1)

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
    "username": "example"
  }
  ```

  {% endcut %}

- **gsheets**

  **Type**: [gsheets1](#entity-gsheets1)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "cache_invalidation_throttling_interval_sec": null,
    "cache_ttl_sec": null,
    "collection_id": "null",
    "created_at": "example",
    "data_export_forbidden": "off",
    "description": "",
    "id": "example",
    "key": "example",
    "meta": {},
    "name": "example",
    "type": "gsheets",
    "updated_at": "example",
    "url": "example"
  }
  ```

  {% endcut %}

- **json_api**

  **Type**: [json_api1](#entity-json_api1)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "allowed_methods": [
      "GET"
    ],
    "collection_id": "null",
    "created_at": "example",
    "description": "",
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
    "updated_at": "example"
  }
  ```

  {% endcut %}

- **kontur_market**

  **Type**: [kontur_market1](#entity-kontur_market1)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "collection_id": "null",
    "created_at": "example",
    "description": "",
    "id": "example",
    "key": "example",
    "meta": {},
    "name": "example",
    "type": "kontur_market",
    "updated_at": "example"
  }
  ```

  {% endcut %}

- **metrika_api**

  **Type**: [metrika_api1](#entity-metrika_api1)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "accuracy": null,
    "collection_id": "null",
    "counter_id": "example",
    "created_at": "example",
    "data_export_forbidden": "off",
    "description": "",
    "id": "example",
    "key": "example",
    "meta": {},
    "name": "example",
    "type": "metrika_api",
    "updated_at": "example"
  }
  ```

  {% endcut %}

- **monitoring**

  **Type**: [monitoring1](#entity-monitoring1)

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
    "folder_id": "example",
    "id": "example",
    "key": "example",
    "meta": {},
    "name": "example",
    "service_account_id": "example",
    "type": "monitoring",
    "updated_at": "example"
  }
  ```

  {% endcut %}

- **moysklad**

  **Type**: [moysklad1](#entity-moysklad1)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "collection_id": "null",
    "created_at": "example",
    "description": "",
    "id": "example",
    "key": "example",
    "meta": {},
    "name": "example",
    "type": "moysklad",
    "updated_at": "example"
  }
  ```

  {% endcut %}

- **mssql**

  **Type**: [mssql1](#entity-mssql1)

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
    "host": "example",
    "id": "example",
    "key": "example",
    "meta": {},
    "name": "example",
    "port": 0,
    "raw_sql_level": "off",
    "type": "mssql",
    "updated_at": "example",
    "username": "example"
  }
  ```

  {% endcut %}

- **mysql**

  **Type**: [mysql1](#entity-mysql1)

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
    "username": "example"
  }
  ```

  {% endcut %}

- **oracle**

  **Type**: [oracle1](#entity-oracle1)

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
    "username": "example"
  }
  ```

  {% endcut %}

- **postgres**

  **Type**: [postgres1](#entity-postgres1)

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
    "username": "example"
  }
  ```

  {% endcut %}

- **promql**

  **Type**: [promql1](#entity-promql1)

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
    "username": "example"
  }
  ```

  {% endcut %}

- **smb_heatmaps**

  **Type**: [smb_heatmaps1](#entity-smb_heatmaps1)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "collection_id": "null",
    "created_at": "example",
    "description": "",
    "id": "example",
    "key": "example",
    "meta": {},
    "name": "example",
    "type": "smb_heatmaps",
    "updated_at": "example"
  }
  ```

  {% endcut %}

- **snowflake**

  **Type**: [snowflake1](#entity-snowflake1)

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
    "warehouse": "example"
  }
  ```

  {% endcut %}

- **speechsense**

  **Type**: [speechsense1](#entity-speechsense1)

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
    "folder_id": "null",
    "id": "example",
    "key": "example",
    "meta": {},
    "name": "example",
    "project_id": "example",
    "service_account_id": "null",
    "type": "speechsense",
    "updated_at": "example"
  }
  ```

  {% endcut %}

- **trino**

  **Type**: [trino1](#entity-trino1)

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
    "username": "example"
  }
  ```

  {% endcut %}

- **usage_analytics_detailed**

  **Type**: [usage_analytics_detailed1](#entity-usage_analytics_detailed1)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "collection_id": "null",
    "created_at": "example",
    "description": "",
    "id": "example",
    "key": "example",
    "meta": {},
    "name": "example",
    "type": "usage_analytics_detailed",
    "updated_at": "example"
  }
  ```

  {% endcut %}

- **usage_analytics_light**

  **Type**: [usage_analytics_light1](#entity-usage_analytics_light1)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "collection_id": "null",
    "created_at": "example",
    "description": "",
    "id": "example",
    "key": "example",
    "meta": {},
    "name": "example",
    "type": "usage_analytics_light",
    "updated_at": "example"
  }
  ```

  {% endcut %}

- **ydb**

  **Type**: [ydb1](#entity-ydb1)

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
    "username": "example"
  }
  ```

  {% endcut %}

- **yq**

  **Type**: [yq1](#entity-yq1)

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
    "folder_id": "example",
    "id": "example",
    "key": "example",
    "name": "example",
    "raw_sql_level": "off",
    "service_account_id": "example",
    "type": "yq",
    "updated_at": "example"
  }
  ```

  {% endcut %}

{% endcut %}

</div>

<div class="openapi-entity">

### appmetrica_api1 {#entity-appmetrica_api1}

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
  "id": "example",
  "key": "example",
  "meta": {},
  "name": "example",
  "type": "appmetrica_api",
  "updated_at": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### bigquery1 {#entity-bigquery1}

#|
|| **Name** | **Description** ||
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
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "cache_invalidation_throttling_interval_sec": null,
  "cache_ttl_sec": null,
  "collection_id": "null",
  "created_at": "example",
  "description": "",
  "id": "example",
  "key": "example",
  "name": "example",
  "project_id": "example",
  "raw_sql_level": "off",
  "type": "bigquery",
  "updated_at": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### bitrix241 {#entity-bitrix241}

#|
|| **Name** | **Description** ||
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
  "id": "example",
  "key": "example",
  "meta": {},
  "name": "example",
  "portal": "example",
  "type": "bitrix24",
  "updated_at": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### ch_billing_analytics1 {#entity-ch_billing_analytics1}

#|
|| **Name** | **Description** ||
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
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "collection_id": "null",
  "created_at": "example",
  "description": "",
  "id": "example",
  "key": "example",
  "meta": {},
  "name": "example",
  "type": "ch_billing_analytics",
  "updated_at": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### ch_ya_music_podcast_stats1 {#entity-ch_ya_music_podcast_stats1}

#|
|| **Name** | **Description** ||
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
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "collection_id": "null",
  "created_at": "example",
  "description": "",
  "id": "example",
  "key": "example",
  "meta": {},
  "name": "example",
  "type": "ch_ya_music_podcast_stats",
  "updated_at": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### chyt1 {#entity-chyt1}

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
  "host": "example",
  "id": "example",
  "key": "example",
  "meta": {},
  "name": "example",
  "port": 0,
  "raw_sql_level": "off",
  "secure": true,
  "type": "chyt",
  "updated_at": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### clickhouse1 {#entity-clickhouse1}

#|
|| **Name** | **Description** ||
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
  "username": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### equeo1 {#entity-equeo1}

#|
|| **Name** | **Description** ||
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
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "collection_id": "null",
  "created_at": "example",
  "description": "",
  "id": "example",
  "key": "example",
  "meta": {},
  "name": "example",
  "type": "equeo",
  "updated_at": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### extractor1c1 {#entity-extractor1c1}

#|
|| **Name** | **Description** ||
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
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "collection_id": "null",
  "created_at": "example",
  "description": "",
  "id": "example",
  "key": "example",
  "meta": {},
  "name": "example",
  "type": "extractor1c",
  "updated_at": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### greenplum1 {#entity-greenplum1}

#|
|| **Name** | **Description** ||
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
  "username": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### gsheets1 {#entity-gsheets1}

#|
|| **Name** | **Description** ||
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
  "id": "example",
  "key": "example",
  "meta": {},
  "name": "example",
  "type": "gsheets",
  "updated_at": "example",
  "url": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### json_api1 {#entity-json_api1}

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
  "updated_at": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### kontur_market1 {#entity-kontur_market1}

#|
|| **Name** | **Description** ||
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
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "collection_id": "null",
  "created_at": "example",
  "description": "",
  "id": "example",
  "key": "example",
  "meta": {},
  "name": "example",
  "type": "kontur_market",
  "updated_at": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### metrika_api1 {#entity-metrika_api1}

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
  "id": "example",
  "key": "example",
  "meta": {},
  "name": "example",
  "type": "metrika_api",
  "updated_at": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### monitoring1 {#entity-monitoring1}

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
  "folder_id": "example",
  "id": "example",
  "key": "example",
  "meta": {},
  "name": "example",
  "service_account_id": "example",
  "type": "monitoring",
  "updated_at": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### moysklad1 {#entity-moysklad1}

#|
|| **Name** | **Description** ||
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
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "collection_id": "null",
  "created_at": "example",
  "description": "",
  "id": "example",
  "key": "example",
  "meta": {},
  "name": "example",
  "type": "moysklad",
  "updated_at": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### mssql1 {#entity-mssql1}

#|
|| **Name** | **Description** ||
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
  "host": "example",
  "id": "example",
  "key": "example",
  "meta": {},
  "name": "example",
  "port": 0,
  "raw_sql_level": "off",
  "type": "mssql",
  "updated_at": "example",
  "username": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### mysql1 {#entity-mysql1}

#|
|| **Name** | **Description** ||
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
  "username": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### oracle1 {#entity-oracle1}

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
  "username": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### postgres1 {#entity-postgres1}

#|
|| **Name** | **Description** ||
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
  "username": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### promql1 {#entity-promql1}

#|
|| **Name** | **Description** ||
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
  "username": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### smb_heatmaps1 {#entity-smb_heatmaps1}

#|
|| **Name** | **Description** ||
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
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "collection_id": "null",
  "created_at": "example",
  "description": "",
  "id": "example",
  "key": "example",
  "meta": {},
  "name": "example",
  "type": "smb_heatmaps",
  "updated_at": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### snowflake1 {#entity-snowflake1}

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
  "warehouse": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### speechsense1 {#entity-speechsense1}

#|
|| **Name** | **Description** ||
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
  "folder_id": "null",
  "id": "example",
  "key": "example",
  "meta": {},
  "name": "example",
  "project_id": "example",
  "service_account_id": "null",
  "type": "speechsense",
  "updated_at": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### trino1 {#entity-trino1}

#|
|| **Name** | **Description** ||
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
  "username": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### usage_analytics_detailed1 {#entity-usage_analytics_detailed1}

#|
|| **Name** | **Description** ||
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
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "collection_id": "null",
  "created_at": "example",
  "description": "",
  "id": "example",
  "key": "example",
  "meta": {},
  "name": "example",
  "type": "usage_analytics_detailed",
  "updated_at": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### usage_analytics_light1 {#entity-usage_analytics_light1}

#|
|| **Name** | **Description** ||
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
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "collection_id": "null",
  "created_at": "example",
  "description": "",
  "id": "example",
  "key": "example",
  "meta": {},
  "name": "example",
  "type": "usage_analytics_light",
  "updated_at": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### ydb1 {#entity-ydb1}

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
  "username": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### yq1 {#entity-yq1}

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
  "folder_id": "example",
  "id": "example",
  "key": "example",
  "name": "example",
  "raw_sql_level": "off",
  "service_account_id": "example",
  "type": "yq",
  "updated_at": "example"
}
```

{% endcut %}

</div>

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.