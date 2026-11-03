[Документация Yandex Cloud](../../../index.md) > [Yandex DataLens](../../index.md) > DataLens Public API > [DataLens API (англ.)](../index.md) > [Subscriptions](index.md) > Delete subscription by id

<div class="openapi">

# Delete subscription by id

<!-- markdownlint-disable-file -->

Deletes the specified subscription.

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
https://api.datalens.tech/rpc/deleteSubscription
```

</div>

</div>

</div>

### Headers

#|
|| **Name** | **Description** ||
||

_x-dl-api-version_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

API version header.

_Const:_{.json-schema-reset .json-schema-value} `3`

_Example:_{.json-schema-reset .json-schema-example} `3`
{.table-cell}
||
|#{.json-schema-properties}

<div class="openapi-entity">

### Body

{% cut "application/json" %}

```json translate=no
{
  "subscriptionId": "7lieexzx4kxs0"
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_subscriptionId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Min length:_{.json-schema-reset .json-schema-assertion} `1`

_Pattern:_{.json-schema-reset .json-schema-assertion} `^[a-zA-Z0-9._:-]+$`

_Example:_{.json-schema-reset .json-schema-example} `7lieexzx4kxs0`
{.table-cell}
||
|#{.json-schema-properties}

</div>

## Responses

<div class="openapi__response__code__200">

## 200 OK

Response

<div class="openapi-entity">

### Body

{% cut "application/json" %}

```json translate=no
{}
```

{% endcut %}

#|
|| **Name** | **Description** ||
|#{.json-schema-properties}

</div>

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.