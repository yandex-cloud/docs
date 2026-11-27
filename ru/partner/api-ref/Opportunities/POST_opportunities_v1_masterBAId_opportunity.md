---
alternate:
  - href: ru/partner/api-ref/Opportunities/POST_opportunities_v1_masterBAId_opportunity.md
    type: text/markdown
    title: Markdown version
---
<div class="openapi">

# Create opportunity

<!-- markdownlint-disable-file -->

Create a new opportunity (deal).

POST /opportunities/v1/:masterBAId/opportunity

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
/opportunities/v1/{masterBAId}/opportunity
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
  "opportunity": {
    "partnerOpportunityType": "new_client",
    "name": "Миграция инфраструктуры клиента",
    "accountId": "c4f57a84-f20e-4b55-9f51-4887276fcd5e",
    "dateCloseFrom": "2026-12-01",
    "dateCloseTo": "2026-12-31",
    "amount": 12233,
    "nonRecurring": false,
    "description": "Миграция инфраструктуры клиента в Yandex Cloud",
    "dimensions": [
      "5b6374e9-271f-4c7a-a217-3842f5a1e3f3"
    ]
  },
  "contacts": [
    {
      "lastName": "Иван Иванов",
      "email": "ivan@example.com",
      "role": "lpr"
    }
  ]
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_opportunity_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object" %}

#|
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

Decimal deal amount
{.table-cell}
||
||

_dateCloseFrom_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Deal close period start date (YYYY-MM-DD)

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_dateCloseTo_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Deal close period end date (YYYY-MM-DD)

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_dimensions_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string[]

List of product IDs

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

Opportunity type: new_client (deal), project, tender (regulated deal)

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

Project scope: folder, datalens_business, speechsense, datasphere. Required for project type.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_scopeIds_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string[]

Scope IDs. Required for project type.

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

Opportunity object

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "partnerOpportunityType": "example",
  "name": "example",
  "accountId": "example",
  "dateCloseFrom": "example",
  "dateCloseTo": "example",
  "amount": 0.5,
  "projectScope": "example",
  "scopeIds": [
    "example"
  ],
  "nonRecurring": true,
  "numberUsers": 0.5,
  "totalPotentialUsers": 0.5,
  "description": "example",
  "dimensions": [
    "example"
  ]
}
```

{% endcut %}
{.table-cell}
||
||

_contacts_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object[]" %}

#|
||

_email_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Contact email

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_lastName_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Contact full name

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_role_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Contact role in the deal: lpr (decision maker), partner (partner contact)

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

List of contact persons for the opportunity

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "lastName": "example",
    "email": "example",
    "role": "example"
  }
]
```

{% endcut %}
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
  "operationType": "CreateOpportunity"
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_operationId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Opportunity creation operation ID

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_operationType_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Operation type

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

</div>

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.