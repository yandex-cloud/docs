<div class="openapi">

# Get list of available add-ons for a tariff

<!-- markdownlint-disable-file -->

Get a list of available add-ons for a tariff.

GET /workseats/v1/:subaccountId/:organization360Id/:productId/addons

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-get);margin-bottom: 12px">

<div class="openapi__request">

GET {.openapi__method}
```text translate=no
/workseats/v1/{subaccountId}/{organization360Id}/{productId}/addons
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

_productId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Product/tariff ID

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
  "list": [
    {
      "productId": "b2b_cloud_licenses_alisa_pro_per_user_addon",
      "currency": "RUB",
      "title": "Персональный аддон Алисы Про",
      "paymentType": "prepaid",
      "educational": false
    },
    {
      "productId": "b2b_cloud_licenses_disk_1tb_addon",
      "currency": "RUB",
      "title": "Место на диске (+1 ТБ)",
      "paymentType": "prepaid",
      "educational": false
    },
    {
      "productId": "b2b_cloud_licenses_telemost_conference_limit_1000_addon",
      "currency": "RUB",
      "title": "До 1000 участников на встречах в Телемосте",
      "paymentType": "prepaid",
      "educational": false
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

_currency_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Currency

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_educational_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

Educational add-on flag
{.table-cell}
||
||

_paymentType_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Payment type: prepaid or postpaid

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

_title_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Add-on name

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Array of available add-ons

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "productId": "example",
    "currency": "example",
    "title": "example",
    "paymentType": "example",
    "educational": true
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