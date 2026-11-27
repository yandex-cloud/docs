---
alternate:
  - href: ru/partner/api-ref/Orders/POST_orders_v1_masterBAId_downloadClosedDocs_orderId.md
    type: text/markdown
    title: Markdown version
---
<div class="openapi">

# Download closing documents

<!-- markdownlint-disable-file -->

Get a signed URL for downloading closing documents for an order.

POST /orders/v1/:masterBAId/downloadClosedDocs/:orderId

**Важно:** закрывающие документы доступны только после формирования акта. Для заказа без акта ручка отдаёт 400 «По заказу … ещё не сформирован акт».

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
/orders/v1/{masterBAId}/downloadClosedDocs/{orderId}
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

Successful response

<div class="openapi-entity">

### Body

{% cut "application/json" %}

```json translate=no
{
  "url": "https://s78vla.storage.yandex.net/ryadoc-test/U2FsdGVkX1-SJRXc5-SOVSYfKrFvbyFgx-_W1nQhe3BTj-VikSbSXCrRjZA6DGbq-qBss-8Gu7MrrDf6AtkVHlTxWGV86Unkx1dxj4NOfn8?ts=00065cb793fff65e&sign=0a45a64dd930a69c81abf0ce4dfe77fd79f22c5a5254df0170f6a2dda9a2e57a"
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_url_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Signed URL for downloading closing documents

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

</div>

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.