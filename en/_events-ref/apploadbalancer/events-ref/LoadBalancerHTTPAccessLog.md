---
editable: false
---

# Application Load Balancer Audit Trails Events: LoadBalancerHTTPAccessLog

## Event JSON schema {#yandex.cloud.audit.apploadbalancer.LoadBalancerHTTPAccessLog2-schema}

```json
{
  "eventId": "string",
  "eventSource": "string",
  "eventType": "string",
  "eventTime": "string",
  "authentication": {
    "authenticated": "boolean",
    "subjectType": "string",
    "subjectId": "string",
    "subjectName": "string",
    "federationId": "string",
    "federationName": "string",
    "federationType": "string",
    "tokenInfo": {
      "maskedIamToken": "string",
      "iamTokenId": "string",
      "impersonatorId": "string",
      "impersonatorType": "string",
      "impersonatorName": "string",
      "impersonatorFederationId": "string",
      "impersonatorFederationName": "string",
      "impersonatorFederationType": "string"
    }
  },
  "resourceMetadata": {
    "path": [
      {
        "resourceType": "string",
        "resourceId": "string",
        "resourceName": "string"
      }
    ]
  },
  "requestMetadata": {
    "remoteAddress": "string",
    "userAgent": "string",
    "requestId": "string",
    "remotePort": "string"
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
    "loadBalancerId": "string",
    "loadBalancerName": "string",
    "type": "string",
    "time": "string",
    "httpMethod": "string",
    "authority": "string",
    "requestUri": "string",
    "httpStatus": "string",
    "httpVersion": "string",
    "rewrittenRequestUri": "string",
    "referer": "string",
    "requestContentType": "string",
    "responseContentType": "string",
    "grpcService": "string",
    "grpcMethod": "string",
    "clientIp": "string",
    "clientPort": "string",
    "backendIp": "string",
    "backendPort": "string",
    "httpRouterId": "string",
    "virtualHostName": "string",
    "routeName": "string",
    "backendGroupId": "string",
    "backendName": "string",
    "requestHeadersBytes": "string",
    "requestBodyBytes": "string",
    "responseHeadersBytes": "string",
    "responseBodyBytes": "string",
    "requestProcessingTimes": {
      "requestProcessingTime": "string",
      "requestRxTime": "string",
      "requestTxTime": "string",
      "backendResponseTime": "string",
      "backendProcessingTime": "string",
      "responseProcessingTime": "string",
      "responseRxTime": "string",
      "responseTxTime": "string",
      "responseStartTime": "string",
      "requestTime": "string"
    },
    "errorDetails": "string",
    "tlsVersion": "string",
    "cipherSuite": "string",
    "sniHostname": "string",
    "serverCertificateSubject": "string",
    "clientCertificateSubject": "string",
    "upstreamTransportFailureReason": "string",
    "smartwebsecurity": {
      "profileId": "string",
      "matchedRule": {
        "ruleName": "string",
        "ruleType": "string",
        "verdict": "string",
        "dryRun": "boolean",
        "wafResponse": {
          "profileId": "string",
          "ruleIds": [
            "string"
          ],
          "exclusionRuleNames": [
            "string"
          ]
        }
      },
      "dryRunMatchedRule": {
        "ruleName": "string",
        "ruleType": "string",
        "verdict": "string",
        "dryRun": "boolean",
        "wafResponse": {
          "profileId": "string",
          "ruleIds": [
            "string"
          ],
          "exclusionRuleNames": [
            "string"
          ]
        }
      },
      "advancedRateLimiter": {
        "profileId": "string",
        "verdict": "string",
        "appliedQuotaName": "string"
      }
    },
    "responseFlags": {
      "failedLocalHealthcheck": "boolean",
      "noHealthyUpstream": "boolean",
      "upstreamRequestTimeout": "boolean",
      "localReset": "boolean",
      "upstreamRemoteReset": "boolean",
      "upstreamConnectionFailure": "boolean",
      "upstreamConnectionTermination": "boolean",
      "upstreamOverflow": "boolean",
      "noRouteFound": "boolean",
      "delayInjected": "boolean",
      "faultInjected": "boolean",
      "rateLimited": "boolean",
      "unauthorizedDetails": {
        "reason": "string"
      },
      "rateLimitServiceError": "boolean",
      "downstreamConnectionTermination": "boolean",
      "upstreamRetryLimitExceeded": "boolean",
      "streamIdleTimeout": "boolean",
      "invalidEnvoyRequestHeaders": "boolean",
      "downstreamProtocolError": "boolean",
      "upstreamMaxStreamDurationReached": "boolean",
      "responseFromCacheFilter": "boolean",
      "noFilterConfigFound": "boolean",
      "durationTimeout": "boolean",
      "upstreamProtocolError": "boolean",
      "noClusterFound": "boolean",
      "overloadManager": "boolean",
      "dnsResolutionFailure": "boolean",
      "downstreamRemoteReset": "boolean"
    },
    "clientTraceId": "string",
    "upstreamHost": "string",
    "upstreamTimings": {
      "firstTxByte": "string",
      "lastTxByte": "string",
      "firstRxByte": "string",
      "lastRxByte": "string"
    },
    "downstreamTimings": {
      "firstTxByte": "string",
      "lastTxByte": "string",
      "firstRxByte": "string",
      "lastRxByte": "string"
    },
    "duration": "string"
  }
}
```

