<div class="openapi">

# Get entries

<!-- markdownlint-disable-file -->

Returns a list of DataLens entries.

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
https://api.datalens.tech/rpc/getEntries
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
  "ids": [
    "example"
  ],
  "scope": "dash",
  "type": "example",
  "createdBy": [
    "example"
  ],
  "orderBy": {
    "field": "createdAt",
    "direction": "desc"
  },
  "excludeLocked": true,
  "includeLinks": true,
  "filters": {
    "name": "example"
  },
  "pageSize": 1,
  "includePermissionsInfo": true,
  "ignoreWorkbookEntries": true,
  "ignoreSharedEntries": true,
  "pageToken": "example",
  "includeData": true
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_createdBy_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string[]

IDs of entry creators to filter by.

_Max items:_{.json-schema-reset .json-schema-assertion} `1000`

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

_excludeLocked_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

Whether to exclude locked entries.
{.table-cell}
||
||

_filters_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_name_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Name used to filter entries.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Entry filters.

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

_ids_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string[]

IDs of entries to return.

_Max items:_{.json-schema-reset .json-schema-assertion} `1000`

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

_ignoreSharedEntries_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

Whether to exclude shared entries.
{.table-cell}
||
||

_ignoreWorkbookEntries_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

Whether to exclude entries that belong to workbooks.
{.table-cell}
||
||

_includeData_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

Whether to include entry data.
{.table-cell}
||
||

_includeLinks_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

Whether to include entry links.
{.table-cell}
||
||

_includePermissionsInfo_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

Whether to include permission information.
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

Entry sort direction.

_Enum:_{.json-schema-reset .json-schema-value} `desc`, `asc`
{.table-cell}
||
||

_field_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Field used to sort entries: creation date or name.

_Enum:_{.json-schema-reset .json-schema-value} `createdAt`, `name`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Entry sorting configuration.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "field": "createdAt",
  "direction": "desc"
}
```

{% endcut %}
{.table-cell}
||
||

_pageSize_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer

Maximum number of entries to return.

_Min value:_{.json-schema-reset .json-schema-assertion} `1`

_Max value:_{.json-schema-reset .json-schema-assertion} `200`
{.table-cell}
||
||

_pageToken_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Token for the next page of entries.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_scope_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Scope used to filter entries.

_Enum:_{.json-schema-reset .json-schema-value} `dash`, `report`, `widget`, `dataset`, `folder`, `connection`, `compute`, `artifact`, `sql_query`
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Entry type to filter by.

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
  "nextPageToken": "example",
  "entries": [
    {
      "isLocked": true,
      "entryId": "example",
      "scope": "dash",
      "type": "example",
      "name": "example"
    }
  ]
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_entries_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: array" %}

{% cut "**Any of 2 types**" %}{.json-schema-combinators data-marker=or}

- **Type**: object

  #|
  ||

  _entryId_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Unique identifier of the locked entry.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _isLocked_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: boolean

  Indicates that the entry is locked.

  _Const:_{.json-schema-reset .json-schema-value} `true`
  {.table-cell}
  ||
  ||

  _name_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Name of the entry.

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
  **Type**: string

  Type of the locked entry.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "isLocked": true,
    "entryId": "example",
    "scope": "dash",
    "type": "example",
    "name": "example"
  }
  ```

  {% endcut %}

- **Type**: object

  #|
  ||

  _collectionId_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string &#124; null

  ID of the collection containing the entry.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _createdAt_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Date and time when the entry was created.

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
  **Type**: boolean

  Whether the entry is hidden.
  {.table-cell}
  ||
  ||

  _isFavorite_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: boolean

  Whether the entry is marked as a favorite.
  {.table-cell}
  ||
  ||

  _key_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Key of the entry.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _links_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: object &#124; null

  Links associated with the entry.

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {}
  ```

  {% endcut %}
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

  _name_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Name of the entry.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _publishedId_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string &#124; null

  ID of the published entry revision.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _savedId_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  ID of the saved entry revision.

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
  **Type**: string

  Type of the entry.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _updatedAt_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Date and time when the entry was last updated.

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

  ID of the workbook containing the entry.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _collectionTitle_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: string &#124; null

  Title of the collection containing the entry.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _data_{.json-schema-reset .json-schema-property}
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

  Data stored in the entry.

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {}
  ```

  {% endcut %}
  {.table-cell}
  ||
  ||

  _isLocked_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: boolean

  Indicates that the entry is not locked.

  _Const:_{.json-schema-reset .json-schema-value} `false`
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
  ||

  _workbookTitle_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: string &#124; null

  Title of the workbook containing the entry.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "entryId": "example",
    "key": "example",
    "scope": "dash",
    "type": "example",
    "meta": {},
    "createdAt": "example",
    "updatedAt": "example",
    "createdBy": "example",
    "updatedBy": "example",
    "savedId": "example",
    "publishedId": "example",
    "hidden": true,
    "workbookId": "example",
    "workbookTitle": "example",
    "collectionId": "example",
    "collectionTitle": "example",
    "isFavorite": true,
    "isLocked": false,
    "permissions": {
      "execute": true,
      "read": true,
      "edit": true,
      "admin": true
    },
    "links": {},
    "data": {},
    "name": "example"
  }
  ```

  {% endcut %}

{% endcut %}

{% endcut %}

Entries matching the request.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "isLocked": true,
    "entryId": "example",
    "scope": "dash",
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

Token for the next page of entries.

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

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.