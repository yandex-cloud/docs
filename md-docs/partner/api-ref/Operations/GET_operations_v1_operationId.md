[Документация Yandex Cloud](../../../index.md) > [Партнерская программа B2B Tech](../../index.md) > Партнерский портал > [API](../../api/index.md) > [Описание методов (англ.)](../index.md) > [Operations](index.md) > Request operation data

<div class="openapi">

# Request operation data

<!-- markdownlint-disable-file -->

Get operation data by its ID.

GET /operations/v1/:operationId

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-get);margin-bottom: 12px">

<div class="openapi__request">

GET {.openapi__method}
```text translate=no
/operations/v1/{operationId}
```

</div>

</div>

</div>

### Path parameters

#|
|| **Name** | **Description** ||
||

_operationId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string&lt;uuid&gt;

Operation ID (UUID)

_Example:_{.json-schema-reset .json-schema-example} ``
{.table-cell}
||
|#{.json-schema-properties}

### Query parameters

#|
|| **Name** | **Description** ||
||

_operationType_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: [OperationType](#entity-OperationType)

Operation type:
- CreateAccount — Account creation
- UpdateAccount — Account update

Operation type (as validated by server, 2026-10 preprod probe)

_Enum:_{.json-schema-reset .json-schema-value} `CreateAccount`, `UpdateAccount`, `Deals`, `Orders`, `CreateOpportunity`, `UpdateOpportunity`
{.table-cell}
||
|#{.json-schema-properties}

<div class="openapi-entity">

### OperationType {#entity-OperationType}

Operation type (as validated by server, 2026-10 preprod probe)

**Type**: string

_Enum:_{.json-schema-reset .json-schema-value} `CreateAccount`, `UpdateAccount`, `Deals`, `Orders`, `CreateOpportunity`, `UpdateOpportunity`

</div>

## Responses

<div class="openapi__response__code__200">

## 200 OK

Successful response

<div class="openapi-entity">

### Body

{% cut "application/json" %}

```json translate=no
{
  "id": "f8119ace-4075-4397-b2b9-e07228120783",
  "done": true,
  "error": ""
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_done_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: boolean

Operation status (completed or not)
{.table-cell}
||
||

_error_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Error text (empty string if there are no errors)

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

ID of the record that was created, updated, or deleted

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

</div>

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.