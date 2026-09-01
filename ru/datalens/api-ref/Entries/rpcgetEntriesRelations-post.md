<div class="openapi">

# Get entries relations

<!-- markdownlint-disable-file -->

Returns the specified DataLens entries relations.

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
https://api.datalens.tech/rpc/getEntriesRelations
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
  "entryIds": [
    "example"
  ],
  "linkDirection": "from",
  "includePermissionsInfo": true,
  "limit": 0.5,
  "pageToken": "example",
  "scope": "dash"
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_entryIds_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string[]

ID of the entries to get relations for.

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

_includePermissionsInfo_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

Include permission information in the response.
{.table-cell}
||
||

_limit_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: number

Maximum number of results to return.
{.table-cell}
||
||

_linkDirection_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

The direction of the link relatively to the original entry:
- `from` — entries that are linked to the original entry
- `to` — the original entry is linked to the entries

_Enum:_{.json-schema-reset .json-schema-value} `from`, `to`
{.table-cell}
||
||

_pageToken_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Token for retrieving the next page of results.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_scope_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [EntryScope](#entity-EntryScope)

Type of the entry, e.g. `dash` — dashboard, `widget` — chart, etc.

_Enum:_{.json-schema-reset .json-schema-value} `dash`, `report`, `widget`, `dataset`, `folder`, `connection`, `compute`, `artifact`, `sql_query`
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

## Responses

<div class="openapi__response__code__200">

## 200 OK

Response

<div class="openapi-entity">

### Body

{% cut "application/json" %}

```json translate=no
{
  "relations": [
    {
      "entryId": "example",
      "key": "example",
      "scope": "dash",
      "type": "example",
      "createdAt": "example",
      "public": true,
      "tenantId": "example",
      "workbookId": "example",
      "collectionId": "example",
      "isLocked": true,
      "permissions": {
        "execute": true,
        "read": true,
        "edit": true,
        "admin": true
      },
      "fullPermissions": {
        "listAccessBindings": true,
        "updateAccessBindings": true,
        "limitedView": true,
        "view": true,
        "update": true,
        "copy": true,
        "move": true,
        "delete": true,
        "createEntryBinding": true,
        "createLimitedEntryBinding": true
      }
    }
  ],
  "nextPageToken": "example"
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_relations_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: [GetEntriesRelationsEntry](#entity-GetEntriesRelationsEntry)[]

List of related entries.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "entryId": "example",
    "key": "example",
    "scope": "dash",
    "type": "example",
    "createdAt": "example",
    "public": true,
    "tenantId": "example",
    "workbookId": "example",
    "collectionId": "example",
    "isLocked": true,
    "permissions": {
      "execute": true,
      "read": true,
      "edit": true,
      "admin": true
    },
    "fullPermissions": {
      "listAccessBindings": true,
      "updateAccessBindings": true,
      "limitedView": true,
      "view": true,
      "update": true,
      "copy": true,
      "move": true,
      "delete": true,
      "createEntryBinding": true,
      "createLimitedEntryBinding": true
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

Token for retrieving the next page of results.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

</div>

<div class="openapi-entity">

### GetEntriesRelationsEntry {#entity-GetEntriesRelationsEntry}

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

_entryId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Unique identifier of the entry.

_Example:_{.json-schema-reset .json-schema-example} `example`
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

_public_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: boolean

Indicates if the entry is public.
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

Specified type of the entry from scope (e.g. type of the connection or visualization type for charts).

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

_fullPermissions_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_copy_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: boolean

Permission to copy.
{.table-cell}
||
||

_createEntryBinding_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: boolean

Permission to create entry binding.
{.table-cell}
||
||

_createLimitedEntryBinding_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: boolean

Permission to create limited entry binding.
{.table-cell}
||
||

_delete_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: boolean

Permission to delete.
{.table-cell}
||
||

_limitedView_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: boolean

Permission for limited viewing.
{.table-cell}
||
||

_listAccessBindings_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: boolean

Permission to list access bindings.
{.table-cell}
||
||

_move_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: boolean

Permission to move.
{.table-cell}
||
||

_update_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: boolean

Permission to update.
{.table-cell}
||
||

_updateAccessBindings_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: boolean

Permission to update access bindings.
{.table-cell}
||
||

_view_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: boolean

Permission to view.
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Full permissions for the entry.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "listAccessBindings": true,
  "updateAccessBindings": true,
  "limitedView": true,
  "view": true,
  "update": true,
  "copy": true,
  "move": true,
  "delete": true,
  "createEntryBinding": true,
  "createLimitedEntryBinding": true
}
```

{% endcut %}
{.table-cell}
||
||

_isLocked_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

Indicates if the entry is locked.
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

Basic permissions for the entry.

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
  "key": "example",
  "scope": "dash",
  "type": "example",
  "createdAt": "example",
  "public": true,
  "tenantId": "example",
  "workbookId": "example",
  "collectionId": "example",
  "isLocked": true,
  "permissions": {
    "execute": true,
    "read": true,
    "edit": true,
    "admin": true
  },
  "fullPermissions": {
    "listAccessBindings": true,
    "updateAccessBindings": true,
    "limitedView": true,
    "view": true,
    "update": true,
    "copy": true,
    "move": true,
    "delete": true,
    "createEntryBinding": true,
    "createLimitedEntryBinding": true
  }
}
```

{% endcut %}

</div>

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.