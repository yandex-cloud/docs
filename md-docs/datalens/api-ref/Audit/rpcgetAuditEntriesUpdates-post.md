[Документация Yandex Cloud](../../../index.md) > [Yandex DataLens](../../index.md) > DataLens Public API > [DataLens API (англ.)](../index.md) > [Audit](index.md) > Get updated entries for audit

<div class="openapi">

# Get updated entries for audit

<!-- markdownlint-disable-file -->

Returns updated DataLens entries for audit.

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
https://api.datalens.tech/rpc/getAuditEntriesUpdates
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
  "from": "2025-01-01T00:00:00Z",
  "to": "2025-01-01T00:00:00Z",
  "limit": 0.5,
  "pageToken": "example"
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_from_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string&lt;date-time&gt;

Start date for filtering entries by updatedAt

_Example:_{.json-schema-reset .json-schema-example} `2025-01-01T00:00:00Z`
{.table-cell}
||
||

_limit_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: number

Maximum number of entries to return
{.table-cell}
||
||

_pageToken_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Token for pagination

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_to_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string&lt;date-time&gt;

End date for filtering entries by updatedAt

_Example:_{.json-schema-reset .json-schema-example} `2025-01-01T00:00:00Z`
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
  "entries": [
    {
      "entryId": "example",
      "key": "example",
      "isDeleted": true,
      "workbookId": "example",
      "collectionId": "example",
      "parentFolderId": "example",
      "scope": "dash",
      "type": "example",
      "updatedAt": "example",
      "userId": "example"
    }
  ],
  "nextPageToken": "example"
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_entries_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: [AuditEntry](#entity-AuditEntry)[]

Entries updated in the requested period.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "entryId": "example",
    "key": "example",
    "isDeleted": true,
    "workbookId": "example",
    "collectionId": "example",
    "parentFolderId": "example",
    "scope": "dash",
    "type": "example",
    "updatedAt": "example",
    "userId": "example"
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

Token for the next page of results

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

</div>

<div class="openapi-entity">

### EntryScope {#entity-EntryScope}

Type of the entry, e.g. `dash` — dashboard, `widget` — chart, etc.

**Type**: string

_Enum:_{.json-schema-reset .json-schema-value} `dash`, `report`, `widget`, `dataset`, `folder`, `connection`, `compute`, `artifact`, `sql_query`

</div>

<div class="openapi-entity">

### AuditEntry {#entity-AuditEntry}

#|
|| **Name** | **Description** ||
||

_collectionId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string &#124; null

ID of the associated collection

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_entryId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Unique identifier of the entry

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_isDeleted_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: boolean

Flag indicating if the entry is deleted
{.table-cell}
||
||

_key_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string &#124; null

Entry key identifier

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_parentFolderId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string &#124; null

ID of the associated folder

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_scope_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: [EntryScope](#entity-EntryScope)

Type of the entry, e.g. `dash` — dashboard, `widget` — chart, etc.

_Enum:_{.json-schema-reset .json-schema-value} `dash`, `report`, `widget`, `dataset`, `folder`, `connection`, `compute`, `artifact`, `sql_query`
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string &#124; null

Type of the entry

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_updatedAt_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Timestamp of the last update

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_userId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the user who made the change

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_workbookId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string &#124; null

ID of the associated workbook

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "entryId": "example",
  "key": "example",
  "isDeleted": true,
  "workbookId": "example",
  "collectionId": "example",
  "parentFolderId": "example",
  "scope": "dash",
  "type": "example",
  "updatedAt": "example",
  "userId": "example"
}
```

{% endcut %}

</div>

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.