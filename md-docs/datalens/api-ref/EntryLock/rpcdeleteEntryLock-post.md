[Документация Yandex Cloud](../../../index.md) > [Yandex DataLens](../../index.md) > DataLens Public API > [DataLens API (англ.)](../index.md) > [EntryLock](index.md) > Delete entry lock

<div class="openapi">

# Delete entry lock

<!-- markdownlint-disable-file -->

Deletes a lock for the specified DataLens entry.

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
https://api.datalens.tech/rpc/deleteEntryLock
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
  "params": {
    "lockToken": "example",
    "force": true
  }
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_entryId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the entry whose lock should be deleted.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_params_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_lockToken_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Token identifying the lock to delete.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_force_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

Whether to force lock deletion.
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "lockToken": "example",
  "force": true
}
```

{% endcut %}
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