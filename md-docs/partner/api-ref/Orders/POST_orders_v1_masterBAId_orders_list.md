[Документация Yandex Cloud](../../../index.md) > [Партнерская программа B2B Tech](../../index.md) > Партнерский портал > [API](../../api/index.md) > [Описание методов (англ.)](../index.md) > [Orders](index.md) > List orders

<div class="openapi">

# List orders

<!-- markdownlint-disable-file -->

Get a list of on-premises orders for the master billing account.

POST /orders/v1/:masterBAId/orders/list

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
/orders/v1/{masterBAId}/orders/list
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
  "filter": "state=any (\"active\");type=any (\"paid\",\"trial\")",
  "limit": 25,
  "sorting": {
    "id": "createdAt",
    "order": "desc"
  }
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_filter_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Filter string. Available fields: organizationIds, orderIds, type, state, subaccountIds, productIds (any), paymentType, opportunityId (equal), licenseDateFrom, licenseDateTo (equal), orderNumber, productName (contain), createdAtFrom, createdAtTo (equal)

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_limit_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: number

Number of records per page. 1 to 100, default 25
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

_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Field to sort by: createdAt, licenseDate, state

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_order_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SortingOrder](#entity-SortingOrder)

Sort order: asc (ascending) or desc (descending)

_Enum:_{.json-schema-reset .json-schema-value} `asc`, `desc`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Sorting parameters

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
      "id": "a6qoae5rc3cg9ibqhg4g",
      "licenseDate": 1790802000,
      "opportunityId": "ade13da7-ee93-45d6-b949-bd2f0a54c7f8",
      "state": "active",
      "type": "paid",
      "isCancellationAllowed": false,
      "orderNumber": "2026-352",
      "paymentType": "post_payment",
      "totalPrice": "1044000",
      "createdAt": 1790239938,
      "updatedAt": 1790240410,
      "products": [
        {
          "licenseDate": 1790802000,
          "id": "a6qg01m5t91nr50msv42",
          "organizationId": "aatfnnsci4icgqdnr07f",
          "price": "0",
          "productName": "Корпоративная СУБД Яндекса, 1 год гарантийной информационной поддержки",
          "quantity": 1,
          "productId": "a6qxuarxrl6ejh5xvpje",
          "subaccountId": "a6qngjkitagnnalr2ei8"
        },
        {
          "licenseDate": 1790802000,
          "id": "a6qm00dl3o5vporepatc",
          "organizationId": "aatfnnsci4icgqdnr07f",
          "price": "1044000",
          "productName": "Предоставление права использования ПО Корпоративная СУБД Яндекса (процессорное ядро), 1 год гарантийной информационной поддержки, бессрочная лицензия (бессрочно). Заказ №2026-352",
          "quantity": 1,
          "productId": "a6quxtkxnovr6timutrb",
          "subaccountId": "a6qngjkitagnnalr2ei8"
        }
      ]
    }
  ],
  "nextPageToken": "WzE3ODAwNDM1NjgsICJhNnFzYjgxcGNwNWkzcGdxbGZwOCJd"
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

_createdAt_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: number

Order creation date (Unix timestamp)
{.table-cell}
||
||

_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Order ID

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_isCancellationAllowed_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

Whether cancellation is allowed
{.table-cell}
||
||

_licenseDate_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: number

License start date (Unix timestamp)
{.table-cell}
||
||

_opportunityId_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Opportunity ID

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_orderNumber_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Order number

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_paymentType_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Payment type: prepayment, post_payment

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_products_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object[]" %}

#|
||

_price_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Price

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
||

_productName_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Product name

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_quantity_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: number

Product quantity
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Array of products in the order

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "productId": "example",
    "quantity": 0.5,
    "productName": "example",
    "price": "example"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_state_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Order state: pendingApproval, canceled, active

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_totalPrice_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Total price

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

License type: paid, trial

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_updatedAt_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: number

Order modification date (Unix timestamp)
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Array of order objects

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "id": "example",
    "orderNumber": "example",
    "type": "example",
    "state": "example",
    "paymentType": "example",
    "opportunityId": "example",
    "licenseDate": 0.5,
    "createdAt": 0.5,
    "updatedAt": 0.5,
    "totalPrice": "example",
    "isCancellationAllowed": true,
    "products": [
      {
        "productId": "example",
        "quantity": 0.5,
        "productName": "example",
        "price": "example"
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

Next page token

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

</div>

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.