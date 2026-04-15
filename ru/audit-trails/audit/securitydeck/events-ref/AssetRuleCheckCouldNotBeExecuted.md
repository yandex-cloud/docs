---
editable: false
---

# Security Deck Audit Trails Events: AssetRuleCheckCouldNotBeExecuted

## Event JSON schema {#yandex.cloud.audit.securitydeck.cspm.AssetRuleCheckCouldNotBeExecuted2-schema}

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
    "scanDetails": {
      "workspaceId": "string",
      "workspaceName": "string",
      "scopeId": "string",
      "scanJobId": "string",
      "scanId": "string"
    },
    "ruleDetails": {
      "title": {
        "ruText": "string",
        "enText": "string"
      },
      "severity": "string",
      "ruleId": "string",
      "ruleKind": "string",
      "status": "string"
    },
    "assetDetails": {
      "fullResourceId": "string",
      "mainResourcePath": "string",
      "assetStateAt": "string",
      "assetProviderType": "string",
      // Includes only one of the fields `yandexCloudProviderMetadata`
      "yandexCloudProviderMetadata": {
        "organizationId": "string",
        "cloudId": "string",
        "cloudName": "string",
        "folderId": "string",
        "folderName": "string"
      }
      // end of the list of possible fields
    },
    "errorType": "string"
  }
}
```

## Field description {#yandex.cloud.audit.securitydeck.cspm.AssetRuleCheckCouldNotBeExecuted2}

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
|| eventStatus | **enum** (SynchronousEventStatus)

- `ERROR`
- `DONE` ||
|| details | **[AssetRuleCheckCouldNotBeExecutedEventDetails](#yandex.cloud.audit.securitydeck.cspm.AssetRuleCheckCouldNotBeExecutedEventDetails)** ||
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

## AssetRuleCheckCouldNotBeExecutedEventDetails {#yandex.cloud.audit.securitydeck.cspm.AssetRuleCheckCouldNotBeExecutedEventDetails}

#|
||Field | Description ||
|| scanDetails | **[ScanEventDetails](#yandex.cloud.audit.securitydeck.cspm.ScanEventDetails)** ||
|| ruleDetails | **[RuleDetails](#yandex.cloud.audit.securitydeck.cspm.RuleDetails)** ||
|| assetDetails | **[AssetDetails](#yandex.cloud.audit.securitydeck.cspm.AssetDetails)** ||
|| errorType | **enum** (ErrorType)

- `ACCESS_DENIED` ||
|#

## ScanEventDetails {#yandex.cloud.audit.securitydeck.cspm.ScanEventDetails}

#|
||Field | Description ||
|| workspaceId | **string** ||
|| workspaceName | **string** ||
|| scopeId | **string** ||
|| scanJobId | **string** ||
|| scanId | **string** ||
|#

## RuleDetails {#yandex.cloud.audit.securitydeck.cspm.RuleDetails}

#|
||Field | Description ||
|| title | **[I18nMessage](#yandex.cloud.audit.securitydeck.cspm.I18nMessage)** ||
|| severity | **enum** (Severity)

- `CRITICAL`
- `HIGH`
- `MEDIUM`
- `LOW`
- `INFORMATION` ||
|| ruleId | **string** ||
|| ruleKind | **string** ||
|| status | **enum** (RuleCheckStatus)

- `PASS`
- `MANUAL_PASS`
- `FAIL`
- `ERROR` ||
|#

## I18nMessage {#yandex.cloud.audit.securitydeck.cspm.I18nMessage}

#|
||Field | Description ||
|| ruText | **string** ||
|| enText | **string** ||
|#

## AssetDetails {#yandex.cloud.audit.securitydeck.cspm.AssetDetails}

#|
||Field | Description ||
|| fullResourceId | **string** ||
|| mainResourcePath | **string** ||
|| assetStateAt | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| assetProviderType | **enum** (AssetProviderType)

- `YANDEX_CLOUD` ||
|| yandexCloudProviderMetadata | **[YandexCloudProviderMetadata](#yandex.cloud.audit.securitydeck.cspm.YandexCloudProviderMetadata)**

Includes only one of the fields `yandexCloudProviderMetadata`. ||
|#

## YandexCloudProviderMetadata {#yandex.cloud.audit.securitydeck.cspm.YandexCloudProviderMetadata}

#|
||Field | Description ||
|| organizationId | **string** ||
|| cloudId | **string** ||
|| cloudName | **string** ||
|| folderId | **string** ||
|| folderName | **string** ||
|#