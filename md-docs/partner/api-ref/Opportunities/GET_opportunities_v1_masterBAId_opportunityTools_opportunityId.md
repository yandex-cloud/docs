[Документация Yandex Cloud](../../../index.md) > [Партнерская программа B2B Tech](../../index.md) > Партнерский портал > [API](../../api/index.md) > [Описание методов (англ.)](../index.md) > [Opportunities](index.md) > Get available tools for opportunity

<div class="openapi">

# Get available tools for opportunity

<!-- markdownlint-disable-file -->

Get a list of available tools for an opportunity.

GET /opportunities/v1/:masterBAId/opportunityTools/:opportunityId

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-get);margin-bottom: 12px">

<div class="openapi__request">

GET {.openapi__method}
```text translate=no
/opportunities/v1/{masterBAId}/opportunityTools/{opportunityId}
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

_opportunityId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Opportunity ID

_Example:_{.json-schema-reset .json-schema-example} ``
{.table-cell}
||
|#{.json-schema-properties}

### Query parameters

#|
|| **Name** | **Description** ||
||

_lang_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Language for tool URLs

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
  "tools": [
    {
      "type": "registering_transaction_y360",
      "url": "https://forms.yandex.ru/surveys/13758287.01147dd378bc3e70a31236d1f9198d07d2b65da6/?lang=RU&requestType=registering_transaction_y360&masterBaId=a6q3hv13r2pe0njnhefs&accountId=baec86c7-4fcd-49ca-91a5-06f5fc0f3ac4&opportunityId=a008f524-754b-4ddd-bc79-6d4130bb3ee3&lastNamePartner=Darharious&emailPartner=vio-94%40yandex.ru&resident=RU&region=RU&tariff360=Yandex+360%3A+%22%D0%9E%D1%81%D0%BD%D0%BE%D0%B2%D0%BD%D0%BE%D0%B9+%2B+%D0%A2%D1%80%D0%B5%D0%BA%D0%B5%D1%80%22"
    }
  ]
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_tools_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object[]" %}

#|
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Tool type: registering_transaction_yc, registering_transaction_y360, registering_transaction_ytracker, registering_project_yc, regulated_purchase_yc, regulated_purchase_y360, regulated_purchase_ytracker, registering_transaction_on_premises, regulated_purchase_on_premises

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_url_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Generated URL for the application form

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Array of available tools

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "url": "example",
    "type": "example"
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