## Field description {#yandex.cloud.audit.apploadbalancer.LoadBalancerHTTPAccessLog2}

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
|| authentication | **[Authentication](#yandex.cloud.audit.Authentication)** ||
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
|| details | **[EventDetails](#yandex.cloud.audit.apploadbalancer.LoadBalancerHTTPAccessLog.EventDetails)** ||
|#

## Authentication {#yandex.cloud.audit.Authentication}

#|
||Field | Description ||
|| authenticated | **boolean** ||
|| subjectType | **enum** (SubjectType)

- `YANDEX_PASSPORT_USER_ACCOUNT`
- `SERVICE_ACCOUNT`
- `FEDERATED_USER_ACCOUNT`
- `GROUP`
- `SSH_USER`
- `DB_NATIVE_USER`
- `KUBERNETES_USER`
- `DATALENS_SYSTEM_USER`
- `INVITEE` ||
|| subjectId | **string** ||
|| subjectName | **string** ||
|| federationId | **string**

Federation block will be filled only when subject_type = FEDERATED_USER_ACCOUNT ||
|| federationName | **string** ||
|| federationType | **enum** (FederationType)

- `GLOBAL_FEDERATION`
- `PRIVATE_FEDERATION` ||
|| tokenInfo | **[IamTokenInfo](#yandex.cloud.audit.Authentication.IamTokenInfo)** ||
|#

## IamTokenInfo {#yandex.cloud.audit.Authentication.IamTokenInfo}

#|
||Field | Description ||
|| maskedIamToken | **string** ||
|| iamTokenId | **string** ||
|| impersonatorId | **string** ||
|| impersonatorType | **enum** (SubjectType)

- `YANDEX_PASSPORT_USER_ACCOUNT`
- `SERVICE_ACCOUNT`
- `FEDERATED_USER_ACCOUNT`
- `GROUP`
- `SSH_USER`
- `DB_NATIVE_USER`
- `KUBERNETES_USER`
- `DATALENS_SYSTEM_USER`
- `INVITEE` ||
|| impersonatorName | **string** ||
|| impersonatorFederationId | **string** ||
|| impersonatorFederationName | **string** ||
|| impersonatorFederationType | **enum** (FederationType)

- `GLOBAL_FEDERATION`
- `PRIVATE_FEDERATION` ||
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
|| resourceName | **string** ||
|#

## RequestMetadata {#yandex.cloud.audit.RequestMetadata}

#|
||Field | Description ||
|| remoteAddress | **string** ||
|| userAgent | **string** ||
|| requestId | **string** ||
|| remotePort | **string** (int64) ||
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

## EventDetails {#yandex.cloud.audit.apploadbalancer.LoadBalancerHTTPAccessLog.EventDetails}

#|
||Field | Description ||
|| loadBalancerId | **string** ||
|| loadBalancerName | **string** ||
|| type | **string** ||
|| time | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| httpMethod | **string**

basic HTTP info ||
|| authority | **string** ||
|| requestUri | **string** ||
|| httpStatus | **string** (int64) ||
|| httpVersion | **string** ||
|| rewrittenRequestUri | **string** ||
|| referer | **string** ||
|| requestContentType | **string** ||
|| responseContentType | **string** ||
|| grpcService | **string**

grpc ||
|| grpcMethod | **string** ||
|| clientIp | **string**

downstreamAddr ||
|| clientPort | **string** (int64) ||
|| backendIp | **string**

upstreamAddr ||
|| backendPort | **string** (int64) ||
|| httpRouterId | **string**

alb api info ||
|| virtualHostName | **string** ||
|| routeName | **string** ||
|| backendGroupId | **string** ||
|| backendName | **string** ||
|| requestHeadersBytes | **string** (int64)

technical info HTTP ||
|| requestBodyBytes | **string** (int64) ||
|| responseHeadersBytes | **string** (int64) ||
|| responseBodyBytes | **string** (int64) ||
|| requestProcessingTimes | **[RequestProcessingTimes](#yandex.cloud.audit.apploadbalancer.RequestProcessingTimes)** ||
|| errorDetails | **string** ||
|| tlsVersion | **string**

tls info ||
|| cipherSuite | **string** ||
|| sniHostname | **string** ||
|| serverCertificateSubject | **string** ||
|| clientCertificateSubject | **string** ||
|| upstreamTransportFailureReason | **string** ||
|| smartwebsecurity | **[Smartwebsecurity](#yandex.cloud.audit.apploadbalancer.LoadBalancerHTTPAccessLog.Smartwebsecurity)** ||
|| responseFlags | **[ResponseFlags](#yandex.cloud.audit.apploadbalancer.ResponseFlags)**

TCP info ||
|| clientTraceId | **string**

default fields ||
|| upstreamHost | **string** ||
|| upstreamTimings | **[Timings](#yandex.cloud.audit.apploadbalancer.Timings)** ||
|| downstreamTimings | **[Timings](#yandex.cloud.audit.apploadbalancer.Timings)** ||
|| duration | **string** (duration) ||
|#

## RequestProcessingTimes {#yandex.cloud.audit.apploadbalancer.RequestProcessingTimes}

#|
||Field | Description ||
|| requestProcessingTime | **string** (duration) ||
|| requestRxTime | **string** (duration) ||
|| requestTxTime | **string** (duration) ||
|| backendResponseTime | **string** (duration) ||
|| backendProcessingTime | **string** (duration) ||
|| responseProcessingTime | **string** (duration) ||
|| responseRxTime | **string** (duration) ||
|| responseTxTime | **string** (duration) ||
|| responseStartTime | **string** (duration) ||
|| requestTime | **string** (duration) ||
|#

## Smartwebsecurity {#yandex.cloud.audit.apploadbalancer.LoadBalancerHTTPAccessLog.Smartwebsecurity}

#|
||Field | Description ||
|| profileId | **string** ||
|| matchedRule | **[MatchedRule](#yandex.cloud.audit.apploadbalancer.LoadBalancerHTTPAccessLog.Smartwebsecurity.MatchedRule)** ||
|| dryRunMatchedRule | **[MatchedRule](#yandex.cloud.audit.apploadbalancer.LoadBalancerHTTPAccessLog.Smartwebsecurity.MatchedRule)** ||
|| advancedRateLimiter | **[AdvancedRateLimiter](#yandex.cloud.audit.apploadbalancer.LoadBalancerHTTPAccessLog.Smartwebsecurity.AdvancedRateLimiter)** ||
|#

## MatchedRule {#yandex.cloud.audit.apploadbalancer.LoadBalancerHTTPAccessLog.Smartwebsecurity.MatchedRule}

#|
||Field | Description ||
|| ruleName | **string** ||
|| ruleType | **string** ||
|| verdict | **string** ||
|| dryRun | **boolean** ||
|| wafResponse | **[WafResponse](#yandex.cloud.audit.apploadbalancer.LoadBalancerHTTPAccessLog.Smartwebsecurity.MatchedRule.WafResponse)** ||
|#

## WafResponse {#yandex.cloud.audit.apploadbalancer.LoadBalancerHTTPAccessLog.Smartwebsecurity.MatchedRule.WafResponse}

#|
||Field | Description ||
|| profileId | **string** ||
|| ruleIds[] | **string** ||
|| exclusionRuleNames[] | **string** ||
|#

## AdvancedRateLimiter {#yandex.cloud.audit.apploadbalancer.LoadBalancerHTTPAccessLog.Smartwebsecurity.AdvancedRateLimiter}

#|
||Field | Description ||
|| profileId | **string** ||
|| verdict | **string** ||
|| appliedQuotaName | **string** ||
|#

## ResponseFlags {#yandex.cloud.audit.apploadbalancer.ResponseFlags}

ResponseFlags was taken from envoy/api/envoy/data/accesslog/v3/accesslog.proto

#|
||Field | Description ||
|| failedLocalHealthcheck | **boolean**

Indicates local server healthcheck failed. ||
|| noHealthyUpstream | **boolean**

Indicates there was no healthy upstream. ||
|| upstreamRequestTimeout | **boolean**

Indicates an there was an upstream request timeout. ||
|| localReset | **boolean**

Indicates local codec level reset was sent on the stream. ||
|| upstreamRemoteReset | **boolean**

Indicates remote codec level reset was received on the stream. ||
|| upstreamConnectionFailure | **boolean**

Indicates there was a local reset by a connection pool due to an initial connection failure. ||
|| upstreamConnectionTermination | **boolean**

Indicates the stream was reset due to an upstream connection termination. ||
|| upstreamOverflow | **boolean**

Indicates the stream was reset because of a resource overflow. ||
|| noRouteFound | **boolean**

Indicates no route was found for the request. ||
|| delayInjected | **boolean**

Indicates that the request was delayed before proxying. ||
|| faultInjected | **boolean**

Indicates that the request was aborted with an injected error code. ||
|| rateLimited | **boolean**

Indicates that the request was rate-limited locally. ||
|| unauthorizedDetails | **[Unauthorized](#yandex.cloud.audit.apploadbalancer.ResponseFlags.Unauthorized)**

Indicates if the request was deemed unauthorized and the reason for it. ||
|| rateLimitServiceError | **boolean**

Indicates that the request was rejected because there was an error in rate limit service. ||
|| downstreamConnectionTermination | **boolean**

Indicates the stream was reset due to a downstream connection termination. ||
|| upstreamRetryLimitExceeded | **boolean**

Indicates that the upstream retry limit was exceeded, resulting in a downstream error. ||
|| streamIdleTimeout | **boolean**

Indicates that the stream idle timeout was hit, resulting in a downstream 408. ||
|| invalidEnvoyRequestHeaders | **boolean**

Indicates that the request was rejected because an envoy request header failed strict
validation. ||
|| downstreamProtocolError | **boolean**

Indicates there was an HTTP protocol error on the downstream request. ||
|| upstreamMaxStreamDurationReached | **boolean**

Indicates there was a max stream duration reached on the upstream request. ||
|| responseFromCacheFilter | **boolean**

Indicates the response was served from a cache filter. ||
|| noFilterConfigFound | **boolean**

Indicates that a filter configuration is not available. ||
|| durationTimeout | **boolean**

Indicates that request or connection exceeded the downstream connection duration. ||
|| upstreamProtocolError | **boolean**

Indicates there was an HTTP protocol error in the upstream response. ||
|| noClusterFound | **boolean**

Indicates no cluster was found for the request. ||
|| overloadManager | **boolean**

Indicates overload manager terminated the request. ||
|| dnsResolutionFailure | **boolean**

Indicates a DNS resolution failed. ||
|| downstreamRemoteReset | **boolean**

Indicates a downstream remote codec level reset was received on the stream ||
|#

## Unauthorized {#yandex.cloud.audit.apploadbalancer.ResponseFlags.Unauthorized}

#|
||Field | Description ||
|| reason | **enum** (Reason)

- `EXTERNAL_SERVICE`: The request was denied by the external authorization service. ||
|#

## Timings {#yandex.cloud.audit.apploadbalancer.Timings}

#|
||Field | Description ||
|| firstTxByte | **string** (duration) ||
|| lastTxByte | **string** (duration) ||
|| firstRxByte | **string** (duration) ||
|| lastRxByte | **string** (duration) ||
|#