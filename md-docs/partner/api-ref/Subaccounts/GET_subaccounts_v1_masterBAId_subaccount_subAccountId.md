[Документация Yandex Cloud](../../../index.md) > [Партнерская программа B2B Tech](../../index.md) > Партнерский портал > [API](../../api/index.md) > [Описание методов (англ.)](../index.md) > [Subaccounts](index.md) > Subaccount data

<div class="openapi">

# Subaccount data

<!-- markdownlint-disable-file -->

Get subaccount data by ID.

GET /subaccounts/v1/:masterBAId/subaccount/:subAccountId

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-get);margin-bottom: 12px">

<div class="openapi__request">

GET {.openapi__method}
```text translate=no
/subaccounts/v1/{masterBAId}/subaccount/{subAccountId}
```

</div>

</div>

</div>

### Path parameters

#|
|| **Name** | **Description** ||
||

_masterBAId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Master billing account ID

_Example:_{.json-schema-reset .json-schema-example} ``
{.table-cell}
||
||

_subAccountId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Subaccount ID

_Example:_{.json-schema-reset .json-schema-example} ``
{.table-cell}
||
|#{.json-schema-properties}

## Responses

<div class="openapi__response__code__200">

## 200 OK

Successful response

<div class="openapi-entity">

### Body

{% cut "application/json" %}

```json translate=no
{
  "createdAt": 1772012856,
  "name": "Subaccount Renamed",
  "email": "test.partners-api@yandex.ru",
  "phone": "+79991234567",
  "state": "active",
  "externalId": 133742021,
  "accountId": "789c6c9c-ccb0-429e-a6da-40c95a1575dc"
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_createdAt_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: number

Creation date UTC (Unix timestamp)
{.table-cell}
||
||

_email_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Email address

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Subaccount name

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_phone_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Phone number

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_state_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Subaccount state (e.g., "active")

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_accountId_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Linked account ID

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_externalId_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

Used when you need to tag a subaccount using your internal company identifiers

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

</div>

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.