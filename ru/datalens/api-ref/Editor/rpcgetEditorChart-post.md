<div class="openapi">

# 🚧 [Experimental] Get editor chart

<!-- markdownlint-disable-file -->

Returns the specified Editor chart.

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
https://api.datalens.tech/rpc/getEditorChart
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
  "chartId": "example",
  "workbookId": "example",
  "revId": "example",
  "includePermissions": true,
  "includeLinks": true,
  "includeFavorite": true,
  "branch": "saved"
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_chartId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the Editor chart to return. You can find it in the chart settings in DataLens interface.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_branch_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [EntryBranch](#entity-EntryBranch)

Entry branch: saved or published.

_Enum:_{.json-schema-reset .json-schema-value} `saved`, `published`
{.table-cell}
||
||

_includeFavorite_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

Include favorite status in the response.
{.table-cell}
||
||

_includeLinks_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

Include information on configured links in the response.
{.table-cell}
||
||

_includePermissions_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

Include information on configured permissions in the response.
{.table-cell}
||
||

_revId_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Version ID for the Editor chart.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_workbookId_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

ID of the workbook the Editor chart belongs to. If navigation across folders is enabled and the Editor chart belongs to a folder, the value must be null.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

</div>

<div class="openapi-entity">

### EntryBranch {#entity-EntryBranch}

Entry branch: saved or published.

**Type**: string

_Enum:_{.json-schema-reset .json-schema-value} `saved`, `published`

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
  "entry": {
    "version": 1,
    "entryId": "example",
    "key": null,
    "createdAt": "example",
    "createdBy": "example",
    "updatedAt": "example",
    "updatedBy": "example",
    "revId": "example",
    "savedId": "example",
    "publishedId": "example",
    "tenantId": "example",
    "hidden": true,
    "public": true,
    "workbookId": null,
    "scope": "widget",
    "meta": {},
    "links": {},
    "annotation": {
      "description": "example"
    },
    "type": "table_node",
    "data": {
      "meta": "example",
      "params": "example",
      "sources": "example",
      "controls": "example",
      "prepare": "example",
      "config": "example"
    }
  },
  "isFavorite": true,
  "permissions": {
    "execute": true,
    "read": true,
    "edit": true,
    "admin": true
  }
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_entry_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**One of 5 types**" %}{.json-schema-combinators data-marker=or}

- **Type**: [EditorTableNode](#entity-EditorTableNode)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "version": 1,
    "entryId": "example",
    "key": null,
    "createdAt": "example",
    "createdBy": "example",
    "updatedAt": "example",
    "updatedBy": "example",
    "revId": "example",
    "savedId": "example",
    "publishedId": "example",
    "tenantId": "example",
    "hidden": true,
    "public": true,
    "workbookId": null,
    "scope": "widget",
    "meta": {},
    "links": {},
    "annotation": {
      "description": "example"
    },
    "type": "table_node",
    "data": {
      "meta": "example",
      "params": "example",
      "sources": "example",
      "controls": "example",
      "prepare": "example",
      "config": "example"
    }
  }
  ```

  {% endcut %}

- **Type**: [EditorGravityChartsNode](#entity-EditorGravityChartsNode)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "version": 1,
    "entryId": "example",
    "key": null,
    "createdAt": "example",
    "createdBy": "example",
    "updatedAt": "example",
    "updatedBy": "example",
    "revId": "example",
    "savedId": "example",
    "publishedId": "example",
    "tenantId": "example",
    "hidden": true,
    "public": true,
    "workbookId": null,
    "scope": "widget",
    "meta": {},
    "links": {},
    "annotation": {
      "description": "example"
    },
    "type": "d3_node",
    "data": {
      "meta": "example",
      "params": "example",
      "sources": "example",
      "controls": "example",
      "prepare": "example",
      "config": "example"
    }
  }
  ```

  {% endcut %}

- **Type**: [EditorMarkdownNode](#entity-EditorMarkdownNode)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "version": 1,
    "entryId": "example",
    "key": null,
    "createdAt": "example",
    "createdBy": "example",
    "updatedAt": "example",
    "updatedBy": "example",
    "revId": "example",
    "savedId": "example",
    "publishedId": "example",
    "tenantId": "example",
    "hidden": true,
    "public": true,
    "workbookId": null,
    "scope": "widget",
    "meta": {},
    "links": {},
    "annotation": {
      "description": "example"
    },
    "type": "markdown_node",
    "data": {
      "meta": "example",
      "params": "example",
      "sources": "example",
      "controls": "example",
      "prepare": "example"
    }
  }
  ```

  {% endcut %}

- **Type**: [EditorAdvancedChartNode](#entity-EditorAdvancedChartNode)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "version": 1,
    "entryId": "example",
    "key": null,
    "createdAt": "example",
    "createdBy": "example",
    "updatedAt": "example",
    "updatedBy": "example",
    "revId": "example",
    "savedId": "example",
    "publishedId": "example",
    "tenantId": "example",
    "hidden": true,
    "public": true,
    "workbookId": null,
    "scope": "widget",
    "meta": {},
    "links": {},
    "annotation": {
      "description": "example"
    },
    "type": "advanced-chart_node",
    "data": {
      "meta": "example",
      "params": "example",
      "sources": "example",
      "controls": "example",
      "prepare": "example"
    }
  }
  ```

  {% endcut %}

- **Type**: [EditorSelectorNode](#entity-EditorSelectorNode)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "version": 1,
    "entryId": "example",
    "key": null,
    "createdAt": "example",
    "createdBy": "example",
    "updatedAt": "example",
    "updatedBy": "example",
    "revId": "example",
    "savedId": "example",
    "publishedId": "example",
    "tenantId": "example",
    "hidden": true,
    "public": true,
    "workbookId": null,
    "scope": "widget",
    "meta": {},
    "links": {},
    "annotation": {
      "description": "example"
    },
    "type": "control_node",
    "data": {
      "meta": "example",
      "params": "example",
      "sources": "example",
      "controls": "example"
    }
  }
  ```

  {% endcut %}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "version": 1,
  "entryId": "example",
  "key": null,
  "createdAt": "example",
  "createdBy": "example",
  "updatedAt": "example",
  "updatedBy": "example",
  "revId": "example",
  "savedId": "example",
  "publishedId": "example",
  "tenantId": "example",
  "hidden": true,
  "public": true,
  "workbookId": null,
  "scope": "widget",
  "meta": {},
  "links": {},
  "annotation": {
    "description": "example"
  },
  "type": "table_node",
  "data": {
    "meta": "example",
    "params": "example",
    "sources": "example",
    "controls": "example",
    "prepare": "example",
    "config": "example"
  }
}
```

{% endcut %}
{.table-cell}
||
||

_isFavorite_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

Indicates if the chart is marked as favorite.
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

Permissions for the chart.

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

</div>

<div class="openapi-entity">

### EditorTableNode {#entity-EditorTableNode}

#|
|| **Name** | **Description** ||
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

_data_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_config_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Configuration from the Config tab.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_controls_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Configuration from the Controls tab.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_meta_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Configuration from the Meta tab.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_params_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Configuration from the Params tab.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_prepare_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Configuration from the Prepare tab.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_sources_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Configuration from the Sources tab.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "meta": "example",
  "params": "example",
  "sources": "example",
  "controls": "example",
  "prepare": "example",
  "config": "example"
}
```

{% endcut %}
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

_key_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Any of 3 types**" %}{.json-schema-combinators data-marker=or}

- **Type**: null

  _Example:_{.json-schema-reset .json-schema-example} `null`

- **Type**: string

  _Example:_{.json-schema-reset .json-schema-example} `example`

- **Type**: null

  _Example:_{.json-schema-reset .json-schema-example} `null`

{% endcut %}

Key identifier of the entry.

_Example:_{.json-schema-reset .json-schema-example} `null`
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

_public_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: boolean

Indicates if the entry is public.
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

_revId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Version ID for the Editor chart.

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
**Type**: string

Type of the entry. For charts takes value: widget

_Const:_{.json-schema-reset .json-schema-value} `widget`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_tenantId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Tenant ID.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

For Table Editor charts takes value: table_node

_Const:_{.json-schema-reset .json-schema-value} `table_node`

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

_version_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: number

Editor version.

_Const:_{.json-schema-reset .json-schema-value} `1`
{.table-cell}
||
||

_workbookId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Any of 3 types**" %}{.json-schema-combinators data-marker=or}

- **Type**: null

  _Example:_{.json-schema-reset .json-schema-example} `null`

- **Type**: string

  _Example:_{.json-schema-reset .json-schema-example} `example`

- **Type**: null

  _Example:_{.json-schema-reset .json-schema-example} `null`

{% endcut %}

ID of the workbook the Editor chart belongs to.

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
||

_annotation_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: object &#124; null

Annotation information.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "description": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_links_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: object &#124; null

Link information.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "version": 1,
  "entryId": "example",
  "key": null,
  "createdAt": "example",
  "createdBy": "example",
  "updatedAt": "example",
  "updatedBy": "example",
  "revId": "example",
  "savedId": "example",
  "publishedId": "example",
  "tenantId": "example",
  "hidden": true,
  "public": true,
  "workbookId": null,
  "scope": "widget",
  "meta": {},
  "links": {},
  "annotation": {
    "description": "example"
  },
  "type": "table_node",
  "data": {
    "meta": "example",
    "params": "example",
    "sources": "example",
    "controls": "example",
    "prepare": "example",
    "config": "example"
  }
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### EditorGravityChartsNode {#entity-EditorGravityChartsNode}

#|
|| **Name** | **Description** ||
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

_data_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_config_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Configuration from the Config tab.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_controls_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Configuration from the Controls tab.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_meta_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Configuration from the Meta tab.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_params_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Configuration from the Params tab.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_prepare_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Configuration from the Prepare tab.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_sources_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Configuration from the Sources tab.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "meta": "example",
  "params": "example",
  "sources": "example",
  "controls": "example",
  "prepare": "example",
  "config": "example"
}
```

