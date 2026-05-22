---
editable: false
---

# Ytsaurus Audit Trails Events: UpdateClusterGroupMembers

## Event JSON schema {#yandex.cloud.audit.ytsaurus.UpdateClusterGroupMembers2-schema}

```json
{
  "eventId": "string",
  "eventSource": "string",
  "eventType": "string",
  "eventTime": "string",
  "resourceMetadata": {
    "path": [
      {
        "resourceType": "string",
        "resourceId": "string",
        // Includes only one of the fields `resourceName`
        "resourceName": "string"
        // end of the list of possible fields
      }
    ]
  },
  "eventStatus": "string",
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "details": {
    "clusterId": "string",
    "groupMemberDeltas": [
      {
        "action": "string",
        "groupMember": {
          "group": "string",
          "userId": "string"
        }
      }
    ]
  }
}
```

## Field description {#yandex.cloud.audit.ytsaurus.UpdateClusterGroupMembers2}

#|
||Field | Description ||
|| eventId | **string** ||
|| eventSource | **string** ||
|| eventType | **string** ||
|| eventTime | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| resourceMetadata | **[ResourceMetadata](#yandex.cloud.audit.ResourceMetadata)** ||
|| eventStatus | **enum** (EventStatus)

- `STARTED`
- `ERROR`
- `DONE`
- `CANCELLED`
- `RUNNING` ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation. ||
|| details | **[EventDetails](#yandex.cloud.audit.ytsaurus.UpdateClusterGroupMembers.EventDetails)** ||
|#

## ResourceMetadata {#yandex.cloud.audit.ResourceMetadata}

#|
||Field | Description ||
|| path[] | **[Resource](#yandex.cloud.audit.Resource)** ||
|#

## Resource {#yandex.cloud.audit.Resource}

#|
||Field | Description ||
|| resourceType | **string** ||
|| resourceId | **string** ||
|| resourceName | **string**

Includes only one of the fields `resourceName`. ||
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

## EventDetails {#yandex.cloud.audit.ytsaurus.UpdateClusterGroupMembers.EventDetails}

#|
||Field | Description ||
|| clusterId | **string**

The maximum string length in characters is 50. ||
|| groupMemberDeltas[] | **[ClusterGroupMemberDelta](#yandex.cloud.audit.ytsaurus.ClusterGroupMemberDelta)** ||
|#

## ClusterGroupMemberDelta {#yandex.cloud.audit.ytsaurus.ClusterGroupMemberDelta}

#|
||Field | Description ||
|| action | **enum** (DeltaAction)

- `ADD`
- `REMOVE` ||
|| groupMember | **[ClusterGroupMember](#yandex.cloud.audit.ytsaurus.ClusterGroupMember)** ||
|#

## ClusterGroupMember {#yandex.cloud.audit.ytsaurus.ClusterGroupMember}

#|
||Field | Description ||
|| group | **string** ||
|| userId | **string** ||
|#