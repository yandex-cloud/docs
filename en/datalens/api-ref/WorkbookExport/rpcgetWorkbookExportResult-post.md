<div class="openapi">

# Get workbook export result

<!-- markdownlint-disable-file -->

Returns the result of the specified workbook export.

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
https://api.datalens.tech/rpc/getWorkbookExportResult
```

</div>

</div>

</div>

### Headers

#|
|| **Name** | **Description** ||
||

_x-dl-api-version_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

API version header.

_Const:_{.json-schema-reset .json-schema-value} `2`

_Example:_{.json-schema-reset .json-schema-example} `2`
{.table-cell}
||
|#{.json-schema-properties}

<div class="openapi-entity">

### Body

{% cut "application/json" %}

```json translate=no
{
  "exportId": "example"
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_exportId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the workbook export whose result to retrieve.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

</div>

## Responses

<div class="openapi__response__code__200">

## 200 OK

Response

<div class="openapi-entity">

### Body

{% cut "application/json" %}

```json translate=no
{
  "exportId": "example",
  "data": {
    "export": {},
    "hash": "example"
  },
  "status": "pending"
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_data_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_export_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_[additional]_{.json-schema-reset .json-schema-additional-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Serialized workbook export data.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
||

_hash_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Hash of the serialized workbook export data.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "export": {},
  "hash": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_exportId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the workbook export.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_status_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: [WorkbookTransferProcessStatus](#entity-WorkbookTransferProcessStatus)

Status of the workbook transfer process.

_Enum:_{.json-schema-reset .json-schema-value} `pending`, `success`, `error`
{.table-cell}
||
|#{.json-schema-properties}

</div>

<div class="openapi-entity">

### WorkbookTransferProcessStatus {#entity-WorkbookTransferProcessStatus}

Status of the workbook transfer process.

**Type**: string

_Enum:_{.json-schema-reset .json-schema-value} `pending`, `success`, `error`

</div>

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.