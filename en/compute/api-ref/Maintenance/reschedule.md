---
editable: false
apiPlayground:
  - url: https://compute.{{ api-host }}/compute/v1/maintenances/{maintenanceId}:reschedule
    method: post
    path:
      type: object
      properties:
        maintenanceId:
          description: |-
            **string**
            Required field. Required. ID of the maintenance.
          type: string
      required:
        - maintenanceId
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        rescheduleType:
          description: |-
            **enum** (Type)
            Required. If `reschedule_type` is "SPECIFIC_TIME",
            must set up `schedule_time` as well.
            - `TYPE_UNSPECIFIED`: Not set.
            - `IMMEDIATE`: If the user wants to reschedule the maintenance to happen now.
            - `NEXT_AVAILABLE_WINDOW`: If the user wants to reschedule the maintenance for the next maintenance window.
            - `SPECIFIC_TIME`: If the user wants to reschedule the maintenance to a specific time.
          type: string
          enum:
            - TYPE_UNSPECIFIED
            - STANDARD
            - SOFTWARE_ACCELERATED
            - HARDWARE_ACCELERATED
        scheduledAt:
          description: |-
            **string** (date-time)
            Optional. Timestamp the maintenance shall be rescheduled to,
            if `reschedule_type` = "SPECIFIC_TIME".
            Must be in RFC 3339 format (e.g. "2025-11-15T16:19:00.094Z").
            String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
            `0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.
            To work with values in this field, use the APIs described in the
            [Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
            In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).
          type: string
          format: date-time
      additionalProperties: false
    definitions: null
sourcePath: en/_api-ref/compute/v1/api-ref/Maintenance/reschedule.md
---

# Compute Cloud API, REST: Maintenance.Reschedule

Allows user to reschedule Maintenance to another date and time.

## HTTP request

```
POST https://compute.{{ api-host }}/compute/v1/maintenances/{maintenanceId}:reschedule
```

## Path parameters

RescheduleMaintenanceRequest allows to reschedule maintenance to another date and time.

#|
||Field | Description ||
|| maintenanceId | **string**

Required field. Required. ID of the maintenance. ||
|#

## Body parameters {#yandex.cloud.maintenance.v2.RescheduleMaintenanceRequest}

```json
{
  "rescheduleType": "string",
  "scheduledAt": "string"
}
```

RescheduleMaintenanceRequest allows to reschedule maintenance to another date and time.

#|
||Field | Description ||
|| rescheduleType | **enum** (Type)

Required. If `reschedule_type` is "SPECIFIC_TIME",
must set up `schedule_time` as well.

- `TYPE_UNSPECIFIED`: Not set.
- `IMMEDIATE`: If the user wants to reschedule the maintenance to happen now.
- `NEXT_AVAILABLE_WINDOW`: If the user wants to reschedule the maintenance for the next maintenance window.
- `SPECIFIC_TIME`: If the user wants to reschedule the maintenance to a specific time. ||
|| scheduledAt | **string** (date-time)

Optional. Timestamp the maintenance shall be rescheduled to,
if `reschedule_type` = "SPECIFIC_TIME".
Must be in RFC 3339 format (e.g. "2025-11-15T16:19:00.094Z").

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
  "response": {
    "id": "string",
    "resourcePath": [
      {
        "id": "string",
        "type": "string"
      }
    ],
    "description": "string",
    "details": [
      {
        "key": "string",
        "value": "string"
      }
    ],
    "status": "string",
    "createdAt": "string",
    "startScheduledAt": "string",
    "completionScheduledAt": "string",
    "maxStartScheduledAt": "string",
    "startedAt": "string",
    "succeededAt": "string",
    "cancelledAt": "string",
    "userControllable": "boolean"
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
|| response | **[Maintenance](#yandex.cloud.maintenance.v2.Maintenance)**

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

## Maintenance {#yandex.cloud.maintenance.v2.Maintenance}

#|
||Field | Description ||
|| id | **string**

ID of the maintenance. ||
|| resourcePath[] | **[Resource](#yandex.cloud.maintenance.v2.Maintenance.Resource)**

Full path to the resource affected by maintenance,
represented as a hierarchy from specific resource to top-level container.
Example for a Compute instance with ID "I" in folder "F" and cloud "C":
resource_path = [
{ "compute.instance", "I" },
{ "resource-manager.folder", "F" },
{ "resource-manager.cloud", "C" }
] ||
|| description | **string**

Describes action to be performed. ||
|| details[] | **[Detail](#yandex.cloud.maintenance.v2.Maintenance.Detail)**

Service-specific details. ||
|| status | **enum** (Status)

Status of the maintenance.

- `STATUS_UNSPECIFIED`: Not set.
- `SCHEDULED`: Maintenance is scheduled for a future time.
- `RUNNING`: Maintenance is currently running.
- `SUCCEEDED`: Maintenance completed successfully.
- `CANCELLED`: Maintenance is cancelled and will not run. ||
|| createdAt | **string** (date-time)

The creation time of the maintenance.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| startScheduledAt | **string** (date-time)

The time when the maintenance was scheduled to start.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| completionScheduledAt | **string** (date-time)

The time when the maintenance is estimated to complete. Optional.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| maxStartScheduledAt | **string** (date-time)

Latest time the maintenance can be postponed to.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| startedAt | **string** (date-time)

The time time when the maintenance has actually started.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| succeededAt | **string** (date-time)

The time time when the maintenance has actually completed successfully.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| cancelledAt | **string** (date-time)

The time time when the maintenance has actually been cancelled.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| userControllable | **boolean**

Indicates whether the user can control (reschedule) the maintenance. ||
|#

## Resource {#yandex.cloud.maintenance.v2.Maintenance.Resource}

#|
||Field | Description ||
|| id | **string**

ID of the resource ||
|| type | **string**

The type of the resource, e.g. resource-manager.cloud, resource-manager.folder, compute.instance, etc. ||
|#

## Detail {#yandex.cloud.maintenance.v2.Maintenance.Detail}

#|
||Field | Description ||
|| key | **string**

Unique key (service-specific). ||
|| value | **string**

Description (service-specific). ||
|#