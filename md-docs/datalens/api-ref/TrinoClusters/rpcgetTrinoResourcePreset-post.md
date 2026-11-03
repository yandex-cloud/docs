[Документация Yandex Cloud](../../../index.md) > [Yandex DataLens](../../index.md) > DataLens Public API > [DataLens API (англ.)](../index.md) > [TrinoClusters](index.md) > 🚧 [Experimental] Get Trino resource preset

<div class="openapi">

# 🚧 [Experimental] Get Trino resource preset

<!-- markdownlint-disable-file -->

Returns the specified Trino resource preset.

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
https://api.datalens.tech/rpc/getTrinoResourcePreset
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
  "resourcePresetId": "example",
  "cloudEnvironmentId": "example"
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_cloudEnvironmentId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the cloud environment the resource preset is requested for.

_Min length:_{.json-schema-reset .json-schema-assertion} `1`

_Max length:_{.json-schema-reset .json-schema-assertion} `50`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_resourcePresetId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the resource preset to return.

_Min length:_{.json-schema-reset .json-schema-assertion} `1`

_Max length:_{.json-schema-reset .json-schema-assertion} `50`

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
  "id": "example",
  "cores": "example",
  "memory": "example"
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_cores_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Number of CPU cores for an instance created with the preset.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the resource preset.

_Min length:_{.json-schema-reset .json-schema-assertion} `1`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_memory_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

RAM volume for an instance created with the preset, in bytes.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

</div>

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.