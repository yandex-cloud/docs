[Документация Yandex Cloud](../../../index.md) > [Партнерская программа B2B Tech](../../index.md) > Партнерский портал > [API](../../api/index.md) > [Описание методов (англ.)](../index.md) > [Yandex 360](index.md) > Get organization 360 data

<div class="openapi">

# Get organization 360 data

<!-- markdownlint-disable-file -->

Get data about a Yandex 360 organization.

GET /organization360/v1/:subaccountId/:organization360Id

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-get);margin-bottom: 12px">

<div class="openapi__request">

GET {.openapi__method}
```text translate=no
/organization360/v1/{subaccountId}/{organization360Id}
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
{
  "metadata": {
    "usersCount": 1
  },
  "name": "#8563574"
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: number

Organization 360 ID
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Organization name

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

</div>

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.