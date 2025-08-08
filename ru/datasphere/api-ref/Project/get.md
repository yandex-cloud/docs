---
editable: false
apiPlayground:
  - url: https://datasphere.{{ api-host }}/datasphere/v2/projects/{projectId}
    method: get
    path:
      type: object
      properties:
        projectId:
          description: |-
            **string**
            Required field. ID of the Project resource to return.
            To get the project ID use a [ProjectService.List](/docs/datasphere/api-ref/Project/list#List) request.
          type: string
      required:
        - projectId
      additionalProperties: false
    query: null
    body: null
    definitions: null
sourcePath: en/_api-ref/datasphere/v2/api-ref/Project/get.md
---

# DataSphere API v2, REST: Project.Get

Returns the specified project.

## HTTP request

```
GET https://datasphere.{{ api-host }}/datasphere/v2/projects/{projectId}
```

## Path parameters

#|
||Field | Description ||
|| projectId | **string**

Required field. ID of the Project resource to return.
To get the project ID use a [ProjectService.List](/docs/datasphere/api-ref/Project/list#List) request. ||
|#

## Response {#yandex.cloud.datasphere.v2.Project}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "createdById": "string",
  "settings": {
    "serviceAccountId": "string",
    "subnetId": "string",
    "dataProcClusterId": "string",
    "securityGroupIds": [
      "string"
    ],
    "earlyAccess": "boolean",
    "ide": "string",
    "defaultFolderId": "string",
    "staleExecTimeoutMode": "string",
    "vmInactivityTimeout": "string",
    "defaultDedicatedSpec": "string"
  },
  "limits": {
    "maxUnitsPerHour": "string",
    "maxUnitsPerExecution": "string"
  },
  "communityId": "string"
}
```

A Project resource.

#|
||Field | Description ||
|| id | **string**

ID of the project. ||
|| createdAt | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Name of the project. 1-63 characters long. ||
|| description | **string**

Description of the project. 0-256 characters long. ||
|| labels | **object** (map<**string**, **string**>) ||
|| createdById | **string** ||
|| settings | **[Settings](#yandex.cloud.datasphere.v2.Project.Settings)**

Settings of the project. ||
|| limits | **[Limits](#yandex.cloud.datasphere.v2.Project.Limits)**

Limits of the project. ||
|| communityId | **string**

ID of the community that the project belongs to. ||
|#

## Settings {#yandex.cloud.datasphere.v2.Project.Settings}

#|
||Field | Description ||
|| serviceAccountId | **string**

ID of the service account, on whose behalf all operations with clusters will be performed. ||
|| subnetId | **string**

ID of the subnet where the DataProc cluster resides.
Currently only subnets created in the availability zone ru-central1-a are supported. ||
|| dataProcClusterId | **string**

ID of the DataProc cluster. ||
|| securityGroupIds[] | **string**

Network interfaces security groups. ||
|| earlyAccess | **boolean**

Is early access preview enabled for the project. ||
|| ide | **enum** (Ide)

Project IDE.

- `IDE_UNSPECIFIED`
- `JUPYTER_LAB`: Project running on JupyterLab IDE. ||
|| defaultFolderId | **string**

Default project folder ID. ||
|| staleExecTimeoutMode | **enum** (StaleExecutionTimeoutMode)

Timeout to automatically stop stale executions.

- `STALE_EXECUTION_TIMEOUT_MODE_UNSPECIFIED`
- `ONE_HOUR`: Setting to automatically stop stale execution after one hour with low consumption.
- `THREE_HOURS`: Setting to automatically stop stale execution after three hours with low consumption.
- `NO_TIMEOUT`: Setting to never automatically stop stale executions. ||
|| vmInactivityTimeout | **string** (duration)

Timeout for VM deallocation. ||
|| defaultDedicatedSpec | **string**

Default VM configuration for DEDICATED mode. ||
|#

## Limits {#yandex.cloud.datasphere.v2.Project.Limits}

#|
||Field | Description ||
|| maxUnitsPerHour | **string** (int64)

The number of units that can be spent per hour. ||
|| maxUnitsPerExecution | **string** (int64)

The number of units that can be spent on the one execution. ||
|#