---
editable: false
apiPlayground:
  - url: https://alert-sink.{{ api-host }}/securitydeck/alerts/v1/alerts/{alertId}/comments
    method: get
    path:
      type: object
      properties:
        alertId:
          description: |-
            **string**
            Required field. Alert ID.
            The maximum string length in characters is 50.
          type: string
      required:
        - alertId
      additionalProperties: false
    query:
      type: object
      properties:
        pageSize:
          description: |-
            **string** (int64)
            Number of results per page.
            The maximum value is 1000.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Token for the results page.
            The maximum string length in characters is 200.
          type: string
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/securitydeck/alerts/v1/api-ref/Comment/list.md
---

# Security Deck Alerts API, REST: Comment.List

List comments.

## HTTP request

```
GET https://alert-sink.{{ api-host }}/securitydeck/alerts/v1/alerts/{alertId}/comments
```

## Path parameters

#|
||Field | Description ||
|| alertId | **string**

Required field. Alert ID.

The maximum string length in characters is 50. ||
|#

## Query parameters {#yandex.cloud.securitydeck.alerts.v1.ListCommentsRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

Number of results per page.

The maximum value is 1000. ||
|| pageToken | **string**

Token for the results page.

The maximum string length in characters is 200. ||
|#

## Response {#yandex.cloud.securitydeck.alerts.v1.ListCommentsResponse}

**HTTP Code: 200 - OK**

```json
{
  "comments": [
    {
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
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| comments[] | **[Comment](#yandex.cloud.securitydeck.alerts.v1.Comment)**

Requested comments. ||
|| nextPageToken | **string**

Token for the next results page. ||
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