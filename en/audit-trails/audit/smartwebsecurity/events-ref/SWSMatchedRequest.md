---
editable: false
---

# Smart Web Security Audit Trails Events: SWSMatchedRequest

## Event JSON schema {#yandex.cloud.audit.smartwebsecurity.SWSMatchedRequest2-schema}

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
    "clientIp": "string",
    "requestTime": "string",
    "albId": "string",
    "albRequestId": "string",
    "uniqueKey": "string",
    "httpVersion": "string",
    "httpMethod": "string",
    "httpHost": "string",
    "httpPath": "string",
    "httpQueries": "string",
    "headers": [
      {
        "key": "string",
        "value": "string"
      }
    ],
    "securityProfileId": "string",
    "securityProfileName": "string",
    "moduleType": "string",
    "action": "string",
    "arlProfileId": "string",
    "arlProfileName": "string",
    "arlVerdict": "string",
    "arlAppliedQuotaName": "string",
    "arlMatchedQuotas": [
      {
        "quotaName": "string",
        "allowed": "string",
        "dryRun": "string",
        "priority": "string",
        "counter": "string",
        "requests": "string",
        "period": "string",
        "limit": "string",
        "banPeriod": "string"
      }
    ],
    "matchedRuleName": "string",
    "matchedRuleVerdict": "string",
    "wafProfileId": "string",
    "wafProfileName": "string",
    "wafAppliedRuleSetId": "string",
    "wafRuleSetsIds": [
      "string"
    ],
    "wafMatchedRules": "object",
    "wafMatchedExclusionRules": [
      {
        "exclusionRuleName": "string",
        "excludedRuleIds": [
          "string"
        ]
      }
    ],
    "dryRunMatchedRuleName": "string",
    "dryRunMatchedRuleVerdict": "string",
    "dryRunWafProfileId": "string",
    "dryRunWafProfileName": "string",
    "dryRunWafAppliedRuleSetId": "string",
    "dryRunWafRuleSetsIds": [
      "string"
    ],
    "dryRunWafMatchedRules": "object",
    "dryRunWafMatchedExclusionRules": [
      {
        "exclusionRuleName": "string",
        "excludedRuleIds": [
          "string"
        ]
      }
    ],
    "customPageId": "string",
    "customPageName": "string",
    "botScore": "string",
    "botName": "string",
    "botCategory": "string",
    "verifiedBot": "string",
    "ja3": "string",
    "ja4": "string",
    "asnList": [
      "string"
    ],
    "country": "string",
    "userAgent": "string",
    "matchedRuleType": "string",
    "dryRunMatchedRuleType": "string",
    "httpBodySize": "string"
  },
  "requestParameters": "object",
  "response": "object"
}
```

## Field description {#yandex.cloud.audit.smartwebsecurity.SWSMatchedRequest2}

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
|| details | **[SWSMatchedRequestDetails](#yandex.cloud.audit.smartwebsecurity.SWSMatchedRequestDetails)** ||
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

## SWSMatchedRequestDetails {#yandex.cloud.audit.smartwebsecurity.SWSMatchedRequestDetails}

#|
||Field | Description ||
|| clientIp | **string** ||
|| requestTime | **string** ||
|| albId | **string** ||
|| albRequestId | **string** ||
|| uniqueKey | **string** ||
|| httpVersion | **string** ||
|| httpMethod | **string** ||
|| httpHost | **string** ||
|| httpPath | **string** ||
|| httpQueries | **string** ||
|| headers[] | **[Header](#yandex.cloud.audit.smartwebsecurity.SWSMatchedRequestDetails.Header)** ||
|| securityProfileId | **string** ||
|| securityProfileName | **string** ||
|| moduleType | **string** ||
|| action | **string** ||
|| arlProfileId | **string** ||
|| arlProfileName | **string** ||
|| arlVerdict | **string** ||
|| arlAppliedQuotaName | **string** ||
|| arlMatchedQuotas[] | **[MatchedQuota](#yandex.cloud.audit.smartwebsecurity.SWSMatchedRequestDetails.MatchedQuota)** ||
|| matchedRuleName | **string** ||
|| matchedRuleVerdict | **string** ||
|| wafProfileId | **string** ||
|| wafProfileName | **string** ||
|| wafAppliedRuleSetId | **string** ||
|| wafRuleSetsIds[] | **string** ||
|| wafMatchedRules | **object** (map<**string**, **[MatchedRulesList](#yandex.cloud.audit.smartwebsecurity.SWSMatchedRequestDetails.MatchedRulesList)**>) ||
|| wafMatchedExclusionRules[] | **[WafMatchedExclusionRule](#yandex.cloud.audit.smartwebsecurity.SWSMatchedRequestDetails.WafMatchedExclusionRule)** ||
|| dryRunMatchedRuleName | **string** ||
|| dryRunMatchedRuleVerdict | **string** ||
|| dryRunWafProfileId | **string** ||
|| dryRunWafProfileName | **string** ||
|| dryRunWafAppliedRuleSetId | **string** ||
|| dryRunWafRuleSetsIds[] | **string** ||
|| dryRunWafMatchedRules | **object** (map<**string**, **[MatchedRulesList](#yandex.cloud.audit.smartwebsecurity.SWSMatchedRequestDetails.MatchedRulesList)**>) ||
|| dryRunWafMatchedExclusionRules[] | **[WafMatchedExclusionRule](#yandex.cloud.audit.smartwebsecurity.SWSMatchedRequestDetails.WafMatchedExclusionRule)** ||
|| customPageId | **string** ||
|| customPageName | **string** ||
|| botScore | **string** ||
|| botName | **string** ||
|| botCategory | **string** ||
|| verifiedBot | **string** ||
|| ja3 | **string** ||
|| ja4 | **string** ||
|| asnList[] | **string** ||
|| country | **string** ||
|| userAgent | **string** ||
|| matchedRuleType | **string** ||
|| dryRunMatchedRuleType | **string** ||
|| httpBodySize | **string** ||
|#

## Header {#yandex.cloud.audit.smartwebsecurity.SWSMatchedRequestDetails.Header}

#|
||Field | Description ||
|| key | **string** ||
|| value | **string** ||
|#

## MatchedQuota {#yandex.cloud.audit.smartwebsecurity.SWSMatchedRequestDetails.MatchedQuota}

#|
||Field | Description ||
|| quotaName | **string** ||
|| allowed | **string** ||
|| dryRun | **string** ||
|| priority | **string** ||
|| counter | **string** ||
|| requests | **string** ||
|| period | **string** ||
|| limit | **string** ||
|| banPeriod | **string** ||
|#

## MatchedRulesList {#yandex.cloud.audit.smartwebsecurity.SWSMatchedRequestDetails.MatchedRulesList}

#|
||Field | Description ||
|| rules[] | **[WafMatchedRule](#yandex.cloud.audit.smartwebsecurity.SWSMatchedRequestDetails.WafMatchedRule)** ||
|#

## WafMatchedRule {#yandex.cloud.audit.smartwebsecurity.SWSMatchedRequestDetails.WafMatchedRule}

#|
||Field | Description ||
|| score | **string** ||
|| ruleId | **string** ||
|| ruleSetId | **string** ||
|| ruleGroupId | **string** ||
|| data | **string** ||
|| message | **string** ||
|| matchedDataVariable | **string** ||
|| matchedDataKey | **string** ||
|| matchedDataValue | **string** ||
|| isBlockingRule | **string** ||
|#

## WafMatchedExclusionRule {#yandex.cloud.audit.smartwebsecurity.SWSMatchedRequestDetails.WafMatchedExclusionRule}

#|
||Field | Description ||
|| exclusionRuleName | **string** ||
|| excludedRuleIds[] | **string** ||
|#