<div class="openapi">

# Get products available for opportunities

<!-- markdownlint-disable-file -->

Get a tree of product groups and products available for creating opportunities for the master billing account. The list depends on the master account type (on-premise account, Yandex 360 availability).

GET /opportunities/v1/:masterBAId/products

Requires permission billing.accounts.getCrmOpportunity on the billing account.

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-get);margin-bottom: 12px">

<div class="openapi__request">

GET {.openapi__method}
```text translate=no
/opportunities/v1/{masterBAId}/products
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

## Responses

<div class="openapi__response__code__200">

## 200 OK

Successful response

<div class="openapi-entity">

### Body

{% cut "application/json" %}

```json translate=no
{
  "products": [
    {
      "group": "Data platform",
      "children": [
        {
          "id": "5b6374e9-271f-4c7a-a217-3842f5a1e3f3",
          "name": "DataLens"
        }
      ]
    },
    {
      "group": "Marketplace",
      "children": [
        {
          "id": "ef39ed93-3543-4e1d-bdf8-1d69c4c6e550",
          "name": "Marketplace"
        }
      ]
    }
  ]
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_products_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object[]" %}

#|
||

_children_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object[]" %}

#|
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Product ID

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Product name

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Products in the group

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

_group_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Product group name

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

List of product groups available for opportunities (depends on master account type: on-premise, Yandex 360 availability)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "group": "example",
    "children": [
      {
        "id": "example",
        "name": "example"
      }
    ]
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