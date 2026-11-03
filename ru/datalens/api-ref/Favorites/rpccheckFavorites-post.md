<div class="openapi">

# Check favorites

<!-- markdownlint-disable-file -->

Returns, for each requested entity, whether the current user has marked it as a favorite.

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
https://api.datalens.tech/rpc/checkFavorites
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
  "entities": [
    {
      "entityId": "example",
      "entityType": "entry"
    }
  ]
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_entities_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: [FavoriteEntityRef](#entity-FavoriteEntityRef)[]

Entities to check.

_Max items:_{.json-schema-reset .json-schema-assertion} `1000`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "entityId": "example",
    "entityType": "entry"
  }
]
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

</div>

<div class="openapi-entity">

### FavoriteEntityRef {#entity-FavoriteEntityRef}

#|
|| **Name** | **Description** ||
||

_entityId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the entity.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_entityType_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Type of the entity.

_Enum:_{.json-schema-reset .json-schema-value} `entry`, `workbook`, `collection`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "entityId": "example",
  "entityType": "entry"
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
[
  {
    "entityId": "example",
    "entityType": "entry",
    "isFavorite": true,
    "displayAlias": "example"
  }
]
```

{% endcut %}

**Type**: [CheckedFavorite](#entity-CheckedFavorite)[]

</div>

<div class="openapi-entity">

### CheckedFavorite {#entity-CheckedFavorite}

#|
|| **Name** | **Description** ||
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

ID of the entity.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_entityType_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Type of the entity.

_Enum:_{.json-schema-reset .json-schema-value} `entry`, `workbook`, `collection`
{.table-cell}
||
||

_isFavorite_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: boolean

Whether the current user has marked the entity as a favorite.
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "entityId": "example",
  "entityType": "entry",
  "isFavorite": true,
  "displayAlias": "example"
}
```

{% endcut %}

</div>

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.