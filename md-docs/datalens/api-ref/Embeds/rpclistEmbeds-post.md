[Документация Yandex Cloud](../../../index.md) > [Yandex DataLens](../../index.md) > DataLens Public API > [DataLens API (англ.)](../index.md) > [Embeds](index.md) > List embeds

<div class="openapi">

# List embeds

<!-- markdownlint-disable-file -->

Lists embeddings of the specified entry.

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
https://api.datalens.tech/rpc/listEmbeds
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
  "entryId": "example"
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_entryId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the entry to list embeddings for.

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
[
  {
    "embedId": "example",
    "title": "example",
    "embeddingSecretId": "example",
    "entryId": "example",
    "depsIds": [
      "example"
    ],
    "unsignedParams": [
      "example"
    ],
    "privateParams": [
      "example"
    ],
    "createdBy": "example",
    "createdAt": "example",
    "updatedAt": "example",
    "updatedBy": "example",
    "publicParamsMode": true,
    "settings": {
      "enableExport": true
    }
  }
]
```

{% endcut %}

**Type**: [Embed](#entity-Embed)[]

</div>

<div class="openapi-entity">

### EmbedSettings {#entity-EmbedSettings}

#|
|| **Name** | **Description** ||
||

_enableExport_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

Whether data export is enabled for the embedding.
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "enableExport": true
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### Embed {#entity-Embed}

#|
|| **Name** | **Description** ||
||

_createdAt_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Timestamp when the embedding was created.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_createdBy_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the user who created the embedding.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_depsIds_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string[]

Array of dependency entry IDs.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  "example"
]
```

{% endcut %}
{.table-cell}
||
||

_embeddingSecretId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the key for embedding used for authentication.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_embedId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Unique identifier of the embedding.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_entryId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the entry being privately embedded.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_privateParams_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string[]

Array of signed parameters that are provided as part of the token.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  "example"
]
```

{% endcut %}
{.table-cell}
||
||

_publicParamsMode_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: boolean

Whether default parameters mode is enabled.
{.table-cell}
||
||

_settings_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: [EmbedSettings](#entity-EmbedSettings)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "enableExport": true
}
```

{% endcut %}
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Name of the embedding.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_unsignedParams_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string[]

Array of unsigned parameters to be provided in the embedding link.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  "example"
]
```

{% endcut %}
{.table-cell}
||
||

_updatedAt_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Timestamp when the embedding was last updated.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_updatedBy_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the user who was the last to update the embedding.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "embedId": "example",
  "title": "example",
  "embeddingSecretId": "example",
  "entryId": "example",
  "depsIds": [
    "example"
  ],
  "unsignedParams": [
    "example"
  ],
  "privateParams": [
    "example"
  ],
  "createdBy": "example",
  "createdAt": "example",
  "updatedAt": "example",
  "updatedBy": "example",
  "publicParamsMode": true,
  "settings": {
    "enableExport": true
  }
}
```

{% endcut %}

</div>

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.