{% endcut %}
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

_key_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Any of 3 types**" %}{.json-schema-combinators data-marker=or}

- **Type**: null

  _Example:_{.json-schema-reset .json-schema-example} `null`

- **Type**: string

  _Example:_{.json-schema-reset .json-schema-example} `example`

- **Type**: null

  _Example:_{.json-schema-reset .json-schema-example} `null`

{% endcut %}

Key identifier of the entry.

_Example:_{.json-schema-reset .json-schema-example} `null`
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

_public_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: boolean

Indicates if the entry is public.
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

_revId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Version ID for the Editor chart.

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
**Type**: string

Type of the entry. For charts takes value: widget

_Const:_{.json-schema-reset .json-schema-value} `widget`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_tenantId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Tenant ID.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

For D3 Editor charts takes value: d3_node

_Const:_{.json-schema-reset .json-schema-value} `d3_node`

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

_version_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: number

Editor version.

_Const:_{.json-schema-reset .json-schema-value} `1`
{.table-cell}
||
||

_workbookId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Any of 3 types**" %}{.json-schema-combinators data-marker=or}

- **Type**: null

  _Example:_{.json-schema-reset .json-schema-example} `null`

- **Type**: string

  _Example:_{.json-schema-reset .json-schema-example} `example`

- **Type**: null

  _Example:_{.json-schema-reset .json-schema-example} `null`

