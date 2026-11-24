[Документация Yandex Cloud](../../../index.md) > [Партнерская программа B2B Tech](../../index.md) > Партнерский портал > [API](../../api/index.md) > [Описание методов (англ.)](../index.md) > [Orders](index.md) > Calculate order cost

<div class="openapi">

# Calculate order cost

<!-- markdownlint-disable-file -->

Calculate the cost of an on-premises order.

POST /orders/v1/:masterBAId/orders/calculateCost

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
/orders/v1/{masterBAId}/orders/calculateCost
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
    {
      "productId": "a6qxuarxrl6ejh5xvpje",
      "quantity": 1
    }
  ]
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_items_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object[]" %}

#|
||

_productId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Product ID

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_quantity_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: integer

Product quantity (minimum 1)
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Array of products (minimum 1)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "productId": "example",
    "quantity": 0
  }
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

Subaccount ID (sent to backend as billingAccountId)

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
  "items": [
    {
      "productId": "a6qxuarxrl6ejh5xvpje",
      "cost": "0.00"
    }
  ]
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_items_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object[]" %}

#|
||

_cost_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Cost

_Example:_{.json-schema-reset .json-schema-example} `example`
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

Array of cost calculations per product

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "productId": "example",
    "cost": "example"
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