<div class="openapi">

# CreateFolder

<!-- markdownlint-disable-file -->

Creates a new folder.

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
https://api.datalens.tech/rpc/createFolder
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
  "key": "example",
  "initialPermissions": {
    "acl_adm": [
      {
        "comment": "example",
        "subject": "example"
      }
    ],
    "acl_edit": [
      null
    ],
    "acl_view": [
      null
    ],
    "acl_execute": [
      null
    ]
  }
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_key_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Key of the folder to create.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_initialPermissions_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_acl_adm_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [DlsInitialPermissionItem](#entity-DlsInitialPermissionItem)[]

Initial admin permissions.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "comment": "example",
    "subject": "example"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_acl_edit_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [DlsInitialPermissionItem](#entity-DlsInitialPermissionItem)[]

Initial edit permissions.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "comment": "example",
    "subject": "example"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_acl_execute_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [DlsInitialPermissionItem](#entity-DlsInitialPermissionItem)[]

Initial execute permissions.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "comment": "example",
    "subject": "example"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_acl_view_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [DlsInitialPermissionItem](#entity-DlsInitialPermissionItem)[]

Initial view permissions.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "comment": "example",
    "subject": "example"
  }
]
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Initial permissions for the folder.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "acl_adm": [
    {
      "comment": "example",
      "subject": "example"
    }
  ],
  "acl_edit": [
    null
  ],
  "acl_view": [
    null
  ],
  "acl_execute": [
    null
  ]
}
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

</div>

<div class="openapi-entity">

### DlsInitialPermissionItem {#entity-DlsInitialPermissionItem}

#|
|| **Name** | **Description** ||
||

_comment_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Comment describing the reason for this initial permission.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_subject_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Subject identifier.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "comment": "example",
  "subject": "example"
}
```

{% endcut %}

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
  "entryId": "example",
  "scope": "folder",
  "type": "",
  "key": "example",
  "unversionedData": {},
  "createdBy": "example",
  "createdAt": "example",
  "updatedBy": "example",
  "updatedAt": "example",
  "savedId": "example",
  "revId": "example",
  "publishedId": "example",
  "tenantId": "example",
  "data": {},
  "meta": {},
  "annotation": null,
  "hidden": true,
  "mirrored": true,
  "public": true,
  "workbookId": null,
  "collectionId": null,
  "version": null,
  "sourceVersion": null,
  "links": null
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_annotation_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: null

Annotation of the folder.

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
||

_collectionId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: null

Collection ID associated with the folder.

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
||

_createdAt_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Date and time when the folder was created.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_createdBy_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the user who created the folder.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_data_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object" %}

#|
|#{.json-schema-properties}

{% endcut %}

Versioned data of the folder.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
||

_entryId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Unique identifier of the created folder.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_hidden_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: boolean

Whether the folder is hidden.
{.table-cell}
||
||

_key_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Key of the created folder.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_links_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: null

Links associated with the folder.

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
||

_meta_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object" %}

#|
|#{.json-schema-properties}

{% endcut %}

Metadata of the folder.

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
**Type**: boolean

Whether the folder is mirrored.
{.table-cell}
||
||

_public_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: boolean

Whether the folder is public.
{.table-cell}
||
||

_publishedId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string &#124; null

ID of the published folder revision.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_revId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the current folder revision.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_savedId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the saved folder revision.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_scope_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Scope of the created entry.

_Const:_{.json-schema-reset .json-schema-value} `folder`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_sourceVersion_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: null

Source folder schema version.

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
||

_tenantId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the tenant that owns the folder.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Type of the created folder entry.

_Const:_{.json-schema-reset .json-schema-value} ``

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_unversionedData_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object" %}

#|
|#{.json-schema-properties}

{% endcut %}

Unversioned data of the folder.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
||

_updatedAt_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Date and time when the folder was last updated.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_updatedBy_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the user who last updated the folder.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_version_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: null

Folder schema version.

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
||

_workbookId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: null

Workbook ID associated with the folder.

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

</div>

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.