{% endcut %}

ID of the workbook the Editor chart belongs to.

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
||

_annotation_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: object &#124; null

Annotation information.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "description": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_links_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: object &#124; null

Link information.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "version": 1,
  "entryId": "example",
  "key": null,
  "createdAt": "example",
  "createdBy": "example",
  "updatedAt": "example",
  "updatedBy": "example",
  "revId": "example",
  "savedId": "example",
  "publishedId": "example",
  "tenantId": "example",
  "hidden": true,
  "public": true,
  "workbookId": null,
  "scope": "widget",
  "meta": {},
  "links": {},
  "annotation": {
    "description": "example"
  },
  "type": "d3_node",
  "data": {
    "meta": "example",
    "params": "example",
    "sources": "example",
    "controls": "example",
    "prepare": "example",
    "config": "example"
  }
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### EditorMarkdownNode {#entity-EditorMarkdownNode}

#|
|| **Name** | **Description** ||
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

_data_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_controls_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Configuration from the Controls tab.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_meta_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Configuration from the Meta tab.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_params_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Configuration from the Params tab.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_prepare_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Configuration from the Prepare tab.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_sources_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Configuration from the Sources tab.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "meta": "example",
  "params": "example",
  "sources": "example",
  "controls": "example",
  "prepare": "example"
}
```

{% endcut %}
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

_key_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Any of 3 types**" %}{.json-schema-combinators data-marker=or}

- **Type**: null

  _Example:_{.json-schema-reset .json-schema-example} `null`

- **Type**: string

  _Example:_{.json-schema-reset .json-schema-example} `example`

- **Type**: null

  _Example:_{.json-schema-reset .json-schema-example} `null`

{% endcut %}

Key identifier of the entry.

_Example:_{.json-schema-reset .json-schema-example} `null`
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

_public_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: boolean

Indicates if the entry is public.
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

_revId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Version ID for the Editor chart.

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
**Type**: string

Type of the entry. For charts takes value: widget

_Const:_{.json-schema-reset .json-schema-value} `widget`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_tenantId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Tenant ID.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

For Markdown Editor charts takes value: markdown_node

_Const:_{.json-schema-reset .json-schema-value} `markdown_node`

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

_version_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: number

Editor version.

_Const:_{.json-schema-reset .json-schema-value} `1`
{.table-cell}
||
||

_workbookId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Any of 3 types**" %}{.json-schema-combinators data-marker=or}

- **Type**: null

  _Example:_{.json-schema-reset .json-schema-example} `null`

- **Type**: string

  _Example:_{.json-schema-reset .json-schema-example} `example`

- **Type**: null

  _Example:_{.json-schema-reset .json-schema-example} `null`

{% endcut %}

ID of the workbook the Editor chart belongs to.

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
||

_annotation_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: object &#124; null

Annotation information.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "description": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_links_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: object &#124; null

Link information.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "version": 1,
  "entryId": "example",
  "key": null,
  "createdAt": "example",
  "createdBy": "example",
  "updatedAt": "example",
  "updatedBy": "example",
  "revId": "example",
  "savedId": "example",
  "publishedId": "example",
  "tenantId": "example",
  "hidden": true,
  "public": true,
  "workbookId": null,
  "scope": "widget",
  "meta": {},
  "links": {},
  "annotation": {
    "description": "example"
  },
  "type": "markdown_node",
  "data": {
    "meta": "example",
    "params": "example",
    "sources": "example",
    "controls": "example",
    "prepare": "example"
  }
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### EditorAdvancedChartNode {#entity-EditorAdvancedChartNode}

#|
|| **Name** | **Description** ||
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

_data_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_controls_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Configuration from the Controls tab.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_meta_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Configuration from the Meta tab.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_params_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Configuration from the Params tab.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_prepare_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Configuration from the Prepare tab.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_sources_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Configuration from the Sources tab.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "meta": "example",
  "params": "example",
  "sources": "example",
  "controls": "example",
  "prepare": "example"
}
```

