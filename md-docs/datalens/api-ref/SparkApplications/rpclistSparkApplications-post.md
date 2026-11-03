[Документация Yandex Cloud](../../../index.md) > [Yandex DataLens](../../index.md) > DataLens Public API > [DataLens API (англ.)](../index.md) > [SparkApplications](index.md) > 🚧 [Experimental] List Spark applications

<div class="openapi">

# 🚧 [Experimental] List Spark applications

<!-- markdownlint-disable-file -->

Returns a list of applications for the specified Spark cluster.

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
https://api.datalens.tech/rpc/listSparkApplications
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
  "clusterId": "example",
  "pageSize": 0,
  "pageToken": "example",
  "filter": [
    "example"
  ]
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_clusterId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the Spark cluster.

_Min length:_{.json-schema-reset .json-schema-assertion} `1`

_Max length:_{.json-schema-reset .json-schema-assertion} `50`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_filter_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string[]

Filter conditions applied to the Spark application list, combined with AND. Each condition has the form `field="value"`, where field is one of `name`, `created_by`, `application_type` or `catalog_id`.

_Max items:_{.json-schema-reset .json-schema-assertion} `100`

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

_pageSize_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer

Maximum number of Spark applications to return. The default is 100.

_Min value:_{.json-schema-reset .json-schema-assertion} `0`

_Max value:_{.json-schema-reset .json-schema-assertion} `1000`
{.table-cell}
||
||

_pageToken_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Token for the next page of Spark applications.

