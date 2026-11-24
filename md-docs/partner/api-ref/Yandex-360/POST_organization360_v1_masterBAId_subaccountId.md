[Документация Yandex Cloud](../../../index.md) > [Партнерская программа B2B Tech](../../index.md) > Партнерский портал > [API](../../api/index.md) > [Описание методов (англ.)](../index.md) > [Yandex 360](index.md) > Create organization 360

<div class="openapi">

# Create organization 360

<!-- markdownlint-disable-file -->

Create a Yandex 360 organization for a subaccount. The subaccount must belong to the master billing account, be active (or require acceptance), have an email, and Yandex 360 must be available for it. On production this endpoint returns 403 ORGANIZATION360_NOT_AVAILABLE (available on preprod/dev).

POST /organization360/v1/:masterBAId/:subaccountId

Requires permission billing.accounts.manageSubaccounts on the billing account.

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
/organization360/v1/{masterBAId}/{subaccountId}
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

_Min length:_{.json-schema-reset .json-schema-assertion} `1`

_Example:_{.json-schema-reset .json-schema-example} ``
{.table-cell}
||
||

_subaccountId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Client subaccount ID

_Min length:_{.json-schema-reset .json-schema-assertion} `1`

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
  "organization360Id": "8563574"
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_organization360Id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Created organization 360 ID

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

</div>

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.