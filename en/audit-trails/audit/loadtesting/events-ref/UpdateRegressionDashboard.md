---
editable: false
---

# Load Testing Audit Trails Events: UpdateRegressionDashboard

## Event JSON schema {#yandex.cloud.audit.loadtesting.UpdateRegressionDashboard2-schema}

```json
{
  "eventId": "string",
  "eventSource": "string",
  "eventType": "string",
  "eventTime": "string",
  "authentication": {
    "authenticated": "boolean",
    // Includes only one of the fields `subjectType`
    "subjectType": "string",
    // end of the list of possible fields
    // Includes only one of the fields `subjectId`
    "subjectId": "string",
    // end of the list of possible fields
    // Includes only one of the fields `subjectName`
    "subjectName": "string",
    // end of the list of possible fields
    // Includes only one of the fields `federationId`
    "federationId": "string",
    // end of the list of possible fields
    // Includes only one of the fields `federationName`
    "federationName": "string",
    // end of the list of possible fields
    // Includes only one of the fields `federationType`
    "federationType": "string",
    // end of the list of possible fields
    "tokenInfo": {
      "maskedIamToken": "string",
      // Includes only one of the fields `iamTokenId`
      "iamTokenId": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorId`
      "impersonatorId": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorType`
      "impersonatorType": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorName`
      "impersonatorName": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorFederationId`
      "impersonatorFederationId": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorFederationName`
      "impersonatorFederationName": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorFederationType`
      "impersonatorFederationType": "string"
      // end of the list of possible fields
    }
  },
  "authorization": {
    "authorized": "boolean"
  },
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
  "requestMetadata": {
    "remoteAddress": "string",
    "userAgent": "string",
    "requestId": "string",
    // Includes only one of the fields `remotePort`
    "remotePort": "string"
    // end of the list of possible fields
  },
  "eventStatus": "string",
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "details": {
    "dashboardId": "string",
    "dashboardName": "string",
    "description": "string",
    "updatedAt": "string",
    "updatedBy": "string",
    "content": {
      "widgets": [
        {
          // Includes only one of the fields `chart`, `text`, `title`
          "chart": {
            "id": "string",
            "name": "string",
            "description": "string",
            "filterStr": "string",
            "testCase": "string",
            "kpis": [
              {
                "selector": {
                  // Includes only one of the fields `responseTime`, `instances`, `imbalanceRps`, `protocolCodesAbsolute`, `protocolCodesRelative`, `networkCodesAbsolute`, `networkCodesRelative`
                  "responseTime": {
                    "quantile": "string"
                  },
                  "instances": {
                    "agg": "string"
                  },
                  "imbalanceRps": "object",
                  "protocolCodesAbsolute": {
                    "codesPatterns": [
                      "string"
                    ]
                  },
                  "protocolCodesRelative": {
                    "codesPatterns": [
                      "string"
                    ]
                  },
                  "networkCodesAbsolute": {
                    "codesPatterns": [
                      "string"
                    ]
                  },
                  "networkCodesRelative": {
                    "codesPatterns": [
                      "string"
                    ]
                  }
                  // end of the list of possible fields
                },
                "threshold": {
                  "value": "string",
                  "comparison": "string"
                }
              }
            ]
          },
          "text": {
            "text": "string"
          },
          "title": {
            "text": "string"
          }
          // end of the list of possible fields
        }
      ]
    }
  },
  "requestParameters": "object",
  "response": "object"
}
```

