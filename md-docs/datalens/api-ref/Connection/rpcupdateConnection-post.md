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

_Const:_{.json-schema-reset .json-schema-value} `3`

_Example:_{.json-schema-reset .json-schema-example} `3`
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
    "ai_access_level": "allow",
    "counter_id": "example",
    "data_export_forbidden": "off",
    "description": "",
    "token": "example"
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
  "ai_access_level": "allow",
  "counter_id": "example",
  "data_export_forbidden": "off",
  "description": "",
  "token": "example"
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

_accuracy_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: number &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_ai_access_level_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `allow`

_Enum:_{.json-schema-reset .json-schema-value} `allow`, `allow_trusted`, `deny`
{.table-cell}
||
||

_counter_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_data_export_forbidden_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `on`, `off`
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

_token_{.json-schema-reset .json-schema-property}
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
  "ai_access_level": "allow",
  "counter_id": "example",
  "data_export_forbidden": "off",
  "description": "",
  "token": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### bigquery2 {#entity-bigquery2}

#|
|| **Name** | **Description** ||
||

_ai_access_level_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `allow`

_Enum:_{.json-schema-reset .json-schema-value} `allow`, `allow_trusted`, `deny`
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

_credentials_{.json-schema-reset .json-schema-property}
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

_project_id_{.json-schema-reset .json-schema-property}
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

_Enum:_{.json-schema-reset .json-schema-value} `off`, `subselect`, `template`, `dashsql`, `readwrite`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "ai_access_level": "allow",
  "cache_invalidation_throttling_interval_sec": null,
  "cache_ttl_sec": null,
  "credentials": "example",
  "description": "",
  "project_id": "example",
  "raw_sql_level": "off"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### bitrix242 {#entity-bitrix242}

#|
|| **Name** | **Description** ||
||

_ai_access_level_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `allow`

_Enum:_{.json-schema-reset .json-schema-value} `allow`, `allow_trusted`, `deny`
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

_data_export_forbidden_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `on`, `off`
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

_portal_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_token_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "ai_access_level": "allow",
  "cache_invalidation_throttling_interval_sec": null,
  "cache_ttl_sec": null,
  "data_export_forbidden": "off",
  "description": "",
  "portal": "example",
  "token": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### ch_billing_analytics2 {#entity-ch_billing_analytics2}

#|
|| **Name** | **Description** ||
||

_ai_access_level_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `allow`

_Enum:_{.json-schema-reset .json-schema-value} `allow`, `allow_trusted`, `deny`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} ``
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "ai_access_level": "allow",
  "description": ""
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### ch_ya_music_podcast_stats2 {#entity-ch_ya_music_podcast_stats2}

#|
|| **Name** | **Description** ||
||

_ai_access_level_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `allow`

_Enum:_{.json-schema-reset .json-schema-value} `allow`, `allow_trusted`, `deny`
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

_token_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "ai_access_level": "allow",
  "description": "",
  "token": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### chyt2 {#entity-chyt2}

#|
|| **Name** | **Description** ||
||

_ai_access_level_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `allow`

_Enum:_{.json-schema-reset .json-schema-value} `allow`, `allow_trusted`, `deny`
{.table-cell}
||
||

_alias_{.json-schema-reset .json-schema-property}
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

_data_export_forbidden_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `on`, `off`
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

_host_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_port_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer
{.table-cell}
||
||

_raw_sql_level_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `off`, `subselect`, `template`, `dashsql`, `readwrite`
{.table-cell}
||
||

_secure_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean
{.table-cell}
||
||

_token_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "ai_access_level": "allow",
  "alias": "example",
  "cache_invalidation_throttling_interval_sec": null,
  "cache_ttl_sec": null,
  "data_export_forbidden": "off",
  "description": "",
  "host": "example",
  "port": 0,
  "raw_sql_level": "off",
  "secure": true,
  "token": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### clickhouse2 {#entity-clickhouse2}

#|
|| **Name** | **Description** ||
||

_ai_access_level_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `allow`

_Enum:_{.json-schema-reset .json-schema-value} `allow`, `allow_trusted`, `deny`
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
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `on`, `off`
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

_dlp_managed_cloud_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_dlp_managed_cluster_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_dlp_managed_connection_manager_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_dlp_managed_connection_manager_delegation_is_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean &#124; null
{.table-cell}
||
||

_dlp_managed_folder_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_experimental_features_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `on`, `off`
{.table-cell}
||
||

_host_{.json-schema-reset .json-schema-property}
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

_mode_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

_Enum:_{.json-schema-reset .json-schema-value} `onpremise`, `managed`, `null`
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
**Type**: integer
{.table-cell}
||
||

_raw_sql_level_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `off`, `subselect`, `template`, `dashsql`, `readwrite`
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
**Type**: string

_Enum:_{.json-schema-reset .json-schema-value} `on`, `off`
{.table-cell}
||
||

_ssl_ca_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_ssl_ca_verify_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `on`

_Enum:_{.json-schema-reset .json-schema-value} `on`, `off`
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

_variant_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `default`

_Enum:_{.json-schema-reset .json-schema-value} `default`, `dlp`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "ai_access_level": "allow",
  "cache_invalidation_throttling_interval_sec": null,
  "cache_ttl_sec": null,
  "connection_manager_cloud_id": "example",
  "connection_manager_connection_id": "example",
  "connection_manager_delegation_is_set": true,
  "connection_manager_folder_id": "example",
  "data_export_forbidden": "off",
  "db_name": "example",
  "description": "",
  "dlp_managed_cloud_id": "example",
  "dlp_managed_cluster_id": "example",
  "dlp_managed_connection_manager_connection_id": "example",
  "dlp_managed_connection_manager_delegation_is_set": true,
  "dlp_managed_folder_id": "example",
  "experimental_features": "off",
  "host": "example",
  "mdb_cluster_id": "example",
  "mdb_folder_id": "example",
  "mode": "null",
  "password": "example",
  "port": 0,
  "raw_sql_level": "off",
  "readonly": 2,
  "secure": "on",
  "ssl_ca": "null",
  "ssl_ca_verify": "on",
  "username": "example",
  "variant": "default"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### greenplum2 {#entity-greenplum2}

#|
|| **Name** | **Description** ||
||

_ai_access_level_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `allow`

_Enum:_{.json-schema-reset .json-schema-value} `allow`, `allow_trusted`, `deny`
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

_data_export_forbidden_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `on`, `off`
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

_host_{.json-schema-reset .json-schema-property}
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

_password_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_port_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer
{.table-cell}
||
||

_raw_sql_level_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `off`, `subselect`, `template`, `dashsql`, `readwrite`
{.table-cell}
||
||

_ssl_ca_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_ssl_enable_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `on`, `off`
{.table-cell}
||
||

_username_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "ai_access_level": "allow",
  "cache_invalidation_throttling_interval_sec": null,
  "cache_ttl_sec": null,
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
  "ssl_ca": "null",
  "ssl_enable": "off",
  "username": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### gsheets2 {#entity-gsheets2}

#|
|| **Name** | **Description** ||
||

_ai_access_level_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `allow`

_Enum:_{.json-schema-reset .json-schema-value} `allow`, `allow_trusted`, `deny`
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

_data_export_forbidden_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `on`, `off`
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

_url_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "ai_access_level": "allow",
  "cache_invalidation_throttling_interval_sec": null,
  "cache_ttl_sec": null,
  "data_export_forbidden": "off",
  "description": "",
  "url": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### json_api2 {#entity-json_api2}

#|
|| **Name** | **Description** ||
||

_ai_access_level_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `allow`

_Enum:_{.json-schema-reset .json-schema-value} `allow`, `allow_trusted`, `deny`
{.table-cell}
||
||

