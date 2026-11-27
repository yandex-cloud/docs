---
alternate:
  - href: ru/partner/api-ref/Comarketing/POST_comarketing_v1_transact_billingAccountId.md
    type: text/markdown
    title: Markdown version
---
<div class="openapi">

# Accrue/deduct co-marketing rebates

<!-- markdownlint-disable-file -->

Accrue or deduct co-marketing rebates on the master account.

POST /comarketing/v1/transact/:billingAccountId

Precondition: the current master account has the is_var = true flag.

Transaction types: reserve (reservation), cancelReserve (cancel reservation), accrual (accrual), payout (payout).

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
/comarketing/v1/transact/{billingAccountId}
```

</div>

</div>

</div>

### Path parameters

#|
|| **Name** | **Description** ||
||

_billingAccountId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Master billing account ID (masterBAId)

_Example:_{.json-schema-reset .json-schema-example} ``
{.table-cell}
||
|#{.json-schema-properties}

<div class="openapi-entity">

### Body

{% cut "application/json" %}

```json translate=no
{
  "transactions": [
    {
      "type": "accrual",
      "amount": "125.00",
      "reason": {
        "type": "ticket",
        "value": "CLOUDPD-1234"
      },
      "description": "Ко-маркетинг активность"
    }
  ]
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_transactions_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object[]" %}

#|
||

_amount_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Transaction amount, decimal string with exactly 2 fractional digits (e.g. '125.00')

_Pattern:_{.json-schema-reset .json-schema-assertion} `^(?:0\.(?:0[1-9]&#124;[1-9]\d)&#124;[1-9]\d*\.\d{2})$`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_reason_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_type_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: [ComarketingTransactionReasonType](#entity-ComarketingTransactionReasonType)

Reason type for the transaction: ticket (Tracker ticket) or activity (CRM record/activity)

_Enum:_{.json-schema-reset .json-schema-value} `ticket`, `activity`
{.table-cell}
||
||

_value_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Tracker ticket key or CRM record ID (GUID)

_Max length:_{.json-schema-reset .json-schema-assertion} `200`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Reason for accrual/deduction

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "type": "ticket",
  "value": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: [ComarketingTransactionType](#entity-ComarketingTransactionType)

Transaction type: reserve (reservation), cancelReserve (cancel reservation), accrual (accrual), payout (payout)

_Enum:_{.json-schema-reset .json-schema-value} `reserve`, `cancelReserve`, `accrual`, `payout`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Description of the accrual/deduction

_Max length:_{.json-schema-reset .json-schema-assertion} `2000`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Array of accruals/deductions

_Min items:_{.json-schema-reset .json-schema-assertion} `1`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "type": "reserve",
    "amount": "example",
    "reason": {
      "type": "ticket",
      "value": "example"
    },
    "description": "example"
  }
]
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

</div>

<div class="openapi-entity">

### ComarketingTransactionType {#entity-ComarketingTransactionType}

Transaction type: reserve (reservation), cancelReserve (cancel reservation), accrual (accrual), payout (payout)

**Type**: string

_Enum:_{.json-schema-reset .json-schema-value} `reserve`, `cancelReserve`, `accrual`, `payout`

</div>

<div class="openapi-entity">

### ComarketingTransactionReasonType {#entity-ComarketingTransactionReasonType}

Reason type for the transaction: ticket (Tracker ticket) or activity (CRM record/activity)

**Type**: string

_Enum:_{.json-schema-reset .json-schema-value} `ticket`, `activity`

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
  "success": true
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_success_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: boolean
{.table-cell}
||
|#{.json-schema-properties}

</div>

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.