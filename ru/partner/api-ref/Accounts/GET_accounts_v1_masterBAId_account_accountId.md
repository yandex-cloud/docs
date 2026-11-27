---
alternate:
  - href: ru/partner/api-ref/Accounts/GET_accounts_v1_masterBAId_account_accountId.md
    type: text/markdown
    title: Markdown version
---
<div class="openapi">

# Account data

<!-- markdownlint-disable-file -->

Get account data by ID.

GET /accounts/v1/:masterBAId/account/:accountId

The account ID may be changed due to internal merging with another account that has the same INN/BIN/TIN. The description and internal ID will be preserved.

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-get);margin-bottom: 12px">

<div class="openapi__request">

GET {.openapi__method}
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

## Responses

<div class="openapi__response__code__200">

## 200 OK

Successful response

<div class="openapi-entity">

### Body

{% cut "application/json" %}

```json translate=no
{
  "id": "166879f0-f2f1-4079-85c8-e04f28283068",
  "createdAt": "2026-05-07T08:09:48.000Z",
  "description": null,
  "fullName": "ООО \"ЦВЕТОК\"",
  "billingAddress": "127030, Г.МОСКВА, ВН.ТЕР.Г. МУНИЦИПАЛЬНЫЙ ОКРУГ ТВЕРСКОЙ, УЛ СУЩЁВСКАЯ, Д. 27, СТР. 2, ПОМЕЩ. 3/3/3",
  "billingPostalCode": "127030",
  "country": "RU",
  "ruInn": "9707052923",
  "ruKpp": "770701001",
  "kzBin": null,
  "externalId": "",
  "subAccounts": [
    {
      "id": "a6q1q3gc3g439cgk9ojj",
      "name": "test org 360",
      "state": "active"
    },
    {
      "id": "a6q0e6vmvomin62qj8vg",
      "name": "Партнёр 1",
      "state": "suspended"
    }
  ]
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

Country code

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_createdAt_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Account creation date and time (ISO 8601)

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_fullName_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Full company name

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Account ID

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_subAccounts_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object[]" %}

#|
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Subaccount ID

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

_state_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Subaccount state

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Array of linked subaccounts

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "id": "example",
    "name": "example",
    "state": "example"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Account description

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_externalId_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Used when you need to tag a subaccount using your internal company identifiers

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_kzBin_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

BIN (for KZ)

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_ruInn_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

INN (for RU)

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_ruKpp_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

KPP (for RU)

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_tin_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

TIN (for other countries)

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

</div>

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.