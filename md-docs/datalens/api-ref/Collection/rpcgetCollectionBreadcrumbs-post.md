[Документация Yandex Cloud](../../../index.md) > [Yandex DataLens](../../index.md) > DataLens Public API > [DataLens API (англ.)](../index.md) > [Collection](index.md) > Get collection breadcrumbs

<div class="openapi">

# Get collection breadcrumbs

<!-- markdownlint-disable-file -->

Returns the breadcrumb path for the specified collection.

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
https://api.datalens.tech/rpc/getCollectionBreadcrumbs
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
  "collectionId": "example",
  "includePermissionsInfo": true
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_collectionId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the collection whose breadcrumbs to retrieve.

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

#|
|| **Name** | **Description** ||
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

</div>

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.