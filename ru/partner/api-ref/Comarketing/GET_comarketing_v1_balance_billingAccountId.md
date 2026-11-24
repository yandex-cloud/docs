<div class="openapi">

# Get co-marketing balance

<!-- markdownlint-disable-file -->

Get information about the current state of the partner's co-marketing budget.

GET /comarketing/v1/balance/:billingAccountId

Precondition: the current master account has the is_var = true flag.

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-get);margin-bottom: 12px">

<div class="openapi__request">

GET {.openapi__method}
```text translate=no
/comarketing/v1/balance/{billingAccountId}
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

## Responses

<div class="openapi__response__code__200">

## 200 OK

Successful response

<div class="openapi-entity">

### Body

{% cut "application/json" %}

```json translate=no
{
  "payout": "0.00",
  "reserved": "125.00",
  "available": "5000.00"
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_available_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Available co-marketing balance

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_payout_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Accrued payout amount (paid out co-marketing funds)

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_reserved_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Reserved amount

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

</div>

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.