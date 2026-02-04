---
editable: false
sourcePath: en/_api-ref-grpc/securitydeck/alerts/v1/api-ref/grpc/Alert/get.md
---

# Security Deck Alerts API, gRPC: AlertService.Get

Get alert by ID.

## gRPC request

**rpc Get ([GetAlertRequest](#yandex.cloud.securitydeck.alerts.v1.GetAlertRequest)) returns ([Alert](#yandex.cloud.securitydeck.alerts.v1.Alert))**

## GetAlertRequest {#yandex.cloud.securitydeck.alerts.v1.GetAlertRequest}

```json
{
  "alert_id": "string",
  "language_code": "string",
  "details_i18n": "bool"
}
```

#|
||Field | Description ||
|| alert_id | **string**

Required field. Alert ID. ||
|| language_code | **string**

Language code. What language should alert texts be in.
Supported values: "en_US" for English, "ru_RU" for Russian.
If requested language is unavailable, language-dependent fields will be omitted.
Optional. Defaults to "en_US" if not specified.

The maximum string length in characters is 10. ||
|| details_i18n | **bool**

Should alert details be internationalized (true) or left in source representation (false). ||
|#

## Alert {#yandex.cloud.securitydeck.alerts.v1.Alert}

```json
{
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
```

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