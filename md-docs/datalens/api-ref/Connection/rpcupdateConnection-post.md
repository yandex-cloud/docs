[Документация Yandex Cloud](../../../index.md) > [Yandex DataLens](../../index.md) > DataLens Public API > [DataLens API (англ.)](../index.md) > [Connection](index.md) > Update connection

<div class="openapi">

# Update connection

<!-- markdownlint-disable-file -->

Updates the specified connection.

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
https://api.datalens.tech/rpc/updateConnection
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
  "connectionId": "example",
  "data": {
    "accuracy": null,
    "collection_id": "null",
    "counter_id": "example",
    "data_export_forbidden": "off",
    "description": "",
    "token": "example",
    "workbook_id": "null"
  }
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

_data_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [ConnectionUpdate](#entity-ConnectionUpdate)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "accuracy": null,
  "collection_id": "null",
  "counter_id": "example",
  "data_export_forbidden": "off",
  "description": "",
  "token": "example",
  "workbook_id": "null"
}
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

</div>

<div class="openapi-entity">

### appmetrica_api2 {#entity-appmetrica_api2}

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
  "token": "example",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### bigquery2 {#entity-bigquery2}

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
  "project_id": "example",
  "raw_sql_level": "off",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### bitrix242 {#entity-bitrix242}

#|
|| **Name** | **Description** ||
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
  "portal": "example",
  "token": "example",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### ch_billing_analytics2 {#entity-ch_billing_analytics2}

#|
|| **Name** | **Description** ||
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
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### ch_ya_music_podcast_stats2 {#entity-ch_ya_music_podcast_stats2}

#|
|| **Name** | **Description** ||
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
  "token": "example",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### chyt2 {#entity-chyt2}

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
  "host": "example",
  "port": 0,
  "raw_sql_level": "off",
  "secure": true,
  "token": "example",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### clickhouse2 {#entity-clickhouse2}

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
  "experimental_features": "off",
  "host": "example",
  "mdb_cluster_id": "example",
  "mdb_folder_id": "example",
  "password": "example",
  "port": 0,
  "raw_sql_level": "off",
  "readonly": 2,
  "secure": null,
  "ssl_ca": null,
  "ssl_ca_verify": "on",
  "username": "example",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### equeo2 {#entity-equeo2}

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
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### greenplum2 {#entity-greenplum2}

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
  "enforce_collate": "auto",
  "host": "example",
  "mdb_cluster_id": "example",
  "mdb_folder_id": "example",
  "password": "example",
  "port": 0,
  "raw_sql_level": "off",
  "ssl_ca": null,
  "ssl_enable": "off",
  "username": "example",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### gsheets2 {#entity-gsheets2}

#|
|| **Name** | **Description** ||
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
  "url": "example",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### json_api2 {#entity-json_api2}

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
  "host": "example",
  "path": "example",
  "plain_headers": {},
  "port": 0,
  "secret_headers": {},
  "secure": true,
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### monitoring2 {#entity-monitoring2}

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
  "folder_id": "example",
  "service_account_id": "example",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### mssql2 {#entity-mssql2}

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
  "host": "example",
  "password": "example",
  "port": 0,
  "raw_sql_level": "off",
  "username": "example",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### mysql2 {#entity-mysql2}

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
  "enforce_collate": "off",
  "host": "example",
  "mdb_cluster_id": "example",
  "mdb_folder_id": "example",
  "password": "example",
  "port": 0,
  "raw_sql_level": "off",
  "ssl_ca": null,
  "ssl_enable": "off",
  "username": "example",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### oracle2 {#entity-oracle2}

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
  "host": "example",
  "password": "example",
  "port": 0,
  "raw_sql_level": "off",
  "ssl_ca": null,
  "ssl_enable": "off",
  "username": "example",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### postgres2 {#entity-postgres2}

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
  "enforce_collate": "auto",
  "host": "example",
  "mdb_cluster_id": "example",
  "mdb_folder_id": "example",
  "password": "example",
  "port": 0,
  "raw_sql_level": "off",
  "ssl_ca": null,
  "ssl_enable": "off",
  "username": "example",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### promql2 {#entity-promql2}

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
  "host": "example",
  "password": "example",
  "path": "example",
  "port": 0,
  "secure": true,
  "username": "example",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### snowflake2 {#entity-snowflake2}

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
  "raw_sql_level": "off",
  "refresh_token": "example",
  "refresh_token_expire_time": "2025-01-01T00:00:00Z",
  "schema": "example",
  "user_name": "example",
  "user_role": "example",
  "warehouse": "example",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### speechsense2 {#entity-speechsense2}

