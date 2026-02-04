---
editable: false
apiPlayground:
  - url: https://alert-sink.{{ api-host }}/securitydeck/alerts/v1/alerts/{alertId}
    method: patch
    path:
      type: object
      properties:
        alertId:
          description: |-
            **string**
            Required field. Alert ID to update.
            The maximum string length in characters is 50.
          type: string
      required:
        - alertId
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        updateMask:
          description: |-
            **string** (field-mask)
            Required field. A comma-separated names off ALL fields to be updated.
            Only the specified fields will be changed. The others will be left untouched.
            If the field is specified in `` updateMask `` and no value for that field was sent in the request,
            the field's value will be reset to the default. The default value for most fields is null or 0.
            If `` updateMask `` is not sent in the request, all fields' values will be updated.
            Fields specified in the request will be updated to provided values.
            The rest of the fields will be reset to the default.
          type: string
          format: field-mask
        status:
          description: |-
            **enum** (Status)
            Alert status.
            Optional. Not used if not present in update_mask.
            - `OPEN`: Status is "open". Alert is not being currently processed.
            - `IN_PROGRESS`: Status is "in progress". Alert assignee is currently processing the alert.
            - `NEED_INFO`: Status is "need info". Alert assignee cannot currently process the alert and requires additional information.
            - `RESOLVED`: Status is "resolved". Alert processing has concluded.
          type: string
          enum:
            - STATUS_UNSPECIFIED
            - OPEN
            - IN_PROGRESS
            - NEED_INFO
            - RESOLVED
        classification:
          description: |-
            **enum** (Classification)
            Alert classification.
            Optional. Can be omitted but present in update_mask to remove classification. Not used if not present in update_mask.
            - `TRUE_POSITIVE`: Alert represents an actual problem that needs to be mitigated.
            - `BENIGN_POSITIVE`: Alert represents a legitimate problem but does not require attention.
            - `FALSE_POSITIVE`: Alert represents something that's not an issue.
            - `UNDETERMINED`: Alert relevance cannot be determined.
          type: string
          enum:
            - CLASSIFICATION_UNSPECIFIED
            - TRUE_POSITIVE
            - BENIGN_POSITIVE
            - FALSE_POSITIVE
            - UNDETERMINED
        assigneeSubjectId:
          description: |-
            **string**
            Assign alert to a subject with specified ID.
            Subject must be a USER_ACCOUNT resolvable by method caller.
            Optional. Can be omitted but present in update_mask to remove assignee. Not used if not present in update_mask.
            Includes only one of the fields `assigneeSubjectId`.
            Alert assignee.
          type: string
      required:
        - updateMask
      additionalProperties: false
    definitions: null
sourcePath: en/_api-ref/securitydeck/alerts/v1/api-ref/Alert/update.md
---

# Security Deck Alerts API, REST: Alert.Update

Update alert.

## HTTP request

```
PATCH https://alert-sink.{{ api-host }}/securitydeck/alerts/v1/alerts/{alertId}
```

## Path parameters

#|
||Field | Description ||
|| alertId | **string**

Required field. Alert ID to update.

The maximum string length in characters is 50. ||
|#

## Body parameters {#yandex.cloud.securitydeck.alerts.v1.UpdateAlertRequest}

```json
{
  "updateMask": "string",
  "status": "string",
  "classification": "string",
  // Includes only one of the fields `assigneeSubjectId`
  "assigneeSubjectId": "string"
  // end of the list of possible fields
}
```

#|
||Field | Description ||
|| updateMask | **string** (field-mask)

Required field. A comma-separated names off ALL fields to be updated.
Only the specified fields will be changed. The others will be left untouched.
If the field is specified in `` updateMask `` and no value for that field was sent in the request,
the field's value will be reset to the default. The default value for most fields is null or 0.

If `` updateMask `` is not sent in the request, all fields' values will be updated.
Fields specified in the request will be updated to provided values.
The rest of the fields will be reset to the default. ||
|| status | **enum** (Status)

Alert status.
Optional. Not used if not present in update_mask.

- `OPEN`: Status is "open". Alert is not being currently processed.
- `IN_PROGRESS`: Status is "in progress". Alert assignee is currently processing the alert.
- `NEED_INFO`: Status is "need info". Alert assignee cannot currently process the alert and requires additional information.
- `RESOLVED`: Status is "resolved". Alert processing has concluded. ||
|| classification | **enum** (Classification)

Alert classification.
Optional. Can be omitted but present in update_mask to remove classification. Not used if not present in update_mask.

- `TRUE_POSITIVE`: Alert represents an actual problem that needs to be mitigated.
- `BENIGN_POSITIVE`: Alert represents a legitimate problem but does not require attention.
- `FALSE_POSITIVE`: Alert represents something that's not an issue.
- `UNDETERMINED`: Alert relevance cannot be determined. ||
|| assigneeSubjectId | **string**

Assign alert to a subject with specified ID.
Subject must be a USER_ACCOUNT resolvable by method caller.
Optional. Can be omitted but present in update_mask to remove assignee. Not used if not present in update_mask.

Includes only one of the fields `assigneeSubjectId`.

