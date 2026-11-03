[Документация Yandex Cloud](../../../index.md) > [Yandex DataLens](../../index.md) > DataLens Public API > [DataLens API (англ.)](../index.md) > [Entries](index.md) > Get entry revisions

<div class="openapi">

# Get entry revisions

<!-- markdownlint-disable-file -->

Returns revisions of the specified DataLens entry.

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
https://api.datalens.tech/rpc/getRevisions
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

_Const:_{.json-schema-reset .json-schema-value} `3`

_Example:_{.json-schema-reset .json-schema-example} `3`
{.table-cell}
||
|#{.json-schema-properties}

<div class="openapi-entity">

### Body

{% cut "application/json" %}

```json translate=no
{
  "entryId": "example",
  "pageSize": 1000,
  "pageToken": "example",
  "revIds": [
    "example"
  ]
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_entryId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Unique identifier of the DataLens entry.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_pageSize_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer

Number of revisions per page.

_Default:_{.json-schema-reset .json-schema-value} `1000`

_Min value:_{.json-schema-reset .json-schema-assertion} `1`

_Max value:_{.json-schema-reset .json-schema-assertion} `1000`
{.table-cell}
||
||

_pageToken_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Token for retrieving the next page of revisions.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_revIds_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string[]

IDs of revisions to return.

_Min items:_{.json-schema-reset .json-schema-assertion} `1`

_Max items:_{.json-schema-reset .json-schema-assertion} `1000`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  "example"
]
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
  "entries": [
    {
      "revId": "example",
      "updatedAt": "example",
      "updatedBy": "example",
      "isSaved": true,
      "isPublished": true
    }
  ],
  "nextPageToken": "example"
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_entries_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object[]" %}

#|
||

_isPublished_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: boolean

Whether this is the published revision.
{.table-cell}
||
||

_isSaved_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: boolean

Whether this is the latest saved revision.
{.table-cell}
||
||

_revId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Unique identifier of the revision.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_updatedAt_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Date and time when the revision was last updated.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_updatedBy_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the user who last updated the revision.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "revId": "example",
    "updatedAt": "example",
    "updatedBy": "example",
    "isSaved": true,
    "isPublished": true
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

Token for retrieving the next page of revisions.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

</div>

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.