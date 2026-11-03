<div class="openapi">

# List favorites

<!-- markdownlint-disable-file -->

Returns the favorite marks of the current user, newest first.

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
https://api.datalens.tech/rpc/listFavorites
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
  "entityTypes": [
    "entry"
  ],
  "pageSize": 1,
  "pageToken": "example"
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_entityTypes_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string[]

Entity types to return. All types are returned if the field is omitted.

_Min items:_{.json-schema-reset .json-schema-assertion} `1`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  "entry"
]
```

{% endcut %}
{.table-cell}
||
||

_pageSize_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer

Maximum number of favorites per page. Defaults to 200.

_Min value:_{.json-schema-reset .json-schema-assertion} `1`

_Max value:_{.json-schema-reset .json-schema-assertion} `200`
{.table-cell}
||
||

_pageToken_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Token of the page to return, taken from the previous response.

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
  "entities": [
    {
      "entityId": "example",
      "entityType": "entry",
      "displayAlias": "example",
      "createdAt": "example"
    }
  ],
  "nextPageToken": "example"
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_entities_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: [FavoriteMark](#entity-FavoriteMark)[]

Favorite marks of the current user.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "entityId": "example",
    "entityType": "entry",
    "displayAlias": "example",
    "createdAt": "example"
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

Token of the next page. Absent on the last page.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

</div>

<div class="openapi-entity">

### FavoriteMark {#entity-FavoriteMark}

#|
|| **Name** | **Description** ||
||

_createdAt_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Date and time when the entity was marked as a favorite.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_displayAlias_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string &#124; null

Custom name the user gave to the favorite, or null if there is none.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_entityId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the entity marked as a favorite.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_entityType_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Type of the entity marked as a favorite.

_Enum:_{.json-schema-reset .json-schema-value} `entry`, `workbook`, `collection`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "entityId": "example",
  "entityType": "entry",
  "displayAlias": "example",
  "createdAt": "example"
}
```

{% endcut %}

</div>

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.