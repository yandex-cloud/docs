[Документация Yandex Cloud](../../../index.md) > [Yandex DataLens](../../index.md) > DataLens Public API > [DataLens API (англ.)](../index.md) > [HtmlPages](index.md) > Get HTML page

<div class="openapi">

# Get HTML page

<!-- markdownlint-disable-file -->

Returns the specified HTML page.

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
https://api.datalens.tech/rpc/getHtmlPage
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
  "entryId": "example",
  "revId": "example",
  "branch": "saved",
  "includePermissions": true,
  "includeFavorite": true
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_entryId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the HTML page to retrieve.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_branch_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

HTML page branch to retrieve.

_Enum:_{.json-schema-reset .json-schema-value} `saved`, `published`
{.table-cell}
||
||

_includeFavorite_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

Whether to include the favorite status.
{.table-cell}
||
||

_includePermissions_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

Whether to include HTML page permissions.
{.table-cell}
||
||

_revId_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

ID of the HTML page revision to retrieve.

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
  "entryId": "example",
  "scope": "artifact",
  "type": "html-page",
  "key": "example",
  "workbookId": "example",
  "collectionId": "example",
  "revId": "example",
  "savedId": "example",
  "publishedId": "example",
  "data": {},
  "meta": {
    "objectId": "example",
    "policyVersion": 0.5
  },
  "annotation": {
    "description": "example"
  },
  "createdBy": "example",
  "createdAt": "example",
  "updatedBy": "example",
  "updatedAt": "example",
  "revUpdatedBy": "example",
  "revUpdatedAt": "example",
  "tenantId": "example",
  "hidden": true,
  "version": 1,
  "public": true,
  "links": {},
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

_annotation_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: object &#124; null

Annotation of the HTML page.

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

_collectionId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string &#124; null

ID of the collection containing the HTML page.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_createdAt_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Date and time when the HTML page was created.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_createdBy_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the user who created the HTML page.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_data_{.json-schema-reset .json-schema-property .json-schema-required}
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

Versioned data of the HTML page entry.

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

Unique identifier of the HTML page.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_hidden_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: boolean

Whether the HTML page is hidden.
{.table-cell}
||
||

_key_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Key of the HTML page entry.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_meta_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_objectId_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

ID of the object containing the HTML content.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_policyVersion_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: number

Version of the security policy injected into the HTML content.
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Metadata of the HTML page.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "objectId": "example",
  "policyVersion": 0.5
}
```

{% endcut %}
{.table-cell}
||
||

_public_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: boolean

Whether the HTML page is public.
{.table-cell}
||
||

_publishedId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string &#124; null

ID of the published HTML page revision.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_revId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the current HTML page revision.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_savedId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the saved HTML page revision.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_scope_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Scope of the HTML page entry.

_Const:_{.json-schema-reset .json-schema-value} `artifact`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_tenantId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the tenant that owns the HTML page.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Type of the HTML page entry.

_Const:_{.json-schema-reset .json-schema-value} `html-page`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_updatedAt_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Date and time when the HTML page was last updated.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_updatedBy_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the user who last updated the HTML page.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_version_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: number

Schema version of the HTML page.

_Const:_{.json-schema-reset .json-schema-value} `1`
{.table-cell}
||
||

_workbookId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string &#124; null

ID of the workbook containing the HTML page.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_isFavorite_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

Whether the HTML page is a favorite.
{.table-cell}
||
||

_links_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: object &#124; null

Links associated with the HTML page.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
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

Permissions for the HTML page.

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

_revUpdatedAt_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Date and time when the current revision was last updated.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_revUpdatedBy_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

ID of the user who last updated the current revision.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

</div>

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.