_allowed_methods_{.json-schema-reset .json-schema-property}
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

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} ``
{.table-cell}
||
||

_host_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

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

_port_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer
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
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "ai_access_level": "allow",
  "allowed_methods": [
    "GET"
  ],
  "description": "",
  "host": "example",
  "path": "example",
  "plain_headers": {},
  "port": 0,
  "secret_headers": {},
  "secure": true
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### monitoring2 {#entity-monitoring2}

#|
|| **Name** | **Description** ||
||

_ai_access_level_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `allow`

_Enum:_{.json-schema-reset .json-schema-value} `allow`, `allow_trusted`, `deny`
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
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_service_account_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "ai_access_level": "allow",
  "cache_invalidation_throttling_interval_sec": null,
  "cache_ttl_sec": null,
  "cloud_id": "example",
  "delegation_is_set": true,
  "description": "",
  "folder_id": "example",
  "service_account_id": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### mssql2 {#entity-mssql2}

#|
|| **Name** | **Description** ||
||

_ai_access_level_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `allow`

_Enum:_{.json-schema-reset .json-schema-value} `allow`, `allow_trusted`, `deny`
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

_data_export_forbidden_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `on`, `off`
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

_host_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_password_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_port_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer
{.table-cell}
||
||

_raw_sql_level_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `off`, `subselect`, `template`, `dashsql`, `readwrite`
{.table-cell}
||
||

_username_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "ai_access_level": "allow",
  "cache_invalidation_throttling_interval_sec": null,
  "cache_ttl_sec": null,
  "data_export_forbidden": "off",
  "db_name": "example",
  "description": "",
  "host": "example",
  "password": "example",
  "port": 0,
  "raw_sql_level": "off",
  "username": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### mysql2 {#entity-mysql2}

#|
|| **Name** | **Description** ||
||

_ai_access_level_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `allow`

_Enum:_{.json-schema-reset .json-schema-value} `allow`, `allow_trusted`, `deny`
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
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `on`, `off`
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

_dlp_managed_cloud_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_dlp_managed_cluster_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_dlp_managed_connection_manager_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_dlp_managed_connection_manager_delegation_is_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean &#124; null
{.table-cell}
||
||

_dlp_managed_folder_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
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

_host_{.json-schema-reset .json-schema-property}
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

_mode_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

_Enum:_{.json-schema-reset .json-schema-value} `onpremise`, `managed`, `null`
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
**Type**: integer
{.table-cell}
||
||

_raw_sql_level_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `off`, `subselect`, `template`, `dashsql`, `readwrite`
{.table-cell}
||
||

_ssl_ca_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_ssl_enable_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `on`, `off`
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

_variant_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `default`

_Enum:_{.json-schema-reset .json-schema-value} `default`, `dlp`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "ai_access_level": "allow",
  "cache_invalidation_throttling_interval_sec": null,
  "cache_ttl_sec": null,
  "connection_manager_cloud_id": "example",
  "connection_manager_connection_id": "example",
  "connection_manager_delegation_is_set": true,
  "connection_manager_folder_id": "example",
  "data_export_forbidden": "off",
  "db_name": "example",
  "description": "",
  "dlp_managed_cloud_id": "example",
  "dlp_managed_cluster_id": "example",
  "dlp_managed_connection_manager_connection_id": "example",
  "dlp_managed_connection_manager_delegation_is_set": true,
  "dlp_managed_folder_id": "example",
  "enforce_collate": "off",
  "host": "example",
  "mdb_cluster_id": "example",
  "mdb_folder_id": "example",
  "mode": "null",
  "password": "example",
  "port": 0,
  "raw_sql_level": "off",
  "ssl_ca": "null",
  "ssl_enable": "off",
  "username": "example",
  "variant": "default"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### oracle2 {#entity-oracle2}

#|
|| **Name** | **Description** ||
||

_ai_access_level_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `allow`

_Enum:_{.json-schema-reset .json-schema-value} `allow`, `allow_trusted`, `deny`
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

_data_export_forbidden_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `on`, `off`
{.table-cell}
||
||

_db_connect_method_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Enum:_{.json-schema-reset .json-schema-value} `sid`, `service_name`
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

_host_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_password_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_port_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer
{.table-cell}
||
||

_raw_sql_level_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `off`, `subselect`, `template`, `dashsql`, `readwrite`
{.table-cell}
||
||

_ssl_ca_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_ssl_enable_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `on`, `off`
{.table-cell}
||
||

_username_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "ai_access_level": "allow",
  "cache_invalidation_throttling_interval_sec": null,
  "cache_ttl_sec": null,
  "data_export_forbidden": "off",
  "db_connect_method": "sid",
  "db_name": "example",
  "description": "",
  "host": "example",
  "password": "example",
  "port": 0,
  "raw_sql_level": "off",
  "ssl_ca": "null",
  "ssl_enable": "off",
  "username": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### postgres2 {#entity-postgres2}

#|
|| **Name** | **Description** ||
||

_ai_access_level_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `allow`

_Enum:_{.json-schema-reset .json-schema-value} `allow`, `allow_trusted`, `deny`
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
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `on`, `off`
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

_dlp_managed_cloud_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_dlp_managed_cluster_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_dlp_managed_connection_manager_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_dlp_managed_connection_manager_delegation_is_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean &#124; null
{.table-cell}
||
||

_dlp_managed_folder_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
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

_host_{.json-schema-reset .json-schema-property}
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

_mode_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

_Enum:_{.json-schema-reset .json-schema-value} `onpremise`, `managed`, `null`
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
**Type**: integer
{.table-cell}
||
||

_raw_sql_level_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `off`, `subselect`, `template`, `dashsql`, `readwrite`
{.table-cell}
||
||

_ssl_ca_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_ssl_enable_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `on`, `off`
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

_variant_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `default`

_Enum:_{.json-schema-reset .json-schema-value} `default`, `dlp`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "ai_access_level": "allow",
  "cache_invalidation_throttling_interval_sec": null,
  "cache_ttl_sec": null,
  "connection_manager_cloud_id": "example",
  "connection_manager_connection_id": "example",
  "connection_manager_delegation_is_set": true,
  "connection_manager_folder_id": "example",
  "data_export_forbidden": "off",
  "db_name": "example",
  "description": "",
  "dlp_managed_cloud_id": "example",
  "dlp_managed_cluster_id": "example",
  "dlp_managed_connection_manager_connection_id": "example",
  "dlp_managed_connection_manager_delegation_is_set": true,
  "dlp_managed_folder_id": "example",
  "enforce_collate": "auto",
  "host": "example",
  "mdb_cluster_id": "example",
  "mdb_folder_id": "example",
  "mode": "null",
  "password": "example",
  "port": 0,
  "raw_sql_level": "off",
  "ssl_ca": "null",
  "ssl_enable": "off",
  "username": "example",
  "variant": "default"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### promql2 {#entity-promql2}

#|
|| **Name** | **Description** ||
||

_ai_access_level_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `allow`

_Enum:_{.json-schema-reset .json-schema-value} `allow`, `allow_trusted`, `deny`
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
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `password`

_Enum:_{.json-schema-reset .json-schema-value} `header`, `password`
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

_data_export_forbidden_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `on`, `off`
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

_host_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

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

_path_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_port_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer
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
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "ai_access_level": "allow",
  "auth_header": "example",
  "auth_type": "password",
  "cache_invalidation_throttling_interval_sec": null,
  "cache_ttl_sec": null,
  "data_export_forbidden": "off",
  "db_name": "example",
  "description": "",
  "host": "example",
  "password": "example",
  "path": "example",
  "port": 0,
  "secure": true,
  "username": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### snowflake2 {#entity-snowflake2}

