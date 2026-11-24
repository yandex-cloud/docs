[Документация Yandex Cloud](../../../index.md) > [Партнерская программа B2B Tech](../../index.md) > Партнерский портал > [API](../../api/index.md) > [Описание методов (англ.)](../index.md) > [Subaccounts](index.md) > List subaccounts

<div class="openapi">

# List subaccounts

<!-- markdownlint-disable-file -->

Get a list of subaccounts for the master billing account.

POST /subaccounts/v1/:masterBAId/subaccounts/list

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
/subaccounts/v1/{masterBAId}/subaccounts/list
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
  "filter": "states=any (\"active\",\"payment_not_confirmed\")",
  "limit": 25
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_filter_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Filter string. Filtering is available by fields: state (any), id (any), name (contain, equal)

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_limit_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: number

Number of records per page. Maximum 25.
{.table-cell}
||
||

_pageToken_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Next page token for pagination

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
  "list": [
    {
      "id": "a6q036dupih92hkpa79b",
      "createdAt": 1772012856,
      "name": "Subaccount Renamed",
      "email": "test.partners-api@yandex.ru",
      "phone": "+79991234567",
      "state": "active",
      "externalId": 133742021,
      "accountId": "789c6c9c-ccb0-429e-a6da-40c95a1575dc"
    },
    {
      "id": "a6q04gdtho91skokpqsi",
      "createdAt": 1760499167,
      "name": "yndx-ne-8woon4l0",
      "email": "yndx-shchepkina-ne-8woon4l0@yandex.ru",
      "phone": "+71111111111",
      "state": "active",
      "externalId": 107078,
      "accountId": null
    }
  ],
  "nextPageToken": "ImE2cWhrbTdkZXNta2w0ZWtqdTQ3Ig=="
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

_createdAt_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: number

Creation date UTC (Unix timestamp)
{.table-cell}
||
||

_email_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Client's email

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Subaccount ID

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

_phone_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Client's phone number

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_state_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Subaccount state (e.g., "active", "payment_not_confirmed")

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_accountId_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Linked account ID

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_externalId_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Used when you need to tag a subaccount using your internal company identifiers

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Array of subaccount objects

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "id": "example",
    "createdAt": 0.5,
    "name": "example",
    "state": "example",
    "email": "example",
    "phone": "example",
    "externalId": "example",
    "accountId": "example"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_nextPageToken_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Next page token

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

</div>

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.