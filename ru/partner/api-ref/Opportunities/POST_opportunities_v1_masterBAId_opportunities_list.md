---
alternate:
  - href: ru/partner/api-ref/Opportunities/POST_opportunities_v1_masterBAId_opportunities_list.md
    type: text/markdown
    title: Markdown version
---
<div class="openapi">

# List opportunities

<!-- markdownlint-disable-file -->

Get a list of opportunities for the master billing account.

POST /opportunities/v1/:masterBAId/opportunities/list

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
/opportunities/v1/{masterBAId}/opportunities/list
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
  "filter": "name=contain \"мега\"",
  "limit": 25
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_limit_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: number

Number of records per page
{.table-cell}
||
||

_filter_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Filter string. Available fields: name (contain, equal, startWith), stageType, partnerOpportunityType, accountId (any), amount (greater, greaterOrEqual, less, lessOrEqual, between), dateCloseFrom, dateCloseTo, createdAt, modifiedAt (between)

_Example:_{.json-schema-reset .json-schema-example} `example`
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
      "id": "50476fbe-98a3-4db8-9b4b-3baa540da6cd",
      "name": "супер мега дил",
      "partnerOpportunityType": "new_client",
      "accountId": "c4f57a84-f20e-4b55-9f51-4887276fcd5e",
      "partnerId": "ee104f14-d169-4a3d-8489-2b6a9d2a12ad",
      "projectScope": null,
      "scopeIds": null,
      "createdAt": "2026-07-17T09:47:40.000Z",
      "modifiedAt": "2026-07-17T09:47:40.000Z",
      "nonRecurring": false,
      "description": "А вот тут чето мощное преподлагается йоу",
      "amount": 12233,
      "currency": "rub",
      "dateCloseFrom": "2026-12-01",
      "dateCloseTo": "2026-12-31",
      "closeReason": null,
      "billingAccounts": [
        "a6qmhc2v395s682rdhoa"
      ],
      "numberUsers": 12,
      "totalPotentialUsers": 1233
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

_accountId_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Account ID

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_amount_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: number

Deal amount
{.table-cell}
||
||

_billingAccounts_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string[]

Linked billing accounts

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  "example"
]
```

{% endcut %}
{.table-cell}
||
||

_closeReason_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Deal close reason

_Example:_{.json-schema-reset .json-schema-example} `example`
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

_currency_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Currency: RUB, USD, KZT

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_dateCloseFrom_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Deal close period start date

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_dateCloseTo_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Deal close period end date

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Opportunity description

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Opportunity ID

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

_name_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Opportunity name

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_nonRecurring_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

Consumption type: true = one-time, false = monthly
{.table-cell}
||
||

_numberUsers_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: number

Number of users
{.table-cell}
||
||

_partnerOpportunityType_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Partner opportunity type: new_client, project, tender

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_projectScope_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Project scope: folder, datalens_business, speechsense, datasphere

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_scopeIds_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string[]

Scope IDs

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  "example"
]
```

{% endcut %}
{.table-cell}
||
||

_totalPotentialUsers_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: number

Total number of potential users
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Array of opportunity objects

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "id": "example",
    "name": "example",
    "partnerOpportunityType": "example",
    "accountId": "example",
    "projectScope": "example",
    "scopeIds": [
      "example"
    ],
    "createdAt": "example",
    "modifiedAt": "example",
    "nonRecurring": true,
    "description": "example",
    "amount": 0.5,
    "currency": "example",
    "dateCloseFrom": "example",
    "dateCloseTo": "example",
    "closeReason": "example",
    "billingAccounts": [
      "example"
    ],
    "numberUsers": 0.5,
    "totalPotentialUsers": 0.5
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