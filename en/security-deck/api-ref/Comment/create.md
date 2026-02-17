---
editable: false
apiPlayground:
  - url: https://alert-sink.{{ api-host }}/securitydeck/alerts/v1/alerts/{alertId}/comments
    method: post
    path:
      type: object
      properties:
        alertId:
          description: |-
            **string**
            Required field. ID of the alert to create a comment for.
            The maximum string length in characters is 50.
          type: string
      required:
        - alertId
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        text:
          description: |-
            **string**
            Required field. Comment contents. Yandex Flavored Markdown.
            The maximum string length in characters is 4096.
          type: string
      required:
        - text
      additionalProperties: false
    definitions: null
---

# Security Deck Alerts API, REST: Comment.Create

Create a comment for a specified alert.

## HTTP request

```
POST https://alert-sink.{{ api-host }}/securitydeck/alerts/v1/alerts/{alertId}/comments
```

## Path parameters

#|
||Field | Description ||
|| alertId | **string**

Required field. ID of the alert to create a comment for.

The maximum string length in characters is 50. ||
|#

## Body parameters {#yandex.cloud.securitydeck.alerts.v1.CreateCommentRequest}

```json
{
  "text": "string"
}
```

#|
||Field | Description ||
|| text | **string**

Required field. Comment contents. Yandex Flavored Markdown.

The maximum string length in characters is 4096. ||
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
    "commentId": "string"
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
    "alertId": "string",
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
    "createTime": "string",
    "updatedBy": {
      // Includes only one of the fields `subject`, `sensor`
      "subject": {
        "id": "string"
      },
      "sensor": {
        "id": "string"
      }
      // end of the list of possible fields
    },
    "updateTime": "string",
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
|| metadata | **[CreateCommentMetadata](#yandex.cloud.securitydeck.alerts.v1.CreateCommentMetadata)**

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
|| commentId | **string**

ID of the comment that is being created. ||
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

## Comment {#yandex.cloud.securitydeck.alerts.v1.Comment}

A comment.

#|
||Field | Description ||
|| id | **string**

Comment ID. ||
|| alertId | **string**

ID of the alert the comment is for. ||
|| createdBy | **[Actor](#yandex.cloud.securitydeck.alerts.v1.Actor)**

Who created the comment. ||
|| createTime | **string** (date-time)

Comment creation date.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| updatedBy | **[Actor](#yandex.cloud.securitydeck.alerts.v1.Actor)**

Who modified the comment last.
Optional. Not present if comment was not modified after initial creation. ||
|| updateTime | **string** (date-time)

When was the comment last modified.
Optional. Not present if comment was not modified after initial creation.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
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