## Field description {#yandex.cloud.audit.loadtesting.UpdateRegressionDashboard2}

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
|| authentication | **[IamAuthentication](#yandex.cloud.audit.IamAuthentication)** ||
|| authorization | **[Authorization](#yandex.cloud.audit.Authorization)** ||
|| resourceMetadata | **[ResourceMetadata](#yandex.cloud.audit.ResourceMetadata)** ||
|| requestMetadata | **[RequestMetadata](#yandex.cloud.audit.RequestMetadata)** ||
|| eventStatus | **enum** (EventStatus)

- `STARTED`
- `ERROR`
- `DONE`
- `CANCELLED`
- `RUNNING` ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation. ||
|| details | **[Details](#yandex.cloud.audit.loadtesting.UpdateRegressionDashboard.Details)** ||
|| requestParameters | **object** ||
|| response | **object** ||
|#

## IamAuthentication {#yandex.cloud.audit.IamAuthentication}

#|
||Field | Description ||
|| authenticated | **boolean** ||
|| subjectType | **enum** (IamSubjectType)

Includes only one of the fields `subjectType`.

- `YANDEX_PASSPORT_USER_ACCOUNT`
- `SERVICE_ACCOUNT`
- `FEDERATED_USER_ACCOUNT`
- `SSH_USER`
- `KUBERNETES_USER` ||
|| subjectId | **string**

Includes only one of the fields `subjectId`. ||
|| subjectName | **string**

Includes only one of the fields `subjectName`. ||
|| federationId | **string**

Includes only one of the fields `federationId`. ||
|| federationName | **string**

Includes only one of the fields `federationName`. ||
|| federationType | **enum** (FederationType)

Includes only one of the fields `federationType`.

- `GLOBAL_FEDERATION`
- `PRIVATE_FEDERATION` ||
|| tokenInfo | **[IamTokenInfo](#yandex.cloud.audit.IamAuthentication.IamTokenInfo)** ||
|#

## IamTokenInfo {#yandex.cloud.audit.IamAuthentication.IamTokenInfo}

#|
||Field | Description ||
|| maskedIamToken | **string** ||
|| iamTokenId | **string**

Includes only one of the fields `iamTokenId`. ||
|| impersonatorId | **string**

Includes only one of the fields `impersonatorId`. ||
|| impersonatorType | **enum** (IamSubjectType)

Includes only one of the fields `impersonatorType`.

- `YANDEX_PASSPORT_USER_ACCOUNT`
- `SERVICE_ACCOUNT`
- `FEDERATED_USER_ACCOUNT`
- `SSH_USER`
- `KUBERNETES_USER` ||
|| impersonatorName | **string**

Includes only one of the fields `impersonatorName`. ||
|| impersonatorFederationId | **string**

Includes only one of the fields `impersonatorFederationId`. ||
|| impersonatorFederationName | **string**

Includes only one of the fields `impersonatorFederationName`. ||
|| impersonatorFederationType | **enum** (FederationType)

Includes only one of the fields `impersonatorFederationType`.

- `GLOBAL_FEDERATION`
- `PRIVATE_FEDERATION` ||
|#

## Authorization {#yandex.cloud.audit.Authorization}

#|
||Field | Description ||
|| authorized | **boolean** ||
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

## RequestMetadata {#yandex.cloud.audit.RequestMetadata}

#|
||Field | Description ||
|| remoteAddress | **string** ||
|| userAgent | **string** ||
|| requestId | **string** ||
|| remotePort | **string** (int64)

Includes only one of the fields `remotePort`. ||
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

## Details {#yandex.cloud.audit.loadtesting.UpdateRegressionDashboard.Details}

#|
||Field | Description ||
|| dashboardId | **string** ||
|| dashboardName | **string** ||
|| description | **string** ||
|| updatedAt | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| updatedBy | **string** ||
|| content | **[Content](#yandex.cloud.audit.loadtesting.Content)** ||
|#

## Content {#yandex.cloud.audit.loadtesting.Content}

#|
||Field | Description ||
|| widgets[] | **[Widget](#yandex.cloud.audit.loadtesting.Widget)** ||
|#

## Widget {#yandex.cloud.audit.loadtesting.Widget}

#|
||Field | Description ||
|| chart | **[ChartWidget](#yandex.cloud.audit.loadtesting.Widget.ChartWidget)**

Includes only one of the fields `chart`, `text`, `title`. ||
|| text | **[TextWidget](#yandex.cloud.audit.loadtesting.Widget.TextWidget)**

Includes only one of the fields `chart`, `text`, `title`. ||
|| title | **[TitleWidget](#yandex.cloud.audit.loadtesting.Widget.TitleWidget)**

Includes only one of the fields `chart`, `text`, `title`. ||
|#

## ChartWidget {#yandex.cloud.audit.loadtesting.Widget.ChartWidget}

#|
||Field | Description ||
|| id | **string** ||
|| name | **string** ||
|| description | **string** ||
|| filterStr | **string** ||
|| testCase | **string** ||
|| kpis[] | **[Kpi](#yandex.cloud.loadtesting.api.v1.report.Kpi)** ||
|#

## Kpi {#yandex.cloud.loadtesting.api.v1.report.Kpi}

#|
||Field | Description ||
|| selector | **[KpiSelector](#yandex.cloud.loadtesting.api.v1.report.KpiSelector)** ||
|| threshold | **[KpiThreshold](#yandex.cloud.loadtesting.api.v1.report.KpiThreshold)** ||
|#

## KpiSelector {#yandex.cloud.loadtesting.api.v1.report.KpiSelector}

#|
||Field | Description ||
|| responseTime | **[ResponseTime](#yandex.cloud.loadtesting.api.v1.report.KpiSelector.ResponseTime)**

Includes only one of the fields `responseTime`, `instances`, `imbalanceRps`, `protocolCodesAbsolute`, `protocolCodesRelative`, `networkCodesAbsolute`, `networkCodesRelative`. ||
|| instances | **[Instances](#yandex.cloud.loadtesting.api.v1.report.KpiSelector.Instances)**

Includes only one of the fields `responseTime`, `instances`, `imbalanceRps`, `protocolCodesAbsolute`, `protocolCodesRelative`, `networkCodesAbsolute`, `networkCodesRelative`. ||
|| imbalanceRps | **object**

Includes only one of the fields `responseTime`, `instances`, `imbalanceRps`, `protocolCodesAbsolute`, `protocolCodesRelative`, `networkCodesAbsolute`, `networkCodesRelative`. ||
|| protocolCodesAbsolute | **[ProtocolCodesAbsolute](#yandex.cloud.loadtesting.api.v1.report.KpiSelector.ProtocolCodesAbsolute)**

Includes only one of the fields `responseTime`, `instances`, `imbalanceRps`, `protocolCodesAbsolute`, `protocolCodesRelative`, `networkCodesAbsolute`, `networkCodesRelative`. ||
|| protocolCodesRelative | **[ProtocolCodesRelative](#yandex.cloud.loadtesting.api.v1.report.KpiSelector.ProtocolCodesRelative)**

Includes only one of the fields `responseTime`, `instances`, `imbalanceRps`, `protocolCodesAbsolute`, `protocolCodesRelative`, `networkCodesAbsolute`, `networkCodesRelative`. ||
|| networkCodesAbsolute | **[NetworkCodesAbsolute](#yandex.cloud.loadtesting.api.v1.report.KpiSelector.NetworkCodesAbsolute)**

Includes only one of the fields `responseTime`, `instances`, `imbalanceRps`, `protocolCodesAbsolute`, `protocolCodesRelative`, `networkCodesAbsolute`, `networkCodesRelative`. ||
|| networkCodesRelative | **[NetworkCodesRelative](#yandex.cloud.loadtesting.api.v1.report.KpiSelector.NetworkCodesRelative)**

Includes only one of the fields `responseTime`, `instances`, `imbalanceRps`, `protocolCodesAbsolute`, `protocolCodesRelative`, `networkCodesAbsolute`, `networkCodesRelative`. ||
|#

## ResponseTime {#yandex.cloud.loadtesting.api.v1.report.KpiSelector.ResponseTime}

#|
||Field | Description ||
|| quantile | **enum** (QuantileType)

- `QUANTILE_TYPE_50`
- `QUANTILE_TYPE_75`
- `QUANTILE_TYPE_80`
- `QUANTILE_TYPE_85`
- `QUANTILE_TYPE_90`
- `QUANTILE_TYPE_95`
- `QUANTILE_TYPE_98`
- `QUANTILE_TYPE_99`
- `QUANTILE_TYPE_100` ||
|#

## Instances {#yandex.cloud.loadtesting.api.v1.report.KpiSelector.Instances}

#|
||Field | Description ||
|| agg | **enum** (Aggregation)

- `AGGREGATION_MIN`
- `AGGREGATION_MAX`
- `AGGREGATION_AVG`
- `AGGREGATION_MEDIAN`
- `AGGREGATION_STD_DEV` ||
|#

## ProtocolCodesAbsolute {#yandex.cloud.loadtesting.api.v1.report.KpiSelector.ProtocolCodesAbsolute}

#|
||Field | Description ||
|| codesPatterns[] | **string** ||
|#

## ProtocolCodesRelative {#yandex.cloud.loadtesting.api.v1.report.KpiSelector.ProtocolCodesRelative}

#|
||Field | Description ||
|| codesPatterns[] | **string** ||
|#

## NetworkCodesAbsolute {#yandex.cloud.loadtesting.api.v1.report.KpiSelector.NetworkCodesAbsolute}

#|
||Field | Description ||
|| codesPatterns[] | **string** ||
|#

## NetworkCodesRelative {#yandex.cloud.loadtesting.api.v1.report.KpiSelector.NetworkCodesRelative}

#|
||Field | Description ||
|| codesPatterns[] | **string** ||
|#

## KpiThreshold {#yandex.cloud.loadtesting.api.v1.report.KpiThreshold}

#|
||Field | Description ||
|| value | **string** ||
|| comparison | **enum** (Comparison)

- `COMPARISON_LT`
- `COMPARISON_LTE`
- `COMPARISON_GT`
- `COMPARISON_GTE` ||
|#

## TextWidget {#yandex.cloud.audit.loadtesting.Widget.TextWidget}

#|
||Field | Description ||
|| text | **string** ||
|#

## TitleWidget {#yandex.cloud.audit.loadtesting.Widget.TitleWidget}

#|
||Field | Description ||
|| text | **string** ||
|#