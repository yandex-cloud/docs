---
editable: false
apiPlayground:
  - url: https://alb.{{ api-host }}/apploadbalancer/v1/targetGroups/{targetGroupId}
    method: patch
    path:
      type: object
      properties:
        targetGroupId:
          description: |-
            **string**
            Required field. ID of the target group to update.
            To get the target group ID, make a [TargetGroupService.List](/docs/application-load-balancer/api-ref/TargetGroup/list#List) request.
          type: string
      required:
        - targetGroupId
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
            New name for the target group.
            The name must be unique within the folder.
          pattern: ([a-z]([-a-z0-9]{0,61}[a-z0-9])?)?
          type: string
        description:
          description: |-
            **string**
            New description of the target group.
          type: string
        labels:
          description: |-
            **object** (map<**string**, **string**>)
            Target group labels as `key:value` pairs.
            For details about the concept, see [documentation](/docs/overview/concepts/services#labels).
            Existing set of labels is completely replaced by the provided set, so if you just want
            to add or remove a label:
            1. Get the current set of labels with a [TargetGroupService.Get](/docs/application-load-balancer/api-ref/TargetGroup/get#Get) request.
            2. Add or remove a label in this set.
            3. Send the new set in this field.
          pattern: '[a-z][-_./\@0-9a-z]*'
          type: string
        targets:
          description: |-
            **[Target](/docs/application-load-balancer/api-ref/LoadBalancer/getTargetStates#yandex.cloud.apploadbalancer.v1.Target)**
            New list of targets in the target group.
            Existing list of targets is completely replaced by the specified list, so if you just want to add or remove
            a target, make a [TargetGroupService.AddTargets](/docs/application-load-balancer/api-ref/TargetGroup/addTargets#AddTargets) request or a [TargetGroupService.RemoveTargets](/docs/application-load-balancer/api-ref/TargetGroup/removeTargets#RemoveTargets) request.
          type: array
          items:
            oneOf:
              - type: object
                properties:
                  ipAddress:
                    description: |-
                      **string**
                      IP address of the target.
                      Includes only one of the fields `ipAddress`.
                      Reference to the target. As of now, targets must only be referred to by their IP addresses.
                    type: string
      additionalProperties: false
    definitions: null
sourcePath: en/_api-ref/apploadbalancer/v1/api-ref/TargetGroup/update.md
---

# Application Load Balancer API, REST: TargetGroup.Update

Updates the specified target group.

## HTTP request

```
PATCH https://alb.{{ api-host }}/apploadbalancer/v1/targetGroups/{targetGroupId}
```

## Path parameters

#|
||Field | Description ||
|| targetGroupId | **string**

Required field. ID of the target group to update.

To get the target group ID, make a [TargetGroupService.List](/docs/application-load-balancer/api-ref/TargetGroup/list#List) request. ||
|#

## Body parameters {#yandex.cloud.apploadbalancer.v1.UpdateTargetGroupRequest}

```json
{
  "updateMask": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "targets": [
    {
      // Includes only one of the fields `ipAddress`
      "ipAddress": "string",
      // end of the list of possible fields
      "subnetId": "string",
      "privateIpv4Address": "boolean"
    }
  ]
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

New name for the target group.
The name must be unique within the folder. ||
|| description | **string**

New description of the target group. ||
|| labels | **object** (map<**string**, **string**>)

Target group labels as `key:value` pairs.
For details about the concept, see [documentation](/docs/overview/concepts/services#labels).

Existing set of labels is completely replaced by the provided set, so if you just want
to add or remove a label:
1. Get the current set of labels with a [TargetGroupService.Get](/docs/application-load-balancer/api-ref/TargetGroup/get#Get) request.
2. Add or remove a label in this set.
3. Send the new set in this field. ||
|| targets[] | **[Target](#yandex.cloud.apploadbalancer.v1.Target)**

New list of targets in the target group.

Existing list of targets is completely replaced by the specified list, so if you just want to add or remove
a target, make a [TargetGroupService.AddTargets](/docs/application-load-balancer/api-ref/TargetGroup/addTargets#AddTargets) request or a [TargetGroupService.RemoveTargets](/docs/application-load-balancer/api-ref/TargetGroup/removeTargets#RemoveTargets) request. ||
|#

## Target {#yandex.cloud.apploadbalancer.v1.Target}

A target resource.
For details about the concept, see [documentation](/docs/application-load-balancer/concepts/target-group).

#|
||Field | Description ||
|| ipAddress | **string**

IP address of the target.

Includes only one of the fields `ipAddress`.

Reference to the target. As of now, targets must only be referred to by their IP addresses. ||
|| subnetId | **string**

ID of the subnet that the target is connected to. ||
|| privateIpv4Address | **boolean**

If set, will not require `subnet_id` to validate the target.
Instead, the address should belong to one of the following ranges:
10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16
Only one of `subnet_id` or `private_ipv4_address` should be set. ||
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
    "targetGroupId": "string"
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
    "name": "string",
    "description": "string",
    "folderId": "string",
    "labels": "object",
    "targets": [
      {
        // Includes only one of the fields `ipAddress`
        "ipAddress": "string",
        // end of the list of possible fields
        "subnetId": "string",
        "privateIpv4Address": "boolean"
      }
    ],
    "createdAt": "string"
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
|| metadata | **[UpdateTargetGroupMetadata](#yandex.cloud.apploadbalancer.v1.UpdateTargetGroupMetadata)**

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
|| response | **[TargetGroup](#yandex.cloud.apploadbalancer.v1.TargetGroup)**

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

## UpdateTargetGroupMetadata {#yandex.cloud.apploadbalancer.v1.UpdateTargetGroupMetadata}

#|
||Field | Description ||
|| targetGroupId | **string**

ID of the target group that is being updated. ||
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

## TargetGroup {#yandex.cloud.apploadbalancer.v1.TargetGroup}

A target group resource.
For details about the concept, see [documentation](/docs/application-load-balancer/concepts/target-group).

#|
||Field | Description ||
|| id | **string**

ID of the target group. Generated at creation time. ||
|| name | **string**

Name of the target group. The name is unique within the folder. ||
|| description | **string**

Description of the target group. ||
|| folderId | **string**

ID of the folder that the target group belongs to. ||
|| labels | **object** (map<**string**, **string**>)

Target group labels as `key:value` pairs.
For details about the concept, see [documentation](/docs/overview/concepts/services#labels). ||
|| targets[] | **[Target](#yandex.cloud.apploadbalancer.v1.Target2)**

List of targets in the target group. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#

## Target {#yandex.cloud.apploadbalancer.v1.Target2}

A target resource.
For details about the concept, see [documentation](/docs/application-load-balancer/concepts/target-group).

#|
||Field | Description ||
|| ipAddress | **string**

IP address of the target.

Includes only one of the fields `ipAddress`.

Reference to the target. As of now, targets must only be referred to by their IP addresses. ||
|| subnetId | **string**

ID of the subnet that the target is connected to. ||
|| privateIpv4Address | **boolean**

If set, will not require `subnet_id` to validate the target.
Instead, the address should belong to one of the following ranges:
10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16
Only one of `subnet_id` or `private_ipv4_address` should be set. ||
|#