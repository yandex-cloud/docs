[Документация Yandex Cloud](../../../index.md) > [Yandex DataLens](../../index.md) > DataLens Public API > [DataLens API (англ.)](../index.md) > [Workbook](index.md) > Get workbooks list

<div class="openapi">

# Get workbooks list

<!-- markdownlint-disable-file -->

Returns a list of workbooks.

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
https://api.datalens.tech/rpc/getWorkbooksList
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
  "includePermissionsInfo": true,
  "filterString": "example",
  "page": 0.5,
  "pageSize": 0.5,
  "orderField": "title",
  "orderDirection": "asc",
  "onlyMy": true
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_collectionId_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

Filter workbooks by collection ID.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_filterString_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Filter workbooks by title.

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

_onlyMy_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

Return only workbooks created by the current user.
{.table-cell}
||
||

_orderDirection_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Workbook sorting direction.

_Enum:_{.json-schema-reset .json-schema-value} `asc`, `desc`
{.table-cell}
||
||

_orderField_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Field to order workbooks by.

_Enum:_{.json-schema-reset .json-schema-value} `title`, `createdAt`, `updatedAt`
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

Number of workbooks per page.
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
  "workbooks": [
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
  ],
  "nextPageToken": "example"
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_workbooks_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object[]" %}

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

{% endcut %}

List of workbooks.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
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

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.