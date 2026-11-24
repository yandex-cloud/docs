[Документация Yandex Cloud](../../../index.md) > [Партнерская программа B2B Tech](../../index.md) > Партнерский портал > [API](../../api/index.md) > [Описание методов (англ.)](../index.md) > [Subaccounts](index.md) > Create subaccount

<div class="openapi">

# Create subaccount

<!-- markdownlint-disable-file -->

Create a subaccount for the master billing account.

POST /subaccounts/v1/:masterBAId/subaccount

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
/subaccounts/v1/{masterBAId}/subaccount
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
  "accountId": "166879f0-f2f1-4079-85c8-e04f28283068",
  "name": "грин",
  "email": "test.partners-api@yandex.ru",
  "phone": "+79210001122",
  "externalId": 22124
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_accountId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Account ID

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Subaccount name

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_email_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Client's email address for which the subaccount is created. Only in the @yandex.ru / @ya.ru domain.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_externalId_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: number

Partner's internal identifier for the subaccount
{.table-cell}
||
||

_phone_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Client's phone number for which the subaccount is created

_Example:_{.json-schema-reset .json-schema-example} `example`
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
  "id": "a6q04gdtho91skokpqsi"
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the created subaccount

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

</div>

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.