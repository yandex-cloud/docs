[Документация Yandex Cloud](../../../index.md) > [Партнерская программа B2B Tech](../../index.md) > Партнерский портал > [API](../../api/index.md) > [Описание методов (англ.)](../index.md) > [Orders](index.md) > Create order

<div class="openapi">

# Create order

<!-- markdownlint-disable-file -->

Create an on-premises order.

POST /orders/v1/:masterBAId/order

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
/orders/v1/{masterBAId}/order
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
  "opportunityId": "ade13da7-ee93-45d6-b949-bd2f0a54c7f8",
  "subaccountId": "a6qngjkitagnnalr2ei8",
  "organizationId": "aatfnnsci4icgqdnr07f",
  "items": [
    {
      "productId": "a6quxtkxnovr6timutrb",
      "quantity": 1
    }
  ],
  "invoiceEmail": "test.partners-api@yandex.ru",
  "licenseDate": "2026-12-01",
  "type": "paid",
  "paymentType": "prepayment"
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_invoiceEmail_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Invoice email

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
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

_opportunityId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Opportunity ID

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_organizationId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Organization ID

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_paymentType_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Payment type: prepayment, post_payment

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
||

_type_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Order type: paid, trial

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
  "operationId": "f8119ace-4075-4397-b2b9-e07228120783"
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_operationId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Order creation operation ID

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

</div>

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.