---
editable: false
apiPlayground:
  - url: https://compute.{{ api-host }}/compute/v1/hostGroups/{hostGroupId}
    method: patch
    path:
      type: object
      properties:
        hostGroupId:
          description: |-
            **string**
            Required field. ID of the host group to update.
            To get the host group ID, use an [HostGroupService.List](/docs/compute/api-ref/HostGroup/list#List) request.
          type: string
      required:
        - hostGroupId
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        updateMask:
          description: |-
            **string** (field-mask)
            A comma-separated names off ALL fields to be updated.
            Only the specified fields will be changed. The others will be left untouched.
            If the field is specified in `` updateMask `` and no value for that field was sent in the request,
            the field's value will be reset to the default. The default value for most fields is null or 0.
            If `` updateMask `` is not sent in the request, all fields' values will be updated.
            Fields specified in the request will be updated to provided values.
            The rest of the fields will be reset to the default.
          type: string
          format: field-mask
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
            The existing set of `labels` is completely replaced by the provided set.
          pattern: '[a-z][-_./\@0-9a-z]*'
          type: string
        maintenancePolicy:
          description: |-
            **enum** (MaintenancePolicy)
            Behaviour on maintenance events
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
      additionalProperties: false
    definitions:
      FixedScale:
        type: object
        properties:
          size:
            description: '**string** (int64)'
            type: string
            format: int64
sourcePath: en/_api-ref/compute/v1/api-ref/HostGroup/update.md
---

# Compute Cloud API, REST: HostGroup.Update

Updates the specified host group.

## HTTP request

```
PATCH https://compute.{{ api-host }}/compute/v1/hostGroups/{hostGroupId}
```

## Path parameters

#|
||Field | Description ||
|| hostGroupId | **string**

Required field. ID of the host group to update.
To get the host group ID, use an [HostGroupService.List](/docs/compute/api-ref/HostGroup/list#List) request. ||
|#

## Body parameters {#yandex.cloud.compute.v1.UpdateHostGroupRequest}

```json
{
  "updateMask": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
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
|| updateMask | **string** (field-mask)

A comma-separated names off ALL fields to be updated.
Only the specified fields will be changed. The others will be left untouched.
If the field is specified in `` updateMask `` and no value for that field was sent in the request,
the field's value will be reset to the default. The default value for most fields is null or 0.

If `` updateMask `` is not sent in the request, all fields' values will be updated.
Fields specified in the request will be updated to provided values.
The rest of the fields will be reset to the default. ||
|| name | **string**

Name of the group. ||
|| description | **string**

Description of the group. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs.

The existing set of `labels` is completely replaced by the provided set. ||
|| maintenancePolicy | **enum** (MaintenancePolicy)

Behaviour on maintenance events

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
|| metadata | **[UpdateHostGroupMetadata](#yandex.cloud.compute.v1.UpdateHostGroupMetadata)**

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

## UpdateHostGroupMetadata {#yandex.cloud.compute.v1.UpdateHostGroupMetadata}

#|
||Field | Description ||
|| hostGroupId | **string**

ID of the host group that is being updated. ||
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