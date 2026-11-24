<div class="openapi">

# Get minimum terms for order

<!-- markdownlint-disable-file -->

Get minimum terms (conditions) for an on-premises order.

POST /orders/v1/:masterBAId/orders/listTerms

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
/orders/v1/{masterBAId}/orders/listTerms
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
  "subaccountId": "a6qngjkitagnnalr2ei8",
  "licenseDate": "2026-12-01",
  "items": [
    "a6qxuarxrl6ejh5xvpje"
  ]
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_items_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string[]

Array of product IDs (minimum 1, no duplicates)

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

_licenseDate_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

License start date (YYYY-MM-DD)

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_subaccountId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Subaccount ID

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
  "termsProduct": [
    {
      "duration": {
        "duration": {
          "days": 304,
          "hours": null,
          "minutes": null,
          "months": null,
          "seconds": null,
          "weeks": null,
          "years": null
        },
        "source_value": "P304D"
      },
      "minActDate": "2026-12-01",
      "minQuantity": 1,
      "productId": "a6qxuarxrl6ejh5xvpje"
    }
  ]
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_termsProduct_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object[]" %}

#|
||

_duration_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Duration object (e.g. P1Y for 1 year)

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_minActDate_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Minimum action date (YYYY-MM-DD)

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_minQuantity_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: number

Minimum quantity
{.table-cell}
||
||

_productId_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Product ID

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Array of product terms

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "duration": "example",
    "minActDate": "example",
    "minQuantity": 0.5,
    "productId": "example"
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