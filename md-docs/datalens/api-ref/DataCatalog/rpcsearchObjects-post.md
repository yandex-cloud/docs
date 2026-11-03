[Документация Yandex Cloud](../../../index.md) > [Yandex DataLens](../../index.md) > DataLens Public API > [DataLens API (англ.)](../index.md) > [DataCatalog](index.md) > 🚧 [Experimental] Search objects

<div class="openapi">

# 🚧 [Experimental] Search objects

<!-- markdownlint-disable-file -->

Searches objects by name and type.

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
https://api.datalens.tech/rpc/searchObjects
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
  "query": "example",
  "objectType": "rest-catalog",
  "pageSize": 1,
  "pageToken": "example"
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_query_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Object name to search for.

_Min length:_{.json-schema-reset .json-schema-assertion} `1`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_objectType_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Object type to search for.

_Enum:_{.json-schema-reset .json-schema-value} `rest-catalog`, `rest-catalog-namespace`, `rest-catalog-table`, `connection`, `cluster`, `pipeline`, `transfer`, `dataset`, `chart`, `workbook`, `collection`, `dashboard`, `report`
{.table-cell}
||
||

_pageSize_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer

Maximum number of results.

_Min value:_{.json-schema-reset .json-schema-assertion} `1`

_Max value:_{.json-schema-reset .json-schema-assertion} `100`
{.table-cell}
||
||

_pageToken_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