#|
|| **Name** | **Description** ||
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
  "folder_id": "null",
  "project_id": "example",
  "service_account_id": "null",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### trino2 {#entity-trino2}

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
  "folder_id": "example",
  "host": "example",
  "jwt": "example",
  "listing_sources": null,
  "mdb_cluster_id": "example",
  "password": "example",
  "port": 0,
  "raw_sql_level": "off",
  "service_account_id": "example",
  "ssl_ca": null,
  "ssl_enable": "off",
  "username": "example",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### ydb2 {#entity-ydb2}

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
  "folder_id": "example",
  "host": "example",
  "mdb_cluster_id": "example",
  "mdb_folder_id": "example",
  "port": 0,
  "raw_sql_level": "off",
  "service_account_id": "example",
  "ssl_ca": null,
  "ssl_enable": "on",
  "token": "example",
  "username": "example",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### yq2 {#entity-yq2}

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
  "folder_id": "example",
  "raw_sql_level": "off",
  "service_account_id": "example",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### ConnectionUpdate {#entity-ConnectionUpdate}

#|
|| **Name** | **Description** ||
|#{.json-schema-properties}

{% cut "**One of 29 types**" %}{.json-schema-combinators data-marker=or}

- **appmetrica_api**

  **Type**: [appmetrica_api2](#entity-appmetrica_api2)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "accuracy": null,
    "collection_id": "null",
    "counter_id": "example",
    "data_export_forbidden": "off",
    "description": "",
    "token": "example",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **bigquery**

  **Type**: [bigquery2](#entity-bigquery2)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "cache_invalidation_throttling_interval_sec": null,
    "cache_ttl_sec": null,
    "collection_id": "null",
    "credentials": "example",
    "description": "",
    "project_id": "example",
    "raw_sql_level": "off",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **bitrix24**

  **Type**: [bitrix242](#entity-bitrix242)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "cache_invalidation_throttling_interval_sec": null,
    "cache_ttl_sec": null,
    "collection_id": "null",
    "data_export_forbidden": "off",
    "description": "",
    "portal": "example",
    "token": "example",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **ch_billing_analytics**

  **Type**: [ch_billing_analytics2](#entity-ch_billing_analytics2)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "collection_id": "null",
    "description": "",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **ch_ya_music_podcast_stats**

  **Type**: [ch_ya_music_podcast_stats2](#entity-ch_ya_music_podcast_stats2)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "collection_id": "null",
    "description": "",
    "token": "example",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **chyt**

  **Type**: [chyt2](#entity-chyt2)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "alias": "example",
    "cache_invalidation_throttling_interval_sec": null,
    "cache_ttl_sec": null,
    "collection_id": "null",
    "data_export_forbidden": "off",
    "description": "",
    "host": "example",
    "port": 0,
    "raw_sql_level": "off",
    "secure": true,
    "token": "example",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **clickhouse**

  **Type**: [clickhouse2](#entity-clickhouse2)

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
    "experimental_features": "off",
    "host": "example",
    "mdb_cluster_id": "example",
    "mdb_folder_id": "example",
    "password": "example",
    "port": 0,
    "raw_sql_level": "off",
    "readonly": 2,
    "secure": null,
    "ssl_ca": null,
    "ssl_ca_verify": "on",
    "username": "example",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **equeo**

  **Type**: [equeo2](#entity-equeo2)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "access_token": "example",
    "collection_id": "null",
    "description": "",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **extractor1c**

  **Type**: [extractor1c2](#entity-extractor1c2)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "access_token": "example",
    "collection_id": "null",
    "description": "",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **greenplum**

  **Type**: [greenplum2](#entity-greenplum2)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "cache_invalidation_throttling_interval_sec": null,
    "cache_ttl_sec": null,
    "collection_id": "null",
    "data_export_forbidden": "off",
    "db_name": "example",
    "description": "",
    "enforce_collate": "auto",
    "host": "example",
    "mdb_cluster_id": "example",
    "mdb_folder_id": "example",
    "password": "example",
    "port": 0,
    "raw_sql_level": "off",
    "ssl_ca": null,
    "ssl_enable": "off",
    "username": "example",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **gsheets**

  **Type**: [gsheets2](#entity-gsheets2)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "cache_invalidation_throttling_interval_sec": null,
    "cache_ttl_sec": null,
    "collection_id": "null",
    "data_export_forbidden": "off",
    "description": "",
    "url": "example",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **json_api**

  **Type**: [json_api2](#entity-json_api2)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "allowed_methods": [
      "GET"
    ],
    "collection_id": "null",
    "description": "",
    "host": "example",
    "path": "example",
    "plain_headers": {},
    "port": 0,
    "secret_headers": {},
    "secure": true,
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **kontur_market**

  **Type**: [kontur_market2](#entity-kontur_market2)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "access_token": "example",
    "collection_id": "null",
    "description": "",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **metrika_api**

  **Type**: [metrika_api2](#entity-metrika_api2)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "accuracy": null,
    "collection_id": "null",
    "counter_id": "example",
    "data_export_forbidden": "off",
    "description": "",
    "token": "example",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **monitoring**

  **Type**: [monitoring2](#entity-monitoring2)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "cache_invalidation_throttling_interval_sec": null,
    "cache_ttl_sec": null,
    "cloud_id": "example",
    "collection_id": "null",
    "delegation_is_set": true,
    "description": "",
    "folder_id": "example",
    "service_account_id": "example",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **moysklad**

  **Type**: [moysklad2](#entity-moysklad2)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "access_token": "example",
    "collection_id": "null",
    "description": "",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **mssql**

  **Type**: [mssql2](#entity-mssql2)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "cache_invalidation_throttling_interval_sec": null,
    "cache_ttl_sec": null,
    "collection_id": "null",
    "data_export_forbidden": "off",
    "db_name": "example",
    "description": "",
    "host": "example",
    "password": "example",
    "port": 0,
    "raw_sql_level": "off",
    "username": "example",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **mysql**

  **Type**: [mysql2](#entity-mysql2)

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
    "enforce_collate": "off",
    "host": "example",
    "mdb_cluster_id": "example",
    "mdb_folder_id": "example",
    "password": "example",
    "port": 0,
    "raw_sql_level": "off",
    "ssl_ca": null,
    "ssl_enable": "off",
    "username": "example",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **oracle**

  **Type**: [oracle2](#entity-oracle2)

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
    "host": "example",
    "password": "example",
    "port": 0,
    "raw_sql_level": "off",
    "ssl_ca": null,
    "ssl_enable": "off",
    "username": "example",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **postgres**

  **Type**: [postgres2](#entity-postgres2)

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
    "enforce_collate": "auto",
    "host": "example",
    "mdb_cluster_id": "example",
    "mdb_folder_id": "example",
    "password": "example",
    "port": 0,
    "raw_sql_level": "off",
    "ssl_ca": null,
    "ssl_enable": "off",
    "username": "example",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **promql**

  **Type**: [promql2](#entity-promql2)

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
    "host": "example",
    "password": "example",
    "path": "example",
    "port": 0,
    "secure": true,
    "username": "example",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **smb_heatmaps**

  **Type**: [smb_heatmaps2](#entity-smb_heatmaps2)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "collection_id": "null",
    "description": "",
    "token": "example",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **snowflake**

  **Type**: [snowflake2](#entity-snowflake2)

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
    "raw_sql_level": "off",
    "refresh_token": "example",
    "refresh_token_expire_time": "2025-01-01T00:00:00Z",
    "schema": "example",
    "user_name": "example",
    "user_role": "example",
    "warehouse": "example",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **speechsense**

  **Type**: [speechsense2](#entity-speechsense2)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "auth_type": "user_credentials",
    "cloud_id": "null",
    "collection_id": "null",
    "data_export_forbidden": "off",
    "delegation_is_set": null,
    "description": "",
    "folder_id": "null",
    "project_id": "example",
    "service_account_id": "null",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **trino**

  **Type**: [trino2](#entity-trino2)

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
    "folder_id": "example",
    "host": "example",
    "jwt": "example",
    "listing_sources": null,
    "mdb_cluster_id": "example",
    "password": "example",
    "port": 0,
    "raw_sql_level": "off",
    "service_account_id": "example",
    "ssl_ca": null,
    "ssl_enable": "off",
    "username": "example",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **usage_analytics_detailed**

  **Type**: [usage_analytics_detailed2](#entity-usage_analytics_detailed2)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "collection_id": "null",
    "description": "",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **usage_analytics_light**

  **Type**: [usage_analytics_light2](#entity-usage_analytics_light2)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "collection_id": "null",
    "description": "",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **ydb**

  **Type**: [ydb2](#entity-ydb2)

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
    "folder_id": "example",
    "host": "example",
    "mdb_cluster_id": "example",
    "mdb_folder_id": "example",
    "port": 0,
    "raw_sql_level": "off",
    "service_account_id": "example",
    "ssl_ca": null,
    "ssl_enable": "on",
    "token": "example",
    "username": "example",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **yq**

  **Type**: [yq2](#entity-yq2)

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
    "folder_id": "example",
    "raw_sql_level": "off",
    "service_account_id": "example",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "accuracy": null,
  "collection_id": "null",
  "counter_id": "example",
  "data_export_forbidden": "off",
  "description": "",
  "token": "example",
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

`null`

{% endcut %}

**Type**: unknown

</div>

<div class="openapi-entity">

### appmetrica_api2 {#entity-appmetrica_api21}

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
  "id": "example",
  "key": "example",
  "meta": {},
  "updated_at": "example",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### bigquery2 {#entity-bigquery21}

#|
|| **Name** | **Description** ||
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
  "id": "example",
  "key": "example",
  "project_id": "example",
  "raw_sql_level": "off",
  "updated_at": "example",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### bitrix242 {#entity-bitrix2421}

#|
|| **Name** | **Description** ||
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
  "id": "example",
  "key": "example",
  "meta": {},
  "portal": "example",
  "updated_at": "example",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### ch_billing_analytics2 {#entity-ch_billing_analytics21}

#|
|| **Name** | **Description** ||
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
  "id": "example",
  "key": "example",
  "meta": {},
  "updated_at": "example",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### chyt2 {#entity-chyt21}

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
  "host": "example",
  "id": "example",
  "key": "example",
  "meta": {},
  "port": 0,
  "raw_sql_level": "off",
  "secure": true,
  "updated_at": "example",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### clickhouse2 {#entity-clickhouse21}

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
  "experimental_features": "off",
  "host": "example",
  "id": "example",
  "key": "example",
  "mdb_cluster_id": "example",
  "mdb_folder_id": "example",
  "meta": {},
  "port": 0,
  "raw_sql_level": "off",
  "readonly": 2,
  "secure": null,
  "ssl_ca_verify": "on",
  "updated_at": "example",
  "username": "example",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### greenplum2 {#entity-greenplum21}

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
  "enforce_collate": "auto",
  "host": "example",
  "id": "example",
  "key": "example",
  "mdb_cluster_id": "example",
  "mdb_folder_id": "example",
  "meta": {},
  "port": 0,
  "raw_sql_level": "off",
  "ssl_enable": "off",
  "updated_at": "example",
  "username": "example",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### gsheets2 {#entity-gsheets21}

#|
|| **Name** | **Description** ||
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
  "id": "example",
  "key": "example",
  "meta": {},
  "updated_at": "example",
  "url": "example",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### json_api2 {#entity-json_api21}

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
  "host": "example",
  "id": "example",
  "key": "example",
  "meta": {},
  "path": "example",
  "plain_headers": {},
  "port": 0,
  "secret_headers": {},
  "secure": true,
  "updated_at": "example",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### monitoring2 {#entity-monitoring21}

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
  "folder_id": "example",
  "id": "example",
  "key": "example",
  "meta": {},
  "service_account_id": "example",
  "updated_at": "example",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### mssql2 {#entity-mssql21}

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
  "host": "example",
  "id": "example",
  "key": "example",
  "meta": {},
  "port": 0,
  "raw_sql_level": "off",
  "updated_at": "example",
  "username": "example",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### mysql2 {#entity-mysql21}

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
  "enforce_collate": "off",
  "host": "example",
  "id": "example",
  "key": "example",
  "mdb_cluster_id": "example",
  "mdb_folder_id": "example",
  "meta": {},
  "port": 0,
  "raw_sql_level": "off",
  "ssl_enable": "off",
  "updated_at": "example",
  "username": "example",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### oracle2 {#entity-oracle21}

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
  "host": "example",
  "id": "example",
  "key": "example",
  "meta": {},
  "port": 0,
  "raw_sql_level": "off",
  "ssl_enable": "off",
  "updated_at": "example",
  "username": "example",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### postgres2 {#entity-postgres21}

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
  "enforce_collate": "auto",
  "host": "example",
  "id": "example",
  "key": "example",
  "mdb_cluster_id": "example",
  "mdb_folder_id": "example",
  "meta": {},
  "port": 0,
  "raw_sql_level": "off",
  "ssl_enable": "off",
  "updated_at": "example",
  "username": "example",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### promql2 {#entity-promql21}

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
  "host": "example",
  "id": "example",
  "key": "example",
  "meta": {},
  "path": "example",
  "port": 0,
  "secure": true,
  "updated_at": "example",
  "username": "example",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### snowflake2 {#entity-snowflake21}

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
  "id": "example",
  "key": "example",
  "raw_sql_level": "off",
  "refresh_token_expire_time": "2025-01-01T00:00:00Z",
  "schema": "example",
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

### speechsense2 {#entity-speechsense21}

#|
|| **Name** | **Description** ||
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
  "folder_id": "null",
  "id": "example",
  "key": "example",
  "meta": {},
  "project_id": "example",
  "service_account_id": "null",
  "updated_at": "example",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### trino2 {#entity-trino21}

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
  "folder_id": "example",
  "host": "example",
  "id": "example",
  "key": "example",
  "listing_sources": null,
  "mdb_cluster_id": "example",
  "meta": {},
  "port": 0,
  "raw_sql_level": "off",
  "service_account_id": "example",
  "ssl_enable": "off",
  "updated_at": "example",
  "username": "example",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### ydb2 {#entity-ydb21}

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
  "folder_id": "example",
  "host": "example",
  "id": "example",
  "key": "example",
  "mdb_cluster_id": "example",
  "mdb_folder_id": "example",
  "port": 0,
  "raw_sql_level": "off",
  "service_account_id": "example",
  "ssl_enable": "on",
  "updated_at": "example",
  "username": "example",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### yq2 {#entity-yq21}

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
  "folder_id": "example",
  "id": "example",
  "key": "example",
  "raw_sql_level": "off",
  "service_account_id": "example",
  "updated_at": "example",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### ConnectionUpdate {#entity-ConnectionUpdate1}

#|
|| **Name** | **Description** ||
|#{.json-schema-properties}

{% cut "**One of 29 types**" %}{.json-schema-combinators data-marker=or}

- **appmetrica_api**

  **Type**: [appmetrica_api2](#entity-appmetrica_api21)

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
    "updated_at": "example",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **bigquery**

  **Type**: [bigquery2](#entity-bigquery21)

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
    "project_id": "example",
    "raw_sql_level": "off",
    "updated_at": "example",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **bitrix24**

  **Type**: [bitrix242](#entity-bitrix2421)

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
    "portal": "example",
    "updated_at": "example",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **ch_billing_analytics**

  **Type**: [ch_billing_analytics2](#entity-ch_billing_analytics21)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "collection_id": "null",
    "created_at": "example",
    "description": "",
    "id": "example",
    "key": "example",
    "meta": {},
    "updated_at": "example",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **ch_ya_music_podcast_stats**

  **Type**: [ch_ya_music_podcast_stats2](#entity-ch_billing_analytics21)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "collection_id": "null",
    "created_at": "example",
    "description": "",
    "id": "example",
    "key": "example",
    "meta": {},
    "updated_at": "example",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **chyt**

  **Type**: [chyt2](#entity-chyt21)

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
    "port": 0,
    "raw_sql_level": "off",
    "secure": true,
    "updated_at": "example",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **clickhouse**

  **Type**: [clickhouse2](#entity-clickhouse21)

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
    "port": 0,
    "raw_sql_level": "off",
    "readonly": 2,
    "secure": null,
    "ssl_ca_verify": "on",
    "updated_at": "example",
    "username": "example",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **equeo**

  **Type**: [equeo2](#entity-ch_billing_analytics21)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "collection_id": "null",
    "created_at": "example",
    "description": "",
    "id": "example",
    "key": "example",
    "meta": {},
    "updated_at": "example",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **extractor1c**

  **Type**: [extractor1c2](#entity-ch_billing_analytics21)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "collection_id": "null",
    "created_at": "example",
    "description": "",
    "id": "example",
    "key": "example",
    "meta": {},
    "updated_at": "example",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **greenplum**

  **Type**: [greenplum2](#entity-greenplum21)

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
    "port": 0,
    "raw_sql_level": "off",
    "ssl_enable": "off",
    "updated_at": "example",
    "username": "example",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **gsheets**

  **Type**: [gsheets2](#entity-gsheets21)

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
    "updated_at": "example",
    "url": "example",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **json_api**

  **Type**: [json_api2](#entity-json_api21)

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
    "path": "example",
    "plain_headers": {},
    "port": 0,
    "secret_headers": {},
    "secure": true,
    "updated_at": "example",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **kontur_market**

  **Type**: [kontur_market2](#entity-ch_billing_analytics21)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "collection_id": "null",
    "created_at": "example",
    "description": "",
    "id": "example",
    "key": "example",
    "meta": {},
    "updated_at": "example",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **metrika_api**

  **Type**: [metrika_api2](#entity-appmetrica_api21)

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
    "updated_at": "example",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **monitoring**

  **Type**: [monitoring2](#entity-monitoring21)

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
    "service_account_id": "example",
    "updated_at": "example",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **moysklad**

  **Type**: [moysklad2](#entity-ch_billing_analytics21)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "collection_id": "null",
    "created_at": "example",
    "description": "",
    "id": "example",
    "key": "example",
    "meta": {},
    "updated_at": "example",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **mssql**

  **Type**: [mssql2](#entity-mssql21)

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
    "port": 0,
    "raw_sql_level": "off",
    "updated_at": "example",
    "username": "example",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **mysql**

  **Type**: [mysql2](#entity-mysql21)

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
    "port": 0,
    "raw_sql_level": "off",
    "ssl_enable": "off",
    "updated_at": "example",
    "username": "example",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **oracle**

  **Type**: [oracle2](#entity-oracle21)

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
    "port": 0,
    "raw_sql_level": "off",
    "ssl_enable": "off",
    "updated_at": "example",
    "username": "example",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **postgres**

  **Type**: [postgres2](#entity-postgres21)

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
    "port": 0,
    "raw_sql_level": "off",
    "ssl_enable": "off",
    "updated_at": "example",
    "username": "example",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **promql**

  **Type**: [promql2](#entity-promql21)

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
    "path": "example",
    "port": 0,
    "secure": true,
    "updated_at": "example",
    "username": "example",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **smb_heatmaps**

  **Type**: [smb_heatmaps2](#entity-ch_billing_analytics21)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "collection_id": "null",
    "created_at": "example",
    "description": "",
    "id": "example",
    "key": "example",
    "meta": {},
    "updated_at": "example",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **snowflake**

  **Type**: [snowflake2](#entity-snowflake21)

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
    "raw_sql_level": "off",
    "refresh_token_expire_time": "2025-01-01T00:00:00Z",
    "schema": "example",
    "updated_at": "example",
    "user_name": "example",
    "user_role": "example",
    "warehouse": "example",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **speechsense**

  **Type**: [speechsense2](#entity-speechsense21)

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
    "project_id": "example",
    "service_account_id": "null",
    "updated_at": "example",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **trino**

  **Type**: [trino2](#entity-trino21)

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
    "port": 0,
    "raw_sql_level": "off",
    "service_account_id": "example",
    "ssl_enable": "off",
    "updated_at": "example",
    "username": "example",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **usage_analytics_detailed**

  **Type**: [usage_analytics_detailed2](#entity-ch_billing_analytics21)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "collection_id": "null",
    "created_at": "example",
    "description": "",
    "id": "example",
    "key": "example",
    "meta": {},
    "updated_at": "example",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **usage_analytics_light**

  **Type**: [usage_analytics_light2](#entity-ch_billing_analytics21)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "collection_id": "null",
    "created_at": "example",
    "description": "",
    "id": "example",
    "key": "example",
    "meta": {},
    "updated_at": "example",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **ydb**

  **Type**: [ydb2](#entity-ydb21)

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
    "port": 0,
    "raw_sql_level": "off",
    "service_account_id": "example",
    "ssl_enable": "on",
    "updated_at": "example",
    "username": "example",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

- **yq**

  **Type**: [yq2](#entity-yq21)

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
    "raw_sql_level": "off",
    "service_account_id": "example",
    "updated_at": "example",
    "workbook_id": "null"
  }
  ```

  {% endcut %}

{% endcut %}

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
  "updated_at": "example",
  "workbook_id": "null"
}
```

{% endcut %}

</div>

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.