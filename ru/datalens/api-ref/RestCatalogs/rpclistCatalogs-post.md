<div class="openapi">

# 🚧 [Experimental] List REST catalogs

<!-- markdownlint-disable-file -->

Returns a list of REST catalogs available to the current DataLens tenant.

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
https://api.datalens.tech/rpc/listCatalogs
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
  "cloudEnvironmentId": "example",
  "filter": [
    "example"
  ],
  "pageSize": 0,
  "pageToken": "example",
  "sortBy": "name",
  "reverseOrder": true,
  "includePermissions": true
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_cloudEnvironmentId_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

ID of the cloud environment to list REST catalogs in. Lists the whole tenant when omitted.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_filter_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string[]

Filter expressions such as name="…"; only matching REST catalogs are returned.

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

_includePermissions_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

Include permission information in the response.
{.table-cell}
||
||

_pageSize_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer

Maximum number of REST catalogs to return. The default is 100.

_Min value:_{.json-schema-reset .json-schema-assertion} `0`
{.table-cell}
||
||

_pageToken_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Token for the next page of REST catalogs.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_reverseOrder_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

Whether to sort REST catalogs in descending order.
{.table-cell}
||
||

_sortBy_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Field used to sort REST catalogs.

_Enum:_{.json-schema-reset .json-schema-value} `name`, `createdAt`, `updatedAt`
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
  "restCatalogs": [
    {
      "id": "example",
      "organizationId": "example",
      "tenantId": "example",
      "cloudEnvironmentId": "example",
      "name": "example",
      "description": "example",
      "labels": {},
      "createdAt": {
        "seconds": "example",
        "nanos": 0.5
      },
      "createdById": "example",
      "updatedAt": {
        "seconds": "example",
        "nanos": 0.5
      },
      "bucket": {
        "settings": {
          "storageClass": "example",
          "maxSize": "example",
          "alias": "example",
          "description": "example"
        },
        "details": {
          "usedSize": "example",
          "maxSize": "example",
          "updatedAt": {}
        }
      },
      "permissions": {}
    }
  ],
  "nextPageToken": "example"
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_nextPageToken_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Token for the next page of REST catalogs.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_restCatalogs_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object[]" %}

#|
||

_bucket_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_settings_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_alias_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Human-readable alias of the REST catalog bucket.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_maxSize_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Maximum size of the REST catalog bucket in bytes.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_storageClass_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Storage class of the REST catalog bucket.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Description of the REST catalog bucket.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Settings of the REST catalog bucket.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "storageClass": "example",
  "maxSize": "example",
  "alias": "example",
  "description": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_details_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_maxSize_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Maximum size of the bucket in bytes.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_updatedAt_{.json-schema-reset .json-schema-property}
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

Time when the bucket details were updated.

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

_usedSize_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Current size of the bucket in bytes.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Current details of the REST catalog bucket.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "usedSize": "example",
  "maxSize": "example",
  "updatedAt": {
    "seconds": "example",
    "nanos": 0.5
  }
}
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Bucket associated with the REST catalog.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "settings": {
    "storageClass": "example",
    "maxSize": "example",
    "alias": "example",
    "description": "example"
  },
  "details": {
    "usedSize": "example",
    "maxSize": "example",
    "updatedAt": {
      "seconds": "example",
      "nanos": 0.5
    }
  }
}
```

{% endcut %}
{.table-cell}
||
||

_cloudEnvironmentId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the associated cloud environment.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_createdById_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the user who created the REST catalog.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Description of the REST catalog.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the REST catalog.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Name of the REST catalog.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_organizationId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the organization that owns the REST catalog.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_tenantId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the tenant that owns the REST catalog.

_Example:_{.json-schema-reset .json-schema-example} `example`
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

Time when the REST catalog was created.

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

_labels_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_[additional]_{.json-schema-reset .json-schema-additional-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

REST catalog labels.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
||

_permissions_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_[additional]_{.json-schema-reset .json-schema-additional-property}
{.table-cell}|
**Type**: boolean
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Permissions for the REST catalog.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
||

_updatedAt_{.json-schema-reset .json-schema-property}
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

Time when the REST catalog was last updated.

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

{% endcut %}

REST catalogs matching the request.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "id": "example",
    "organizationId": "example",
    "tenantId": "example",
    "cloudEnvironmentId": "example",
    "name": "example",
    "description": "example",
    "labels": {},
    "createdAt": {
      "seconds": "example",
      "nanos": 0.5
    },
    "createdById": "example",
    "updatedAt": {
      "seconds": "example",
      "nanos": 0.5
    },
    "bucket": {
      "settings": {
        "storageClass": "example",
        "maxSize": "example",
        "alias": "example",
        "description": "example"
      },
      "details": {
        "usedSize": "example",
        "maxSize": "example",
        "updatedAt": {
          "seconds": "example",
          "nanos": 0.5
        }
      }
    },
    "permissions": {}
  }
]
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

</div>

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.