[Документация Yandex Cloud](../../../index.md) > [Партнерская программа B2B Tech](../../index.md) > Партнерский портал > [API](../../api/index.md) > [Описание методов (англ.)](../index.md) > [Yandex 360](index.md) > Change tariff in organization 360

<div class="openapi">

# Change tariff in organization 360

<!-- markdownlint-disable-file -->

Change a tariff in organization 360.

POST /workseats/v1/:subaccountId/:organization360Id/:workseatId

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
/workseats/v1/{subaccountId}/{organization360Id}/{workseatId}
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
  "productId": "b2b_le_cloud_licenses_corp_light",
  "paymentType": "postpaid",
  "amount": 160,
  "startDate": 1790243883,
  "endDate": 1821780427
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_amount_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: number

Number of users
{.table-cell}
||
||

_paymentType_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Payment type: postpaid or prepaid

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_productId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Product/tariff ID

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_startDate_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: number

Tariff start date and time in Moscow timezone (Unix timestamp)
{.table-cell}
||
||

_endDate_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: number

Tariff end date and time in Moscow timezone (Unix timestamp). Required if end date is specified or payment type is prepaid
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

Operation execution status
{.table-cell}
||
|#{.json-schema-properties}

</div>

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.