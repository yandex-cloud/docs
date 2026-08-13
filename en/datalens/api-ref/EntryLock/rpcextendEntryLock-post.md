<div class="openapi">

# Extend entry lock

<!-- markdownlint-disable-file -->

Extends a lock for the specified DataLens entry.

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
https://api.datalens.tech/rpc/extendEntryLock
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
  "data": {
    "lockToken": "example",
    "duration": 0.5,
    "force": true
  }
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_data_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_duration_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: number

New lock duration in milliseconds.
{.table-cell}
||
||

_lockToken_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Token identifying the lock to extend.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_force_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

Whether to force lock extension.
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "lockToken": "example",
  "duration": 0.5,
  "force": true
}
```

{% endcut %}
{.table-cell}
||
||

_entryId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the entry whose lock should be extended.

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
  "lockId": "example",
  "lockToken": "example",
  "expiryDate": "example",
  "login": "example"
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_entryId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the locked entry.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_expiryDate_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Expiration date and time of the lock.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_lockId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Unique identifier of the lock.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_lockToken_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Token identifying the lock.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_login_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Login of the user who owns the lock.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

</div>

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.