#|
|| **Name** | **Description** ||
||

_account_name_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_ai_access_level_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `allow`

_Enum:_{.json-schema-reset .json-schema-value} `allow`, `allow_trusted`, `deny`
{.table-cell}
||
||

_client_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_client_secret_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_data_export_forbidden_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `on`, `off`
{.table-cell}
||
||

_db_name_{.json-schema-reset .json-schema-property}
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

_raw_sql_level_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `off`, `subselect`, `template`, `dashsql`, `readwrite`
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

_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_user_name_{.json-schema-reset .json-schema-property}
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

_warehouse_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "account_name": "example",
  "ai_access_level": "allow",
  "client_id": "example",
  "client_secret": "example",
  "data_export_forbidden": "off",
  "db_name": "example",
  "description": "",
  "raw_sql_level": "off",
  "refresh_token": "example",
  "refresh_token_expire_time": "2025-01-01T00:00:00Z",
  "schema": "example",
  "user_name": "example",
  "user_role": "example",
  "warehouse": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### speechsense2 {#entity-speechsense2}

#|
|| **Name** | **Description** ||
||

_ai_access_level_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `allow`

_Enum:_{.json-schema-reset .json-schema-value} `allow`, `allow_trusted`, `deny`
{.table-cell}
||
||

_auth_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `user_credentials`

_Enum:_{.json-schema-reset .json-schema-value} `service_account`, `user_credentials`
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

_data_export_forbidden_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `on`, `off`
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

_project_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_service_account_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "ai_access_level": "allow",
  "auth_type": "user_credentials",
  "cloud_id": "null",
  "data_export_forbidden": "off",
  "delegation_is_set": null,
  "description": "",
  "folder_id": "null",
  "project_id": "example",
  "service_account_id": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### trino2 {#entity-trino2}

#|
|| **Name** | **Description** ||
||

_ai_access_level_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `allow`

_Enum:_{.json-schema-reset .json-schema-value} `allow`, `allow_trusted`, `deny`
{.table-cell}
||
||

_auth_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `certificate`, `header`, `jwt`, `kerberos`, `none`, `oauth2`, `password`, `null`

_Example:_{.json-schema-reset .json-schema-example} `certificate`
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

_cluster_entry_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_data_export_forbidden_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `on`, `off`
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

_extra_credentials_{.json-schema-reset .json-schema-property}
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

_folder_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_form_fill_mode_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Enum:_{.json-schema-reset .json-schema-value} `cloud`, `manually`, `platform`
{.table-cell}
||
||

_host_{.json-schema-reset .json-schema-property}
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

_listing_sources_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Enum:_{.json-schema-reset .json-schema-value} `off`, `on`
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

_Enum:_{.json-schema-reset .json-schema-value} `off`, `subselect`, `template`, `dashsql`, `readwrite`
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
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_ssl_enable_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `on`, `off`
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
  "ai_access_level": "allow",
  "auth_type": "certificate",
  "cache_invalidation_throttling_interval_sec": null,
  "cache_ttl_sec": null,
  "cloud_id": "example",
  "cluster_entry_id": "example",
  "data_export_forbidden": "off",
  "db_name": "example",
  "delegation_is_set": true,
  "description": "",
  "extra_credentials": {},
  "folder_id": "example",
  "form_fill_mode": "cloud",
  "host": "example",
  "jwt": "example",
  "listing_sources": "off",
  "mdb_cluster_id": "example",
  "password": "example",
  "port": 0,
  "raw_sql_level": "off",
  "service_account_id": "example",
  "ssl_ca": "null",
  "ssl_enable": "off",
  "username": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### ydb2 {#entity-ydb2}

#|
|| **Name** | **Description** ||
||

_ai_access_level_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `allow`

_Enum:_{.json-schema-reset .json-schema-value} `allow`, `allow_trusted`, `deny`
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

_cloud_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_data_export_forbidden_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `on`, `off`
{.table-cell}
||
||

_db_name_{.json-schema-reset .json-schema-property}
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

_folder_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_host_{.json-schema-reset .json-schema-property}
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

_port_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer
{.table-cell}
||
||

_raw_sql_level_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `off`, `subselect`, `template`, `dashsql`, `readwrite`
{.table-cell}
||
||

_service_account_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_ssl_ca_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_ssl_enable_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `on`

_Enum:_{.json-schema-reset .json-schema-value} `on`, `off`
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
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "ai_access_level": "allow",
  "auth_type": "anonymous",
  "cache_invalidation_throttling_interval_sec": null,
  "cache_ttl_sec": null,
  "cloud_id": "example",
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
  "ssl_ca": "null",
  "ssl_enable": "on",
  "token": "example",
  "username": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### yq2 {#entity-yq2}

#|
|| **Name** | **Description** ||
||

_ai_access_level_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `allow`

_Enum:_{.json-schema-reset .json-schema-value} `allow`, `allow_trusted`, `deny`
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

_data_export_forbidden_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `on`, `off`
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
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_raw_sql_level_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `off`, `subselect`, `template`, `dashsql`, `readwrite`
{.table-cell}
||
||

_service_account_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "ai_access_level": "allow",
  "cache_invalidation_throttling_interval_sec": null,
  "cache_ttl_sec": null,
  "cloud_id": "example",
  "data_export_forbidden": "off",
  "delegation_is_set": true,
  "description": "",
  "folder_id": "example",
  "raw_sql_level": "off",
  "service_account_id": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### ConnectionUpdate {#entity-ConnectionUpdate}

{% cut "**Any of 29 types**" %}{.json-schema-combinators data-marker=or}

- **appmetrica_api**

  **Type**: [appmetrica_api2](#entity-appmetrica_api2)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "accuracy": null,
    "ai_access_level": "allow",
    "counter_id": "example",
    "data_export_forbidden": "off",
    "description": "",
    "token": "example"
  }
  ```

  {% endcut %}

- **bigquery**

  **Type**: [bigquery2](#entity-bigquery2)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "ai_access_level": "allow",
    "cache_invalidation_throttling_interval_sec": null,
    "cache_ttl_sec": null,
    "credentials": "example",
    "description": "",
    "project_id": "example",
    "raw_sql_level": "off"
  }
  ```

  {% endcut %}

- **bitrix24**

  **Type**: [bitrix242](#entity-bitrix242)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "ai_access_level": "allow",
    "cache_invalidation_throttling_interval_sec": null,
    "cache_ttl_sec": null,
    "data_export_forbidden": "off",
    "description": "",
    "portal": "example",
    "token": "example"
  }
  ```

  {% endcut %}

- **ch_billing_analytics**

  **Type**: [ch_billing_analytics2](#entity-ch_billing_analytics2)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "ai_access_level": "allow",
    "description": ""
  }
  ```

  {% endcut %}

- **ch_ya_music_podcast_stats**

  **Type**: [ch_ya_music_podcast_stats2](#entity-ch_ya_music_podcast_stats2)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "ai_access_level": "allow",
    "description": "",
    "token": "example"
  }
  ```

  {% endcut %}

- **chyt**

  **Type**: [chyt2](#entity-chyt2)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "ai_access_level": "allow",
    "alias": "example",
    "cache_invalidation_throttling_interval_sec": null,
    "cache_ttl_sec": null,
    "data_export_forbidden": "off",
    "description": "",
    "host": "example",
    "port": 0,
    "raw_sql_level": "off",
    "secure": true,
    "token": "example"
  }
  ```

  {% endcut %}

