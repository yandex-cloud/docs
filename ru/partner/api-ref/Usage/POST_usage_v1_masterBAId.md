<div class="openapi">

# Request subaccount usage detail

<!-- markdownlint-disable-file -->

Request a detailed usage report for subaccounts. Request period must match the filter values period. Date queries must be in Moscow time. Rate limit: 2 rps.

POST /usage/v1/:masterBAId

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
/usage/v1/{masterBAId}
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
  "startDate": "2026-09-01",
  "endDate": "2026-09-30",
  "group": "SUBACCOUNT",
  "aggregationPeriod": "MONTH",
  "billingAccountIds": [
    "a6q04gdtho91skokpqsi"
  ]
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_aggregationPeriod_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Aggregation: DAY, WEEK, MONTH

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_billingAccountIds_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string[]

Filter by subaccount IDs

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

_endDate_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Period end date (YYYY-MM-DD)

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_group_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Data grouping: SUBACCOUNT, INSTANCE, FOLDER, SERVICE, SKU, LABEL

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_startDate_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Period start date (YYYY-MM-DD)

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_cloudIds_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string[]

Filter by cloud IDs

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

_folderIds_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string[]

Filter by folder IDs

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

_labels_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: object

Filter by labels. For group=LABEL, this field is required and must be a non-empty object.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
||

_serviceIds_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string[]

Filter by service IDs

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

_serviceInstanceIds_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string[]

Filter by service instance IDs

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

_skuIds_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string[]

Filter by SKU IDs

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  "example"
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
  "usageReport": {
    "presentedTo": 1790789495824,
    "totalCost": 89998.61908647,
    "totalCredit": -8204.064814791,
    "totalExpense": 81794.554271679,
    "totalReward": 0,
    "totalAdjustmentReward": 0,
    "total": 81794.554271679,
    "entitiesData": [
      {
        "periodic": [
          {
            "cost": 89998.61908647,
            "credit": -8204.064814791,
            "expense": 81794.554271679,
            "reward": 0,
            "period": "2026-09-01"
          }
        ],
        "entityCost": 89998.61908647,
        "entityCredit": -8204.064814791,
        "entityExpense": 81794.554271679,
        "entityReward": 0,
        "entityPartnerTotal": 81794.554271679,
        "id": "a6q04gdtho91skokpqsi",
        "meta": {
          "name": "yndx-ne-8woon4l0",
          "type": "SUBACCOUNT"
        }
      }
    ]
  }
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_usageReport_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_entitiesData_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object[]" %}

#|
||

_entityCost_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: number

Consumption amount for the period
{.table-cell}
||
||

_entityCredit_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: number

Discount amount for the period
{.table-cell}
||
||

_entityExpense_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: number

Difference between consumption and discount for the period
{.table-cell}
||
||

_entityPartnerTotal_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: number

Difference of consumption, discount and partner reward for the period
{.table-cell}
||
||

_entityPricingQuantity_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: number

Number of tariff units; returned for group=SKU
{.table-cell}
||
||

_entityReward_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: number

Partner reward amount for the period
{.table-cell}
||
||

_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Grouping entity ID (e.g. subaccount if group=SUBACCOUNT)

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_meta_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_name_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Entity name

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Entity type: SUBACCOUNT, INSTANCE, FOLDER, SERVICE, SKU, LABEL

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Entity metadata

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "name": "example",
  "type": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_periodic_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object[]" %}

#|
||

_cost_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: number

Cost for the period
{.table-cell}
||
||

_credit_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: number

Discount for the period
{.table-cell}
||
||

_expense_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: number

Expense for the period
{.table-cell}
||
||

_period_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Period date (YYYY-MM-DD)

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_reward_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: number

Reward for the period
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Consumption, discount and partner reward data by periods

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "cost": 0.5,
    "credit": 0.5,
    "expense": 0.5,
    "period": "example",
    "reward": 0.5
  }
]
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Detail data

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "id": "example",
    "entityCost": 0.5,
    "entityCredit": 0.5,
    "entityExpense": 0.5,
    "entityReward": 0.5,
    "entityPartnerTotal": 0.5,
    "entityPricingQuantity": 0.5,
    "periodic": [
      {
        "cost": 0.5,
        "credit": 0.5,
        "expense": 0.5,
        "period": "example",
        "reward": 0.5
      }
    ],
    "meta": {
      "name": "example",
      "type": "example"
    }
  }
]
```

{% endcut %}
{.table-cell}
||
||

_presentedTo_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: number

Detail retrieval date and time, Unix timestamp in milliseconds
{.table-cell}
||
||

_total_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: number

Difference of consumption, discount, partner reward and adjustment for the period
{.table-cell}
||
||

_totalAdjustmentReward_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: number

Adjustment reward amount in the period
{.table-cell}
||
||

_totalCost_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: number

Total consumption cost for the period
{.table-cell}
||
||

_totalCredit_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: number

Total discount amount for the period
{.table-cell}
||
||

_totalExpense_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: number

Difference between consumption and discount for the period
{.table-cell}
||
||

_totalReward_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: number

Total partner reward amount for the period
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Usage report object

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "presentedTo": 0.5,
  "totalCost": 0.5,
  "totalCredit": 0.5,
  "totalExpense": 0.5,
  "totalReward": 0.5,
  "totalAdjustmentReward": 0.5,
  "total": 0.5,
  "entitiesData": [
    {
      "id": "example",
      "entityCost": 0.5,
      "entityCredit": 0.5,
      "entityExpense": 0.5,
      "entityReward": 0.5,
      "entityPartnerTotal": 0.5,
      "entityPricingQuantity": 0.5,
      "periodic": [
        {
          "cost": 0.5,
          "credit": 0.5,
          "expense": 0.5,
          "period": "example",
          "reward": 0.5
        }
      ],
      "meta": {
        "name": "example",
        "type": "example"
      }
    }
  ]
}
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

</div>

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.