nextPageToken from the previous response.

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
  "results": [
    {
      "childrenCount": "example",
      "detailedObject": "asset",
      "asset": {}
    }
  ],
  "nextPageToken": "example",
  "searchId": "example"
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_nextPageToken_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_results_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: [DataCatalogDetailedSearchResult](#entity-DataCatalogDetailedSearchResult)[]

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "childrenCount": "example",
    "detailedObject": "asset",
    "asset": {
      "datacatalogId": "example",
      "name": "example",
      "createdAt": {},
      "updatedAt": null,
      "urn": "example",
      "description": "example",
      "documetation": "example",
      "tags": [
        null
      ],
      "termins": [
        null
      ],
      "domain": null,
      "service": "example",
      "isDocumentationAiGenerated": true,
      "parent": {},
      "path": [
        null
      ],
      "type": {},
      "payload": "example",
      "majorVersion": "example",
      "minorVersion": "example",
      "ingestionIds": [
        null
      ],
      "ingestionSourceIds": [
        null
      ],
      "lastIngestionAt": null,
      "subTypes": [
        null
      ],
      "assetTypeSpecificInfo": "query",
      "query": {}
    }
  }
]
```

{% endcut %}
{.table-cell}
||
||

_searchId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

</div>

<div class="openapi-entity">

### Timestamp {#entity-Timestamp}

**Type**: object | null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "seconds": "example",
  "nanos": 0.5
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### DataCatalogLinkedTag {#entity-DataCatalogLinkedTag}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_isAiLinked_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: boolean
{.table-cell}
||
||

_isDspm_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: boolean
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "id": "example",
  "name": "example",
  "isAiLinked": true,
  "isDspm": true
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### DataCatalogLinkedEntity {#entity-DataCatalogLinkedEntity}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_isAiLinked_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: boolean
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "id": "example",
  "name": "example",
  "isAiLinked": true
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### DataCatalogAssetKey {#entity-DataCatalogAssetKey}

**Type**: object | null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "urn": "example",
  "name": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### DataCatalogAssetType {#entity-DataCatalogAssetType}

**Type**: object | null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "type": "example",
  "name": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### DataCatalogAssetConsoleView {#entity-DataCatalogAssetConsoleView}

{% cut "**Any of 2 types**" %}{.json-schema-combinators data-marker=or}

- {% cut "**Type**: object" %}

  #|
  ||

  _assetTypeSpecificInfo_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  _Const:_{.json-schema-reset .json-schema-value} `query`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _createdAt_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: [Timestamp](#entity-Timestamp)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "seconds": "example",
    "nanos": 0.5
  }
  ```

  {% endcut %}
  {.table-cell}
  ||
  ||

  _datacatalogId_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _description_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _documetation_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Object documentation; field name follows Data Catalog API.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _domain_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  {% cut "**All of 2 types**" %}{.json-schema-combinators data-marker=and}

  - **Type**: [DataCatalogLinkedEntity](#entity-DataCatalogLinkedEntity)

    {% cut "**Example**" %}{.json-schema-example}

    ```json translate=no
    {
      "id": "example",
      "name": "example",
      "isAiLinked": true
    }
    ```

    {% endcut %}

  - **Type**: object &#124; null

    {% cut "**Example**" %}{.json-schema-example}

    ```json translate=no
    {}
    ```

    {% endcut %}

  {% endcut %}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "id": "example",
    "name": "example",
    "isAiLinked": true
  }
  ```

  {% endcut %}
  {.table-cell}
  ||
  ||

  _ingestionIds_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string[]

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

  _ingestionSourceIds_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string[]

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

  _isDocumentationAiGenerated_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: boolean
  {.table-cell}
  ||
  ||

  _lastIngestionAt_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: [Timestamp](#entity-Timestamp)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "seconds": "example",
    "nanos": 0.5
  }
  ```

  {% endcut %}
  {.table-cell}
  ||
  ||

  _majorVersion_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _minorVersion_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _name_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _parent_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: [DataCatalogAssetKey](#entity-DataCatalogAssetKey)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "urn": "example",
    "name": "example"
  }
  ```

  {% endcut %}
  {.table-cell}
  ||
  ||

  _path_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  {% cut "**Type**: array" %}

  {% cut "**All of 2 types**" %}{.json-schema-combinators data-marker=and}

  - **Type**: [DataCatalogAssetKey](#entity-DataCatalogAssetKey)

    {% cut "**Example**" %}{.json-schema-example}

    ```json translate=no
    {
      "urn": "example",
      "name": "example"
    }
    ```

    {% endcut %}

  - **Type**: object

    {% cut "**Example**" %}{.json-schema-example}

    ```json translate=no
    {}
    ```

    {% endcut %}

  {% endcut %}

  {% endcut %}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  [
    {
      "urn": "example",
      "name": "example"
    }
  ]
  ```

  {% endcut %}
  {.table-cell}
  ||
  ||

  _payload_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Service-specific object payload, as returned by Data Catalog.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _query_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  {% cut "**Type**: object" %}

  #|
  ||

  _isPublished_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: boolean
  {.table-cell}
  ||
  ||

  _language_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _text_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "text": "example",
    "language": "example",
    "isPublished": true
  }
  ```

  {% endcut %}
  {.table-cell}
  ||
  ||

  _service_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _subTypes_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  {% cut "**Type**: array" %}

  {% cut "**All of 2 types**" %}{.json-schema-combinators data-marker=and}

  - **Type**: [DataCatalogAssetType](#entity-DataCatalogAssetType)

    {% cut "**Example**" %}{.json-schema-example}

    ```json translate=no
    {
      "type": "example",
      "name": "example"
    }
    ```

    {% endcut %}

  - **Type**: object

    {% cut "**Example**" %}{.json-schema-example}

    ```json translate=no
    {}
    ```

    {% endcut %}

  {% endcut %}

  {% endcut %}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  [
    {
      "type": "example",
      "name": "example"
    }
  ]
  ```

  {% endcut %}
  {.table-cell}
  ||
  ||

  _tags_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: [DataCatalogLinkedTag](#entity-DataCatalogLinkedTag)[]

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  [
    {
      "id": "example",
      "name": "example",
      "isAiLinked": true,
      "isDspm": true
    }
  ]
  ```

  {% endcut %}
  {.table-cell}
  ||
  ||

  _termins_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: [DataCatalogLinkedEntity](#entity-DataCatalogLinkedEntity)[]

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  [
    {
      "id": "example",
      "name": "example",
      "isAiLinked": true
    }
  ]
  ```

  {% endcut %}
  {.table-cell}
  ||
  ||

  _type_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: [DataCatalogAssetType](#entity-DataCatalogAssetType)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "type": "example",
    "name": "example"
  }
  ```

  {% endcut %}
  {.table-cell}
  ||
  ||

  _updatedAt_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: [Timestamp](#entity-Timestamp)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "seconds": "example",
    "nanos": 0.5
  }
  ```

  {% endcut %}
  {.table-cell}
  ||
  ||

  _urn_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "datacatalogId": "example",
    "name": "example",
    "createdAt": {
      "seconds": "example",
      "nanos": 0.5
    },
    "updatedAt": null,
    "urn": "example",
    "description": "example",
    "documetation": "example",
    "tags": [
      {
        "id": "example",
        "name": "example",
        "isAiLinked": true,
        "isDspm": true
      }
    ],
    "termins": [
      {
        "id": "example",
        "name": "example",
        "isAiLinked": true
      }
    ],
    "domain": null,
    "service": "example",
    "isDocumentationAiGenerated": true,
    "parent": {
      "urn": "example",
      "name": "example"
    },
    "path": [
      null
    ],
    "type": {
      "type": "example",
      "name": "example"
    },
    "payload": "example",
    "majorVersion": "example",
    "minorVersion": "example",
    "ingestionIds": [
      "example"
    ],
    "ingestionSourceIds": [
      "example"
    ],
    "lastIngestionAt": null,
    "subTypes": [
      null
    ],
    "assetTypeSpecificInfo": "query",
    "query": {
      "text": "example",
      "language": "example",
      "isPublished": true
    }
  }
  ```

  {% endcut %}

- {% cut "**Type**: object" %}

  #|
  ||

  _createdAt_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: [Timestamp](#entity-Timestamp)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "seconds": "example",
    "nanos": 0.5
  }
  ```

  {% endcut %}
  {.table-cell}
  ||
  ||

  _datacatalogId_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _description_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _documetation_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Object documentation; field name follows Data Catalog API.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _domain_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  {% cut "**All of 2 types**" %}{.json-schema-combinators data-marker=and}

  - **Type**: [DataCatalogLinkedEntity](#entity-DataCatalogLinkedEntity)

    {% cut "**Example**" %}{.json-schema-example}

    ```json translate=no
    {
      "id": "example",
      "name": "example",
      "isAiLinked": true
    }
    ```

    {% endcut %}

  - **Type**: object &#124; null

    {% cut "**Example**" %}{.json-schema-example}

    ```json translate=no
    {}
    ```

    {% endcut %}

  {% endcut %}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "id": "example",
    "name": "example",
    "isAiLinked": true
  }
  ```

  {% endcut %}
  {.table-cell}
  ||
  ||

  _ingestionIds_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string[]

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

  _ingestionSourceIds_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string[]

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

  _isDocumentationAiGenerated_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: boolean
  {.table-cell}
  ||
  ||

  _lastIngestionAt_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: [Timestamp](#entity-Timestamp)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "seconds": "example",
    "nanos": 0.5
  }
  ```

  {% endcut %}
  {.table-cell}
  ||
  ||

  _majorVersion_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _minorVersion_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _name_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _parent_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: [DataCatalogAssetKey](#entity-DataCatalogAssetKey)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "urn": "example",
    "name": "example"
  }
  ```

  {% endcut %}
  {.table-cell}
  ||
  ||

  _path_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  {% cut "**Type**: array" %}

  {% cut "**All of 2 types**" %}{.json-schema-combinators data-marker=and}

  - **Type**: [DataCatalogAssetKey](#entity-DataCatalogAssetKey)

    {% cut "**Example**" %}{.json-schema-example}

    ```json translate=no
    {
      "urn": "example",
      "name": "example"
    }
    ```

    {% endcut %}

  - **Type**: object

    {% cut "**Example**" %}{.json-schema-example}

    ```json translate=no
    {}
    ```

    {% endcut %}

  {% endcut %}

  {% endcut %}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  [
    {
      "urn": "example",
      "name": "example"
    }
  ]
  ```

  {% endcut %}
  {.table-cell}
  ||
  ||

  _payload_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Service-specific object payload, as returned by Data Catalog.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _service_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _subTypes_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  {% cut "**Type**: array" %}

  {% cut "**All of 2 types**" %}{.json-schema-combinators data-marker=and}

  - **Type**: [DataCatalogAssetType](#entity-DataCatalogAssetType)

    {% cut "**Example**" %}{.json-schema-example}

    ```json translate=no
    {
      "type": "example",
      "name": "example"
    }
    ```

    {% endcut %}

  - **Type**: object

    {% cut "**Example**" %}{.json-schema-example}

    ```json translate=no
    {}
    ```

    {% endcut %}

  {% endcut %}

  {% endcut %}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  [
    {
      "type": "example",
      "name": "example"
    }
  ]
  ```

  {% endcut %}
  {.table-cell}
  ||
  ||

  _tags_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: [DataCatalogLinkedTag](#entity-DataCatalogLinkedTag)[]

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  [
    {
      "id": "example",
      "name": "example",
      "isAiLinked": true,
      "isDspm": true
    }
  ]
  ```

  {% endcut %}
  {.table-cell}
  ||
  ||

  _termins_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: [DataCatalogLinkedEntity](#entity-DataCatalogLinkedEntity)[]

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  [
    {
      "id": "example",
      "name": "example",
      "isAiLinked": true
    }
  ]
  ```

  {% endcut %}
  {.table-cell}
  ||
  ||

  _type_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: [DataCatalogAssetType](#entity-DataCatalogAssetType)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "type": "example",
    "name": "example"
  }
  ```

  {% endcut %}
  {.table-cell}
  ||
  ||

  _updatedAt_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: [Timestamp](#entity-Timestamp)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "seconds": "example",
    "nanos": 0.5
  }
  ```

  {% endcut %}
  {.table-cell}
  ||
  ||

  _urn_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "datacatalogId": "example",
    "name": "example",
    "createdAt": {
      "seconds": "example",
      "nanos": 0.5
    },
    "updatedAt": null,
    "urn": "example",
    "description": "example",
    "documetation": "example",
    "tags": [
      {
        "id": "example",
        "name": "example",
        "isAiLinked": true,
        "isDspm": true
      }
    ],
    "termins": [
      {
        "id": "example",
        "name": "example",
        "isAiLinked": true
      }
    ],
    "domain": null,
    "service": "example",
    "isDocumentationAiGenerated": true,
    "parent": {
      "urn": "example",
      "name": "example"
    },
    "path": [
      null
    ],
    "type": {
      "type": "example",
      "name": "example"
    },
    "payload": "example",
    "majorVersion": "example",
    "minorVersion": "example",
    "ingestionIds": [
      "example"
    ],
    "ingestionSourceIds": [
      "example"
    ],
    "lastIngestionAt": null,
    "subTypes": [
      null
    ]
  }
  ```

  {% endcut %}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "datacatalogId": "example",
  "name": "example",
  "createdAt": {
    "seconds": "example",
    "nanos": 0.5
  },
  "updatedAt": null,
  "urn": "example",
  "description": "example",
  "documetation": "example",
  "tags": [
    {
      "id": "example",
      "name": "example",
      "isAiLinked": true,
      "isDspm": true
    }
  ],
  "termins": [
    {
      "id": "example",
      "name": "example",
      "isAiLinked": true
    }
  ],
  "domain": null,
  "service": "example",
  "isDocumentationAiGenerated": true,
  "parent": {
    "urn": "example",
    "name": "example"
  },
  "path": [
    null
  ],
  "type": {
    "type": "example",
    "name": "example"
  },
  "payload": "example",
  "majorVersion": "example",
  "minorVersion": "example",
  "ingestionIds": [
    "example"
  ],
  "ingestionSourceIds": [
    "example"
  ],
  "lastIngestionAt": null,
  "subTypes": [
    null
  ],
  "assetTypeSpecificInfo": "query",
  "query": {
    "text": "example",
    "language": "example",
    "isPublished": true
  }
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### DataCatalogDataStoreConsoleView {#entity-DataCatalogDataStoreConsoleView}

#|
|| **Name** | **Description** ||
||

_cluster_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Any of 4 types**" %}{.json-schema-combinators data-marker=or}

- **Type**: object

  #|
  ||

  _clusterId_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _dbType_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  _Enum:_{.json-schema-reset .json-schema-value} `DB_TYPE_UNSPECIFIED`, `DB_TYPE_MYSQL`, `DB_TYPE_CLICKHOUSE`, `DB_TYPE_POSTGRES`, `DB_TYPE_DATA_TRANSFER`, `DB_TYPE_MONGO`, `DB_TYPE_OPENSEARCH`, `DB_TYPE_GREENPLUM`, `DB_TYPE_AIRFLOW`, `DB_TYPE_TRINO`, `DB_TYPE_S3`, `DB_TYPE_ICEBERG`, `DB_TYPE_SPARK`
  {.table-cell}
  ||
  ||

  _info_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  _Const:_{.json-schema-reset .json-schema-value} `clusterId`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _installationType_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  _Enum:_{.json-schema-reset .json-schema-value} `INSTALLATION_TYPE_UNSPECIFIED`, `INSTALLATION_TYPE_MANAGED`, `INSTALLATION_TYPE_ON_PREM`
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "installationType": "INSTALLATION_TYPE_UNSPECIFIED",
    "dbType": "DB_TYPE_UNSPECIFIED",
    "info": "clusterId",
    "clusterId": "example"
  }
  ```

  {% endcut %}

- **Type**: object

  #|
  ||

  _dbType_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  _Enum:_{.json-schema-reset .json-schema-value} `DB_TYPE_UNSPECIFIED`, `DB_TYPE_MYSQL`, `DB_TYPE_CLICKHOUSE`, `DB_TYPE_POSTGRES`, `DB_TYPE_DATA_TRANSFER`, `DB_TYPE_MONGO`, `DB_TYPE_OPENSEARCH`, `DB_TYPE_GREENPLUM`, `DB_TYPE_AIRFLOW`, `DB_TYPE_TRINO`, `DB_TYPE_S3`, `DB_TYPE_ICEBERG`, `DB_TYPE_SPARK`
  {.table-cell}
  ||
  ||

  _hosts_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  {% cut "**Type**: object" %}

  #|
  ||

  _hosts_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  {% cut "**Type**: object[]" %}

  #|
  ||

  _host_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _port_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  [
    {
      "host": "example",
      "port": "example"
    }
  ]
  ```

  {% endcut %}
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "hosts": [
      {
        "host": "example",
        "port": "example"
      }
    ]
  }
  ```

  {% endcut %}
  {.table-cell}
  ||
  ||

  _info_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  _Const:_{.json-schema-reset .json-schema-value} `hosts`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _installationType_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  _Enum:_{.json-schema-reset .json-schema-value} `INSTALLATION_TYPE_UNSPECIFIED`, `INSTALLATION_TYPE_MANAGED`, `INSTALLATION_TYPE_ON_PREM`
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "installationType": "INSTALLATION_TYPE_UNSPECIFIED",
    "dbType": "DB_TYPE_UNSPECIFIED",
    "info": "hosts",
    "hosts": {
      "hosts": [
        {
          "host": "example",
          "port": "example"
        }
      ]
    }
  }
  ```

  {% endcut %}

