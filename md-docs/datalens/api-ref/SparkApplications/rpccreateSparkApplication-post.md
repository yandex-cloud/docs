[Документация Yandex Cloud](../../../index.md) > [Yandex DataLens](../../index.md) > DataLens Public API > [DataLens API (англ.)](../index.md) > [SparkApplications](index.md) > 🚧 [Experimental] Create Spark application

<div class="openapi">

# 🚧 [Experimental] Create Spark application

<!-- markdownlint-disable-file -->

Creates a Spark application and returns an asynchronous operation.

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
https://api.datalens.tech/rpc/createSparkApplication
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
  "name": "example",
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
  }
}
```

{% endcut %}

{% cut "**Any of 3 types**" %}{.json-schema-combinators data-marker=or}

- {% cut "**Type**: object" %}

  #|
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

  _sparkApplication_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  {% cut "**Type**: object" %}

  #|
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

  _archiveUris_{.json-schema-reset .json-schema-property}
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

  _args_{.json-schema-reset .json-schema-property}
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

  _excludePackages_{.json-schema-reset .json-schema-property}
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

  _fileUris_{.json-schema-reset .json-schema-property}
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

  _jarFileUris_{.json-schema-reset .json-schema-property}
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

  _mainClass_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: string

  Name of the driver main class.

  _Max length:_{.json-schema-reset .json-schema-assertion} `255`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _packages_{.json-schema-reset .json-schema-property}
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

  _properties_{.json-schema-reset .json-schema-property}
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

  _repositories_{.json-schema-reset .json-schema-property}
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

  _catalogs_{.json-schema-reset .json-schema-property}
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

  REST catalogs to attach to the Spark application.

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

  _name_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: string

  Name of the Spark application.

  _Max length:_{.json-schema-reset .json-schema-assertion} `255`

  _Pattern:_{.json-schema-reset .json-schema-assertion} `^(?:&#124;[a-z][-a-z0-9]{1,61}[a-z0-9])$`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "clusterId": "example",
    "name": "example",
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
    }
  }
  ```

  {% endcut %}

- {% cut "**Type**: object" %}

  #|
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

  _pysparkApplication_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  {% cut "**Type**: object" %}

  #|
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

  _archiveUris_{.json-schema-reset .json-schema-property}
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

  _args_{.json-schema-reset .json-schema-property}
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

  _excludePackages_{.json-schema-reset .json-schema-property}
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

  _fileUris_{.json-schema-reset .json-schema-property}
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

  _jarFileUris_{.json-schema-reset .json-schema-property}
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

  _packages_{.json-schema-reset .json-schema-property}
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

  _properties_{.json-schema-reset .json-schema-property}
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

  _pythonFileUris_{.json-schema-reset .json-schema-property}
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

  _repositories_{.json-schema-reset .json-schema-property}
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

  _catalogs_{.json-schema-reset .json-schema-property}
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

  REST catalogs to attach to the Spark application.

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

  _name_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: string

  Name of the Spark application.

  _Max length:_{.json-schema-reset .json-schema-assertion} `255`

  _Pattern:_{.json-schema-reset .json-schema-assertion} `^(?:&#124;[a-z][-a-z0-9]{1,61}[a-z0-9])$`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "clusterId": "example",
    "name": "example",
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
    }
  }
  ```

  {% endcut %}

- {% cut "**Type**: object" %}

  #|
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

  _sparkConnectApplication_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  {% cut "**Type**: object" %}

  #|
  ||

  _archiveUris_{.json-schema-reset .json-schema-property}
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

  _excludePackages_{.json-schema-reset .json-schema-property}
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

  _fileUris_{.json-schema-reset .json-schema-property}
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

  _jarFileUris_{.json-schema-reset .json-schema-property}
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

  _packages_{.json-schema-reset .json-schema-property}
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

  _properties_{.json-schema-reset .json-schema-property}
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

  _repositories_{.json-schema-reset .json-schema-property}
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

  _catalogs_{.json-schema-reset .json-schema-property}
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

  REST catalogs to attach to the Spark application.

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

  _name_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: string

  Name of the Spark application.

  _Max length:_{.json-schema-reset .json-schema-assertion} `255`

  _Pattern:_{.json-schema-reset .json-schema-assertion} `^(?:&#124;[a-z][-a-z0-9]{1,61}[a-z0-9])$`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "clusterId": "example",
    "name": "example",
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
    }
  }
  ```

  {% endcut %}

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
{
  "id": "example",
  "description": "example",
  "createdAt": {
    "seconds": "example",
    "nanos": 0.5
  },
  "createdBy": "example",
  "modifiedAt": {
    "seconds": "example",
    "nanos": 0.5
  },
  "done": true,
  "metadata": {},
  "error": {
    "code": 0.5,
    "message": "example",
    "details": [
      null
    ]
  },
  "response": {}
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_done_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: boolean

Whether the operation has completed.
{.table-cell}
||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Unique ID of the operation.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_metadata_{.json-schema-reset .json-schema-property .json-schema-required}
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

Service-specific operation metadata.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
||

_createdAt_{.json-schema-reset .json-schema-property}
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

Time when the operation was created.

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

_createdBy_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

ID of the operation creator.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Description of the operation.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_error_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_code_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: number

Operation error code.
{.table-cell}
||
||

_message_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Operation error message.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_details_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown[]

Additional operation error details.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  null
]
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Operation error, if the operation failed.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "code": 0.5,
  "message": "example",
  "details": [
    null
  ]
}
```

{% endcut %}
{.table-cell}
||
||

_modifiedAt_{.json-schema-reset .json-schema-property}
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

Time when the operation was last modified.

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

_response_{.json-schema-reset .json-schema-property}
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

Service-specific operation response.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

</div>

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.