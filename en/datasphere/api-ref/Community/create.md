---
editable: false
apiPlayground:
  - url: https://datasphere.{{ api-host }}/datasphere/v2/communities
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        name:
          description: |-
            **string**
            Name of the community.
          pattern: '[a-zA-Z0-9040104510410-044f]\S{1,61}[a-zA-Z0-9040104510410-044f]'
          type: string
        description:
          description: |-
            **string**
            Description of the community.
          type: string
        organizationId:
          description: |-
            **string**
            Required field. ID of the organization where community should be created.
          type: string
        billingAccountId:
          description: |-
            **string**
            ID of the billing account for the created community. Optional, billing account could be bound to community later.
          type: string
        labels:
          description: |-
            **object** (map<**string**, **string**>)
            Labels of the community.
          type: string
        zoneId:
          description: |-
            **string**
            Required field. ID of the zone where community will be created (all projects and other resources will be in this zone)
          type: string
      required:
        - organizationId
        - zoneId
      additionalProperties: false
    definitions: null
sourcePath: en/_api-ref/datasphere/v2/api-ref/Community/create.md
---

# DataSphere API v2, REST: Community.Create

Creates community in specified organization.

## HTTP request

```
POST https://datasphere.{{ api-host }}/datasphere/v2/communities
```

## Body parameters {#yandex.cloud.datasphere.v2.CreateCommunityRequest}

```json
{
  "name": "string",
  "description": "string",
  "organizationId": "string",
  "billingAccountId": "string",
  "labels": "object",
  "zoneId": "string"
}
```

#|
||Field | Description ||
|| name | **string**

Name of the community. ||
|| description | **string**

Description of the community. ||
|| organizationId | **string**

Required field. ID of the organization where community should be created. ||
|| billingAccountId | **string**

ID of the billing account for the created community. Optional, billing account could be bound to community later. ||
|| labels | **object** (map<**string**, **string**>)

Labels of the community. ||
|| zoneId | **string**

Required field. ID of the zone where community will be created (all projects and other resources will be in this zone) ||
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
    "communityId": "string"
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
    "createdAt": "string",
    "name": "string",
    "description": "string",
    "labels": "object",
    "createdById": "string",
    "organizationId": "string",
    "zoneId": "string"
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
|| metadata | **[CreateCommunityMetadata](#yandex.cloud.datasphere.v2.CreateCommunityMetadata)**

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
|| response | **[Community](#yandex.cloud.datasphere.v2.Community)**

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

## CreateCommunityMetadata {#yandex.cloud.datasphere.v2.CreateCommunityMetadata}

#|
||Field | Description ||
|| communityId | **string**

ID of the community that is being created. ||
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

## Community {#yandex.cloud.datasphere.v2.Community}

#|
||Field | Description ||
|| id | **string**

ID of the community. ||
|| createdAt | **string** (date-time)

Time when community was created.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Name of the community. ||
|| description | **string**

Description of the comminuty. ||
|| labels | **object** (map<**string**, **string**>)

Labels of the community. ||
|| createdById | **string**

ID of the user who created the community. ||
|| organizationId | **string**

ID of the organization to which community belongs. ||
|| zoneId | **string**

ID of the zone where this community was created ||
|#