- **Type**: object

  #|
  ||

  _dbType_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  _Enum:_{.json-schema-reset .json-schema-value} `DB_TYPE_UNSPECIFIED`, `DB_TYPE_MYSQL`, `DB_TYPE_CLICKHOUSE`, `DB_TYPE_POSTGRES`, `DB_TYPE_DATA_TRANSFER`, `DB_TYPE_MONGO`, `DB_TYPE_OPENSEARCH`, `DB_TYPE_GREENPLUM`, `DB_TYPE_AIRFLOW`, `DB_TYPE_TRINO`, `DB_TYPE_S3`, `DB_TYPE_ICEBERG`, `DB_TYPE_SPARK`
  {.table-cell}
  ||
  ||

  _installationType_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  _Enum:_{.json-schema-reset .json-schema-value} `INSTALLATION_TYPE_UNSPECIFIED`, `INSTALLATION_TYPE_MANAGED`, `INSTALLATION_TYPE_ON_PREM`
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "installationType": "INSTALLATION_TYPE_UNSPECIFIED",
    "dbType": "DB_TYPE_UNSPECIFIED"
  }
  ```

  {% endcut %}

- **Type**: null

  _Example:_{.json-schema-reset .json-schema-example} `null`

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "installationType": "INSTALLATION_TYPE_UNSPECIFIED",
  "dbType": "DB_TYPE_UNSPECIFIED",
  "info": "clusterId",
  "clusterId": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_createdAt_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: [Timestamp](#entity-Timestamp)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "seconds": "example",
  "nanos": 0.5
}
```

