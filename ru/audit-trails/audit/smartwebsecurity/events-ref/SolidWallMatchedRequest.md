---
editable: false
---

# Smart Web Security Audit Trails Events: SolidWallMatchedRequest

## Event JSON schema {#yandex.cloud.audit.smartwebsecurity.SolidWallMatchedRequest2-schema}

```json
{
  "eventId": "string",
  "eventSource": "string",
  "eventType": "string",
  "eventTime": "string",
  "resourceMetadata": {
    "path": [
      {
        "resourceType": "string",
        "resourceId": "string",
        // Includes only one of the fields `resourceName`
        "resourceName": "string"
        // end of the list of possible fields
      }
    ]
  },
  "eventStatus": "string",
  "details": {
    "folderId": "string",
    "solidWafWebAppId": "string",
    "solidWafWebAppName": "string",
    "solidWafProfileId": "string",
    "solidwallDashboardWebappId": "string",
    "solidwallDashboardRequestId": "string",
    "request": {
      "time": "string",
      "srcIp": "string",
      "srcPort": "string",
      "dstIp": "string",
      "dstPort": "string",
      "httpMethod": "string",
      "requestUri": "string",
      "httpProtocol": "string",
      "header": [
        {
          "name": "string",
          "value": "string"
        }
      ]
    },
    "requestDecision": {
      "decision": "string",
      "matchedRules": [
        {
          "id": "string",
          // Includes only one of the fields `name`
          "name": "string"
          // end of the list of possible fields
        }
      ]
    },
    // Includes only one of the fields `response`
    "response": {
      "time": "string",
      "httpStatusCode": "string"
    },
    // end of the list of possible fields
    // Includes only one of the fields `responseDecision`
    "responseDecision": {
      "decision": "string",
      "matchedRules": [
        {
          "id": "string",
          // Includes only one of the fields `name`
          "name": "string"
          // end of the list of possible fields
        }
      ]
    }
    // end of the list of possible fields
  }
}
```

## Field description {#yandex.cloud.audit.smartwebsecurity.SolidWallMatchedRequest2}

#|
||Field | Description ||
|| eventId | **string** ||
|| eventSource | **string** ||
|| eventType | **string** ||
|| eventTime | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| resourceMetadata | **[ResourceMetadata](#yandex.cloud.audit.ResourceMetadata)** ||
|| eventStatus | **enum** (EventStatus)

- `STARTED`
- `ERROR`
- `DONE`
- `CANCELLED`
- `RUNNING` ||
|| details | **[SolidWallMatchedRequestDetails](#yandex.cloud.audit.smartwebsecurity.SolidWallMatchedRequestDetails)** ||
|#

## ResourceMetadata {#yandex.cloud.audit.ResourceMetadata}

#|
||Field | Description ||
|| path[] | **[Resource](#yandex.cloud.audit.Resource)** ||
|#

## Resource {#yandex.cloud.audit.Resource}

#|
||Field | Description ||
|| resourceType | **string** ||
|| resourceId | **string** ||
|| resourceName | **string**

Includes only one of the fields `resourceName`. ||
|#

## SolidWallMatchedRequestDetails {#yandex.cloud.audit.smartwebsecurity.SolidWallMatchedRequestDetails}

#|
||Field | Description ||
|| folderId | **string** ||
|| solidWafWebAppId | **string** ||
|| solidWafWebAppName | **string** ||
|| solidWafProfileId | **string** ||
|| solidwallDashboardWebappId | **string** ||
|| solidwallDashboardRequestId | **string** ||
|| request | **[RequestInfo](#yandex.cloud.audit.smartwebsecurity.SolidWallMatchedRequestDetails.RequestInfo)** ||
|| requestDecision | **[Decision](#yandex.cloud.audit.smartwebsecurity.SolidWallMatchedRequestDetails.Decision)** ||
|| response | **[ResponseInfo](#yandex.cloud.audit.smartwebsecurity.SolidWallMatchedRequestDetails.ResponseInfo)**

Includes only one of the fields `response`. ||
|| responseDecision | **[Decision](#yandex.cloud.audit.smartwebsecurity.SolidWallMatchedRequestDetails.Decision)**

Includes only one of the fields `responseDecision`. ||
|#

## RequestInfo {#yandex.cloud.audit.smartwebsecurity.SolidWallMatchedRequestDetails.RequestInfo}

#|
||Field | Description ||
|| time | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| srcIp | **string** ||
|| srcPort | **string** (int64) ||
|| dstIp | **string** ||
|| dstPort | **string** (int64) ||
|| httpMethod | **string** ||
|| requestUri | **string** ||
|| httpProtocol | **string** ||
|| header[] | **[Header](#yandex.cloud.audit.smartwebsecurity.SolidWallMatchedRequestDetails.Header)** ||
|#

## Header {#yandex.cloud.audit.smartwebsecurity.SolidWallMatchedRequestDetails.Header}

#|
||Field | Description ||
|| name | **string** ||
|| value | **string** ||
|#

## Decision {#yandex.cloud.audit.smartwebsecurity.SolidWallMatchedRequestDetails.Decision}

#|
||Field | Description ||
|| decision | **enum** (DecisionType)

- `PASS`
- `BLOCK` ||
|| matchedRules[] | **[Rule](#yandex.cloud.audit.smartwebsecurity.SolidWallMatchedRequestDetails.Rule)** ||
|#

## Rule {#yandex.cloud.audit.smartwebsecurity.SolidWallMatchedRequestDetails.Rule}

#|
||Field | Description ||
|| id | **string** ||
|| name | **string**

Includes only one of the fields `name`. ||
|#

## ResponseInfo {#yandex.cloud.audit.smartwebsecurity.SolidWallMatchedRequestDetails.ResponseInfo}

#|
||Field | Description ||
|| time | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| httpStatusCode | **string** (int64) ||
|#