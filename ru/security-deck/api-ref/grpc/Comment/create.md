---
editable: false
sourcePath: en/_api-ref-grpc/securitydeck/alerts/v1/api-ref/grpc/Comment/create.md
---

# Security Deck Alerts API, gRPC: CommentService.Create

Create a comment for a specified alert.

## gRPC request

**rpc Create ([CreateCommentRequest](#yandex.cloud.securitydeck.alerts.v1.CreateCommentRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateCommentRequest {#yandex.cloud.securitydeck.alerts.v1.CreateCommentRequest}

```json
{
  "alert_id": "string",
  "text": "string"
}
```

#|
||Field | Description ||
|| alert_id | **string**

Required field. ID of the alert to create a comment for.

The maximum string length in characters is 50. ||
|| text | **string**

Required field. Comment contents. Yandex Flavored Markdown.

The maximum string length in characters is 4096. ||
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
    "comment_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "alert_id": "string",
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
    "create_time": "google.protobuf.Timestamp",
    "updated_by": {
      // Includes only one of the fields `subject`, `sensor`
      "subject": {
        "id": "string"
      },
      "sensor": {
        "id": "string"
      }
      // end of the list of possible fields
    },
    "update_time": "google.protobuf.Timestamp",
    "text": "string"
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
|| metadata | **[CreateCommentMetadata](#yandex.cloud.securitydeck.alerts.v1.CreateCommentMetadata)**

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
|| response | **[Comment](#yandex.cloud.securitydeck.alerts.v1.Comment)**

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

## CreateCommentMetadata {#yandex.cloud.securitydeck.alerts.v1.CreateCommentMetadata}

#|
||Field | Description ||
|| comment_id | **string**

ID of the comment that is being created. ||
|#

## Comment {#yandex.cloud.securitydeck.alerts.v1.Comment}

A comment.

#|
||Field | Description ||
|| id | **string**

Comment ID. ||
|| alert_id | **string**

ID of the alert the comment is for. ||
|| created_by | **[Actor](#yandex.cloud.securitydeck.alerts.v1.Actor)**

Who created the comment. ||
|| create_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Comment creation date. ||
|| updated_by | **[Actor](#yandex.cloud.securitydeck.alerts.v1.Actor)**

Who modified the comment last.
Optional. Not present if comment was not modified after initial creation. ||
|| update_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

When was the comment last modified.
Optional. Not present if comment was not modified after initial creation. ||
|| text | **string**

The comment contents. Yandex Flavored Markdown. ||
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