{% endcut %}
{.table-cell}
||
||

_datacatalogId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_domain_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**All of 2 types**" %}{.json-schema-combinators data-marker=and}

- **Type**: [DataCatalogLinkedEntity](#entity-DataCatalogLinkedEntity)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "id": "example",
    "name": "example",
    "isAiLinked": true
  }
  ```

  {% endcut %}

- **Type**: object &#124; null

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {}
  ```

  {% endcut %}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "id": "example",
  "name": "example",
  "isAiLinked": true
}
```

{% endcut %}
{.table-cell}
||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_ingestedDescription_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_ingestionCount_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_ingestionSourceCount_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_isDocumentationAiGenerated_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: boolean
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_tags_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: [DataCatalogLinkedTag](#entity-DataCatalogLinkedTag)[]

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "id": "example",
    "name": "example",
    "isAiLinked": true,
    "isDspm": true
  }
]
```

{% endcut %}
{.table-cell}
||
||

_termins_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: [DataCatalogLinkedEntity](#entity-DataCatalogLinkedEntity)[]

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "id": "example",
    "name": "example",
    "isAiLinked": true
  }
]
```

{% endcut %}
{.table-cell}
||
||

_updatedAt_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: [Timestamp](#entity-Timestamp)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "seconds": "example",
  "nanos": 0.5
}
```

{% endcut %}
{.table-cell}
||
||

_userDefinedDescription_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "datacatalogId": "example",
  "name": "example",
  "createdAt": {
    "seconds": "example",
    "nanos": 0.5
  },
  "updatedAt": null,
  "id": "example",
  "ingestedDescription": "example",
  "userDefinedDescription": "example",
  "cluster": {
    "installationType": "INSTALLATION_TYPE_UNSPECIFIED",
    "dbType": "DB_TYPE_UNSPECIFIED",
    "info": "clusterId",
    "clusterId": "example"
  },
  "ingestionSourceCount": "example",
  "ingestionCount": "example",
  "tags": [
    {
      "id": "example",
      "name": "example",
      "isAiLinked": true,
      "isDspm": true
    }
  ],
  "termins": [
    {
      "id": "example",
      "name": "example",
      "isAiLinked": true
    }
  ],
  "domain": null,
  "isDocumentationAiGenerated": true
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### DataCatalogDomainConsoleView {#entity-DataCatalogDomainConsoleView}

#|
|| **Name** | **Description** ||
||

_aiGenerated_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: boolean
{.table-cell}
||
||

_assetsCount_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_createdAt_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: [Timestamp](#entity-Timestamp)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "seconds": "example",
  "nanos": 0.5
}
```

{% endcut %}
{.table-cell}
||
||

_createdBy_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_datacatalogId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_parentDomainId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_rules_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_subdomainsCount_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_tags_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: [DataCatalogLinkedTag](#entity-DataCatalogLinkedTag)[]

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "id": "example",
    "name": "example",
    "isAiLinked": true,
    "isDspm": true
  }
]
```

