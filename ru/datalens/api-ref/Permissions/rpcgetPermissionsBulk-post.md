<div class="openapi">

# Get entries, workbooks and collections permissions

<!-- markdownlint-disable-file -->

Returns permissions for the specified DataLens entries, workbooks and collections.

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
https://api.datalens.tech/rpc/getPermissionsBulk
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
  "entryIds": [
    "example"
  ],
  "workbookIds": [
    "example"
  ],
  "collectionIds": [
    "example"
  ]
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_collectionIds_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string[]

Identifiers of the collections to check permissions for.

_Min items:_{.json-schema-reset .json-schema-assertion} `1`

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

_entryIds_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string[]

Identifiers of the entries to check permissions for.

_Min items:_{.json-schema-reset .json-schema-assertion} `1`

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

_workbookIds_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string[]

Identifiers of the workbooks to check permissions for.

_Min items:_{.json-schema-reset .json-schema-assertion} `1`

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
  "entries": {},
  "workbooks": {},
  "collections": {}
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_collections_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_[additional]_{.json-schema-reset .json-schema-additional-property}
{.table-cell}|
{% cut "**Any of 2 types**" %}{.json-schema-combinators data-marker=or}

- **Type**: object

  #|
  ||

  _permissions_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  {% cut "**Type**: object" %}

  #|
  ||

  _copy_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: boolean

  Indicates if the collection can be copied.
  {.table-cell}
  ||
  ||

  _createCollection_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: boolean

  Indicates if child collections can be created in the collection.
  {.table-cell}
  ||
  ||

  _createSharedEntry_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: boolean

  Indicates if shared entries can be created in the collection.
  {.table-cell}
  ||
  ||

  _createWorkbook_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: boolean

  Indicates if workbooks can be created in the collection.
  {.table-cell}
  ||
  ||

  _delete_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: boolean

  Indicates if the collection can be deleted.
  {.table-cell}
  ||
  ||

  _limitedView_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: boolean

  Indicates if the collection can be viewed with limited access.
  {.table-cell}
  ||
  ||

  _listAccessBindings_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: boolean

  Indicates if access bindings for the collection can be listed.
  {.table-cell}
  ||
  ||

  _move_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: boolean

  Indicates if the collection can be moved.
  {.table-cell}
  ||
  ||

  _update_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: boolean

  Indicates if the collection can be updated.
  {.table-cell}
  ||
  ||

  _updateAccessBindings_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: boolean

  Indicates if access bindings for the collection can be updated.
  {.table-cell}
  ||
  ||

  _view_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: boolean

  Indicates if the collection can be viewed.
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  Permissions for the collection.

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "listAccessBindings": true,
    "updateAccessBindings": true,
    "createSharedEntry": true,
    "createCollection": true,
    "createWorkbook": true,
    "limitedView": true,
    "view": true,
    "update": true,
    "copy": true,
    "move": true,
    "delete": true
  }
  ```

  {% endcut %}
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "permissions": {
      "listAccessBindings": true,
      "updateAccessBindings": true,
      "createSharedEntry": true,
      "createCollection": true,
      "createWorkbook": true,
      "limitedView": true,
      "view": true,
      "update": true,
      "copy": true,
      "move": true,
      "delete": true
    }
  }
  ```

  {% endcut %}

- **Type**: object

  #|
  ||

  _error_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Error code indicating a missing resource.

  _Const:_{.json-schema-reset .json-schema-value} `NOT_FOUND`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "error": "NOT_FOUND"
  }
  ```

  {% endcut %}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "permissions": {
    "listAccessBindings": true,
    "updateAccessBindings": true,
    "createSharedEntry": true,
    "createCollection": true,
    "createWorkbook": true,
    "limitedView": true,
    "view": true,
    "update": true,
    "copy": true,
    "move": true,
    "delete": true
  }
}
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Collection permissions or errors indexed by collection ID.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
||

_entries_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_[additional]_{.json-schema-reset .json-schema-additional-property}
{.table-cell}|
{% cut "**Any of 2 types**" %}{.json-schema-combinators data-marker=or}

- **Type**: object

  #|
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

- **Type**: object

  #|
  ||

  _error_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Error code indicating a missing resource.

  _Const:_{.json-schema-reset .json-schema-value} `NOT_FOUND`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "error": "NOT_FOUND"
  }
  ```

  {% endcut %}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
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
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Entry permissions or errors indexed by entry ID.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
||

_workbooks_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_[additional]_{.json-schema-reset .json-schema-additional-property}
{.table-cell}|
{% cut "**Any of 2 types**" %}{.json-schema-combinators data-marker=or}

- **Type**: object

  #|
  ||

  _permissions_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  {% cut "**Type**: object" %}

  #|
  ||

  _copy_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: boolean

  Indicates if the workbook can be copied.
  {.table-cell}
  ||
  ||

  _delete_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: boolean

  Indicates if the workbook can be deleted.
  {.table-cell}
  ||
  ||

  _embed_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: boolean

  Indicates if entries in the workbook can be embedded.
  {.table-cell}
  ||
  ||

  _limitedView_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: boolean

  Indicates if the workbook can be viewed with limited access.
  {.table-cell}
  ||
  ||

  _listAccessBindings_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: boolean

  Indicates if access bindings for the workbook can be listed.
  {.table-cell}
  ||
  ||

  _move_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: boolean

  Indicates if the workbook can be moved.
  {.table-cell}
  ||
  ||

  _publish_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: boolean

  Indicates if entries in the workbook can be published.
  {.table-cell}
  ||
  ||

  _update_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: boolean

  Indicates if the workbook can be updated.
  {.table-cell}
  ||
  ||

  _updateAccessBindings_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: boolean

  Indicates if access bindings for the workbook can be updated.
  {.table-cell}
  ||
  ||

  _view_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: boolean

  Indicates if the workbook can be viewed.
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  Permissions for the workbook.

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
    "publish": true,
    "embed": true,
    "delete": true
  }
  ```

  {% endcut %}
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "permissions": {
      "listAccessBindings": true,
      "updateAccessBindings": true,
      "limitedView": true,
      "view": true,
      "update": true,
      "copy": true,
      "move": true,
      "publish": true,
      "embed": true,
      "delete": true
    }
  }
  ```

  {% endcut %}

- **Type**: object

  #|
  ||

  _error_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Error code indicating a missing resource.

  _Const:_{.json-schema-reset .json-schema-value} `NOT_FOUND`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "error": "NOT_FOUND"
  }
  ```

  {% endcut %}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "permissions": {
    "listAccessBindings": true,
    "updateAccessBindings": true,
    "limitedView": true,
    "view": true,
    "update": true,
    "copy": true,
    "move": true,
    "publish": true,
    "embed": true,
    "delete": true
  }
}
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Workbook permissions or errors indexed by workbook ID.

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