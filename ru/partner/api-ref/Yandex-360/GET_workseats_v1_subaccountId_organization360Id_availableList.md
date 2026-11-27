---
alternate:
  - href: ru/partner/api-ref/Yandex-360/GET_workseats_v1_subaccountId_organization360Id_availableList.md
    type: text/markdown
    title: Markdown version
---
<div class="openapi">

# Get list of available tariffs for organization 360

<!-- markdownlint-disable-file -->

Get a list of available tariffs for organization 360.

GET /workseats/v1/:subaccountId/:organization360Id/availableList

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-get);margin-bottom: 12px">

<div class="openapi__request">

GET {.openapi__method}
```text translate=no
/workseats/v1/{subaccountId}/{organization360Id}/availableList
```

</div>

</div>

</div>

### Path parameters

#|
|| **Name** | **Description** ||
||

_organization360Id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: number

Organization 360 ID
{.table-cell}
||
||

_subaccountId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Client subaccount ID

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
[
  {
    "metadata": {
      "educational": false,
      "paymentType": "prepaid"
    },
    "productId": "b2b_le_cloud_licenses_corp_light",
    "title": "Корпоративный Лайт"
  },
  {
    "metadata": {
      "educational": false,
      "paymentType": "prepaid"
    },
    "productId": "b2b_le_cloud_licenses_corp_light_2",
    "title": "Корпоративный Лайт 2.0"
  },
  {
    "metadata": {
      "educational": false,
      "paymentType": "prepaid"
    },
    "productId": "b2b_cloud_licenses_standard_enterprise",
    "title": "Корпоративный"
  }
]
```

{% endcut %}

**Type**: [Org360AvailablePlan](#entity-Org360AvailablePlan)[]

</div>

<div class="openapi-entity">

### Org360AvailablePlan {#entity-Org360AvailablePlan}

Tariff (plan) available for connection

#|
|| **Name** | **Description** ||
||

_name_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Tariff name

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_planId_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: number

Tariff ID
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "planId": 0.5,
  "name": "example"
}
```

{% endcut %}

</div>

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.