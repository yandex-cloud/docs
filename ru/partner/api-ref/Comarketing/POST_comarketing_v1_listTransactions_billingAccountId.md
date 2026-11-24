<div class="openapi">

# List co-marketing transactions

<!-- markdownlint-disable-file -->

Get a list of co-marketing transactions for the master billing account.

POST /comarketing/v1/listTransactions/:billingAccountId

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
/comarketing/v1/listTransactions/{billingAccountId}
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

Filter string. Available fields: type (any, except), reason — by reason value (equal, contain), createdAt (between, betweenEqual), createdBy (any, except), description (equal, contain)

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_limit_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: number

Number of records per page
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
**Type**: [ComarketingTransactionSorting](#entity-ComarketingTransactionSorting)

Sorting parameters for co-marketing transactions

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "id": "createdAt",
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

<div class="openapi-entity">

### ComarketingTransactionSorting {#entity-ComarketingTransactionSorting}

Sorting parameters for co-marketing transactions

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Field to sort by: createdAt (creation date) or type (transaction type)

_Enum:_{.json-schema-reset .json-schema-value} `createdAt`, `type`
{.table-cell}
||
||

_order_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: [SortingOrder](#entity-SortingOrder)

Sort order: asc (ascending) or desc (descending)

_Enum:_{.json-schema-reset .json-schema-value} `asc`, `desc`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "id": "createdAt",
  "order": "asc"
}
```

{% endcut %}

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
      "masterAccountId": "a6q3hv13r2pe0njnhefs",
      "type": "reserve",
      "amount": "125.00",
      "reasonType": "ticket",
      "reasonValue": "CLOUDPD-1234",
      "description": "Резерв под активность ко-маркетинга",
      "createdAt": "2026-09-29 12:00:00",
      "createdBy": {
        "subject": "yandex_123456",
        "claims": {}
      }
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

_amount_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Transaction amount

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_createdAt_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Transaction creation date and time in Moscow time (YYYY-MM-DD HH:mm:ss)

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_createdBy_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_subject_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Creator subject ID

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_claims_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: object

Creator subject claims (may be missing/empty if claims were not found)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Who created the transaction

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "subject": "example",
  "claims": {}
}
```

{% endcut %}
{.table-cell}
||
||

_masterAccountId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Master billing account ID

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_reasonType_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: [ComarketingTransactionReasonType](#entity-ComarketingTransactionReasonType)

Reason type for the transaction: ticket (Tracker ticket) or activity (CRM record/activity)

_Enum:_{.json-schema-reset .json-schema-value} `ticket`, `activity`
{.table-cell}
||
||

_reasonValue_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Tracker ticket key or CRM record ID (GUID)

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: [ComarketingTransactionType](#entity-ComarketingTransactionType)

Transaction type (see ComarketingTransactionType)

Transaction type: reserve (reservation), cancelReserve (cancel reservation), accrual (accrual), payout (payout)

_Enum:_{.json-schema-reset .json-schema-value} `reserve`, `cancelReserve`, `accrual`, `payout`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Transaction description

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Array of co-marketing transactions

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "masterAccountId": "example",
    "type": "reserve",
    "amount": "example",
    "reasonType": "ticket",
    "reasonValue": "example",
    "description": "example",
    "createdAt": "example",
    "createdBy": {
      "subject": "example",
      "claims": {}
    }
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

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.