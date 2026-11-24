[Документация Yandex Cloud](../../../index.md) > [Партнерская программа B2B Tech](../../index.md) > Партнерский портал > [API](../../api/index.md) > [Описание методов (англ.)](../index.md) > [Usage](index.md) > Get usage filter values

<div class="openapi">

# Get usage filter values

<!-- markdownlint-disable-file -->

Get available filter values for usage detail. Request period must match the filter values period. Date queries must be in Moscow time. Rate limit: 2 rps.

POST /usage/v1/:masterBAId/meta

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
/usage/v1/{masterBAId}/meta
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
  "startDate": "2026-09-01",
  "endDate": "2026-09-30"
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_endDate_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Period end date (YYYY-MM-DD)

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_startDate_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Period start date (YYYY-MM-DD)

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
  "clouds": [
    {
      "id": "",
      "name": "Внеоблачное потребление",
      "billingAccountId": "a6qae0c1ai4av05iogds"
    }
  ],
  "services": [
    {
      "id": "a6q2pas77ftg9h3f2djj",
      "name": "compute",
      "description": "Compute Cloud"
    },
    {
      "id": "a6q4j84p743fhjngkebd",
      "name": "datasphere",
      "description": "DataSphere"
    }
  ],
  "skus": [
    {
      "id": "a6qsnuvdppg8cs9ts2s5",
      "name": "b2b.tracker.license.v1",
      "ruTranslation": "Полный доступ в Yandex Tracker",
      "enTranslation": "Full access to Yandex Tracker",
      "pricingUnit": "user*month",
      "serviceId": "a6qeb2c9he5r9bu9bv2u",
      "translation": "Полный доступ в Yandex Tracker"
    }
  ],
  "labelKeys": [
    "organization_id",
    "system-datasphere-project_id"
  ],
  "billingAccounts": [
    {
      "id": "a6q8is16en5bg1rh11ao",
      "name": "ACC"
    },
    {
      "id": "a6q4r5i64ojn1fnv627d",
      "name": "APItest360"
    }
  ]
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_billingAccounts_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object[]" %}

#|
||

_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Billing account ID

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Billing account name

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

List of billing accounts

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "id": "example",
    "name": "example"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_clouds_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object[]" %}

#|
||

_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Cloud ID

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Cloud name

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

List of clouds

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "id": "example",
    "name": "example"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_labelKeys_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string[]

List of label keys

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

_services_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object[]" %}

#|
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Service description

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Service ID

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Service name

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Unique list of services

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "id": "example",
    "name": "example",
    "description": "example"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_skus_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object[]" %}

#|
||

_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

SKU ID

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

SKU name

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_pricingUnit_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Pricing unit

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_serviceId_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Service ID

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Unique list of SKUs

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "id": "example",
    "serviceId": "example",
    "name": "example",
    "pricingUnit": "example"
  }
]
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

</div>

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.