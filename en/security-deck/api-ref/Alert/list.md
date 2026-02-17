---
editable: false
apiPlayground:
  - url: https://alert-sink.{{ api-host }}/securitydeck/alerts/v1/sinks/{sinkId}/alerts
    method: get
    path:
      type: object
      properties:
        sinkId:
          description: |-
            **string**
            Required field. Alert sink ID.
            The maximum string length in characters is 50.
          type: string
      required:
        - sinkId
      additionalProperties: false
    query:
      type: object
      properties:
        languageCode:
          description: |-
            **string**
            Language code. What language should alert texts be in.
            Supported values: "en_US" for English, "ru_RU" for Russian.
            If requested language is unavailable, language-dependent fields will be omitted.
            Optional. Defaults to "en_US" if not specified.
            The maximum string length in characters is 10.
          type: string
        filter:
          description: |-
            **string**
            Filtering expression. See documentation on filter capabilities and syntax.
            Optional. Not filtering if not specified.
            The maximum string length in characters is 2048.
          type: string
        orderBy:
          description: |-
            **string**
            Sorting order.
            Element format: "&lt;field_name&gt; [asc|desc]".
            Optional. Defaults to "create_time desc" if not specified.
            The maximum number of elements is 1.
          type: array
          items:
            type: string
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
---

# Security Deck Alerts API, REST: Alert.List

List alerts.

## HTTP request

```
GET https://alert-sink.{{ api-host }}/securitydeck/alerts/v1/sinks/{sinkId}/alerts
```

## Path parameters

#|
||Field | Description ||
|| sinkId | **string**

Required field. Alert sink ID.

The maximum string length in characters is 50. ||
|#

## Query parameters {#yandex.cloud.securitydeck.alerts.v1.ListAlertsRequest}

#|
||Field | Description ||
|| languageCode | **string**

Language code. What language should alert texts be in.
Supported values: "en_US" for English, "ru_RU" for Russian.
If requested language is unavailable, language-dependent fields will be omitted.
Optional. Defaults to "en_US" if not specified.

The maximum string length in characters is 10. ||
|| filter | **string**

Filtering expression. See documentation on filter capabilities and syntax.
Optional. Not filtering if not specified.

The maximum string length in characters is 2048. ||
|| orderBy[] | **string**

Sorting order.
Element format: "&lt;field_name&gt; [asc\|desc]".
Optional. Defaults to "create_time desc" if not specified.

The maximum number of elements is 1. ||
|| pageSize | **string** (int64)

Number of results per page.

The maximum value is 1000. ||
|| pageToken | **string**

Token for the results page.

The maximum string length in characters is 200. ||
|#

## Response {#yandex.cloud.securitydeck.alerts.v1.ListAlertsResponse}

**HTTP Code: 200 - OK**

```json
{
  "alerts": [
    {
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
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| alerts[] | **[Alert](#yandex.cloud.securitydeck.alerts.v1.Alert)**

Requested alerts.
Only a subset of fields that makes sense for listing is returned (e.g. description, recommendations and details are omitted). ||
|| nextPageToken | **string**

Token for the next results page. ||
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