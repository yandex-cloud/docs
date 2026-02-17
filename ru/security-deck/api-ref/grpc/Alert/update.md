---
editable: false
---

# Security Deck Alerts API, gRPC: AlertService.Update

Update alert.

## gRPC request

**rpc Update ([UpdateAlertRequest](#yandex.cloud.securitydeck.alerts.v1.UpdateAlertRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateAlertRequest {#yandex.cloud.securitydeck.alerts.v1.UpdateAlertRequest}

```json
{
  "alert_id": "string",
  "update_mask": "google.protobuf.FieldMask",
  "status": "Status",
  "classification": "Classification",
  // Includes only one of the fields `assignee_subject_id`
  "assignee_subject_id": "string"
  // end of the list of possible fields
}
```

#|
||Field | Description ||
|| alert_id | **string**

Required field. Alert ID to update.

The maximum string length in characters is 50. ||
|| update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Required field. Field mask that specifies which fields of the alert to update. ||
|| status | enum **Status**

Alert status.
Optional. Not used if not present in update_mask.

- `OPEN`: Status is "open". Alert is not being currently processed.
- `IN_PROGRESS`: Status is "in progress". Alert assignee is currently processing the alert.
- `NEED_INFO`: Status is "need info". Alert assignee cannot currently process the alert and requires additional information.
- `RESOLVED`: Status is "resolved". Alert processing has concluded. ||
|| classification | enum **Classification**

Alert classification.
Optional. Can be omitted but present in update_mask to remove classification. Not used if not present in update_mask.

- `TRUE_POSITIVE`: Alert represents an actual problem that needs to be mitigated.
- `BENIGN_POSITIVE`: Alert represents a legitimate problem but does not require attention.
- `FALSE_POSITIVE`: Alert represents something that's not an issue.
- `UNDETERMINED`: Alert relevance cannot be determined. ||
|| assignee_subject_id | **string**

Assign alert to a subject with specified ID.
Subject must be a USER_ACCOUNT resolvable by method caller.
Optional. Can be omitted but present in update_mask to remove assignee. Not used if not present in update_mask.

Includes only one of the fields `assignee_subject_id`.

Alert assignee. ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "created_at": "google.protobuf.Timestamp",
  "created_by": "string",
  "modified_at": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "alert_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "sink_id": "string",
    "title": "string",
    "description": "string",
    "recommendations": "string",
    "severity": "Severity",
    "status": "Status",
    "category": {
      "name": "string"
    },
    "classification": "Classification",
    "created_by": {
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
    "create_time": "google.protobuf.Timestamp",
    "update_time": "google.protobuf.Timestamp",
    "details": "google.protobuf.Struct"
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
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[UpdateAlertMetadata](#yandex.cloud.securitydeck.alerts.v1.UpdateAlertMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

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
|| alert_id | **string**

Alert ID. ||
|#

## Alert {#yandex.cloud.securitydeck.alerts.v1.Alert}

Security Deck alert.

#|
||Field | Description ||
|| id | **string**

ID of the alert. ||
|| sink_id | **string**

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
|| severity | enum **Severity**

Alert severity.

- `INFO`: Informational severity
- `LOW`: Low severity
- `MEDIUM`: Medium severity
- `HIGH`: High severity ||
|| status | enum **Status**

Alert status.

- `OPEN`: Status is "open". Alert is not being currently processed.
- `IN_PROGRESS`: Status is "in progress". Alert assignee is currently processing the alert.
- `NEED_INFO`: Status is "need info". Alert assignee cannot currently process the alert and requires additional information.
- `RESOLVED`: Status is "resolved". Alert processing has concluded. ||
|| category | **[Category](#yandex.cloud.securitydeck.alerts.v1.Alert.Category)**

Alert category (aka threat type). ||
|| classification | enum **Classification**

Alert classification.
Optional. Can be assigned after creation.

- `TRUE_POSITIVE`: Alert represents an actual problem that needs to be mitigated.
- `BENIGN_POSITIVE`: Alert represents a legitimate problem but does not require attention.
- `FALSE_POSITIVE`: Alert represents something that's not an issue.
- `UNDETERMINED`: Alert relevance cannot be determined. ||
|| created_by | **[Actor](#yandex.cloud.securitydeck.alerts.v1.Actor)**

Who created the alert. ||
|| assignee | **[Assignee](#yandex.cloud.securitydeck.alerts.v1.Alert.Assignee)**

Who the alert is assigned to.
Optional. Can be assigned after creation. ||
|| create_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Alert creation time.
This time is reported by alert creator and can generally be different from the moment the alert record was created.
E.g. a security event occurred at time A and it took B amount of time to deliver the alert to the Alert Sink.
This time is the A and not the A+B. ||
|| update_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Alert modification time.
Represents last time alert record itself was modified, not including anything alert-related (comments, etc.)
Equals to create_time immediately after creation. ||
|| details | **[google.protobuf.Struct](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/struct)**

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