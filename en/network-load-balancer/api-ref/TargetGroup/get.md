---
editable: false
apiPlayground:
  - url: https://load-balancer.{{ api-host }}/load-balancer/v1/targetGroups/{targetGroupId}
    method: get
    path:
      type: object
      properties:
        targetGroupId:
          description: |-
            **string**
            Required field. ID of the TargetGroup resource to return.
            To get the target group ID, use a [TargetGroupService.List](/docs/network-load-balancer/api-ref/TargetGroup/list#List) request.
          type: string
      required:
        - targetGroupId
      additionalProperties: false
    query: null
    body: null
    definitions: null
sourcePath: en/_api-ref/loadbalancer/v1/api-ref/TargetGroup/get.md
---

# Network Load Balancer API, REST: TargetGroup.Get

Returns the specified TargetGroup resource.

## HTTP request

```
GET https://load-balancer.{{ api-host }}/load-balancer/v1/targetGroups/{targetGroupId}
```

## Path parameters

#|
||Field | Description ||
|| targetGroupId | **string**

Required field. ID of the TargetGroup resource to return.
To get the target group ID, use a [TargetGroupService.List](/docs/network-load-balancer/api-ref/TargetGroup/list#List) request. ||
|#

## Response {#yandex.cloud.loadbalancer.v1.TargetGroup}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "regionId": "string",
  "targets": [
    {
      "subnetId": "string",
      "address": "string"
    }
  ]
}
```

A TargetGroup resource. For more information, see [Target groups and resources](/docs/network-load-balancer/concepts/target-resources).

#|
||Field | Description ||
|| id | **string**

Output only. ID of the target group. ||
|| folderId | **string**

ID of the folder that the target group belongs to. ||
|| createdAt | **string** (date-time)

Output only. Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Name of the target group.
The name is unique within the folder. 3-63 characters long. ||
|| description | **string**

Description of the target group. 0-256 characters long. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `` key:value `` pairs. Maximum of 64 per resource. ||
|| regionId | **string**

ID of the region where the target group resides. ||
|| targets[] | **[Target](#yandex.cloud.loadbalancer.v1.Target)**

A list of targets in the target group. ||
|#

## Target {#yandex.cloud.loadbalancer.v1.Target}

A Target resource. For more information, see [Target groups and resources](/docs/network-load-balancer/concepts/target-resources).

#|
||Field | Description ||
|| subnetId | **string**

ID of the subnet that targets are connected to.
All targets in the target group must be connected to the same subnet within a single availability zone. ||
|| address | **string**

IP address of the target. ||
|#