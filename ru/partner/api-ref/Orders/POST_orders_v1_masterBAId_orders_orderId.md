<div class="openapi">

# Cancel order

<!-- markdownlint-disable-file -->

Cancel an on-premises order.

POST /orders/v1/:masterBAId/orders/:orderId

**Важно:** операция асинхронная — ответ содержит только `operationId`. Детали заказа напрямую по этому пути недоступны; статус операции — `POST /operations/v1/.../get` с `operationType: Orders`, данные заказа — из `POST /orders/v1/:masterBAId/orders/list`.

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
/orders/v1/{masterBAId}/orders/{orderId}
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

_orderId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Order ID

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

Order cancellation operation ID

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

</div>

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.