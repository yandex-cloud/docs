<div class="openapi">

# Get list of linked instances

<!-- markdownlint-disable-file -->

Get a list of subaccount links to service instances.

POST /subaccounts/v1/:masterBAId/subaccount/:subAccountId/instances

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
/subaccounts/v1/{masterBAId}/subaccount/{subAccountId}/instances
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

_subAccountId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Subaccount ID

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
  "serviceInstanceType": "yandex360",
  "pageToken": "WyJ5YW5kZXgzNjAiLCAiODMxNjg4MSJd"
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_limit_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: number

Page size
{.table-cell}
||
||

_pageToken_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Next page token

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_serviceInstanceType_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: [BillableEntityType](#entity-BillableEntityType)

Billable entity type

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

</div>

<div class="openapi-entity">

### BillableEntityType {#entity-BillableEntityType}

Billable entity type

**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`

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
      "serviceInstanceType": "yandex360",
      "serviceInstanceId": "8316881",
      "effectiveTime": 1760499316
    },
    {
      "serviceInstanceType": "yandex360",
      "serviceInstanceId": "8563574",
      "effectiveTime": 1787140480
    },
    {
      "serviceInstanceType": "yandex360",
      "serviceInstanceId": "8587332",
      "effectiveTime": 1788947073
    },
    {
      "serviceInstanceType": "yandex360",
      "serviceInstanceId": "8587631",
      "effectiveTime": 1788954234
    },
    {
      "serviceInstanceType": "yandex360",
      "serviceInstanceId": "8600557",
      "effectiveTime": 1789743906
    }
  ]
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_list_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object[]" %}

#|
||

_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Instance ID

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Instance name

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Instance type

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Array of linked service instances

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "id": "example",
    "type": "example",
    "name": "example"
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