- **clickhouse**

  **Type**: [clickhouse2](#entity-clickhouse2)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "ai_access_level": "allow",
    "cache_invalidation_throttling_interval_sec": null,
    "cache_ttl_sec": null,
    "connection_manager_cloud_id": "example",
    "connection_manager_connection_id": "example",
    "connection_manager_delegation_is_set": true,
    "connection_manager_folder_id": "example",
    "data_export_forbidden": "off",
    "db_name": "example",
    "description": "",
    "dlp_managed_cloud_id": "example",
    "dlp_managed_cluster_id": "example",
    "dlp_managed_connection_manager_connection_id": "example",
    "dlp_managed_connection_manager_delegation_is_set": true,
    "dlp_managed_folder_id": "example",
    "experimental_features": "off",
    "host": "example",
    "mdb_cluster_id": "example",
    "mdb_folder_id": "example",
    "mode": "null",
    "password": "example",
    "port": 0,
    "raw_sql_level": "off",
    "readonly": 2,
    "secure": "on",
    "ssl_ca": "null",
    "ssl_ca_verify": "on",
    "username": "example",
    "variant": "default"
  }
  ```

  {% endcut %}

- **equeo**

  **Type**: [equeo2](#entity-equeo2)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "ai_access_level": "allow",
    "description": ""
  }
  ```

  {% endcut %}

- **extractor1c**

  **Type**: [extractor1c2](#entity-extractor1c2)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "ai_access_level": "allow",
    "description": ""
  }
  ```

  {% endcut %}

- **greenplum**

  **Type**: [greenplum2](#entity-greenplum2)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "ai_access_level": "allow",
    "cache_invalidation_throttling_interval_sec": null,
    "cache_ttl_sec": null,
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
    "ssl_ca": "null",
    "ssl_enable": "off",
    "username": "example"
  }
  ```

  {% endcut %}

- **gsheets**

  **Type**: [gsheets2](#entity-gsheets2)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "ai_access_level": "allow",
    "cache_invalidation_throttling_interval_sec": null,
    "cache_ttl_sec": null,
    "data_export_forbidden": "off",
    "description": "",
    "url": "example"
  }
  ```

  {% endcut %}

- **json_api**

  **Type**: [json_api2](#entity-json_api2)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "ai_access_level": "allow",
    "allowed_methods": [
      "GET"
    ],
    "description": "",
    "host": "example",
    "path": "example",
    "plain_headers": {},
    "port": 0,
    "secret_headers": {},
    "secure": true
  }
  ```

  {% endcut %}

- **kontur_market**

  **Type**: [kontur_market2](#entity-kontur_market2)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "ai_access_level": "allow",
    "description": ""
  }
  ```

  {% endcut %}

- **metrika_api**

  **Type**: [metrika_api2](#entity-metrika_api2)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "accuracy": null,
    "ai_access_level": "allow",
    "counter_id": "example",
    "data_export_forbidden": "off",
    "description": "",
    "token": "example"
  }
  ```

  {% endcut %}

- **monitoring**

  **Type**: [monitoring2](#entity-monitoring2)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "ai_access_level": "allow",
    "cache_invalidation_throttling_interval_sec": null,
    "cache_ttl_sec": null,
    "cloud_id": "example",
    "delegation_is_set": true,
    "description": "",
    "folder_id": "example",
    "service_account_id": "example"
  }
  ```

  {% endcut %}

- **moysklad**

  **Type**: [moysklad2](#entity-moysklad2)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "ai_access_level": "allow",
    "description": ""
  }
  ```

  {% endcut %}

- **mssql**

  **Type**: [mssql2](#entity-mssql2)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "ai_access_level": "allow",
    "cache_invalidation_throttling_interval_sec": null,
    "cache_ttl_sec": null,
    "data_export_forbidden": "off",
    "db_name": "example",
    "description": "",
    "host": "example",
    "password": "example",
    "port": 0,
    "raw_sql_level": "off",
    "username": "example"
  }
  ```

  {% endcut %}

- **mysql**

  **Type**: [mysql2](#entity-mysql2)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "ai_access_level": "allow",
    "cache_invalidation_throttling_interval_sec": null,
    "cache_ttl_sec": null,
    "connection_manager_cloud_id": "example",
    "connection_manager_connection_id": "example",
    "connection_manager_delegation_is_set": true,
    "connection_manager_folder_id": "example",
    "data_export_forbidden": "off",
    "db_name": "example",
    "description": "",
    "dlp_managed_cloud_id": "example",
    "dlp_managed_cluster_id": "example",
    "dlp_managed_connection_manager_connection_id": "example",
    "dlp_managed_connection_manager_delegation_is_set": true,
    "dlp_managed_folder_id": "example",
    "enforce_collate": "off",
    "host": "example",
    "mdb_cluster_id": "example",
    "mdb_folder_id": "example",
    "mode": "null",
    "password": "example",
    "port": 0,
    "raw_sql_level": "off",
    "ssl_ca": "null",
    "ssl_enable": "off",
    "username": "example",
    "variant": "default"
  }
  ```

  {% endcut %}

- **oracle**

  **Type**: [oracle2](#entity-oracle2)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "ai_access_level": "allow",
    "cache_invalidation_throttling_interval_sec": null,
    "cache_ttl_sec": null,
    "data_export_forbidden": "off",
    "db_connect_method": "sid",
    "db_name": "example",
    "description": "",
    "host": "example",
    "password": "example",
    "port": 0,
    "raw_sql_level": "off",
    "ssl_ca": "null",
    "ssl_enable": "off",
    "username": "example"
  }
  ```

  {% endcut %}

- **postgres**

  **Type**: [postgres2](#entity-postgres2)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "ai_access_level": "allow",
    "cache_invalidation_throttling_interval_sec": null,
    "cache_ttl_sec": null,
    "connection_manager_cloud_id": "example",
    "connection_manager_connection_id": "example",
    "connection_manager_delegation_is_set": true,
    "connection_manager_folder_id": "example",
    "data_export_forbidden": "off",
    "db_name": "example",
    "description": "",
    "dlp_managed_cloud_id": "example",
    "dlp_managed_cluster_id": "example",
    "dlp_managed_connection_manager_connection_id": "example",
    "dlp_managed_connection_manager_delegation_is_set": true,
    "dlp_managed_folder_id": "example",
    "enforce_collate": "auto",
    "host": "example",
    "mdb_cluster_id": "example",
    "mdb_folder_id": "example",
    "mode": "null",
    "password": "example",
    "port": 0,
    "raw_sql_level": "off",
    "ssl_ca": "null",
    "ssl_enable": "off",
    "username": "example",
    "variant": "default"
  }
  ```

  {% endcut %}

- **promql**

  **Type**: [promql2](#entity-promql2)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "ai_access_level": "allow",
    "auth_header": "example",
    "auth_type": "password",
    "cache_invalidation_throttling_interval_sec": null,
    "cache_ttl_sec": null,
    "data_export_forbidden": "off",
    "db_name": "example",
    "description": "",
    "host": "example",
    "password": "example",
    "path": "example",
    "port": 0,
    "secure": true,
    "username": "example"
  }
  ```

  {% endcut %}

- **smb_heatmaps**

  **Type**: [smb_heatmaps2](#entity-smb_heatmaps2)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "ai_access_level": "allow",
    "description": "",
    "token": "example"
  }
  ```

  {% endcut %}

- **snowflake**

  **Type**: [snowflake2](#entity-snowflake2)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "account_name": "example",
    "ai_access_level": "allow",
    "client_id": "example",
    "client_secret": "example",
    "data_export_forbidden": "off",
    "db_name": "example",
    "description": "",
    "raw_sql_level": "off",
    "refresh_token": "example",
    "refresh_token_expire_time": "2025-01-01T00:00:00Z",
    "schema": "example",
    "user_name": "example",
    "user_role": "example",
    "warehouse": "example"
  }
  ```

  {% endcut %}

- **speechsense**

  **Type**: [speechsense2](#entity-speechsense2)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "ai_access_level": "allow",
    "auth_type": "user_credentials",
    "cloud_id": "null",
    "data_export_forbidden": "off",
    "delegation_is_set": null,
    "description": "",
    "folder_id": "null",
    "project_id": "example",
    "service_account_id": "null"
  }
  ```

  {% endcut %}

