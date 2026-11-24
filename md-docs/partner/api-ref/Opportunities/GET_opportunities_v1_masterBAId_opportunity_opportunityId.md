[Документация Yandex Cloud](../../../index.md) > [Партнерская программа B2B Tech](../../index.md) > Партнерский портал > [API](../../api/index.md) > [Описание методов (англ.)](../index.md) > [Opportunities](index.md) > Get opportunity data

<div class="openapi">

# Get opportunity data

<!-- markdownlint-disable-file -->

Get opportunity data by ID.

GET /opportunities/v1/:masterBAId/opportunity/:opportunityId

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-get);margin-bottom: 12px">

<div class="openapi__request">

GET {.openapi__method}
```text translate=no
/opportunities/v1/{masterBAId}/opportunity/{opportunityId}
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

_opportunityId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Opportunity ID

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
  "id": "a6d13eb9-c9cf-4ff3-a4b9-9051ff59f2ba",
  "name": "API test stefania skill create (PATCHED)",
  "accountId": "166879f0-f2f1-4079-85c8-e04f28283068",
  "createdAt": "2026-08-20T12:48:24.000Z",
  "modifiedAt": "2026-09-09T05:01:01.000Z",
  "createdBy": "bfb2ebjhd3hmb9tvdv39",
  "modifiedBy": "bfb2ebjhd3hmb9tvdv39",
  "nonRecurring": false,
  "contractType": null,
  "amount": 60000,
  "currency": "rub",
  "dateCloseFrom": "2026-09-01",
  "dateCloseTo": "2026-12-31",
  "description": "created via skill client",
  "numberUsers": null,
  "partnerOpportunityType": "new_client",
  "totalPotentialUsers": null,
  "totalCurrentUsers": null,
  "masterBaId": "a6q3hv13r2pe0njnhefs",
  "projectScope": null,
  "scopeIds": [],
  "dimensions": [
    "d893b2eb-be6a-4285-bbb7-2186f3fa72ba"
  ],
  "stageType": "prospect"
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

_amount_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: number

Deal amount
{.table-cell}
||
||

_createdAt_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Creation date and time (ISO 8601)

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_currency_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Currency

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_dateCloseFrom_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Deal close period start date

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_dateCloseTo_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Deal close period end date

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Opportunity ID

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_masterBaId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Master billing account ID

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_modifiedAt_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Modification date and time (ISO 8601)

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Opportunity name

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_nonRecurring_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: boolean

Consumption type: true = one-time, false = monthly
{.table-cell}
||
||

_partnerOpportunityType_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Partner opportunity type: new_client, project, tender

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_createdBy_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Creator ID

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

_dimensions_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object[]" %}

#|
||

_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Product ID

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

List of products linked to the opportunity

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "id": "example"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_modifiedBy_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Modifier ID

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_numberUsers_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: number

Total number of current users
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

</div>

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.