[Документация Yandex Cloud](../../../index.md) > [Партнерская программа B2B Tech](../../index.md) > Партнерский портал > [API](../../api/index.md) > [Описание методов (англ.)](../index.md) > [Accounts](index.md) > Update account

<div class="openapi">

# Update account

<!-- markdownlint-disable-file -->

Update account data.

PATCH /accounts/v1/:masterBAId/account/:accountId

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-patch);margin-bottom: 12px">

<div class="openapi__request">

PATCH {.openapi__method}
```text translate=no
/accounts/v1/{masterBAId}/account/{accountId}
```

</div>

</div>

</div>

### Path parameters

#|
|| **Name** | **Description** ||
||

_accountId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Account ID

_Example:_{.json-schema-reset .json-schema-example} ``
{.table-cell}
||
||

_masterBAId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Master billing account ID

_Example:_{.json-schema-reset .json-schema-example} ``
{.table-cell}
||
|#{.json-schema-properties}

<div class="openapi-entity">

### Body

{% cut "application/json" %}

```json translate=no
{
  "description": "## Тест *Tests*"
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_description_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Account description using markdown syntax

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

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
  "operationId": "f8119ace-4075-4397-b2b9-e07228120783",
  "operationType": "UpdateAccount"
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_operationId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Operation ID

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_operationType_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Operation type = UpdateAccount

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

</div>

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.