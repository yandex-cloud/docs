<div class="openapi">

# Update workbook

<!-- markdownlint-disable-file -->

Updates the specified workbook.

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
https://api.datalens.tech/rpc/updateWorkbook
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
  "workbookId": "example",
  "title": "example",
  "description": "example"
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_workbookId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the workbook to update.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

New description of the workbook.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

New title of the workbook.

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
  "status": "creating"
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
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

_status_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Status of the workbook.

_Enum:_{.json-schema-reset .json-schema-value} `creating`, `deleting`, `active`, `deleted`
{.table-cell}
||
|#{.json-schema-properties}

</div>

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.