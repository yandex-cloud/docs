[Документация Yandex Cloud](../../../index.md) > [Yandex DataLens](../../index.md) > DataLens Public API > [DataLens API (англ.)](../index.md) > [WorkbookImport](index.md) > Get workbook import status

<div class="openapi">

# Get workbook import status

<!-- markdownlint-disable-file -->

Returns the status of the specified workbook import.

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
https://api.datalens.tech/rpc/getWorkbookImportStatus
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
  "importId": "example"
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_importId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the workbook import whose status to retrieve.

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
  "importId": "example",
  "workbookId": "example",
  "status": "pending",
  "progress": 0.5,
  "notifications": [
    {
      "entryId": "example",
      "scope": "dash",
      "code": "example",
      "message": "example",
      "level": "info",
      "details": null
    }
  ]
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_importId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the workbook import.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_notifications_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: array &#124; null

Notifications generated during the workbook import.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "entryId": "example",
    "scope": "dash",
    "code": "example",
    "message": "example",
    "level": "info",
    "details": null
  }
]
```

{% endcut %}
{.table-cell}
||
||

_progress_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: number

Workbook import progress percentage.
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
||

_workbookId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the imported workbook.

_Example:_{.json-schema-reset .json-schema-example} `example`
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

<div class="openapi-entity">

### EntryScope {#entity-EntryScope}

Type of the entry, e.g. `dash` — dashboard, `widget` — chart, etc.

**Type**: string

_Enum:_{.json-schema-reset .json-schema-value} `dash`, `report`, `widget`, `dataset`, `folder`, `connection`, `compute`, `artifact`

</div>

<div class="openapi-entity">

### WorkbookTransferNotificationLevel {#entity-WorkbookTransferNotificationLevel}

Severity level of the workbook transfer notification.

**Type**: string

_Enum:_{.json-schema-reset .json-schema-value} `info`, `warning`, `critical`

</div>

<div class="openapi-entity">

### WorkbookTransferNotification {#entity-WorkbookTransferNotification}

#|
|| **Name** | **Description** ||
||

_code_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Notification code.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_level_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: [WorkbookTransferNotificationLevel](#entity-WorkbookTransferNotificationLevel)

Severity level of the workbook transfer notification.

_Enum:_{.json-schema-reset .json-schema-value} `info`, `warning`, `critical`
{.table-cell}
||
||

_details_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

Additional notification details.

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
||

_entryId_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

ID of the entry associated with the notification.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_message_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Notification message.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_scope_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [EntryScope](#entity-EntryScope)

Type of the entry, e.g. `dash` — dashboard, `widget` — chart, etc.

_Enum:_{.json-schema-reset .json-schema-value} `dash`, `report`, `widget`, `dataset`, `folder`, `connection`, `compute`, `artifact`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "entryId": "example",
  "scope": "dash",
  "code": "example",
  "message": "example",
  "level": "info",
  "details": null
}
```

{% endcut %}

</div>

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.