[Документация Yandex Cloud](../../../index.md) > [Yandex DataLens](../../index.md) > DataLens Public API > [DataLens API (англ.)](../index.md) > [Workbook](index.md) > Get workbook entries

<div class="openapi">

# Get workbook entries

<!-- markdownlint-disable-file -->

Returns a list of entries in the specified workbook.

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
https://api.datalens.tech/rpc/getWorkbookEntries
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
||

_x-dl-audit-mode_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `true`

_Example:_{.json-schema-reset .json-schema-example} ``
{.table-cell}
||
|#{.json-schema-properties}

<div class="openapi-entity">

### Body

{% cut "application/json" %}

```json translate=no
{
  "workbookId": "example",
  "includePermissionsInfo": true,
  "page": 0.5,
  "pageSize": 0.5,
  "createdBy": "example",
  "scope": "dash",
  "orderBy": {
    "field": "name",
    "direction": "asc"
  },
  "filters": {
    "name": "example"
  }
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_workbookId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the workbook whose entries to retrieve.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_createdBy_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Filter entries by creator ID.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_filters_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Filter entries by name.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Filtering configuration.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "name": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_includePermissionsInfo_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

Include permission information in the response.
{.table-cell}
||
||

_orderBy_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_direction_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Workbook entry sorting direction.

_Enum:_{.json-schema-reset .json-schema-value} `asc`, `desc`
{.table-cell}
||
||

_field_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Field to order workbook entries by.

_Enum:_{.json-schema-reset .json-schema-value} `name`, `createdAt`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Sorting configuration.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "field": "name",
  "direction": "asc"
}
```

{% endcut %}
{.table-cell}
||
||

_page_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: number

Page number for pagination.
{.table-cell}
||
||

_pageSize_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: number

Number of entries per page.
{.table-cell}
||
||

_scope_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Any of 2 types**" %}{.json-schema-combinators data-marker=or}

- **Type**: [EntryScope](#entity-EntryScope)

  Type of the entry, e.g. `dash` — dashboard, `widget` — chart, etc.

  _Enum:_{.json-schema-reset .json-schema-value} `dash`, `report`, `widget`, `dataset`, `folder`, `connection`, `compute`, `artifact`

- **Type**: [EntryScope](#entity-EntryScope)[]

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  [
    "dash"
  ]
  ```

  {% endcut %}

{% endcut %}

Filter entries by scope.

_Example:_{.json-schema-reset .json-schema-example} `dash`
{.table-cell}
||
|#{.json-schema-properties}

</div>

<div class="openapi-entity">

### EntryScope {#entity-EntryScope}

Type of the entry, e.g. `dash` — dashboard, `widget` — chart, etc.

**Type**: string

_Enum:_{.json-schema-reset .json-schema-value} `dash`, `report`, `widget`, `dataset`, `folder`, `connection`, `compute`, `artifact`

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
      "scope": "dash",
      "type": "example",
      "key": "example",
      "displayKey": "example",
      "createdBy": "example",
      "createdAt": "example",
      "updatedBy": "example",
      "updatedAt": "example",
      "savedId": "example",
      "publishedId": "example",
      "revId": "example",
      "meta": {},
      "hidden": true,
      "workbookId": "example",
      "collectionId": "example",
      "tenantId": "example",
      "isFavorite": true,
      "isLocked": true,
      "permissions": {
        "execute": true,
        "read": true,
        "edit": true,
        "admin": true
      },
      "mirrored": true
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
**Type**: [GetWorkbookEntriesEntry](#entity-GetWorkbookEntriesEntry)[]

List of workbook entries.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "entryId": "example",
    "scope": "dash",
    "type": "example",
    "key": "example",
    "displayKey": "example",
    "createdBy": "example",
    "createdAt": "example",
    "updatedBy": "example",
    "updatedAt": "example",
    "savedId": "example",
    "publishedId": "example",
    "revId": "example",
    "meta": {},
    "hidden": true,
    "workbookId": "example",
    "collectionId": "example",
    "tenantId": "example",
    "isFavorite": true,
    "isLocked": true,
    "permissions": {
      "execute": true,
      "read": true,
      "edit": true,
      "admin": true
    },
    "mirrored": true
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

Token for retrieving the next page of results.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

</div>

<div class="openapi-entity">

### GetWorkbookEntriesEntry {#entity-GetWorkbookEntriesEntry}

#|
|| **Name** | **Description** ||
||

_collectionId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string &#124; null

ID of the collection the entry belongs to.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_createdAt_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Creation timestamp.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_createdBy_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the user who created the entry.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_displayKey_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string &#124; null

Display key of the entry.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_entryId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Unique identifier of the entry.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_hidden_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: boolean &#124; null

Indicates if the entry is hidden.
{.table-cell}
||
||

_isFavorite_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: boolean

Indicates if the entry is marked as favorite.
{.table-cell}
||
||

_isLocked_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: boolean

Indicates if the entry is locked.
{.table-cell}
||
||

_key_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string &#124; null

Key identifier of the entry.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_meta_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: object &#124; null

Metadata associated with the entry.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
||

_mirrored_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: boolean &#124; null

Indicates if the entry is mirrored.
{.table-cell}
||
||

_publishedId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string &#124; null

Published revision ID.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_revId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Current revision ID.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_savedId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string &#124; null

Saved revision ID.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_scope_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: [EntryScope](#entity-EntryScope)

Type of the entry, e.g. `dash` — dashboard, `widget` — chart, etc.

_Enum:_{.json-schema-reset .json-schema-value} `dash`, `report`, `widget`, `dataset`, `folder`, `connection`, `compute`, `artifact`
{.table-cell}
||
||

_tenantId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string &#124; null

ID of the DataLens tenant.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Entity type of the entry.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_updatedAt_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Last update timestamp.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_updatedBy_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the user who last updated the entry.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_workbookId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string &#124; null

ID of the workbook the entry belongs to.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_permissions_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_admin_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: boolean

Indicates if there are permissions for admin.
{.table-cell}
||
||

_edit_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: boolean

Indicates if there are permissions to edit.
{.table-cell}
||
||

_execute_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: boolean

Indicates if there are permissions to execute.
{.table-cell}
||
||

_read_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: boolean

Indicates if there are permissions to read.
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Permissions for the entry.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "execute": true,
  "read": true,
  "edit": true,
  "admin": true
}
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "entryId": "example",
  "scope": "dash",
  "type": "example",
  "key": "example",
  "displayKey": "example",
  "createdBy": "example",
  "createdAt": "example",
  "updatedBy": "example",
  "updatedAt": "example",
  "savedId": "example",
  "publishedId": "example",
  "revId": "example",
  "meta": {},
  "hidden": true,
  "workbookId": "example",
  "collectionId": "example",
  "tenantId": "example",
  "isFavorite": true,
  "isLocked": true,
  "permissions": {
    "execute": true,
    "read": true,
    "edit": true,
    "admin": true
  },
  "mirrored": true
}
```

{% endcut %}

</div>

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.