{% endcut %}
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

_key_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Any of 3 types**" %}{.json-schema-combinators data-marker=or}

- **Type**: null

  _Example:_{.json-schema-reset .json-schema-example} `null`

- **Type**: string

  _Example:_{.json-schema-reset .json-schema-example} `example`

- **Type**: null

  _Example:_{.json-schema-reset .json-schema-example} `null`

{% endcut %}

Key identifier of the entry.

_Example:_{.json-schema-reset .json-schema-example} `null`
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

_public_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: boolean

Indicates if the entry is public.
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

_revId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Version ID for the Editor chart.

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
**Type**: string

Type of the entry. For charts takes value: widget

_Const:_{.json-schema-reset .json-schema-value} `widget`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_tenantId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Tenant ID.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

For Advanced Editor charts takes value: advanced-chart_node

_Const:_{.json-schema-reset .json-schema-value} `advanced-chart_node`

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

_version_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: number

Editor version.

_Const:_{.json-schema-reset .json-schema-value} `1`
{.table-cell}
||
||

_workbookId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Any of 3 types**" %}{.json-schema-combinators data-marker=or}

- **Type**: null

  _Example:_{.json-schema-reset .json-schema-example} `null`

- **Type**: string

  _Example:_{.json-schema-reset .json-schema-example} `example`