_Max length:_{.json-schema-reset .json-schema-assertion} `200`

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
  "applications": [
    {
      "id": "example",
      "clusterId": "example",
      "createdAt": {
        "seconds": "example",
        "nanos": 0.5
      },
      "startedAt": {
        "seconds": "example",
        "nanos": 0.5
      },
      "finishedAt": {
        "seconds": "example",
        "nanos": 0.5
      },
      "name": "example",
      "createdBy": "example",
      "status": "STATUS_UNSPECIFIED",
      "connectUrl": "example",
      "catalogs": [
        {}
      ],
      "sparkApplication": {
        "args": [
          null
        ],
        "jarFileUris": [
          null
        ],
        "fileUris": [
          null
        ],
        "archiveUris": [
          null
        ],
        "properties": {},
        "mainJarFileUri": "example",
        "mainClass": "example",
        "packages": [
          null
        ],
        "repositories": [
          null
        ],
        "excludePackages": [
          null
        ]
      },
      "applicationSpec": "sparkApplication"
    }
  ],
  "nextPageToken": "example"
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_applications_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: [SparkApplication](#entity-SparkApplication)[]

Spark applications matching the request.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "id": "example",
    "clusterId": "example",
    "createdAt": {
      "seconds": "example",
      "nanos": 0.5
    },
    "startedAt": {
      "seconds": "example",
      "nanos": 0.5
    },
    "finishedAt": {
      "seconds": "example",
      "nanos": 0.5
    },
    "name": "example",
    "createdBy": "example",
    "status": "STATUS_UNSPECIFIED",
    "connectUrl": "example",
    "catalogs": [
      {
        "catalogId": "example"
      }
    ],
    "sparkApplication": {
      "args": [
        "example"
      ],
      "jarFileUris": [
        "example"
      ],
      "fileUris": [
        "example"
      ],
      "archiveUris": [
        "example"
      ],
      "properties": {},
      "mainJarFileUri": "example",
      "mainClass": "example",
      "packages": [
        "example"
      ],
      "repositories": [
        "example"
      ],
      "excludePackages": [
        "example"
      ]
    },
    "applicationSpec": "sparkApplication"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_nextPageToken_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Token for the next page of Spark applications.

_Max length:_{.json-schema-reset .json-schema-assertion} `200`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

</div>

<div class="openapi-entity">

### SparkApplication {#entity-SparkApplication}

{% cut "**Any of 4 types**" %}{.json-schema-combinators data-marker=or}

- {% cut "**Type**: object" %}

  #|
  ||

  _applicationSpec_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  _Const:_{.json-schema-reset .json-schema-value} `sparkApplication`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _catalogs_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  {% cut "**Type**: object[]" %}

  #|
  ||

  _catalogId_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  ID of the REST catalog.

  _Min length:_{.json-schema-reset .json-schema-assertion} `1`

  _Max length:_{.json-schema-reset .json-schema-assertion} `50`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  REST catalogs attached to the Spark application.

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  [
    {
      "catalogId": "example"
    }
  ]
  ```

  {% endcut %}
  {.table-cell}
  ||
  ||

  _clusterId_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  ID of the Spark cluster.

  _Min length:_{.json-schema-reset .json-schema-assertion} `1`

  _Max length:_{.json-schema-reset .json-schema-assertion} `50`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _connectUrl_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Spark Connect URL.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _createdAt_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  {% cut "**Type**: object" %}

  #|
  ||

  _seconds_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Number of seconds since the Unix epoch.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _nanos_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: number

  Fractional seconds in nanoseconds.
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  Time when the Spark application was created.

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

  ID of the user who created the Spark application.

  _Min length:_{.json-schema-reset .json-schema-assertion} `1`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _finishedAt_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: object &#124; null

  Time when the Spark application was finished.

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

  _id_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  ID of the Spark application.

  _Min length:_{.json-schema-reset .json-schema-assertion} `1`

  _Max length:_{.json-schema-reset .json-schema-assertion} `50`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _name_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Name of the Spark application.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _sparkApplication_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  {% cut "**Type**: object" %}

  #|
  ||

  _archiveUris_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string[]

  Archives extracted in the Spark working directory.

  _Max items:_{.json-schema-reset .json-schema-assertion} `100`

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

  _args_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string[]

  Arguments passed to the Spark driver.

  _Max items:_{.json-schema-reset .json-schema-assertion} `100`

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

  _excludePackages_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string[]

  Maven packages excluded during dependency resolution.

  _Max items:_{.json-schema-reset .json-schema-assertion} `100`

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

  _fileUris_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string[]

  Files copied to the Spark working directory.

  _Max items:_{.json-schema-reset .json-schema-assertion} `100`

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

  _jarFileUris_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string[]

  JAR files added to the Spark classpaths.

  _Max items:_{.json-schema-reset .json-schema-assertion} `100`

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

  _mainClass_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Name of the driver main class.

  _Max length:_{.json-schema-reset .json-schema-assertion} `255`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _mainJarFileUri_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  URI of the JAR file that contains the main class.

  _Min length:_{.json-schema-reset .json-schema-assertion} `1`

  _Max length:_{.json-schema-reset .json-schema-assertion} `2047`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _packages_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string[]

  Maven packages added to the Spark classpaths.

  _Max items:_{.json-schema-reset .json-schema-assertion} `100`

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

  _properties_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  {% cut "**Type**: object" %}

  #|
  ||

  _[additional]_{.json-schema-reset .json-schema-additional-property}
  {.table-cell}|
  **Type**: string

  _Max length:_{.json-schema-reset .json-schema-assertion} `256`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  Spark configuration properties.

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {}
  ```

  {% endcut %}
  {.table-cell}
  ||
  ||

  _repositories_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string[]

  Additional Maven repositories.

  _Max items:_{.json-schema-reset .json-schema-assertion} `10`

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

  {% endcut %}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "args": [
      "example"
    ],
    "jarFileUris": [
      "example"
    ],
    "fileUris": [
      "example"
    ],
    "archiveUris": [
      "example"
    ],
    "properties": {},
    "mainJarFileUri": "example",
    "mainClass": "example",
    "packages": [
      "example"
    ],
    "repositories": [
      "example"
    ],
    "excludePackages": [
      "example"
    ]
  }
  ```

  {% endcut %}
  {.table-cell}
  ||
  ||

  _startedAt_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: object &#124; null

  Time when the Spark application was started.

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

  _status_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Current status of the Spark application.

  _Enum:_{.json-schema-reset .json-schema-value} `STATUS_UNSPECIFIED`, `PROVISIONING`, `PENDING`, `RUNNING`, `ERROR`, `DONE`, `CANCELLED`, `CANCELLING`
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "id": "example",
    "clusterId": "example",
    "createdAt": {
      "seconds": "example",
      "nanos": 0.5
    },
    "startedAt": {
      "seconds": "example",
      "nanos": 0.5
    },
    "finishedAt": {
      "seconds": "example",
      "nanos": 0.5
    },
    "name": "example",
    "createdBy": "example",
    "status": "STATUS_UNSPECIFIED",
    "connectUrl": "example",
    "catalogs": [
      {
        "catalogId": "example"
      }
    ],
    "sparkApplication": {
      "args": [
        "example"
      ],
      "jarFileUris": [
        "example"
      ],
      "fileUris": [
        "example"
      ],
      "archiveUris": [
        "example"
      ],
      "properties": {},
      "mainJarFileUri": "example",
      "mainClass": "example",
      "packages": [
        "example"
      ],
      "repositories": [
        "example"
      ],
      "excludePackages": [
        "example"
      ]
    },
    "applicationSpec": "sparkApplication"
  }
  ```

  {% endcut %}

