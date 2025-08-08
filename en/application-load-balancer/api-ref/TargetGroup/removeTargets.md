---
editable: false
apiPlayground:
  - url: https://alb.{{ api-host }}/apploadbalancer/v1/targetGroups/{targetGroupId}:removeTargets
    method: post
    path:
      type: object
      properties:
        targetGroupId:
          description: |-
            **string**
            Required field. ID of the target group to remove targets from.
            To get the target group ID, make a [TargetGroupService.List](/docs/application-load-balancer/api-ref/TargetGroup/list#List) request.
          type: string
      required:
        - targetGroupId
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        targets:
          description: |-
            **[Target](/docs/application-load-balancer/api-ref/LoadBalancer/getTargetStates#yandex.cloud.apploadbalancer.v1.Target)**
            List of targets to remove from the target group.
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
sourcePath: en/_api-ref/apploadbalancer/v1/api-ref/TargetGroup/removeTargets.md
---

# Application Load Balancer API, REST: TargetGroup.RemoveTargets

Removes targets from the specified target group.

## HTTP request

```
POST https://alb.{{ api-host }}/apploadbalancer/v1/targetGroups/{targetGroupId}:removeTargets
```

## Path parameters

#|
||Field | Description ||
|| targetGroupId | **string**

Required field. ID of the target group to remove targets from.

To get the target group ID, make a [TargetGroupService.List](/docs/application-load-balancer/api-ref/TargetGroup/list#List) request. ||
|#

## Body parameters {#yandex.cloud.apploadbalancer.v1.RemoveTargetsRequest}

```json
{
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
|| targets[] | **[Target](#yandex.cloud.apploadbalancer.v1.Target)**

List of targets to remove from the target group. ||
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
|| metadata | **[RemoveTargetsMetadata](#yandex.cloud.apploadbalancer.v1.RemoveTargetsMetadata)**

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

## RemoveTargetsMetadata {#yandex.cloud.apploadbalancer.v1.RemoveTargetsMetadata}

#|
||Field | Description ||
|| targetGroupId | **string**

ID of the target group that the targets are being removed from. ||
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