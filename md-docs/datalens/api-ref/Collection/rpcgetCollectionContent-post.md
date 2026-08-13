[Документация Yandex Cloud](../../../index.md) > [Yandex DataLens](../../index.md) > DataLens Public API > [DataLens API (англ.)](../index.md) > [Collection](index.md) > Get collection content

<div class="openapi">

# Get collection content

<!-- markdownlint-disable-file -->

Returns the content of the specified collection.

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
https://api.datalens.tech/rpc/getCollectionContent
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
  "collectionId": "example",
  "page": "example",
  "filterString": "example",
  "orderField": "title",
  "orderDirection": "asc",
  "onlyMy": true,
  "mode": "all",
  "pageSize": 0.5,
  "includePermissionsInfo": true
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_collectionId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string &#124; null

ID of the collection whose content to retrieve.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_filterString_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Filter collection content by title.

_Example:_{.json-schema-reset .json-schema-example} `example`
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

_mode_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Types of items to include in the response.

_Enum:_{.json-schema-reset .json-schema-value} `all`, `onlyCollections`, `onlyWorkbooks`, `onlyEntries`
{.table-cell}
||
||

_onlyMy_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

Return only items created by the current user.
{.table-cell}
||
||

_orderDirection_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Collection content sorting direction.

_Enum:_{.json-schema-reset .json-schema-value} `asc`, `desc`
{.table-cell}
||
||

_orderField_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Field to order collection content by.

_Enum:_{.json-schema-reset .json-schema-value} `title`, `createdAt`, `updatedAt`
{.table-cell}
||
||

_page_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

Token identifying the page of collection content to retrieve.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_pageSize_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: number

Number of collection items per page.
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
  "items": [
    {
      "collectionId": "example",
      "title": "example",
      "description": "example",
      "parentId": "example",
      "tenantId": "example",
      "createdBy": "example",
      "createdAt": "example",
      "updatedBy": "example",
      "updatedAt": "example",
      "meta": {},
      "entity": "collection",
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
  ],
  "nextPageToken": "example"
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_items_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: array" %}

{% cut "**One of 3 types**" %}{.json-schema-combinators data-marker=or}

- **Type**: object

  #|
  ||

  _collectionId_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Unique identifier of the collection.

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

  ID of the user who created the collection.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _description_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string &#124; null

  Description of the collection.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _entity_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Indicates that the item is a collection.

  _Const:_{.json-schema-reset .json-schema-value} `collection`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _meta_{.json-schema-reset .json-schema-property .json-schema-required}
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

  Metadata associated with the collection.

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {}
  ```

  {% endcut %}
  {.table-cell}
  ||
  ||

  _parentId_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string &#124; null

  ID of the parent collection.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _tenantId_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  ID of the DataLens tenant.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _title_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Title of the collection.

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

  ID of the user who last updated the collection.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
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
    "collectionId": "example",
    "title": "example",
    "description": "example",
    "parentId": "example",
    "tenantId": "example",
    "createdBy": "example",
    "createdAt": "example",
    "updatedBy": "example",
    "updatedAt": "example",
    "meta": {},
    "entity": "collection",
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

  _collectionId_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string &#124; null

  ID of the collection the workbook belongs to.

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

  ID of the user who created the workbook.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _description_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string &#124; null

  Description of the workbook.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _entity_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Indicates that the item is a workbook.

  _Const:_{.json-schema-reset .json-schema-value} `workbook`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _meta_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  {% cut "**All of 2 types**" %}{.json-schema-combinators data-marker=and}

  - **Type**: object

    #|
    ||

    _importId_{.json-schema-reset .json-schema-property}
    {.table-cell}|
    **Type**: string

    ID of the workbook import operation.

    _Example:_{.json-schema-reset .json-schema-example} `example`
    {.table-cell}
    ||
    |#{.json-schema-properties}

    {% cut "**Example**" %}{.json-schema-example}

    ```json translate=no
    {
      "importId": "example"
    }
    ```

    {% endcut %}

  - **Type**: object

    #|
    ||

    _[additional]_{.json-schema-reset .json-schema-additional-property}
    {.table-cell}|
    **Type**: unknown

    _Example:_{.json-schema-reset .json-schema-example} `null`
    {.table-cell}
    ||
    |#{.json-schema-properties}

    {% cut "**Example**" %}{.json-schema-example}

    ```json translate=no
    {}
    ```

    {% endcut %}

  {% endcut %}

  Metadata associated with the workbook.

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "importId": "example"
  }
  ```

  {% endcut %}
  {.table-cell}
  ||
  ||

  _tenantId_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  ID of the DataLens tenant.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _title_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Title of the workbook.

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

  ID of the user who last updated the workbook.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _workbookId_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Unique identifier of the workbook.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
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
  ||

  _status_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: string

  Status of the workbook.

  _Enum:_{.json-schema-reset .json-schema-value} `creating`, `deleting`, `active`, `deleted`
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "workbookId": "example",
    "collectionId": "example",
    "title": "example",
    "description": "example",
    "tenantId": "example",
    "meta": {
      "importId": "example"
    },
    "createdBy": "example",
    "createdAt": "example",
    "updatedBy": "example",
    "updatedAt": "example",
    "status": "creating",
    "entity": "workbook",
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

- **Type**: [StructureItemEntry](#entity-StructureItemEntry)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "collectionId": "example",
    "updatedAt": "example",
    "workbookId": "example",
    "scope": "dash",
    "type": "example",
    "key": "example",
    "entryId": "example",
    "entity": "entry",
    "displayKey": "example",
    "title": "example",
    "permissions": {
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

{% endcut %}

{% endcut %}

List of collection content items.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "collectionId": "example",
    "title": "example",
    "description": "example",
    "parentId": "example",
    "tenantId": "example",
    "createdBy": "example",
    "createdAt": "example",
    "updatedBy": "example",
    "updatedAt": "example",
    "meta": {},
    "entity": "collection",
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
]
```

{% endcut %}
{.table-cell}
||
||

_nextPageToken_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

Token for retrieving the next page of results.

_Example:_{.json-schema-reset .json-schema-example} `example`
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

<div class="openapi-entity">

### StructureItemEntry {#entity-StructureItemEntry}

#|
|| **Name** | **Description** ||
||

_collectionId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the collection the entry belongs to.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_displayKey_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Display key of the entry.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_entity_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Indicates that the item is an entry.

_Const:_{.json-schema-reset .json-schema-value} `entry`

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
**Type**: string

Key identifier of the entry.

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

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Title of the entry.

_Example:_{.json-schema-reset .json-schema-example} `example`
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

Last update timestamp.

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

Permissions for the entry.

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
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "collectionId": "example",
  "updatedAt": "example",
  "workbookId": "example",
  "scope": "dash",
  "type": "example",
  "key": "example",
  "entryId": "example",
  "entity": "entry",
  "displayKey": "example",
  "title": "example",
  "permissions": {
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