- {% cut "**Type**: object" %}

  #|
  ||

  _applicationSpec_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  _Const:_{.json-schema-reset .json-schema-value} `pysparkApplication`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _catalogs_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  {% cut "**Type**: object[]" %}

  #|
  ||

  _catalogId_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  ID of the REST catalog.

  _Min length:_{.json-schema-reset .json-schema-assertion} `1`

  _Max length:_{.json-schema-reset .json-schema-assertion} `50`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  REST catalogs attached to the Spark application.

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  [
    {
      "catalogId": "example"
    }
  ]
  ```

  {% endcut %}
  {.table-cell}
  ||
  ||

  _clusterId_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  ID of the Spark cluster.

  _Min length:_{.json-schema-reset .json-schema-assertion} `1`

  _Max length:_{.json-schema-reset .json-schema-assertion} `50`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _connectUrl_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Spark Connect URL.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _createdAt_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  {% cut "**Type**: object" %}

  #|
  ||

  _seconds_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Number of seconds since the Unix epoch.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _nanos_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: number

  Fractional seconds in nanoseconds.
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  Time when the Spark application was created.

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

  ID of the user who created the Spark application.

  _Min length:_{.json-schema-reset .json-schema-assertion} `1`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _finishedAt_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: object &#124; null

  Time when the Spark application was finished.

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

  _id_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  ID of the Spark application.

  _Min length:_{.json-schema-reset .json-schema-assertion} `1`

  _Max length:_{.json-schema-reset .json-schema-assertion} `50`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _name_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Name of the Spark application.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _pysparkApplication_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  {% cut "**Type**: object" %}

  #|
  ||

  _archiveUris_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string[]

  Archives extracted in the Spark working directory.

  _Max items:_{.json-schema-reset .json-schema-assertion} `100`

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

  _args_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string[]

  Arguments passed to the PySpark driver.

  _Max items:_{.json-schema-reset .json-schema-assertion} `100`

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

  _excludePackages_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string[]

  Maven packages excluded during dependency resolution.

  _Max items:_{.json-schema-reset .json-schema-assertion} `100`

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

  _fileUris_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string[]

  Files copied to the Spark working directory.

  _Max items:_{.json-schema-reset .json-schema-assertion} `100`

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

  _jarFileUris_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string[]

  JAR files added to the Spark classpaths.

  _Max items:_{.json-schema-reset .json-schema-assertion} `100`

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

  _mainPythonFileUri_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  URI of the main Python file.

  _Min length:_{.json-schema-reset .json-schema-assertion} `1`

  _Max length:_{.json-schema-reset .json-schema-assertion} `2047`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _packages_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string[]

  Maven packages added to the Spark classpaths.

  _Max items:_{.json-schema-reset .json-schema-assertion} `100`

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

  _properties_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  {% cut "**Type**: object" %}

  #|
  ||

  _[additional]_{.json-schema-reset .json-schema-additional-property}
  {.table-cell}|
  **Type**: string

  _Max length:_{.json-schema-reset .json-schema-assertion} `256`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  Spark configuration properties.

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {}
  ```

  {% endcut %}
  {.table-cell}
  ||
  ||

  _pythonFileUris_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string[]

  Additional Python files passed to PySpark.

  _Max items:_{.json-schema-reset .json-schema-assertion} `100`

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

  _repositories_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string[]

  Additional Maven repositories.

  _Max items:_{.json-schema-reset .json-schema-assertion} `10`

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

  {% endcut %}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "args": [
      "example"
    ],
    "jarFileUris": [
      "example"
    ],
    "fileUris": [
      "example"
    ],
    "archiveUris": [
      "example"
    ],
    "properties": {},
    "mainPythonFileUri": "example",
    "pythonFileUris": [
      "example"
    ],
    "packages": [
      "example"
    ],
    "repositories": [
      "example"
    ],
    "excludePackages": [
      "example"
    ]
  }
  ```

  {% endcut %}
  {.table-cell}
  ||
  ||

  _startedAt_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: object &#124; null

  Time when the Spark application was started.

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

  _status_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Current status of the Spark application.

  _Enum:_{.json-schema-reset .json-schema-value} `STATUS_UNSPECIFIED`, `PROVISIONING`, `PENDING`, `RUNNING`, `ERROR`, `DONE`, `CANCELLED`, `CANCELLING`
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "id": "example",
    "clusterId": "example",
    "createdAt": {
      "seconds": "example",
      "nanos": 0.5
    },
    "startedAt": {
      "seconds": "example",
      "nanos": 0.5
    },
    "finishedAt": {
      "seconds": "example",
      "nanos": 0.5
    },
    "name": "example",
    "createdBy": "example",
    "status": "STATUS_UNSPECIFIED",
    "connectUrl": "example",
    "catalogs": [
      {
        "catalogId": "example"
      }
    ],
    "pysparkApplication": {
      "args": [
        "example"
      ],
      "jarFileUris": [
        "example"
      ],
      "fileUris": [
        "example"
      ],
      "archiveUris": [
        "example"
      ],
      "properties": {},
      "mainPythonFileUri": "example",
      "pythonFileUris": [
        "example"
      ],
      "packages": [
        "example"
      ],
      "repositories": [
        "example"
      ],
      "excludePackages": [
        "example"
      ]
    },
    "applicationSpec": "pysparkApplication"
  }
  ```

  {% endcut %}