{% endcut %}
{.table-cell}
||
||

_updatedAt_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: [Timestamp](#entity-Timestamp)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "seconds": "example",
  "nanos": 0.5
}
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "datacatalogId": "example",
  "name": "example",
  "createdAt": {
    "seconds": "example",
    "nanos": 0.5
  },
  "updatedAt": null,
  "id": "example",
  "description": "example",
  "createdBy": "example",
  "assetsCount": "example",
  "aiGenerated": true,
  "rules": "example",
  "parentDomainId": "example",
  "subdomainsCount": "example",
  "tags": [
    {
      "id": "example",
      "name": "example",
      "isAiLinked": true,
      "isDspm": true
    }
  ]
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### DataCatalogTagConsoleView {#entity-DataCatalogTagConsoleView}

#|
|| **Name** | **Description** ||
||

_aiGenerated_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: boolean
{.table-cell}
||
||

_assetsCount_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_classificationId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_createdAt_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: [Timestamp](#entity-Timestamp)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "seconds": "example",
  "nanos": 0.5
}
```

{% endcut %}
{.table-cell}
||
||

_createdBy_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_datacatalogId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_isDspm_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: boolean
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_rules_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_updatedAt_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: [Timestamp](#entity-Timestamp)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "seconds": "example",
  "nanos": 0.5
}
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "datacatalogId": "example",
  "name": "example",
  "createdAt": {
    "seconds": "example",
    "nanos": 0.5
  },
  "updatedAt": null,
  "id": "example",
  "description": "example",
  "createdBy": "example",
  "assetsCount": "example",
  "aiGenerated": true,
  "rules": "example",
  "classificationId": "example",
  "isDspm": true
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### DataCatalogGlossaryConsoleView {#entity-DataCatalogGlossaryConsoleView}

#|
|| **Name** | **Description** ||
||

_aiGenerated_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: boolean
{.table-cell}
||
||

_assetsCount_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_createdAt_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: [Timestamp](#entity-Timestamp)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "seconds": "example",
  "nanos": 0.5
}
```

{% endcut %}
{.table-cell}
||
||

_createdBy_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_datacatalogId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_rules_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_tags_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: [DataCatalogLinkedTag](#entity-DataCatalogLinkedTag)[]

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "id": "example",
    "name": "example",
    "isAiLinked": true,
    "isDspm": true
  }
]
```

{% endcut %}
{.table-cell}
||
||

_termsCount_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_updatedAt_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: [Timestamp](#entity-Timestamp)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "seconds": "example",
  "nanos": 0.5
}
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "datacatalogId": "example",
  "name": "example",
  "createdAt": {
    "seconds": "example",
    "nanos": 0.5
  },
  "updatedAt": null,
  "id": "example",
  "description": "example",
  "createdBy": "example",
  "assetsCount": "example",
  "aiGenerated": true,
  "rules": "example",
  "tags": [
    {
      "id": "example",
      "name": "example",
      "isAiLinked": true,
      "isDspm": true
    }
  ],
  "termsCount": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### DataCatalogClassificationConsoleView {#entity-DataCatalogClassificationConsoleView}

#|
|| **Name** | **Description** ||
||

_aiGenerated_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: boolean
{.table-cell}
||
||

_assetsCount_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_createdAt_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: [Timestamp](#entity-Timestamp)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "seconds": "example",
  "nanos": 0.5
}
```

{% endcut %}
{.table-cell}
||
||

_createdBy_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_datacatalogId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_mutualExclusion_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: boolean
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_rules_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_tagsCount_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_updatedAt_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: [Timestamp](#entity-Timestamp)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "seconds": "example",
  "nanos": 0.5
}
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "datacatalogId": "example",
  "name": "example",
  "createdAt": {
    "seconds": "example",
    "nanos": 0.5
  },
  "updatedAt": null,
  "id": "example",
  "description": "example",
  "createdBy": "example",
  "assetsCount": "example",
  "aiGenerated": true,
  "rules": "example",
  "mutualExclusion": true,
  "tagsCount": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### DataCatalogTermConsoleView {#entity-DataCatalogTermConsoleView}

#|
|| **Name** | **Description** ||
||

_aiGenerated_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: boolean
{.table-cell}
||
||

_assetsCount_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_childCount_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connectedTerms_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: [DataCatalogLinkedEntity](#entity-DataCatalogLinkedEntity)[]

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "id": "example",
    "name": "example",
    "isAiLinked": true
  }
]
```

{% endcut %}
{.table-cell}
||
||

_createdAt_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: [Timestamp](#entity-Timestamp)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "seconds": "example",
  "nanos": 0.5
}
```

{% endcut %}
{.table-cell}
||
||

_createdBy_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_datacatalogId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_glossaryId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_parentTermId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_rules_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_synonyms_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string[]

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

_tags_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: [DataCatalogLinkedTag](#entity-DataCatalogLinkedTag)[]

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "id": "example",
    "name": "example",
    "isAiLinked": true,
    "isDspm": true
  }
]
```

{% endcut %}
{.table-cell}
||
||

_updatedAt_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: [Timestamp](#entity-Timestamp)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "seconds": "example",
  "nanos": 0.5
}
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "datacatalogId": "example",
  "name": "example",
  "createdAt": {
    "seconds": "example",
    "nanos": 0.5
  },
  "updatedAt": null,
  "id": "example",
  "description": "example",
  "createdBy": "example",
  "assetsCount": "example",
  "aiGenerated": true,
  "rules": "example",
  "glossaryId": "example",
  "parentTermId": "example",
  "childCount": "example",
  "connectedTerms": [
    {
      "id": "example",
      "name": "example",
      "isAiLinked": true
    }
  ],
  "synonyms": [
    "example"
  ],
  "tags": [
    {
      "id": "example",
      "name": "example",
      "isAiLinked": true,
      "isDspm": true
    }
  ]
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### DataCatalogQueryView {#entity-DataCatalogQueryView}

#|
|| **Name** | **Description** ||
||

_createdAt_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: [Timestamp](#entity-Timestamp)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "seconds": "example",
  "nanos": 0.5
}
```