- **trino**

  **Type**: [trino2](#entity-trino2)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "ai_access_level": "allow",
    "auth_type": "certificate",
    "cache_invalidation_throttling_interval_sec": null,
    "cache_ttl_sec": null,
    "cloud_id": "example",
    "cluster_entry_id": "example",
    "data_export_forbidden": "off",
    "db_name": "example",
    "delegation_is_set": true,
    "description": "",
    "extra_credentials": {},
    "folder_id": "example",
    "form_fill_mode": "cloud",
    "host": "example",
    "jwt": "example",
    "listing_sources": "off",
    "mdb_cluster_id": "example",
    "password": "example",
    "port": 0,
    "raw_sql_level": "off",
    "service_account_id": "example",
    "ssl_ca": "null",
    "ssl_enable": "off",
    "username": "example"
  }
  ```

  {% endcut %}

- **usage_analytics_detailed**

  **Type**: [usage_analytics_detailed2](#entity-usage_analytics_detailed2)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "ai_access_level": "allow",
    "description": ""
  }
  ```

  {% endcut %}

- **usage_analytics_light**

  **Type**: [usage_analytics_light2](#entity-usage_analytics_light2)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "ai_access_level": "allow",
    "description": ""
  }
  ```

  {% endcut %}

- **ydb**

  **Type**: [ydb2](#entity-ydb2)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "ai_access_level": "allow",
    "auth_type": "anonymous",
    "cache_invalidation_throttling_interval_sec": null,
    "cache_ttl_sec": null,
    "cloud_id": "example",
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
    "ssl_ca": "null",
    "ssl_enable": "on",
    "token": "example",
    "username": "example"
  }
  ```

  {% endcut %}