- {% cut "**Type**: object" %}

  #|
  ||

  _applicationSpec_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  _Const:_{.json-schema-reset .json-schema-value} `sparkConnectApplication`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _catalogs_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  {% cut "**Type**: object[]" %}

  #|
  ||

  _catalogId_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  ID of the REST catalog.

  _Min length:_{.json-schema-reset .json-schema-assertion} `1`

  _Max length:_{.json-schema-reset .json-schema-assertion} `50`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  REST catalogs attached to the Spark application.

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  [
    {
      "catalogId": "example"
    }
  ]
  ```

  {% endcut %}
  {.table-cell}
  ||
  ||

  _clusterId_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  ID of the Spark cluster.

  _Min length:_{.json-schema-reset .json-schema-assertion} `1`

  _Max length:_{.json-schema-reset .json-schema-assertion} `50`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _connectUrl_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Spark Connect URL.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _createdAt_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  {% cut "**Type**: object" %}

  #|
  ||

  _seconds_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Number of seconds since the Unix epoch.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _nanos_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: number

  Fractional seconds in nanoseconds.
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  Time when the Spark application was created.

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

  ID of the user who created the Spark application.

  _Min length:_{.json-schema-reset .json-schema-assertion} `1`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _finishedAt_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: object &#124; null

  Time when the Spark application was finished.

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

  _id_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  ID of the Spark application.

  _Min length:_{.json-schema-reset .json-schema-assertion} `1`

  _Max length:_{.json-schema-reset .json-schema-assertion} `50`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _name_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Name of the Spark application.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _sparkConnectApplication_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  {% cut "**Type**: object" %}

  #|
  ||

  _archiveUris_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string[]

  Archives extracted in the Spark working directory.

  _Max items:_{.json-schema-reset .json-schema-assertion} `100`

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

  _excludePackages_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string[]

  Maven packages excluded during dependency resolution.

  _Max items:_{.json-schema-reset .json-schema-assertion} `100`

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

  _fileUris_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string[]

  Files copied to the Spark working directory.

  _Max items:_{.json-schema-reset .json-schema-assertion} `100`

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

  _jarFileUris_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string[]

  JAR files added to the Spark classpaths.

  _Max items:_{.json-schema-reset .json-schema-assertion} `100`

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

  _packages_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string[]

  Maven packages added to the Spark classpaths.

  _Max items:_{.json-schema-reset .json-schema-assertion} `100`

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

  _properties_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  {% cut "**Type**: object" %}

  #|
  ||

  _[additional]_{.json-schema-reset .json-schema-additional-property}
  {.table-cell}|
  **Type**: string

  _Max length:_{.json-schema-reset .json-schema-assertion} `256`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  Spark configuration properties.

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {}
  ```

  {% endcut %}
  {.table-cell}
  ||
  ||

  _repositories_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string[]

  Additional Maven repositories.

  _Max items:_{.json-schema-reset .json-schema-assertion} `10`

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

  {% endcut %}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "jarFileUris": [
      "example"
    ],
    "fileUris": [
      "example"
    ],
    "archiveUris": [
      "example"
    ],
    "properties": {},
    "packages": [
      "example"
    ],
    "repositories": [
      "example"
    ],
    "excludePackages": [
      "example"
    ]
  }
  ```

  {% endcut %}
  {.table-cell}
  ||
  ||

  _startedAt_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: object &#124; null

  Time when the Spark application was started.

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

  _status_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Current status of the Spark application.

  _Enum:_{.json-schema-reset .json-schema-value} `STATUS_UNSPECIFIED`, `PROVISIONING`, `PENDING`, `RUNNING`, `ERROR`, `DONE`, `CANCELLED`, `CANCELLING`
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "id": "example",
    "clusterId": "example",
    "createdAt": {
      "seconds": "example",
      "nanos": 0.5
    },
    "startedAt": {
      "seconds": "example",
      "nanos": 0.5
    },
    "finishedAt": {
      "seconds": "example",
      "nanos": 0.5
    },
    "name": "example",
    "createdBy": "example",
    "status": "STATUS_UNSPECIFIED",
    "connectUrl": "example",
    "catalogs": [
      {
        "catalogId": "example"
      }
    ],
    "sparkConnectApplication": {
      "jarFileUris": [
        "example"
      ],
      "fileUris": [
        "example"
      ],
      "archiveUris": [
        "example"
      ],
      "properties": {},
      "packages": [
        "example"
      ],
      "repositories": [
        "example"
      ],
      "excludePackages": [
        "example"
      ]
    },
    "applicationSpec": "sparkConnectApplication"
  }
  ```

  {% endcut %}