{% endcut %}
{.table-cell}
||
||

_datacatalogId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_documetation_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Object documentation; field name follows Data Catalog API.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_domain_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**All of 2 types**" %}{.json-schema-combinators data-marker=and}

- **Type**: [DataCatalogLinkedEntity](#entity-DataCatalogLinkedEntity)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "id": "example",
    "name": "example",
    "isAiLinked": true
  }
  ```

  {% endcut %}

- **Type**: object &#124; null

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {}
  ```

  {% endcut %}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "id": "example",
  "name": "example",
  "isAiLinked": true
}
```

{% endcut %}
{.table-cell}
||
||

_isDocumentationAiGenerated_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: boolean
{.table-cell}
||
||

_isNameAiGenerated_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: boolean
{.table-cell}
||
||

_isPublished_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: boolean
{.table-cell}
||
||

_language_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_service_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_statement_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_tags_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: [DataCatalogLinkedTag](#entity-DataCatalogLinkedTag)[]

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "id": "example",
    "name": "example",
    "isAiLinked": true,
    "isDspm": true
  }
]
```

{% endcut %}
{.table-cell}
||
||

_termins_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: [DataCatalogLinkedEntity](#entity-DataCatalogLinkedEntity)[]

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "id": "example",
    "name": "example",
    "isAiLinked": true
  }
]
```

{% endcut %}
{.table-cell}
||
||

_updatedAt_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: [Timestamp](#entity-Timestamp)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "seconds": "example",
  "nanos": 0.5
}
```

{% endcut %}
{.table-cell}
||
||

_urn_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "datacatalogId": "example",
  "name": "example",
  "createdAt": {
    "seconds": "example",
    "nanos": 0.5
  },
  "updatedAt": null,
  "urn": "example",
  "description": "example",
  "documetation": "example",
  "tags": [
    {
      "id": "example",
      "name": "example",
      "isAiLinked": true,
      "isDspm": true
    }
  ],
  "termins": [
    {
      "id": "example",
      "name": "example",
      "isAiLinked": true
    }
  ],
  "domain": null,
  "service": "example",
  "isDocumentationAiGenerated": true,
  "statement": "example",
  "language": "example",
  "isNameAiGenerated": true,
  "isPublished": true
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### DataCatalogDetailedSearchResult {#entity-DataCatalogDetailedSearchResult}

{% cut "**Any of 9 types**" %}{.json-schema-combinators data-marker=or}

- {% cut "**Type**: object" %}

  #|
  ||

  _asset_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: [DataCatalogAssetConsoleView](#entity-DataCatalogAssetConsoleView)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "datacatalogId": "example",
    "name": "example",
    "createdAt": {
      "seconds": "example",
      "nanos": 0.5
    },
    "updatedAt": null,
    "urn": "example",
    "description": "example",
    "documetation": "example",
    "tags": [
      {
        "id": "example",
        "name": "example",
        "isAiLinked": true,
        "isDspm": true
      }
    ],
    "termins": [
      {
        "id": "example",
        "name": "example",
        "isAiLinked": true
      }
    ],
    "domain": null,
    "service": "example",
    "isDocumentationAiGenerated": true,
    "parent": {
      "urn": "example",
      "name": "example"
    },
    "path": [
      null
    ],
    "type": {
      "type": "example",
      "name": "example"
    },
    "payload": "example",
    "majorVersion": "example",
    "minorVersion": "example",
    "ingestionIds": [
      "example"
    ],
    "ingestionSourceIds": [
      "example"
    ],
    "lastIngestionAt": null,
    "subTypes": [
      null
    ],
    "assetTypeSpecificInfo": "query",
    "query": {
      "text": "example",
      "language": "example",
      "isPublished": true
    }
  }
  ```

  {% endcut %}
  {.table-cell}
  ||
  ||

  _childrenCount_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Number of direct child resources.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _detailedObject_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  _Const:_{.json-schema-reset .json-schema-value} `asset`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "childrenCount": "example",
    "detailedObject": "asset",
    "asset": {
      "datacatalogId": "example",
      "name": "example",
      "createdAt": {
        "seconds": "example",
        "nanos": 0.5
      },
      "updatedAt": null,
      "urn": "example",
      "description": "example",
      "documetation": "example",
      "tags": [
        {
          "id": "example",
          "name": "example",
          "isAiLinked": true,
          "isDspm": true
        }
      ],
      "termins": [
        {
          "id": "example",
          "name": "example",
          "isAiLinked": true
        }
      ],
      "domain": null,
      "service": "example",
      "isDocumentationAiGenerated": true,
      "parent": {
        "urn": "example",
        "name": "example"
      },
      "path": [
        null
      ],
      "type": {
        "type": "example",
        "name": "example"
      },
      "payload": "example",
      "majorVersion": "example",
      "minorVersion": "example",
      "ingestionIds": [
        "example"
      ],
      "ingestionSourceIds": [
        "example"
      ],
      "lastIngestionAt": null,
      "subTypes": [
        null
      ],
      "assetTypeSpecificInfo": "query",
      "query": {
        "text": "example",
        "language": "example",
        "isPublished": true
      }
    }
  }
  ```

  {% endcut %}

