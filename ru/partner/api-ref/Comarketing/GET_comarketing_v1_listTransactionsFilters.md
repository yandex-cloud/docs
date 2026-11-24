<div class="openapi">

# Get co-marketing transaction filter values

<!-- markdownlint-disable-file -->

Get available filter fields and allowed operators for co-marketing transactions listing. Useful for building filter strings for POST /comarketing/v1/listTransactions/{billingAccountId}.

GET /comarketing/v1/listTransactionsFilters

Ignores the master billing account middleware — permissions are checked when the filters are used.

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-get);margin-bottom: 12px">

<div class="openapi__request">

GET {.openapi__method}
```text translate=no
/comarketing/v1/listTransactionsFilters
```

</div>

</div>

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
  "dto": [
    [
      {
        "id": "type",
        "type": "enum",
        "enum": [
          "reserve",
          "cancelReserve",
          "accrual",
          "payout"
        ],
        "operator": "any"
      },
      {
        "id": "reason",
        "fieldName": "reasonValue",
        "type": "string",
        "operator": "equal"
      },
      {
        "id": "createdAt",
        "type": "dateWithTime",
        "operator": "between"
      },
      {
        "id": "createdBy",
        "type": "string",
        "operator": "any"
      },
      {
        "id": "description",
        "type": "string",
        "operator": "contain"
      }
    ]
  ],
  "operators": {
    "type": [
      "any",
      "except"
    ],
    "reason": [
      "equal",
      "contain"
    ],
    "createdAt": [
      "between",
      "betweenEqual"
    ],
    "createdBy": [
      "any",
      "except"
    ],
    "description": [
      "equal",
      "contain"
    ]
  }
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_dto_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object[][]" %}

#|
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Filter field ID: type, reason, createdAt, createdBy, description

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Filter value type: string, uuid, dateWithTime, dateWithoutTime, dateRange, number, enum, enumArray, enumString

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Filter description

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_enum_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string[]

Allowed values for enum-type filters

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

_fieldName_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

DB field name (present when it differs from id, e.g. reason → reasonValue)

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_operator_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Default operator for the filter

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_withSuggest_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

Whether suggestions (autocomplete) are available in UI
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Available filter field definitions grouped by filter groups

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  [
    {
      "id": "example",
      "fieldName": "example",
      "type": "example",
      "operator": "example",
      "enum": [
        "example"
      ],
      "description": "example",
      "withSuggest": true
    }
  ]
]
```

{% endcut %}
{.table-cell}
||
||

_operators_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_[additional]_{.json-schema-reset .json-schema-additional-property}
{.table-cell}|
**Type**: string[]

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

{% endcut %}

Map of filter field ID to the list of allowed filter operators

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

</div>

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.