[Документация Yandex Cloud](../../../index.md) > [Партнерская программа B2B Tech](../../index.md) > Партнерский портал > [API](../../api/index.md) > [Описание методов (англ.)](../index.md) > [Yandex 360](index.md) > Cancel tariff in organization 360

<div class="openapi">

# Cancel tariff in organization 360

<!-- markdownlint-disable-file -->

Cancel (disable) a tariff in organization 360.

POST /workseats/v1/:subaccountId/:organization360Id/:workseatId/disable

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
/workseats/v1/{subaccountId}/{organization360Id}/{workseatId}/disable
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