- **yq**

  **Type**: [yq2](#entity-yq2)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "ai_access_level": "allow",
    "cache_invalidation_throttling_interval_sec": null,
    "cache_ttl_sec": null,
    "cloud_id": "example",
    "data_export_forbidden": "off",
    "delegation_is_set": true,
    "description": "",
    "folder_id": "example",
    "raw_sql_level": "off",
    "service_account_id": "example"
  }
  ```

  {% endcut %}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "accuracy": null,
  "ai_access_level": "allow",
  "counter_id": "example",
  "data_export_forbidden": "off",
  "description": "",
  "token": "example"
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

_accuracy_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: number &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_ai_access_level_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `allow`

_Enum:_{.json-schema-reset .json-schema-value} `allow`, `allow_trusted`, `deny`
{.table-cell}
||
||

_counter_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_data_export_forbidden_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `on`, `off`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} ``
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "accuracy": null,
  "ai_access_level": "allow",
  "counter_id": "example",
  "data_export_forbidden": "off",
  "description": ""
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### bigquery2 {#entity-bigquery21}

#|
|| **Name** | **Description** ||
||

_ai_access_level_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `allow`

_Enum:_{.json-schema-reset .json-schema-value} `allow`, `allow_trusted`, `deny`
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

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} ``
{.table-cell}
||
||

_project_id_{.json-schema-reset .json-schema-property}
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

_Enum:_{.json-schema-reset .json-schema-value} `off`, `subselect`, `template`, `dashsql`, `readwrite`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "ai_access_level": "allow",
  "cache_invalidation_throttling_interval_sec": null,
  "cache_ttl_sec": null,
  "description": "",
  "project_id": "example",
  "raw_sql_level": "off"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### bitrix242 {#entity-bitrix2421}

#|
|| **Name** | **Description** ||
||

_ai_access_level_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `allow`

_Enum:_{.json-schema-reset .json-schema-value} `allow`, `allow_trusted`, `deny`
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

_data_export_forbidden_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `on`, `off`
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

_portal_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "ai_access_level": "allow",
  "cache_invalidation_throttling_interval_sec": null,
  "cache_ttl_sec": null,
  "data_export_forbidden": "off",
  "description": "",
  "portal": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### chyt2 {#entity-chyt21}

#|
|| **Name** | **Description** ||
||

_ai_access_level_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `allow`

_Enum:_{.json-schema-reset .json-schema-value} `allow`, `allow_trusted`, `deny`
{.table-cell}
||
||

_alias_{.json-schema-reset .json-schema-property}
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

_data_export_forbidden_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `on`, `off`
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

_host_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_port_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer
{.table-cell}
||
||

_raw_sql_level_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `off`, `subselect`, `template`, `dashsql`, `readwrite`
{.table-cell}
||
||

_secure_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "ai_access_level": "allow",
  "alias": "example",
  "cache_invalidation_throttling_interval_sec": null,
  "cache_ttl_sec": null,
  "data_export_forbidden": "off",
  "description": "",
  "host": "example",
  "port": 0,
  "raw_sql_level": "off",
  "secure": true
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### clickhouse2 {#entity-clickhouse21}

#|
|| **Name** | **Description** ||
||

_ai_access_level_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `allow`

_Enum:_{.json-schema-reset .json-schema-value} `allow`, `allow_trusted`, `deny`
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
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `on`, `off`
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

_dlp_managed_cloud_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_dlp_managed_cluster_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_dlp_managed_connection_manager_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_dlp_managed_connection_manager_delegation_is_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean &#124; null
{.table-cell}
||
||

_dlp_managed_folder_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_experimental_features_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `on`, `off`
{.table-cell}
||
||

_host_{.json-schema-reset .json-schema-property}
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

_mode_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

_Enum:_{.json-schema-reset .json-schema-value} `onpremise`, `managed`, `null`
{.table-cell}
||
||

_port_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer
{.table-cell}
||
||

_raw_sql_level_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `off`, `subselect`, `template`, `dashsql`, `readwrite`
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
**Type**: string

_Enum:_{.json-schema-reset .json-schema-value} `on`, `off`
{.table-cell}
||
||

_ssl_ca_verify_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `on`

_Enum:_{.json-schema-reset .json-schema-value} `on`, `off`
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

_variant_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `default`

_Enum:_{.json-schema-reset .json-schema-value} `default`, `dlp`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "ai_access_level": "allow",
  "cache_invalidation_throttling_interval_sec": null,
  "cache_ttl_sec": null,
  "connection_manager_cloud_id": "example",
  "connection_manager_connection_id": "example",
  "connection_manager_delegation_is_set": true,
  "connection_manager_folder_id": "example",
  "data_export_forbidden": "off",
  "db_name": "example",
  "description": "",
  "dlp_managed_cloud_id": "example",
  "dlp_managed_cluster_id": "example",
  "dlp_managed_connection_manager_connection_id": "example",
  "dlp_managed_connection_manager_delegation_is_set": true,
  "dlp_managed_folder_id": "example",
  "experimental_features": "off",
  "host": "example",
  "mdb_cluster_id": "example",
  "mdb_folder_id": "example",
  "mode": "null",
  "port": 0,
  "raw_sql_level": "off",
  "readonly": 2,
  "secure": "on",
  "ssl_ca_verify": "on",
  "username": "example",
  "variant": "default"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### greenplum2 {#entity-greenplum21}

#|
|| **Name** | **Description** ||
||

_ai_access_level_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `allow`

_Enum:_{.json-schema-reset .json-schema-value} `allow`, `allow_trusted`, `deny`
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

_data_export_forbidden_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `on`, `off`
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

_host_{.json-schema-reset .json-schema-property}
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

_port_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer
{.table-cell}
||
||

_raw_sql_level_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `off`, `subselect`, `template`, `dashsql`, `readwrite`
{.table-cell}
||
||

_ssl_enable_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `on`, `off`
{.table-cell}
||
||

_username_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "ai_access_level": "allow",
  "cache_invalidation_throttling_interval_sec": null,
  "cache_ttl_sec": null,
  "data_export_forbidden": "off",
  "db_name": "example",
  "description": "",
  "enforce_collate": "auto",
  "host": "example",
  "mdb_cluster_id": "example",
  "mdb_folder_id": "example",
  "port": 0,
  "raw_sql_level": "off",
  "ssl_enable": "off",
  "username": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### mssql2 {#entity-mssql21}

#|
|| **Name** | **Description** ||
||

_ai_access_level_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `allow`

_Enum:_{.json-schema-reset .json-schema-value} `allow`, `allow_trusted`, `deny`
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

_data_export_forbidden_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `on`, `off`
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

_host_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_port_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer
{.table-cell}
||
||

_raw_sql_level_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `off`, `subselect`, `template`, `dashsql`, `readwrite`
{.table-cell}
||
||

_username_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "ai_access_level": "allow",
  "cache_invalidation_throttling_interval_sec": null,
  "cache_ttl_sec": null,
  "data_export_forbidden": "off",
  "db_name": "example",
  "description": "",
  "host": "example",
  "port": 0,
  "raw_sql_level": "off",
  "username": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### mysql2 {#entity-mysql21}

#|
|| **Name** | **Description** ||
||

_ai_access_level_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `allow`

_Enum:_{.json-schema-reset .json-schema-value} `allow`, `allow_trusted`, `deny`
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
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `on`, `off`
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

_dlp_managed_cloud_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_dlp_managed_cluster_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_dlp_managed_connection_manager_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_dlp_managed_connection_manager_delegation_is_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean &#124; null
{.table-cell}
||
||

_dlp_managed_folder_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
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

_host_{.json-schema-reset .json-schema-property}
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

_mode_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

_Enum:_{.json-schema-reset .json-schema-value} `onpremise`, `managed`, `null`
{.table-cell}
||
||

_port_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer
{.table-cell}
||
||

_raw_sql_level_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `off`, `subselect`, `template`, `dashsql`, `readwrite`
{.table-cell}
||
||

_ssl_enable_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `on`, `off`
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

_variant_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `default`

_Enum:_{.json-schema-reset .json-schema-value} `default`, `dlp`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "ai_access_level": "allow",
  "cache_invalidation_throttling_interval_sec": null,
  "cache_ttl_sec": null,
  "connection_manager_cloud_id": "example",
  "connection_manager_connection_id": "example",
  "connection_manager_delegation_is_set": true,
  "connection_manager_folder_id": "example",
  "data_export_forbidden": "off",
  "db_name": "example",
  "description": "",
  "dlp_managed_cloud_id": "example",
  "dlp_managed_cluster_id": "example",
  "dlp_managed_connection_manager_connection_id": "example",
  "dlp_managed_connection_manager_delegation_is_set": true,
  "dlp_managed_folder_id": "example",
  "enforce_collate": "off",
  "host": "example",
  "mdb_cluster_id": "example",
  "mdb_folder_id": "example",
  "mode": "null",
  "port": 0,
  "raw_sql_level": "off",
  "ssl_enable": "off",
  "username": "example",
  "variant": "default"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### oracle2 {#entity-oracle21}

#|
|| **Name** | **Description** ||
||

_ai_access_level_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `allow`

_Enum:_{.json-schema-reset .json-schema-value} `allow`, `allow_trusted`, `deny`
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

_data_export_forbidden_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `on`, `off`
{.table-cell}
||
||

_db_connect_method_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Enum:_{.json-schema-reset .json-schema-value} `sid`, `service_name`
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

_host_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_port_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer
{.table-cell}
||
||

_raw_sql_level_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `off`, `subselect`, `template`, `dashsql`, `readwrite`
{.table-cell}
||
||

_ssl_enable_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `on`, `off`
{.table-cell}
||
||

_username_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "ai_access_level": "allow",
  "cache_invalidation_throttling_interval_sec": null,
  "cache_ttl_sec": null,
  "data_export_forbidden": "off",
  "db_connect_method": "sid",
  "db_name": "example",
  "description": "",
  "host": "example",
  "port": 0,
  "raw_sql_level": "off",
  "ssl_enable": "off",
  "username": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### postgres2 {#entity-postgres21}

#|
|| **Name** | **Description** ||
||

_ai_access_level_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `allow`

_Enum:_{.json-schema-reset .json-schema-value} `allow`, `allow_trusted`, `deny`
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
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `on`, `off`
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

_dlp_managed_cloud_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_dlp_managed_cluster_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_dlp_managed_connection_manager_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_dlp_managed_connection_manager_delegation_is_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean &#124; null
{.table-cell}
||
||

_dlp_managed_folder_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
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

_host_{.json-schema-reset .json-schema-property}
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

_mode_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

_Enum:_{.json-schema-reset .json-schema-value} `onpremise`, `managed`, `null`
{.table-cell}
||
||

_port_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer
{.table-cell}
||
||

_raw_sql_level_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `off`, `subselect`, `template`, `dashsql`, `readwrite`
{.table-cell}
||
||

_ssl_enable_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `on`, `off`
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

_variant_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `default`

_Enum:_{.json-schema-reset .json-schema-value} `default`, `dlp`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "ai_access_level": "allow",
  "cache_invalidation_throttling_interval_sec": null,
  "cache_ttl_sec": null,
  "connection_manager_cloud_id": "example",
  "connection_manager_connection_id": "example",
  "connection_manager_delegation_is_set": true,
  "connection_manager_folder_id": "example",
  "data_export_forbidden": "off",
  "db_name": "example",
  "description": "",
  "dlp_managed_cloud_id": "example",
  "dlp_managed_cluster_id": "example",
  "dlp_managed_connection_manager_connection_id": "example",
  "dlp_managed_connection_manager_delegation_is_set": true,
  "dlp_managed_folder_id": "example",
  "enforce_collate": "auto",
  "host": "example",
  "mdb_cluster_id": "example",
  "mdb_folder_id": "example",
  "mode": "null",
  "port": 0,
  "raw_sql_level": "off",
  "ssl_enable": "off",
  "username": "example",
  "variant": "default"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### promql2 {#entity-promql21}

#|
|| **Name** | **Description** ||
||

_ai_access_level_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `allow`

_Enum:_{.json-schema-reset .json-schema-value} `allow`, `allow_trusted`, `deny`
{.table-cell}
||
||

_auth_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `password`

_Enum:_{.json-schema-reset .json-schema-value} `header`, `password`
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

_data_export_forbidden_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `on`, `off`
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

_host_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

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

_port_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer
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
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "ai_access_level": "allow",
  "auth_type": "password",
  "cache_invalidation_throttling_interval_sec": null,
  "cache_ttl_sec": null,
  "data_export_forbidden": "off",
  "db_name": "example",
  "description": "",
  "host": "example",
  "path": "example",
  "port": 0,
  "secure": true,
  "username": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### snowflake2 {#entity-snowflake21}

#|
|| **Name** | **Description** ||
||

_account_name_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_ai_access_level_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `allow`

_Enum:_{.json-schema-reset .json-schema-value} `allow`, `allow_trusted`, `deny`
{.table-cell}
||
||

_client_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_data_export_forbidden_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `on`, `off`
{.table-cell}
||
||

_db_name_{.json-schema-reset .json-schema-property}
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

_raw_sql_level_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `off`, `subselect`, `template`, `dashsql`, `readwrite`
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

_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_user_name_{.json-schema-reset .json-schema-property}
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

_warehouse_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "account_name": "example",
  "ai_access_level": "allow",
  "client_id": "example",
  "data_export_forbidden": "off",
  "db_name": "example",
  "description": "",
  "raw_sql_level": "off",
  "refresh_token_expire_time": "2025-01-01T00:00:00Z",
  "schema": "example",
  "user_name": "example",
  "user_role": "example",
  "warehouse": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### trino2 {#entity-trino21}

#|
|| **Name** | **Description** ||
||

_ai_access_level_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `allow`

_Enum:_{.json-schema-reset .json-schema-value} `allow`, `allow_trusted`, `deny`
{.table-cell}
||
||

_auth_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `certificate`, `header`, `jwt`, `kerberos`, `none`, `oauth2`, `password`, `null`

_Example:_{.json-schema-reset .json-schema-example} `certificate`
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

_cluster_entry_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_data_export_forbidden_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `on`, `off`
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

_extra_credentials_{.json-schema-reset .json-schema-property}
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

_folder_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_form_fill_mode_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Enum:_{.json-schema-reset .json-schema-value} `cloud`, `manually`, `platform`
{.table-cell}
||
||

_host_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_listing_sources_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Enum:_{.json-schema-reset .json-schema-value} `off`, `on`
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

_Enum:_{.json-schema-reset .json-schema-value} `off`, `subselect`, `template`, `dashsql`, `readwrite`
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
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `on`, `off`
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
  "ai_access_level": "allow",
  "auth_type": "certificate",
  "cache_invalidation_throttling_interval_sec": null,
  "cache_ttl_sec": null,
  "cloud_id": "example",
  "cluster_entry_id": "example",
  "data_export_forbidden": "off",
  "db_name": "example",
  "delegation_is_set": true,
  "description": "",
  "extra_credentials": {},
  "folder_id": "example",
  "form_fill_mode": "cloud",
  "host": "example",
  "listing_sources": "off",
  "mdb_cluster_id": "example",
  "port": 0,
  "raw_sql_level": "off",
  "service_account_id": "example",
  "ssl_enable": "off",
  "username": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### ydb2 {#entity-ydb21}

#|
|| **Name** | **Description** ||
||

_ai_access_level_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `allow`

_Enum:_{.json-schema-reset .json-schema-value} `allow`, `allow_trusted`, `deny`
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

_cloud_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_data_export_forbidden_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `on`, `off`
{.table-cell}
||
||

_db_name_{.json-schema-reset .json-schema-property}
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

_folder_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_host_{.json-schema-reset .json-schema-property}
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

_port_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer
{.table-cell}
||
||

_raw_sql_level_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `off`, `subselect`, `template`, `dashsql`, `readwrite`
{.table-cell}
||
||

_service_account_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_ssl_enable_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `on`

_Enum:_{.json-schema-reset .json-schema-value} `on`, `off`
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
  "ai_access_level": "allow",
  "auth_type": "anonymous",
  "cache_invalidation_throttling_interval_sec": null,
  "cache_ttl_sec": null,
  "cloud_id": "example",
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
  "ssl_enable": "on",
  "username": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### ConnectionUpdate {#entity-ConnectionUpdate1}

{% cut "**Any of 29 types**" %}{.json-schema-combinators data-marker=or}

- **appmetrica_api**

  **Type**: [appmetrica_api2](#entity-appmetrica_api21)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "accuracy": null,
    "ai_access_level": "allow",
    "counter_id": "example",
    "data_export_forbidden": "off",
    "description": ""
  }
  ```

  {% endcut %}

