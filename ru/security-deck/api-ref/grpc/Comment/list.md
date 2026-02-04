---
editable: false
sourcePath: en/_api-ref-grpc/securitydeck/alerts/v1/api-ref/grpc/Comment/list.md
---

# Security Deck Alerts API, gRPC: CommentService.List

List comments.

## gRPC request

**rpc List ([ListCommentsRequest](#yandex.cloud.securitydeck.alerts.v1.ListCommentsRequest)) returns ([ListCommentsResponse](#yandex.cloud.securitydeck.alerts.v1.ListCommentsResponse))**

## ListCommentsRequest {#yandex.cloud.securitydeck.alerts.v1.ListCommentsRequest}

```json
{
  "alert_id": "string",
  "page_size": "int64",
  "page_token": "string"
}
```

#|
||Field | Description ||
|| alert_id | **string**

Required field. Alert ID.

The maximum string length in characters is 50. ||
|| page_size | **int64**

Number of results per page.

The maximum value is 1000. ||
|| page_token | **string**

Token for the results page.

The maximum string length in characters is 200. ||
|#

## ListCommentsResponse {#yandex.cloud.securitydeck.alerts.v1.ListCommentsResponse}

```json
{
  "comments": [
    {
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
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| comments[] | **[Comment](#yandex.cloud.securitydeck.alerts.v1.Comment)**

Requested comments. ||
|| next_page_token | **string**

Token for the next results page. ||
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