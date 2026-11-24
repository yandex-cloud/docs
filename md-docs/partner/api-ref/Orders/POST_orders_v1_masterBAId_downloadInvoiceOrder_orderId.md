[Документация Yandex Cloud](../../../index.md) > [Партнерская программа B2B Tech](../../index.md) > Партнерский портал > [API](../../api/index.md) > [Описание методов (англ.)](../index.md) > [Orders](index.md) > Download invoice PDF

<div class="openapi">

# Download invoice PDF

<!-- markdownlint-disable-file -->

Download the invoice PDF for an order.

POST /orders/v1/:masterBAId/downloadInvoiceOrder/:orderId

**Важно:** PDF доступен только для заказов со сформированным счётом. Для заказа без сформированного счёта ручка отдаёт 400 «Gateway request error».

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
/orders/v1/{masterBAId}/downloadInvoiceOrder/{orderId}
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

<div class="openapi-entity">

### Body

{% cut "application/json" %}

```json translate=no
{}
```

{% endcut %}

#|
|| **Name** | **Description** ||
|#{.json-schema-properties}

</div>

## Responses

<div class="openapi__response__code__200">

## 200 OK

Бинарное PDF-тело (Content-Type: application/pdf). Только для заказов со сформированным счётом.

### Body

application/pdf

**Type:** string

**Format:** binary

**Description:** Бинарное PDF-тело (пример недоступен: бинарный контент).

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.