- **bigquery**

  **Type**: [bigquery2](#entity-bigquery21)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "ai_access_level": "allow",
    "cache_invalidation_throttling_interval_sec": null,
    "cache_ttl_sec": null,
    "description": "",
    "project_id": "example",
    "raw_sql_level": "off"
  }
  ```

  {% endcut %}

- **bitrix24**

  **Type**: [bitrix242](#entity-bitrix2421)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "ai_access_level": "allow",
    "cache_invalidation_throttling_interval_sec": null,
    "cache_ttl_sec": null,
    "data_export_forbidden": "off",
    "description": "",
    "portal": "example"
  }
  ```

  {% endcut %}

- **ch_billing_analytics**

  **Type**: [ch_billing_analytics2](#entity-ch_billing_analytics2)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "ai_access_level": "allow",
    "description": ""
  }
  ```

  {% endcut %}

- **ch_ya_music_podcast_stats**

  **Type**: [ch_ya_music_podcast_stats2](#entity-ch_billing_analytics2)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "ai_access_level": "allow",
    "description": ""
  }
  ```

  {% endcut %}

- **chyt**

  **Type**: [chyt2](#entity-chyt21)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "ai_access_level": "allow",
    "alias": "example",
    "cache_invalidation_throttling_interval_sec": null,
    "cache_ttl_sec": null,
    "data_export_forbidden": "off",
    "description": "",
    "host": "example",
    "port": 0,
    "raw_sql_level": "off",
    "secure": true
  }
  ```

  {% endcut %}

- **clickhouse**

  **Type**: [clickhouse2](#entity-clickhouse21)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "ai_access_level": "allow",
    "cache_invalidation_throttling_interval_sec": null,
    "cache_ttl_sec": null,
    "connection_manager_cloud_id": "example",
    "connection_manager_connection_id": "example",
    "connection_manager_delegation_is_set": true,
    "connection_manager_folder_id": "example",
    "data_export_forbidden": "off",
    "db_name": "example",
    "description": "",
    "dlp_managed_cloud_id": "example",
    "dlp_managed_cluster_id": "example",
    "dlp_managed_connection_manager_connection_id": "example",
    "dlp_managed_connection_manager_delegation_is_set": true,
    "dlp_managed_folder_id": "example",
    "experimental_features": "off",
    "host": "example",
    "mdb_cluster_id": "example",
    "mdb_folder_id": "example",
    "mode": "null",
    "port": 0,
    "raw_sql_level": "off",
    "readonly": 2,
    "secure": "on",
    "ssl_ca_verify": "on",
    "username": "example",
    "variant": "default"
  }
  ```

  {% endcut %}

- **equeo**

  **Type**: [equeo2](#entity-ch_billing_analytics2)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "ai_access_level": "allow",
    "description": ""
  }
  ```

  {% endcut %}

- **extractor1c**

  **Type**: [extractor1c2](#entity-ch_billing_analytics2)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "ai_access_level": "allow",
    "description": ""
  }
  ```

  {% endcut %}

- **greenplum**

  **Type**: [greenplum2](#entity-greenplum21)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "ai_access_level": "allow",
    "cache_invalidation_throttling_interval_sec": null,
    "cache_ttl_sec": null,
    "data_export_forbidden": "off",
    "db_name": "example",
    "description": "",
    "enforce_collate": "auto",
    "host": "example",
    "mdb_cluster_id": "example",
    "mdb_folder_id": "example",
    "port": 0,
    "raw_sql_level": "off",
    "ssl_enable": "off",
    "username": "example"
  }
  ```

  {% endcut %}

- **gsheets**

  **Type**: [gsheets2](#entity-gsheets2)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "ai_access_level": "allow",
    "cache_invalidation_throttling_interval_sec": null,
    "cache_ttl_sec": null,
    "data_export_forbidden": "off",
    "description": "",
    "url": "example"
  }
  ```

  {% endcut %}

- **json_api**

  **Type**: [json_api2](#entity-json_api2)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "ai_access_level": "allow",
    "allowed_methods": [
      "GET"
    ],
    "description": "",
    "host": "example",
    "path": "example",
    "plain_headers": {},
    "port": 0,
    "secret_headers": {},
    "secure": true
  }
  ```

  {% endcut %}

- **kontur_market**

  **Type**: [kontur_market2](#entity-ch_billing_analytics2)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "ai_access_level": "allow",
    "description": ""
  }
  ```

  {% endcut %}

