[Документация Yandex Cloud](../../../index.md) > [Партнерская программа B2B Tech](../../index.md) > Партнерский портал > [API](../../api/index.md) > [Описание методов (англ.)](../index.md) > [Accounts](index.md) > Create account

<div class="openapi">

# Create account

<!-- markdownlint-disable-file -->

Create an account for the master billing account.

POST /accounts/v1/:masterBAId/account

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
/accounts/v1/{masterBAId}/account
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
|#{.json-schema-properties}

<div class="openapi-entity">

### Body

{% cut "application/json" %}

```json translate=no
{
  "country": "RU",
  "fullName": "ООО \"ЗАЙКА\"",
  "ruInn": "7814827177",
  "ruKpp": "781401001",
  "billingAddress": "г Санкт-Петербург, пр-кт Королёва, д 66 к 1 стр 1, кв 92",
  "billingPostalCode": "197350",
  "description": "# Заголовок",
  "externalId": "partner-22124"
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_billingAddress_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Legal address

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_billingPostalCode_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Postal code

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_country_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Two-letter country code (e.g., RU, KZ)

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_fullName_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Company name

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Account description using markdown syntax

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_externalId_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Free-form identifier

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_kzBin_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

BIN — Business Identification Number (required if country is KZ)

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_ruInn_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

INN — Individual Taxpayer Number (required if country is RU)

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_ruKpp_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

KPP — Tax Registration Reason Code (required if country is RU)

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_tin_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

TIN — Taxpayer Identification Number (required if country is not RU/KZ)

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
  "operationType": "CreateAccount"
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_operationId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Account creation operation ID

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_operationType_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Operation type

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

</div>

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.