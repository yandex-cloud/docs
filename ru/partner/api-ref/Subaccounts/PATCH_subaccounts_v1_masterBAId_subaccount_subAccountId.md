---
alternate:
  - href: ru/partner/api-ref/Subaccounts/PATCH_subaccounts_v1_masterBAId_subaccount_subAccountId.md
    type: text/markdown
    title: Markdown version
---
<div class="openapi">

# Update subaccount

<!-- markdownlint-disable-file -->

Update subaccount data. At least one of the following parameters must be specified: name, phone, email, or externalId.

PATCH /subaccounts/v1/:masterBAId/subaccount/:subAccountId

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-patch);margin-bottom: 12px">

<div class="openapi__request">

PATCH {.openapi__method}
```text translate=no
/subaccounts/v1/{masterBAId}/subaccount/{subAccountId}
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
||

_subAccountId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Subaccount ID

_Example:_{.json-schema-reset .json-schema-example} ``
{.table-cell}
||
|#{.json-schema-properties}

<div class="openapi-entity">

### Body

{% cut "application/json" %}

```json translate=no
{
  "name": "Subaccount Renamed",
  "phone": "+79991234567",
  "email": "test.partners-api@yandex.ru",
  "externalId": 133742021
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_email_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Email address

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_externalId_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: number

Used when you need to tag a subaccount using your internal company identifiers
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Subaccount name

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_phone_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Phone number

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