[Документация Yandex Cloud](../../../index.md) > [Yandex DataLens](../../index.md) > DataLens Public API > [DataLens API (англ.)](../index.md) > [Audit](index.md) > Get entry permissions for user

<div class="openapi">

# Get entry permissions for user

<!-- markdownlint-disable-file -->

Returns entry permissions for the specified user.

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
https://api.datalens.tech/rpc/getAuditEntryPermissionsForUser
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
  "userId": "example"
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_entryIds_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string[]

IDs of the entries to check permissions for.

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

_userId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the user whose permissions should be returned.

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
{}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_[additional]_{.json-schema-reset .json-schema-additional-property}
{.table-cell}|
{% cut "**Any of 2 types**" %}{.json-schema-combinators data-marker=or}

- **Type**: object

  #|
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

  Permissions granted to the user for the entry.

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

  Error code indicating a missing entry.

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
  }
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