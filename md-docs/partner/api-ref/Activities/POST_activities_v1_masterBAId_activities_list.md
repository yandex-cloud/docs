[Документация Yandex Cloud](../../../index.md) > [Партнерская программа B2B Tech](../../index.md) > Партнерский портал > [API](../../api/index.md) > [Описание методов (англ.)](../index.md) > [Activities](index.md) > List activities

<div class="openapi">

# List activities

<!-- markdownlint-disable-file -->

Get a list of activities for the master billing account with filtering, pagination and sorting.

POST /activities/v1/:masterBAId/activities/list

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
/activities/v1/{masterBAId}/activities/list
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

Master billing account ID (VAR account)

_Example:_{.json-schema-reset .json-schema-example} ``
{.table-cell}
||
|#{.json-schema-properties}

<div class="openapi-entity">

### Body

{% cut "application/json" %}

```json translate=no
{
  "limit": 20,
  "sorting": {
    "id": "createdAt",
    "order": "desc"
  }
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_filter_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Filter string. Available fields: id, type, status, accountId, opportunityId, requestType, disqualifiedReason, description, createdAt, modifiedAt

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_limit_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: number

Number of records per page. Min 1, max 100. Default 20
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
||

_sorting_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Field to sort by: createdAt, modifiedAt, type, status. Default: createdAt

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_order_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SortingOrder](#entity-SortingOrder)

Sort order: asc (ascending) or desc (descending)

_Enum:_{.json-schema-reset .json-schema-value} `asc`, `desc`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Sorting parameters

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "id": "example",
  "order": "asc"
}
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

</div>

<div class="openapi-entity">

### SortingOrder {#entity-SortingOrder}

Sort order: asc (ascending) or desc (descending)

**Type**: string

_Enum:_{.json-schema-reset .json-schema-value} `asc`, `desc`

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
      "id": "21187814-5906-4a44-84b3-4b0182a4de0f",
      "createdAt": "2026-08-28T07:38:29.000Z",
      "modifiedAt": "2026-08-28T07:38:29.000Z",
      "type": "partner_award_request",
      "description": "Специфика услуг: \n\n### Данные по заявке проекта\n\nСкан-копия договора партнера с клиентом: <#><#>\nДата начала проекта: 2026-08-30\nОбласть действия: \nИдентифкаторы области: \n\nОписание: test",
      "status": "awaiting_decision",
      "disqualifiedReason": null,
      "disqualifiedReasonDescription": null,
      "requestType": "registering_project_yc",
      "award": "15.00",
      "accounts": "35dda13a-a3fd-4ec2-af66-3ed58de45a8a"
    }
  ],
  "nextPageToken": "ImE2cTFqOTlodHQ2aWlvYTVsaG8wIg=="
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

_accounts_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

First linked account ID

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_award_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: number

Award amount
{.table-cell}
||
||

_createdAt_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Creation date and time (ISO 8601)

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Activity description

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_disqualifiedReason_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Disqualification reason: waiting_period_subaccount_expired, partner_refused, duplicate, other, issued_another_partner, client_refused, no_paid_consumption, tool_not_available

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_disqualifiedReasonDescription_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Disqualification reason description

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Activity ID

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_modifiedAt_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Modification date and time (ISO 8601)

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_opportunities_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

First linked opportunity ID (only when isDistributor = true)

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_partnerAccounts_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

First linked partner account ID (only when isDistributor = true)

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_requestType_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Request type: registering_transaction_yc, registering_project_yc, regulated_purchase_yc, registering_transaction_y360, regulated_purchase_y360, registering_transaction_ytracker, regulated_purchase_ytracker, registering_transaction_on_premises, regulated_purchase_on_premises

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_status_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Activity status: awaiting_decision, need_information, waiting_verification, award_saved, rebate_accrued, award_not_saved, denied

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Activity type: partner_award_request

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Array of activity objects

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "id": "example",
    "createdAt": "example",
    "modifiedAt": "example",
    "type": "example",
    "description": "example",
    "status": "example",
    "disqualifiedReason": "example",
    "disqualifiedReasonDescription": "example",
    "requestType": "example",
    "award": 0.5,
    "accounts": "example",
    "partnerAccounts": "example",
    "opportunities": "example"
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