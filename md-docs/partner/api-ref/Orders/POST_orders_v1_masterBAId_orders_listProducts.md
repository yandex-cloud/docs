[Документация Yandex Cloud](../../../index.md) > [Партнерская программа B2B Tech](../../index.md) > Партнерский портал > [API](../../api/index.md) > [Описание методов (англ.)](../index.md) > [Orders](index.md) > List available products

<div class="openapi">

# List available products

<!-- markdownlint-disable-file -->

Get a list of available on-premises products.

POST /orders/v1/:masterBAId/orders/listProducts

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
/orders/v1/{masterBAId}/orders/listProducts
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
  "trial": false
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_name_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Value to filter products by name

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_trial_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

Trial order flag. Default: false
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
  "list": [
    {
      "serviceId": "a6qeggdkyfbqpooiis6e",
      "serviceName": "AI Studio On-premises",
      "serviceSlug": "onprem.ai_studio",
      "products": [
        {
          "externalId": "a6qh4o6smatxjex2zkls",
          "slug": "onprem.ai_studio.pg.year.1",
          "translationEn": "Yandex Cloud AI Hybrid (parallel generation) license, 1 year, urgent",
          "translationRu": "Предоставление права использования ПО Yandex Cloud AI Hybrid (параллельная генерация), 1 год гарантийной информационной поддержки, срочная лицензия"
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

_list_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object[]" %}

#|
||

_products_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object[]" %}

#|
||

_externalId_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Product external ID

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_slug_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Product slug

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_translationEn_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Product name (en)

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_translationRu_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Product name (ru)

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Array of products

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "externalId": "example",
    "slug": "example",
    "translationEn": "example",
    "translationRu": "example"
  }
]
```

{% endcut %}
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
||

_serviceName_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Service name

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_serviceSlug_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Service slug

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Array of product service records

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "serviceId": "example",
    "serviceName": "example",
    "serviceSlug": "example",
    "products": [
      {
        "externalId": "example",
        "slug": "example",
        "translationEn": "example",
        "translationRu": "example"
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