- **metrika_api**

  **Type**: [metrika_api2](#entity-appmetrica_api21)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "accuracy": null,
    "ai_access_level": "allow",
    "counter_id": "example",
    "data_export_forbidden": "off",
    "description": ""
  }
  ```

  {% endcut %}

- **monitoring**

  **Type**: [monitoring2](#entity-monitoring2)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "ai_access_level": "allow",
    "cache_invalidation_throttling_interval_sec": null,
    "cache_ttl_sec": null,
    "cloud_id": "example",
    "delegation_is_set": true,
    "description": "",
    "folder_id": "example",
    "service_account_id": "example"
  }
  ```

  {% endcut %}

- **moysklad**

  **Type**: [moysklad2](#entity-ch_billing_analytics2)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "ai_access_level": "allow",
    "description": ""
  }
  ```

  {% endcut %}

- **mssql**

  **Type**: [mssql2](#entity-mssql21)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "ai_access_level": "allow",
    "cache_invalidation_throttling_interval_sec": null,
    "cache_ttl_sec": null,
    "data_export_forbidden": "off",
    "db_name": "example",
    "description": "",
    "host": "example",
    "port": 0,
    "raw_sql_level": "off",
    "username": "example"
  }
  ```

  {% endcut %}

- **mysql**

  **Type**: [mysql2](#entity-mysql21)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "ai_access_level": "allow",
    "cache_invalidation_throttling_interval_sec": null,
    "cache_ttl_sec": null,
    "connection_manager_cloud_id": "example",
    "connection_manager_connection_id": "example",
    "connection_manager_delegation_is_set": true,
    "connection_manager_folder_id": "example",
    "data_export_forbidden": "off",
    "db_name": "example",
    "description": "",
    "dlp_managed_cloud_id": "example",
    "dlp_managed_cluster_id": "example",
    "dlp_managed_connection_manager_connection_id": "example",
    "dlp_managed_connection_manager_delegation_is_set": true,
    "dlp_managed_folder_id": "example",
    "enforce_collate": "off",
    "host": "example",
    "mdb_cluster_id": "example",
    "mdb_folder_id": "example",
    "mode": "null",
    "port": 0,
    "raw_sql_level": "off",
    "ssl_enable": "off",
    "username": "example",
    "variant": "default"
  }
  ```

  {% endcut %}

- **oracle**

  **Type**: [oracle2](#entity-oracle21)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "ai_access_level": "allow",
    "cache_invalidation_throttling_interval_sec": null,
    "cache_ttl_sec": null,
    "data_export_forbidden": "off",
    "db_connect_method": "sid",
    "db_name": "example",
    "description": "",
    "host": "example",
    "port": 0,
    "raw_sql_level": "off",
    "ssl_enable": "off",
    "username": "example"
  }
  ```

  {% endcut %}

- **postgres**

  **Type**: [postgres2](#entity-postgres21)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "ai_access_level": "allow",
    "cache_invalidation_throttling_interval_sec": null,
    "cache_ttl_sec": null,
    "connection_manager_cloud_id": "example",
    "connection_manager_connection_id": "example",
    "connection_manager_delegation_is_set": true,
    "connection_manager_folder_id": "example",
    "data_export_forbidden": "off",
    "db_name": "example",
    "description": "",
    "dlp_managed_cloud_id": "example",
    "dlp_managed_cluster_id": "example",
    "dlp_managed_connection_manager_connection_id": "example",
    "dlp_managed_connection_manager_delegation_is_set": true,
    "dlp_managed_folder_id": "example",
    "enforce_collate": "auto",
    "host": "example",
    "mdb_cluster_id": "example",
    "mdb_folder_id": "example",
    "mode": "null",
    "port": 0,
    "raw_sql_level": "off",
    "ssl_enable": "off",
    "username": "example",
    "variant": "default"
  }
  ```

  {% endcut %}

- **promql**

  **Type**: [promql2](#entity-promql21)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "ai_access_level": "allow",
    "auth_type": "password",
    "cache_invalidation_throttling_interval_sec": null,
    "cache_ttl_sec": null,
    "data_export_forbidden": "off",
    "db_name": "example",
    "description": "",
    "host": "example",
    "path": "example",
    "port": 0,
    "secure": true,
    "username": "example"
  }
  ```

  {% endcut %}

- **smb_heatmaps**

  **Type**: [smb_heatmaps2](#entity-ch_billing_analytics2)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "ai_access_level": "allow",
    "description": ""
  }
  ```

  {% endcut %}

- **snowflake**

  **Type**: [snowflake2](#entity-snowflake21)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "account_name": "example",
    "ai_access_level": "allow",
    "client_id": "example",
    "data_export_forbidden": "off",
    "db_name": "example",
    "description": "",
    "raw_sql_level": "off",
    "refresh_token_expire_time": "2025-01-01T00:00:00Z",
    "schema": "example",
    "user_name": "example",
    "user_role": "example",
    "warehouse": "example"
  }
  ```

  {% endcut %}

- **speechsense**

  **Type**: [speechsense2](#entity-speechsense2)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "ai_access_level": "allow",
    "auth_type": "user_credentials",
    "cloud_id": "null",
    "data_export_forbidden": "off",
    "delegation_is_set": null,
    "description": "",
    "folder_id": "null",
    "project_id": "example",
    "service_account_id": "null"
  }
  ```

  {% endcut %}

- **trino**

  **Type**: [trino2](#entity-trino21)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "ai_access_level": "allow",
    "auth_type": "certificate",
    "cache_invalidation_throttling_interval_sec": null,
    "cache_ttl_sec": null,
    "cloud_id": "example",
    "cluster_entry_id": "example",
    "data_export_forbidden": "off",
    "db_name": "example",
    "delegation_is_set": true,
    "description": "",
    "extra_credentials": {},
    "folder_id": "example",
    "form_fill_mode": "cloud",
    "host": "example",
    "listing_sources": "off",
    "mdb_cluster_id": "example",
    "port": 0,
    "raw_sql_level": "off",
    "service_account_id": "example",
    "ssl_enable": "off",
    "username": "example"
  }
  ```

  {% endcut %}

- **usage_analytics_detailed**

  **Type**: [usage_analytics_detailed2](#entity-ch_billing_analytics2)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "ai_access_level": "allow",
    "description": ""
  }
  ```

  {% endcut %}

- **usage_analytics_light**

  **Type**: [usage_analytics_light2](#entity-ch_billing_analytics2)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "ai_access_level": "allow",
    "description": ""
  }
  ```

  {% endcut %}

- **ydb**

  **Type**: [ydb2](#entity-ydb21)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "ai_access_level": "allow",
    "auth_type": "anonymous",
    "cache_invalidation_throttling_interval_sec": null,
    "cache_ttl_sec": null,
    "cloud_id": "example",
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
    "ssl_enable": "on",
    "username": "example"
  }
  ```

  {% endcut %}

- **yq**

  **Type**: [yq2](#entity-yq2)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "ai_access_level": "allow",
    "cache_invalidation_throttling_interval_sec": null,
    "cache_ttl_sec": null,
    "cloud_id": "example",
    "data_export_forbidden": "off",
    "delegation_is_set": true,
    "description": "",
    "folder_id": "example",
    "raw_sql_level": "off",
    "service_account_id": "example"
  }
  ```

  {% endcut %}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "accuracy": null,
  "ai_access_level": "allow",
  "counter_id": "example",
  "data_export_forbidden": "off",
  "description": ""
}
```

{% endcut %}

</div>

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.