- {% cut "**Type**: object" %}

  #|
  ||

  _childrenCount_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Number of direct child resources.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _datastore_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: [DataCatalogDataStoreConsoleView](#entity-DataCatalogDataStoreConsoleView)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "datacatalogId": "example",
    "name": "example",
    "createdAt": {
      "seconds": "example",
      "nanos": 0.5
    },
    "updatedAt": null,
    "id": "example",
    "ingestedDescription": "example",
    "userDefinedDescription": "example",
    "cluster": {
      "installationType": "INSTALLATION_TYPE_UNSPECIFIED",
      "dbType": "DB_TYPE_UNSPECIFIED",
      "info": "clusterId",
      "clusterId": "example"
    },
    "ingestionSourceCount": "example",
    "ingestionCount": "example",
    "tags": [
      {
        "id": "example",
        "name": "example",
        "isAiLinked": true,
        "isDspm": true
      }
    ],
    "termins": [
      {
        "id": "example",
        "name": "example",
        "isAiLinked": true
      }
    ],
    "domain": null,
    "isDocumentationAiGenerated": true
  }
  ```

  {% endcut %}
  {.table-cell}
  ||
  ||

  _detailedObject_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  _Const:_{.json-schema-reset .json-schema-value} `datastore`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "childrenCount": "example",
    "detailedObject": "datastore",
    "datastore": {
      "datacatalogId": "example",
      "name": "example",
      "createdAt": {
        "seconds": "example",
        "nanos": 0.5
      },
      "updatedAt": null,
      "id": "example",
      "ingestedDescription": "example",
      "userDefinedDescription": "example",
      "cluster": {
        "installationType": "INSTALLATION_TYPE_UNSPECIFIED",
        "dbType": "DB_TYPE_UNSPECIFIED",
        "info": "clusterId",
        "clusterId": "example"
      },
      "ingestionSourceCount": "example",
      "ingestionCount": "example",
      "tags": [
        {
          "id": "example",
          "name": "example",
          "isAiLinked": true,
          "isDspm": true
        }
      ],
      "termins": [
        {
          "id": "example",
          "name": "example",
          "isAiLinked": true
        }
      ],
      "domain": null,
      "isDocumentationAiGenerated": true
    }
  }
  ```

  {% endcut %}

- {% cut "**Type**: object" %}

  #|
  ||

  _childrenCount_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Number of direct child resources.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _detailedObject_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  _Const:_{.json-schema-reset .json-schema-value} `domain`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _domain_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: [DataCatalogDomainConsoleView](#entity-DataCatalogDomainConsoleView)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "datacatalogId": "example",
    "name": "example",
    "createdAt": {
      "seconds": "example",
      "nanos": 0.5
    },
    "updatedAt": null,
    "id": "example",
    "description": "example",
    "createdBy": "example",
    "assetsCount": "example",
    "aiGenerated": true,
    "rules": "example",
    "parentDomainId": "example",
    "subdomainsCount": "example",
    "tags": [
      {
        "id": "example",
        "name": "example",
        "isAiLinked": true,
        "isDspm": true
      }
    ]
  }
  ```

  {% endcut %}
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "childrenCount": "example",
    "detailedObject": "domain",
    "domain": {
      "datacatalogId": "example",
      "name": "example",
      "createdAt": {
        "seconds": "example",
        "nanos": 0.5
      },
      "updatedAt": null,
      "id": "example",
      "description": "example",
      "createdBy": "example",
      "assetsCount": "example",
      "aiGenerated": true,
      "rules": "example",
      "parentDomainId": "example",
      "subdomainsCount": "example",
      "tags": [
        {
          "id": "example",
          "name": "example",
          "isAiLinked": true,
          "isDspm": true
        }
      ]
    }
  }
  ```

  {% endcut %}

- {% cut "**Type**: object" %}

  #|
  ||

  _childrenCount_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Number of direct child resources.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _detailedObject_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  _Const:_{.json-schema-reset .json-schema-value} `tag`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _tag_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: [DataCatalogTagConsoleView](#entity-DataCatalogTagConsoleView)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "datacatalogId": "example",
    "name": "example",
    "createdAt": {
      "seconds": "example",
      "nanos": 0.5
    },
    "updatedAt": null,
    "id": "example",
    "description": "example",
    "createdBy": "example",
    "assetsCount": "example",
    "aiGenerated": true,
    "rules": "example",
    "classificationId": "example",
    "isDspm": true
  }
  ```

  {% endcut %}
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "childrenCount": "example",
    "detailedObject": "tag",
    "tag": {
      "datacatalogId": "example",
      "name": "example",
      "createdAt": {
        "seconds": "example",
        "nanos": 0.5
      },
      "updatedAt": null,
      "id": "example",
      "description": "example",
      "createdBy": "example",
      "assetsCount": "example",
      "aiGenerated": true,
      "rules": "example",
      "classificationId": "example",
      "isDspm": true
    }
  }
  ```

  {% endcut %}

- {% cut "**Type**: object" %}

  #|
  ||

  _childrenCount_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Number of direct child resources.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _detailedObject_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  _Const:_{.json-schema-reset .json-schema-value} `glossary`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _glossary_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: [DataCatalogGlossaryConsoleView](#entity-DataCatalogGlossaryConsoleView)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "datacatalogId": "example",
    "name": "example",
    "createdAt": {
      "seconds": "example",
      "nanos": 0.5
    },
    "updatedAt": null,
    "id": "example",
    "description": "example",
    "createdBy": "example",
    "assetsCount": "example",
    "aiGenerated": true,
    "rules": "example",
    "tags": [
      {
        "id": "example",
        "name": "example",
        "isAiLinked": true,
        "isDspm": true
      }
    ],
    "termsCount": "example"
  }
  ```

  {% endcut %}
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "childrenCount": "example",
    "detailedObject": "glossary",
    "glossary": {
      "datacatalogId": "example",
      "name": "example",
      "createdAt": {
        "seconds": "example",
        "nanos": 0.5
      },
      "updatedAt": null,
      "id": "example",
      "description": "example",
      "createdBy": "example",
      "assetsCount": "example",
      "aiGenerated": true,
      "rules": "example",
      "tags": [
        {
          "id": "example",
          "name": "example",
          "isAiLinked": true,
          "isDspm": true
        }
      ],
      "termsCount": "example"
    }
  }
  ```

  {% endcut %}