- {% cut "**Type**: object" %}

  #|
  ||

  _catalogs_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  {% cut "**Type**: object[]" %}

  #|
  ||

  _catalogId_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  ID of the REST catalog.

  _Min length:_{.json-schema-reset .json-schema-assertion} `1`

  _Max length:_{.json-schema-reset .json-schema-assertion} `50`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  REST catalogs attached to the Spark application.

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  [
    {
      "catalogId": "example"
    }
  ]
  ```

  {% endcut %}
  {.table-cell}
  ||
  ||

  _clusterId_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  ID of the Spark cluster.

  _Min length:_{.json-schema-reset .json-schema-assertion} `1`

  _Max length:_{.json-schema-reset .json-schema-assertion} `50`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _connectUrl_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Spark Connect URL.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _createdAt_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  {% cut "**Type**: object" %}

  #|
  ||

  _seconds_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Number of seconds since the Unix epoch.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _nanos_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: number

  Fractional seconds in nanoseconds.
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  Time when the Spark application was created.

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

  ID of the user who created the Spark application.

  _Min length:_{.json-schema-reset .json-schema-assertion} `1`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _finishedAt_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: object &#124; null

  Time when the Spark application was finished.

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

  _id_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  ID of the Spark application.

  _Min length:_{.json-schema-reset .json-schema-assertion} `1`

  _Max length:_{.json-schema-reset .json-schema-assertion} `50`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _name_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Name of the Spark application.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _startedAt_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: object &#124; null

  Time when the Spark application was started.

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

  _status_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Current status of the Spark application.

  _Enum:_{.json-schema-reset .json-schema-value} `STATUS_UNSPECIFIED`, `PROVISIONING`, `PENDING`, `RUNNING`, `ERROR`, `DONE`, `CANCELLED`, `CANCELLING`
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "id": "example",
    "clusterId": "example",
    "createdAt": {
      "seconds": "example",
      "nanos": 0.5
    },
    "startedAt": {
      "seconds": "example",
      "nanos": 0.5
    },
    "finishedAt": {
      "seconds": "example",
      "nanos": 0.5
    },
    "name": "example",
    "createdBy": "example",
    "status": "STATUS_UNSPECIFIED",
    "connectUrl": "example",
    "catalogs": [
      {
        "catalogId": "example"
      }
    ]
  }
  ```

  {% endcut %}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "id": "example",
  "clusterId": "example",
  "createdAt": {
    "seconds": "example",
    "nanos": 0.5
  },
  "startedAt": {
    "seconds": "example",
    "nanos": 0.5
  },
  "finishedAt": {
    "seconds": "example",
    "nanos": 0.5
  },
  "name": "example",
  "createdBy": "example",
  "status": "STATUS_UNSPECIFIED",
  "connectUrl": "example",
  "catalogs": [
    {
      "catalogId": "example"
    }
  ],
  "sparkApplication": {
    "args": [
      "example"
    ],
    "jarFileUris": [
      "example"
    ],
    "fileUris": [
      "example"
    ],
    "archiveUris": [
      "example"
    ],
    "properties": {},
    "mainJarFileUri": "example",
    "mainClass": "example",
    "packages": [
      "example"
    ],
    "repositories": [
      "example"
    ],
    "excludePackages": [
      "example"
    ]
  },
  "applicationSpec": "sparkApplication"
}
```

{% endcut %}

</div>

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.