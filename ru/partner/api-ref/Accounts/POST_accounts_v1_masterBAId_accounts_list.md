<div class="openapi">

# List accounts

<!-- markdownlint-disable-file -->

Get a list of accounts for the master billing account.

POST /accounts/v1/:masterBAId/accounts/list

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
/accounts/v1/{masterBAId}/accounts/list
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
  "filter": "taxpayerId=equal \"9707052923\"",
  "sorting": {
    "id": "createdAt",
    "order": "desc"
  },
  "limit": 100
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_filter_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Filter string. Filtering is available by fields: description (contain, equal, startWith), fullName (contain, equal, startWith), billingAddress (contain, equal, startWith), externalId (contain, equal, startWith), taxpayerId (contain, equal, startWith) — filtering by ruInn/kzBin/TIN

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_limit_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: number

Number of records per page
{.table-cell}
||
||

_pageToken_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Next page token for pagination

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_sorting_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Field to sort by: fullName, createdAt, description, externalId, country, taxpayerId

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_order_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: [SortingOrder](#entity-SortingOrder)

Sort order: asc (ascending) or desc (descending)

_Enum:_{.json-schema-reset .json-schema-value} `asc`, `desc`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Sorting parameters object. Sorting is available by fields: fullName, createdAt, description, externalId, country, taxpayerId

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "id": "example",
  "order": "asc"
}
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

</div>

<div class="openapi-entity">

### SortingOrder {#entity-SortingOrder}

Sort order: asc (ascending) or desc (descending)

**Type**: string

_Enum:_{.json-schema-reset .json-schema-value} `asc`, `desc`

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
  "list": [
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
  ],
  "nextPageToken": "ImE2cWhrbTdkZXNta2w0ZWtqdTQ3Ig=="
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_list_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object[]" %}

#|
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

Account name

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

Subaccount state (e.g., "payment_not_confirmed")

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

Account description with markdown markup

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

{% endcut %}

Array of account objects

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "id": "example",
    "createdAt": "example",
    "description": "example",
    "fullName": "example",
    "billingAddress": "example",
    "billingPostalCode": "example",
    "country": "example",
    "ruInn": "example",
    "ruKpp": "example",
    "kzBin": "example",
    "tin": "example",
    "externalId": "example",
    "subAccounts": [
      {
        "id": "example",
        "name": "example",
        "state": "example"
      }
    ]
  }
]
```

{% endcut %}
{.table-cell}
||
||

_nextPageToken_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Next page token (if there is more data)

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

</div>

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.