Alert assignee. ||
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
    "alertId": "string"
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
    "sinkId": "string",
    "title": "string",
    "description": "string",
    "recommendations": "string",
    "severity": "string",
    "status": "string",
    "category": {
      "name": "string"
    },
    "classification": "string",
    "createdBy": {
      // Includes only one of the fields `subject`, `sensor`
      "subject": {
        "id": "string"
      },
      "sensor": {
        "id": "string"
      }
      // end of the list of possible fields
    },
    "assignee": {
      // Includes only one of the fields `subject`
      "subject": {
        "id": "string"
      }
      // end of the list of possible fields
    },
    "createTime": "string",
    "updateTime": "string",
    "details": "object"
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
|| metadata | **[UpdateAlertMetadata](#yandex.cloud.securitydeck.alerts.v1.UpdateAlertMetadata)**

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
|| response | **[Alert](#yandex.cloud.securitydeck.alerts.v1.Alert)**

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

## UpdateAlertMetadata {#yandex.cloud.securitydeck.alerts.v1.UpdateAlertMetadata}

#|
||Field | Description ||
|| alertId | **string**

Alert ID. ||
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

## Alert {#yandex.cloud.securitydeck.alerts.v1.Alert}

Security Deck alert.

#|
||Field | Description ||
|| id | **string**

ID of the alert. ||
|| sinkId | **string**

ID of the alert sink alert is in. ||
|| title | **string**

Alert title. Plain text in requested language. ||
|| description | **string**

Alert description. Yandex Flavored Markdown in requested language.
Optional. Only present in Get method response.
May be absent in Get method response if description is not available in requested language. ||
|| recommendations | **string**

Alert recommendations. Yandex Flavored Markdown in requested language.
Optional. Only present in Get method response.
May be absent in Get method response if recommendations are not available in requested language. ||
|| severity | **enum** (Severity)

Alert severity.

- `INFO`: Informational severity
- `LOW`: Low severity
- `MEDIUM`: Medium severity
- `HIGH`: High severity ||
|| status | **enum** (Status)

Alert status.

- `OPEN`: Status is "open". Alert is not being currently processed.
- `IN_PROGRESS`: Status is "in progress". Alert assignee is currently processing the alert.
- `NEED_INFO`: Status is "need info". Alert assignee cannot currently process the alert and requires additional information.
- `RESOLVED`: Status is "resolved". Alert processing has concluded. ||
|| category | **[Category](#yandex.cloud.securitydeck.alerts.v1.Alert.Category)**

Alert category (aka threat type). ||
|| classification | **enum** (Classification)

Alert classification.
Optional. Can be assigned after creation.

- `TRUE_POSITIVE`: Alert represents an actual problem that needs to be mitigated.
- `BENIGN_POSITIVE`: Alert represents a legitimate problem but does not require attention.
- `FALSE_POSITIVE`: Alert represents something that's not an issue.
- `UNDETERMINED`: Alert relevance cannot be determined. ||
|| createdBy | **[Actor](#yandex.cloud.securitydeck.alerts.v1.Actor)**

Who created the alert. ||
|| assignee | **[Assignee](#yandex.cloud.securitydeck.alerts.v1.Alert.Assignee)**

Who the alert is assigned to.
Optional. Can be assigned after creation. ||
|| createTime | **string** (date-time)

Alert creation time.
This time is reported by alert creator and can generally be different from the moment the alert record was created.
E.g. a security event occurred at time A and it took B amount of time to deliver the alert to the Alert Sink.
This time is the A and not the A+B.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| updateTime | **string** (date-time)

Alert modification time.
Represents last time alert record itself was modified, not including anything alert-related (comments, etc.)
Equals to create_time immediately after creation.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| details | **object**

Alert technical details.
Optional. Only present in Get method response. ||
|#

## Category {#yandex.cloud.securitydeck.alerts.v1.Alert.Category}

Alert category.

#|
||Field | Description ||
|| name | **string**

Alert category name. ||
|#

## Actor {#yandex.cloud.securitydeck.alerts.v1.Actor}

Information about an entity that performed an action (created an alert, added a comment, etc.).

#|
||Field | Description ||
|| subject | **[Subject](#yandex.cloud.securitydeck.alerts.v1.Actor.Subject)**

Action was performed by a specific Cloud subject.

Includes only one of the fields `subject`, `sensor`. ||
|| sensor | **[Sensor](#yandex.cloud.securitydeck.alerts.v1.Actor.Sensor)**

Action was performed by (or on behalf of) an alert provider system (aka sensor)

Includes only one of the fields `subject`, `sensor`. ||
|#

## Subject {#yandex.cloud.securitydeck.alerts.v1.Actor.Subject}

Cloud subject.

#|
||Field | Description ||
|| id | **string**

Subject ID. ||
|#

## Sensor {#yandex.cloud.securitydeck.alerts.v1.Actor.Sensor}

Alert provider system (aka sensor).

#|
||Field | Description ||
|| id | **string**

Sensor ID. ||
|#

## Assignee {#yandex.cloud.securitydeck.alerts.v1.Alert.Assignee}

Information about an entity that alert was assigned to.

#|
||Field | Description ||
|| subject | **[Subject](#yandex.cloud.securitydeck.alerts.v1.Alert.Assignee.Subject)**

Alert is assigned to as specific Cloud subject.

Includes only one of the fields `subject`. ||
|#

## Subject {#yandex.cloud.securitydeck.alerts.v1.Alert.Assignee.Subject}

Cloud subject.

#|
||Field | Description ||
|| id | **string**

Subject ID. ||
|#