- **Type**: null

  _Example:_{.json-schema-reset .json-schema-example} `null`

{% endcut %}

ID of the workbook the Editor chart belongs to.

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
||

_annotation_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: object &#124; null

Annotation information.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "description": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_links_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: object &#124; null

Link information.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "version": 1,
  "entryId": "example",
  "key": null,
  "createdAt": "example",
  "createdBy": "example",
  "updatedAt": "example",
  "updatedBy": "example",
  "revId": "example",
  "savedId": "example",
  "publishedId": "example",
  "tenantId": "example",
  "hidden": true,
  "public": true,
  "workbookId": null,
  "scope": "widget",
  "meta": {},
  "links": {},
  "annotation": {
    "description": "example"
  },
  "type": "advanced-chart_node",
  "data": {
    "meta": "example",
    "params": "example",
    "sources": "example",
    "controls": "example",
    "prepare": "example"
  }
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### EditorSelectorNode {#entity-EditorSelectorNode}

#|
|| **Name** | **Description** ||
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

_data_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_controls_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Configuration from the Controls tab.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_meta_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Configuration from the Meta tab.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_params_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Configuration from the Params tab.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_sources_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Configuration from the Sources tab.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "meta": "example",
  "params": "example",
  "sources": "example",
  "controls": "example"
}
```

{% endcut %}
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

_key_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Any of 3 types**" %}{.json-schema-combinators data-marker=or}

- **Type**: null

  _Example:_{.json-schema-reset .json-schema-example} `null`

- **Type**: string

  _Example:_{.json-schema-reset .json-schema-example} `example`

- **Type**: null

  _Example:_{.json-schema-reset .json-schema-example} `null`

{% endcut %}

Key identifier of the entry.

_Example:_{.json-schema-reset .json-schema-example} `null`
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

_public_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: boolean

Indicates if the entry is public.
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

_revId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Version ID for the Editor chart.

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
**Type**: string

Type of the entry. For charts takes value: widget

_Const:_{.json-schema-reset .json-schema-value} `widget`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_tenantId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Tenant ID.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

For Editor JS selectors takes value: control_node

_Const:_{.json-schema-reset .json-schema-value} `control_node`

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

_version_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: number

Editor version.

_Const:_{.json-schema-reset .json-schema-value} `1`
{.table-cell}
||
||

_workbookId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Any of 3 types**" %}{.json-schema-combinators data-marker=or}

- **Type**: null

  _Example:_{.json-schema-reset .json-schema-example} `null`

- **Type**: string

  _Example:_{.json-schema-reset .json-schema-example} `example`

- **Type**: null

  _Example:_{.json-schema-reset .json-schema-example} `null`

{% endcut %}

ID of the workbook the Editor chart belongs to.

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
||

_annotation_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: object &#124; null

Annotation information.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "description": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_links_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: object &#124; null

Link information.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "version": 1,
  "entryId": "example",
  "key": null,
  "createdAt": "example",
  "createdBy": "example",
  "updatedAt": "example",
  "updatedBy": "example",
  "revId": "example",
  "savedId": "example",
  "publishedId": "example",
  "tenantId": "example",
  "hidden": true,
  "public": true,
  "workbookId": null,
  "scope": "widget",
  "meta": {},
  "links": {},
  "annotation": {
    "description": "example"
  },
  "type": "control_node",
  "data": {
    "meta": "example",
    "params": "example",
    "sources": "example",
    "controls": "example"
  }
}
```

{% endcut %}

</div>

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.