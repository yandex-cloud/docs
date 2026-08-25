<div class="openapi">

# List directory

<!-- markdownlint-disable-file -->

Lists entries from the specified directory.

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
https://api.datalens.tech/rpc/listDirectory
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
  "path": "example",
  "createdBy": "example",
  "orderBy": {
    "field": "createdAt",
    "direction": "desc"
  },
  "filters": {
    "name": "example"
  },
  "page": 0.5,
  "pageSize": 0.5,
  "includePermissionsInfo": true
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_createdBy_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Any of 2 types**" %}{.json-schema-combinators data-marker=or}

- **Type**: string

  _Example:_{.json-schema-reset .json-schema-example} `example`

- **Type**: string[]

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  [
    "example"
  ]
  ```

  {% endcut %}

{% endcut %}

Filter entries by creator.

_Example:_{.json-schema-reset .json-schema-example} `example`
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

Include permission information in response.
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

Sorting configuration.

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

_path_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Directory path to list entries from.

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
  "hasNextPage": true,
  "breadCrumbs": [
    {
      "title": "example",
      "path": "example",
      "entryId": "example",
      "isLocked": true,
      "permissions": {
        "execute": true,
        "read": true,
        "edit": true,
        "admin": true
      }
    }
  ],
  "entries": [
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
      "isLocked": true,
      "permissions": {
        "execute": true,
        "read": true,
        "edit": true,
        "admin": true
      },
      "name": "example"
    }
  ]
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_breadCrumbs_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: [ListDirectoryBreadCrumb](#entity-ListDirectoryBreadCrumb)[]

Navigation breadcrumbs for the current path.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "title": "example",
    "path": "example",
    "entryId": "example",
    "isLocked": true,
    "permissions": {
      "execute": true,
      "read": true,
      "edit": true,
      "admin": true
    }
  }
]
```

{% endcut %}
{.table-cell}
||
||

_entries_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: [ListDirectoryEntry](#entity-ListDirectoryEntry)[]

List of directory entries.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
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
    "isLocked": true,
    "permissions": {
      "execute": true,
      "read": true,
      "edit": true,
      "admin": true
    },
    "name": "example"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_hasNextPage_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: boolean

Indicates if there are more pages.
{.table-cell}
||
|#{.json-schema-properties}

</div>

<div class="openapi-entity">

### ListDirectoryBreadCrumb {#entity-ListDirectoryBreadCrumb}

#|
|| **Name** | **Description** ||
||

_entryId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Entry ID of the breadcrumb item.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_isLocked_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: boolean

Indicates if the item is locked.
{.table-cell}
||
||

_path_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Path of the breadcrumb item.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_permissions_{.json-schema-reset .json-schema-property .json-schema-required}
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

Permissions for the breadcrumb item.

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

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Title of the breadcrumb item.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "title": "example",
  "path": "example",
  "entryId": "example",
  "isLocked": true,
  "permissions": {
    "execute": true,
    "read": true,
    "edit": true,
    "admin": true
  }
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### EntryScope {#entity-EntryScope}

Type of the entry, e.g. `dash` — dashboard, `widget` — chart, etc.

**Type**: string

_Enum:_{.json-schema-reset .json-schema-value} `dash`, `report`, `widget`, `dataset`, `folder`, `connection`, `compute`, `artifact`

</div>

<div class="openapi-entity">

### ListDirectoryEntry {#entity-ListDirectoryEntry}

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

Creator of the entry.

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
**Type**: string

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

Published version ID.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_savedId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Saved version ID.

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

_type_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Type of the entry (e.g., dash, dataset, connection).

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

Last updater of the entry.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_workbookId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the workbook the entry belongs to.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_collectionTitle_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

Collection name.

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
||

_workbookTitle_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

Workbook name.

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
  "isLocked": true,
  "permissions": {
    "execute": true,
    "read": true,
    "edit": true,
    "admin": true
  },
  "name": "example"
}
```

{% endcut %}

</div>

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.