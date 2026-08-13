[Документация Yandex Cloud](../../../index.md) > [Yandex DataLens](../../index.md) > DataLens Public API > [DataLens API (англ.)](../index.md) > [EmbeddingSecrets](index.md) > List embedding secrets

<div class="openapi">

# List embedding secrets

<!-- markdownlint-disable-file -->

Lists keys for embedding of the specified workbook.

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
https://api.datalens.tech/rpc/listEmbeddingSecrets
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
  "workbookId": "example"
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_workbookId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the workbook to list its keys for embedding.

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
    "embeddingSecretId": "example",
    "title": "example",
    "workbookId": "example",
    "createdBy": "example",
    "createdAt": "example"
  }
]
```

{% endcut %}

**Type**: [EmbeddingSecret](#entity-EmbeddingSecret)[]

</div>

<div class="openapi-entity">

### EmbeddingSecret {#entity-EmbeddingSecret}

#|
|| **Name** | **Description** ||
||

_createdAt_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Date and time when the key for embedding was created.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_createdBy_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the user who created the key for embedding.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_embeddingSecretId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Unique identifier of the key for embedding.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Name of the key for embedding.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_workbookId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the workbook associated with the key for embedding.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "embeddingSecretId": "example",
  "title": "example",
  "workbookId": "example",
  "createdBy": "example",
  "createdAt": "example"
}
```

{% endcut %}

</div>

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.