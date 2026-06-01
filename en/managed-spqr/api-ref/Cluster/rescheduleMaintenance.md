---
editable: false
apiPlayground:
  - url: https://{{ api-host-mdb }}/managed-spqr/v1/clusters/{clusterId}:rescheduleMaintenance
    method: post
    path:
      type: object
      properties:
        clusterId:
          description: |-
            **string**
            Required field. ID of the SPQR cluster to reschedule the maintenance operation for.
            The maximum string length in characters is 50.
          type: string
      required:
        - clusterId
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        rescheduleType:
          description: |-
            **enum** (RescheduleType)
            Required field. The type of reschedule request.
            - `IMMEDIATE`: Start the maintenance operation immediately.
            - `NEXT_AVAILABLE_WINDOW`: Start the maintenance operation within the next available maintenance window.
            - `SPECIFIC_TIME`: Start the maintenance operation at the specific time.
          type: string
          enum:
            - RESCHEDULE_TYPE_UNSPECIFIED
            - IMMEDIATE
            - NEXT_AVAILABLE_WINDOW
            - SPECIFIC_TIME
        delayedUntil:
          description: |-
            **string** (date-time)
            The time until which this maintenance operation should be delayed. The value should be ahead of the first time when the maintenance operation has been scheduled for no more than two weeks. The value can also point to the past moment of time if [rescheduleType.IMMEDIATE](/docs/managed-spqr/api-ref/Cluster/rescheduleMaintenance#yandex.cloud.mdb.spqr.v1.RescheduleMaintenanceRequest.RescheduleType) reschedule type is chosen.
            String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
            `0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.
            To work with values in this field, use the APIs described in the
            [Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
            In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).
          type: string
          format: date-time
      required:
        - rescheduleType
      additionalProperties: false
    definitions: null
---

# Managed Service for SPQR API, REST: Cluster.RescheduleMaintenance

Reschedules planned maintenance operation.

## HTTP request

```
POST https://{{ api-host-mdb }}/managed-spqr/v1/clusters/{clusterId}:rescheduleMaintenance
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the SPQR cluster to reschedule the maintenance operation for.

The maximum string length in characters is 50. ||
|#

## Body parameters {#yandex.cloud.mdb.spqr.v1.RescheduleMaintenanceRequest}

```json
{
  "rescheduleType": "string",
  "delayedUntil": "string"
}
```

#|
||Field | Description ||
|| rescheduleType | **enum** (RescheduleType)

Required field. The type of reschedule request.

- `IMMEDIATE`: Start the maintenance operation immediately.
- `NEXT_AVAILABLE_WINDOW`: Start the maintenance operation within the next available maintenance window.
- `SPECIFIC_TIME`: Start the maintenance operation at the specific time. ||
|| delayedUntil | **string** (date-time)

The time until which this maintenance operation should be delayed. The value should be ahead of the first time when the maintenance operation has been scheduled for no more than two weeks. The value can also point to the past moment of time if [rescheduleType.IMMEDIATE](/docs/managed-spqr/api-ref/Cluster/rescheduleMaintenance#yandex.cloud.mdb.spqr.v1.RescheduleMaintenanceRequest.RescheduleType) reschedule type is chosen.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
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
  "metadata": "object",
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object"
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
|| metadata | **object**

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
|| response | **object**

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