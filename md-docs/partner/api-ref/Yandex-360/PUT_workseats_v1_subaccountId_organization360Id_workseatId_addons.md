[Документация Yandex Cloud](../../../index.md) > [Партнерская программа B2B Tech](../../index.md) > Партнерский портал > [API](../../api/index.md) > [Описание методов (англ.)](../index.md) > [Yandex 360](index.md) > Manage add-ons for a tariff

<div class="openapi">

# Manage add-ons for a tariff

<!-- markdownlint-disable-file -->

Manage add-ons for a tariff (add, change, remove). When creating, changing or canceling an addon, all current and planned addons are passed in the request.

PUT /workseats/v1/:subaccountId/:organization360Id/:workseatId/addons

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-put);margin-bottom: 12px">

<div class="openapi__request">

PUT {.openapi__method}
```text translate=no
/workseats/v1/{subaccountId}/{organization360Id}/{workseatId}/addons
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
**Type**: string

Organization 360 ID

_Example:_{.json-schema-reset .json-schema-example} ``
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
||

_workseatId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Tariff ID in organization 360

_Example:_{.json-schema-reset .json-schema-example} ``
{.table-cell}
||
|#{.json-schema-properties}

<div class="openapi-entity">

### Body

{% cut "application/json" %}

```json translate=no
{
  "initiatedBy": "bfbcv502pjhsioj0mfis",
  "addons": [
    {
      "id": "97af46b0-29c7-4d42-a700-da768cac17a3",
      "type": "postpaid",
      "productId": "b2b_cloud_licenses_disk_1tb_addon",
      "startDate": 1821780427,
      "endDate": 1853317800,
      "amount": 2
    },
    {
      "id": "888da7cf-1ed3-44f2-a03c-495fa6402fca",
      "type": "postpaid",
      "productId": "b2b_cloud_licenses_alisa_pro_per_user_addon",
      "startDate": 1821780427,
      "endDate": 1853317800,
      "amount": 1
    }
  ]
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_addons_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object[]" %}

#|
||

_amount_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer

Add-on quantity
{.table-cell}
||
||

_endDate_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer

Add-on end date and time (Unix time, seconds)
{.table-cell}
||
||

_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Add-on ID

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_productId_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Add-on product ID

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_startDate_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer

Add-on start date and time (Unix time, seconds)
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Payment type

_Enum:_{.json-schema-reset .json-schema-value} `prepaid`, `postpaid`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Add-ons to update

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "id": "example",
    "type": "prepaid",
    "productId": "example",
    "startDate": 0,
    "endDate": 0,
    "amount": 0
  }
]
```

{% endcut %}
{.table-cell}
||
||

_initiatedBy_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the user initiating the change

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

</div>

## Responses

<div class="openapi__response__code__200">

## 200 OK

Successful operation

<div class="openapi-entity">

### Body

{% cut "application/json" %}

```json translate=no
{
  "done": true
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_done_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: boolean
{.table-cell}
||
|#{.json-schema-properties}

</div>

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.