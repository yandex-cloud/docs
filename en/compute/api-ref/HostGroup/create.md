---
editable: false
apiPlayground:
  - url: https://compute.{{ api-host }}/compute/v1/hostGroups
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        folderId:
          description: |-
            **string**
            Required field. ID of the folder to create a host group in.
            To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request.
          type: string
        name:
          description: |-
            **string**
            Name of the group.
          pattern: '|[a-z]([-_a-z0-9]{0,61}[a-z0-9])?'
          type: string
        description:
          description: |-
            **string**
            Description of the group.
          type: string
        labels:
          description: |-
            **object** (map<**string**, **string**>)
            Resource labels as `key:value` pairs.
          pattern: '[a-z][-_./\@0-9a-z]*'
          type: string
        zoneId:
          description: |-
            **string**
            Required field. Availability zone where all dedicated hosts will be allocated.
          type: string
        typeId:
          description: |-
            **string**
            Required field. ID of host type. Resources provided by each host of the group.
          type: string
        maintenancePolicy:
          description: |-
            **enum** (MaintenancePolicy)
            Behaviour on maintenance events.
            - `MAINTENANCE_POLICY_UNSPECIFIED`
            - `RESTART`: Restart instance to move it to another host during maintenance
            - `MIGRATE`: Use live migration to move instance to another host during maintenance
          type: string
          enum:
            - MAINTENANCE_POLICY_UNSPECIFIED
            - RESTART
            - MIGRATE
        scalePolicy:
          description: |-
            **[ScalePolicy](/docs/compute/api-ref/HostGroup/get#yandex.cloud.compute.v1.ScalePolicy)**
            Scale policy. Only fixed number of hosts are supported at this moment.
          oneOf:
            - type: object
              properties:
                fixedScale:
                  description: |-
                    **[FixedScale](/docs/compute/api-ref/HostGroup/get#yandex.cloud.compute.v1.ScalePolicy.FixedScale)**
                    Includes only one of the fields `fixedScale`.
                  $ref: '#/definitions/FixedScale'
      required:
        - folderId
        - zoneId
        - typeId
      additionalProperties: false
    definitions:
      FixedScale:
        type: object
        properties:
          size:
            description: '**string** (int64)'
            type: string
            format: int64
sourcePath: en/_api-ref/compute/v1/api-ref/HostGroup/create.md
---

# Compute Cloud API, REST: HostGroup.Create

Creates a host group in the specified folder.

## HTTP request

```
POST https://compute.{{ api-host }}/compute/v1/hostGroups
```

## Body parameters {#yandex.cloud.compute.v1.CreateHostGroupRequest}

```json
{
  "folderId": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "zoneId": "string",
  "typeId": "string",
  "maintenancePolicy": "string",
  "scalePolicy": {
    // Includes only one of the fields `fixedScale`
    "fixedScale": {
      "size": "string"
    }
    // end of the list of possible fields
  }
}
```

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to create a host group in.
To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request. ||
|| name | **string**

Name of the group. ||
|| description | **string**

Description of the group. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. ||
|| zoneId | **string**

Required field. Availability zone where all dedicated hosts will be allocated. ||
|| typeId | **string**

Required field. ID of host type. Resources provided by each host of the group. ||
|| maintenancePolicy | **enum** (MaintenancePolicy)

Behaviour on maintenance events.

- `MAINTENANCE_POLICY_UNSPECIFIED`
- `RESTART`: Restart instance to move it to another host during maintenance
- `MIGRATE`: Use live migration to move instance to another host during maintenance ||
|| scalePolicy | **[ScalePolicy](#yandex.cloud.compute.v1.ScalePolicy)**

Scale policy. Only fixed number of hosts are supported at this moment. ||
|#

## ScalePolicy {#yandex.cloud.compute.v1.ScalePolicy}

#|
||Field | Description ||
|| fixedScale | **[FixedScale](#yandex.cloud.compute.v1.ScalePolicy.FixedScale)**

Includes only one of the fields `fixedScale`. ||
|#

## FixedScale {#yandex.cloud.compute.v1.ScalePolicy.FixedScale}

#|
||Field | Description ||
|| size | **string** (int64) ||
|#

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": {
    "hostGroupId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": {
    "id": "string",
    "folderId": "string",
    "createdAt": "string",
    "name": "string",
    "description": "string",
    "labels": "object",
    "zoneId": "string",
    "status": "string",
    "typeId": "string",
    "maintenancePolicy": "string",
    "scalePolicy": {
      // Includes only one of the fields `fixedScale`
      "fixedScale": {
        "size": "string"
      }
      // end of the list of possible fields
    }
  }
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[CreateHostGroupMetadata](#yandex.cloud.compute.v1.CreateHostGroupMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[HostGroup](#yandex.cloud.compute.v1.HostGroup)**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## CreateHostGroupMetadata {#yandex.cloud.compute.v1.CreateHostGroupMetadata}

#|
||Field | Description ||
|| hostGroupId | **string**

ID of the host group that is being created. ||
|#

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
|#

## HostGroup {#yandex.cloud.compute.v1.HostGroup}

Represents group of dedicated hosts

#|
||Field | Description ||
|| id | **string**

ID of the group. ||
|| folderId | **string**

ID of the folder that the group belongs to. ||
|| createdAt | **string** (date-time)

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Name of the group. The name is unique within the folder. ||
|| description | **string**

Description of the group. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. ||
|| zoneId | **string**

Availability zone where all dedicated hosts are allocated. ||
|| status | **enum** (Status)

Status of the group.

- `STATUS_UNSPECIFIED`
- `CREATING`
- `READY`
- `UPDATING`
- `DELETING` ||
|| typeId | **string**

ID of host type. Resources provided by each host of the group. ||
|| maintenancePolicy | **enum** (MaintenancePolicy)

Behaviour on maintenance events.

- `MAINTENANCE_POLICY_UNSPECIFIED`
- `RESTART`: Restart instance to move it to another host during maintenance
- `MIGRATE`: Use live migration to move instance to another host during maintenance ||
|| scalePolicy | **[ScalePolicy](#yandex.cloud.compute.v1.ScalePolicy2)**

Scale policy. Only fixed number of hosts are supported at this moment. ||
|#

## ScalePolicy {#yandex.cloud.compute.v1.ScalePolicy2}

#|
||Field | Description ||
|| fixedScale | **[FixedScale](#yandex.cloud.compute.v1.ScalePolicy.FixedScale2)**

Includes only one of the fields `fixedScale`. ||
|#

## FixedScale {#yandex.cloud.compute.v1.ScalePolicy.FixedScale2}

#|
||Field | Description ||
|| size | **string** (int64) ||
|#