<div class="openapi">

# 🚧 [Experimental] List cloud environments

<!-- markdownlint-disable-file -->

Returns a list of cloud environments available to the current DataLens tenant.

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
https://api.datalens.tech/rpc/listCloudEnvironments
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
  "pageSize": 0,
  "pageToken": "example",
  "filter": [
    "example"
  ],
  "includePermissions": true
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_filter_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string[]

Filter conditions applied to the cloud environment list, combined with AND. Each condition has the form `field="value"`, where field is one of `name`, `cloud_id`, `status` or `created_by_id`.

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

_includePermissions_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

Whether to return permissions of the current user.
{.table-cell}
||
||

_pageSize_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer

Maximum number of cloud environments to return.

_Min value:_{.json-schema-reset .json-schema-assertion} `0`
{.table-cell}
||
||

_pageToken_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Token for the next page of cloud environments.

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
  "cloudEnvironments": [
    {
      "id": "example",
      "name": "example",
      "description": "example",
      "createdAt": {
        "seconds": "example",
        "nanos": 0.5
      },
      "createdById": "example",
      "updatedAt": {
        "seconds": "example",
        "nanos": 0.5
      },
      "updatedById": "example",
      "status": "STATUS_UNSPECIFIED",
      "statusDetails": "example",
      "cloudId": "example",
      "tenantId": "example",
      "subnetId": "example",
      "securityGroupIds": [
        "example"
      ],
      "permissions": {},
      "storage": {
        "maxSize": "example"
      }
    }
  ],
  "nextPageToken": "example"
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_cloudEnvironments_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: [CloudEnvironment](#entity-CloudEnvironment)[]

Cloud environments matching the request.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "id": "example",
    "name": "example",
    "description": "example",
    "createdAt": {
      "seconds": "example",
      "nanos": 0.5
    },
    "createdById": "example",
    "updatedAt": {
      "seconds": "example",
      "nanos": 0.5
    },
    "updatedById": "example",
    "status": "STATUS_UNSPECIFIED",
    "statusDetails": "example",
    "cloudId": "example",
    "tenantId": "example",
    "subnetId": "example",
    "securityGroupIds": [
      "example"
    ],
    "permissions": {},
    "storage": {
      "maxSize": "example"
    }
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

Token for the next page of cloud environments.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

</div>

<div class="openapi-entity">

### CloudEnvironment {#entity-CloudEnvironment}

#|
|| **Name** | **Description** ||
||

_cloudId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the cloud that hosts the cloud environment.

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

Time when the cloud environment was created.

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

_createdById_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the cloud environment creator.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the cloud environment.

_Min length:_{.json-schema-reset .json-schema-assertion} `1`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Name of the cloud environment.

_Min length:_{.json-schema-reset .json-schema-assertion} `1`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_securityGroupIds_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string[]

IDs of the security groups used by the cloud environment.

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

_status_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Current status of the cloud environment.

_Enum:_{.json-schema-reset .json-schema-value} `STATUS_UNSPECIFIED`, `CREATING`, `READY`, `ERROR`, `DELETING`, `BROKEN`
{.table-cell}
||
||

_statusDetails_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Details of the current status.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_subnetId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the subnet used by the cloud environment.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_tenantId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the DataLens tenant.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_updatedAt_{.json-schema-reset .json-schema-property .json-schema-required}
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

Time when the cloud environment was last updated.

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

_updatedById_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the user who last updated the cloud environment.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Description of the cloud environment.

_Example:_{.json-schema-reset .json-schema-example} `example`
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

Permissions of the current user for the cloud environment.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
||

_storage_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: object &#124; null

Storage settings of the cloud environment.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "maxSize": "example"
}
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "id": "example",
  "name": "example",
  "description": "example",
  "createdAt": {
    "seconds": "example",
    "nanos": 0.5
  },
  "createdById": "example",
  "updatedAt": {
    "seconds": "example",
    "nanos": 0.5
  },
  "updatedById": "example",
  "status": "STATUS_UNSPECIFIED",
  "statusDetails": "example",
  "cloudId": "example",
  "tenantId": "example",
  "subnetId": "example",
  "securityGroupIds": [
    "example"
  ],
  "permissions": {},
  "storage": {
    "maxSize": "example"
  }
}
```

{% endcut %}

</div>

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.