- {% cut "**Type**: object" %}

  #|
  ||

  _childrenCount_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Number of direct child resources.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _classification_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: [DataCatalogClassificationConsoleView](#entity-DataCatalogClassificationConsoleView)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "datacatalogId": "example",
    "name": "example",
    "createdAt": {
      "seconds": "example",
      "nanos": 0.5
    },
    "updatedAt": null,
    "id": "example",
    "description": "example",
    "createdBy": "example",
    "assetsCount": "example",
    "aiGenerated": true,
    "rules": "example",
    "mutualExclusion": true,
    "tagsCount": "example"
  }
  ```

  {% endcut %}
  {.table-cell}
  ||
  ||

  _detailedObject_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  _Const:_{.json-schema-reset .json-schema-value} `classification`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "childrenCount": "example",
    "detailedObject": "classification",
    "classification": {
      "datacatalogId": "example",
      "name": "example",
      "createdAt": {
        "seconds": "example",
        "nanos": 0.5
      },
      "updatedAt": null,
      "id": "example",
      "description": "example",
      "createdBy": "example",
      "assetsCount": "example",
      "aiGenerated": true,
      "rules": "example",
      "mutualExclusion": true,
      "tagsCount": "example"
    }
  }
  ```

  {% endcut %}

- {% cut "**Type**: object" %}

  #|
  ||

  _childrenCount_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Number of direct child resources.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _detailedObject_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  _Const:_{.json-schema-reset .json-schema-value} `term`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _term_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: [DataCatalogTermConsoleView](#entity-DataCatalogTermConsoleView)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "datacatalogId": "example",
    "name": "example",
    "createdAt": {
      "seconds": "example",
      "nanos": 0.5
    },
    "updatedAt": null,
    "id": "example",
    "description": "example",
    "createdBy": "example",
    "assetsCount": "example",
    "aiGenerated": true,
    "rules": "example",
    "glossaryId": "example",
    "parentTermId": "example",
    "childCount": "example",
    "connectedTerms": [
      {
        "id": "example",
        "name": "example",
        "isAiLinked": true
      }
    ],
    "synonyms": [
      "example"
    ],
    "tags": [
      {
        "id": "example",
        "name": "example",
        "isAiLinked": true,
        "isDspm": true
      }
    ]
  }
  ```

  {% endcut %}
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "childrenCount": "example",
    "detailedObject": "term",
    "term": {
      "datacatalogId": "example",
      "name": "example",
      "createdAt": {
        "seconds": "example",
        "nanos": 0.5
      },
      "updatedAt": null,
      "id": "example",
      "description": "example",
      "createdBy": "example",
      "assetsCount": "example",
      "aiGenerated": true,
      "rules": "example",
      "glossaryId": "example",
      "parentTermId": "example",
      "childCount": "example",
      "connectedTerms": [
        {
          "id": "example",
          "name": "example",
          "isAiLinked": true
        }
      ],
      "synonyms": [
        "example"
      ],
      "tags": [
        {
          "id": "example",
          "name": "example",
          "isAiLinked": true,
          "isDspm": true
        }
      ]
    }
  }
  ```

  {% endcut %}

- {% cut "**Type**: object" %}

  #|
  ||

  _childrenCount_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Number of direct child resources.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _detailedObject_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  _Const:_{.json-schema-reset .json-schema-value} `query`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _query_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: [DataCatalogQueryView](#entity-DataCatalogQueryView)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "datacatalogId": "example",
    "name": "example",
    "createdAt": {
      "seconds": "example",
      "nanos": 0.5
    },
    "updatedAt": null,
    "urn": "example",
    "description": "example",
    "documetation": "example",
    "tags": [
      {
        "id": "example",
        "name": "example",
        "isAiLinked": true,
        "isDspm": true
      }
    ],
    "termins": [
      {
        "id": "example",
        "name": "example",
        "isAiLinked": true
      }
    ],
    "domain": null,
    "service": "example",
    "isDocumentationAiGenerated": true,
    "statement": "example",
    "language": "example",
    "isNameAiGenerated": true,
    "isPublished": true
  }
  ```

  {% endcut %}
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "childrenCount": "example",
    "detailedObject": "query",
    "query": {
      "datacatalogId": "example",
      "name": "example",
      "createdAt": {
        "seconds": "example",
        "nanos": 0.5
      },
      "updatedAt": null,
      "urn": "example",
      "description": "example",
      "documetation": "example",
      "tags": [
        {
          "id": "example",
          "name": "example",
          "isAiLinked": true,
          "isDspm": true
        }
      ],
      "termins": [
        {
          "id": "example",
          "name": "example",
          "isAiLinked": true
        }
      ],
      "domain": null,
      "service": "example",
      "isDocumentationAiGenerated": true,
      "statement": "example",
      "language": "example",
      "isNameAiGenerated": true,
      "isPublished": true
    }
  }
  ```

  {% endcut %}

- {% cut "**Type**: object" %}

  #|
  ||

  _childrenCount_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Number of direct child resources.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "childrenCount": "example"
  }
  ```

  {% endcut %}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "childrenCount": "example",
  "detailedObject": "asset",
  "asset": {
    "datacatalogId": "example",
    "name": "example",
    "createdAt": {
      "seconds": "example",
      "nanos": 0.5
    },
    "updatedAt": null,
    "urn": "example",
    "description": "example",
    "documetation": "example",
    "tags": [
      {}
    ],
    "termins": [
      {}
    ],
    "domain": null,
    "service": "example",
    "isDocumentationAiGenerated": true,
    "parent": {
      "urn": "example",
      "name": "example"
    },
    "path": [
      null
    ],
    "type": {
      "type": "example",
      "name": "example"
    },
    "payload": "example",
    "majorVersion": "example",
    "minorVersion": "example",
    "ingestionIds": [
      "example"
    ],
    "ingestionSourceIds": [
      "example"
    ],
    "lastIngestionAt": null,
    "subTypes": [
      null
    ],
    "assetTypeSpecificInfo": "query",
    "query": {
      "text": "example",
      "language": "example",
      "isPublished": true
    }
  }
}
```

{% endcut %}

</div>

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.