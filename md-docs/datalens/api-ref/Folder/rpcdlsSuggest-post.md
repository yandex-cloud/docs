[Документация Yandex Cloud](../../../index.md) > [Yandex DataLens](../../index.md) > DataLens Public API > [DataLens API (англ.)](../index.md) > [Folder](index.md) > DLS suggest

<div class="openapi">

# DLS suggest

<!-- markdownlint-disable-file -->

Returns suggested DLS subjects.

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
https://api.datalens.tech/rpc/dlsSuggest
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
  "searchText": "example"
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_searchText_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Text to search for permission subjects.

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
[
  {
    "cloud_icon": "example",
    "cloud_icon_data": "example",
    "cloud_user_id": "example",
    "icon": "example",
    "link": "example",
    "name": "example",
    "title": "example",
    "type": "user",
    "parent": {
      "link": "example",
      "title": "example"
    },
    "__rlsid": "example",
    "__source": "example"
  }
]
```

{% endcut %}

**Type**: [DlsPermissionUnit](#entity-DlsPermissionUnit)[]

</div>

<div class="openapi-entity">

### DlsPermissionUnit {#entity-DlsPermissionUnit}

#|
|| **Name** | **Description** ||
||

_rlsid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Row-level security identifier.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_source_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Source system identifier.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_cloud_icon_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Cloud icon URL for the subject.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_cloud_icon_data_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Cloud icon raw data for the subject.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_cloud_user_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Cloud platform user ID.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_icon_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Icon URL for the subject.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_link_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Profile link for the subject.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Subject id.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_parent_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_link_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Link to the parent group.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Display title of the parent group.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Parent group information.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "link": "example",
  "title": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Display title for the subject.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Subject type.

_Enum:_{.json-schema-reset .json-schema-value} `user`, `user-staff`, `user-system`, `group-system`, `group-staff-servicerole`, `group-staff-service`, `group-staff-wiki`, `group-staff-department`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "cloud_icon": "example",
  "cloud_icon_data": "example",
  "cloud_user_id": "example",
  "icon": "example",
  "link": "example",
  "name": "example",
  "title": "example",
  "type": "user",
  "parent": {
    "link": "example",
    "title": "example"
  },
  "__rlsid": "example",
  "__source": "example"
}
```

{% endcut %}

</div>

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.