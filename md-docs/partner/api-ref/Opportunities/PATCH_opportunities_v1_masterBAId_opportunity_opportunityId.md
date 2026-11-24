[Документация Yandex Cloud](../../../index.md) > [Партнерская программа B2B Tech](../../index.md) > Партнерский портал > [API](../../api/index.md) > [Описание методов (англ.)](../index.md) > [Opportunities](index.md) > Update opportunity

<div class="openapi">

# Update opportunity

<!-- markdownlint-disable-file -->

Update opportunity data.

PATCH /opportunities/v1/:masterBAId/opportunity/:opportunityId

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-patch);margin-bottom: 12px">

<div class="openapi__request">

PATCH {.openapi__method}
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

<div class="openapi-entity">

### Body

{% cut "application/json" %}

```json translate=no
{
  "name": "API test stefania skill create (PATCHED)",
  "description": "created via skill client",
  "dateCloseFrom": "2026-09-01",
  "dateCloseTo": "2026-12-31"
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

_amount_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: number

Decimal deal amount
{.table-cell}
||
||

_closeReason_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Loss reason: price, lost_competitor, lack_functionality, call_not_reached, insufficient_qualification, canceled_by_customer, partner, other

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_dateCloseFrom_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Deal close period start date (YYYY-MM-DD)

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_dateCloseTo_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Deal close period end date (YYYY-MM-DD)

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

_stage_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Deal stage: won, loss

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_subaccountId_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Subaccount ID

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
  "operationId": "f8119ace-4075-4397-b2b9-e07228120783",
  "operationType": "UpdateOpportunity"
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_operationId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Opportunity update operation ID

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_operationType_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Operation type = UpdateOpportunity

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

</div>

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.