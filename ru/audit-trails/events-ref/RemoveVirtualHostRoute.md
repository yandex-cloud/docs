---
editable: false
---

# Application Load Balancer Audit Trails Events: RemoveVirtualHostRoute

## Event JSON schema {#yandex.cloud.audit.apploadbalancer.RemoveVirtualHostRoute2-schema}

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
  "authorization": {
    "authorized": "boolean"
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
    "httpRouterId": "string",
    "virtualHostName": "string",
    "routeName": "string",
    "route": {
      "name": "string",
      // Includes only one of the fields `http`, `grpc`
      "http": {
        "match": {
          "httpMethod": [
            "string"
          ],
          "path": {
            // Includes only one of the fields `exactMatch`, `prefixMatch`, `regexMatch`
            "exactMatch": "string",
            "prefixMatch": "string",
            "regexMatch": "string"
            // end of the list of possible fields
          },
          "headers": [
            {
              "name": "string",
              "value": {
                // Includes only one of the fields `exactMatch`, `prefixMatch`, `regexMatch`
                "exactMatch": "string",
                "prefixMatch": "string",
                "regexMatch": "string"
                // end of the list of possible fields
              }
            }
          ],
          "queryParameters": [
            {
              "name": "string",
              "value": {
                // Includes only one of the fields `exactMatch`, `prefixMatch`, `regexMatch`
                "exactMatch": "string",
                "prefixMatch": "string",
                "regexMatch": "string"
                // end of the list of possible fields
              }
            }
          ]
        },
        // Includes only one of the fields `route`, `redirect`, `directResponse`
        "route": {
          "backendGroupId": "string",
          "timeout": "string",
          "idleTimeout": "string",
          // Includes only one of the fields `hostRewrite`, `autoHostRewrite`
          "hostRewrite": "string",
          "autoHostRewrite": "boolean",
          // end of the list of possible fields
          "prefixRewrite": "string",
          "upgradeTypes": [
            "string"
          ],
          "rateLimit": {
            "allRequests": {
              // Includes only one of the fields `perSecond`, `perMinute`
              "perSecond": "string",
              "perMinute": "string"
              // end of the list of possible fields
            },
            "requestsPerIp": {
              // Includes only one of the fields `perSecond`, `perMinute`
              "perSecond": "string",
              "perMinute": "string"
              // end of the list of possible fields
            }
          },
          "regexRewrite": {
            "regex": "string",
            "substitute": "string"
          }
        },
        "redirect": {
          "replaceScheme": "string",
          "replaceHost": "string",
          "replacePort": "string",
          // Includes only one of the fields `replacePath`, `replacePrefix`
          "replacePath": "string",
          "replacePrefix": "string",
          // end of the list of possible fields
          "removeQuery": "boolean",
          "responseCode": "string"
        },
        "directResponse": {
          "status": "string",
          "body": {
            // Includes only one of the fields `text`
            "text": "string"
            // end of the list of possible fields
          }
        }
        // end of the list of possible fields
      },
      "grpc": {
        "match": {
          "fqmn": {
            // Includes only one of the fields `exactMatch`, `prefixMatch`, `regexMatch`
            "exactMatch": "string",
            "prefixMatch": "string",
            "regexMatch": "string"
            // end of the list of possible fields
          }
        },
        // Includes only one of the fields `route`, `statusResponse`
        "route": {
          "backendGroupId": "string",
          "maxTimeout": "string",
          "idleTimeout": "string",
          // Includes only one of the fields `hostRewrite`, `autoHostRewrite`
          "hostRewrite": "string",
          "autoHostRewrite": "boolean",
          // end of the list of possible fields
          "rateLimit": {
            "allRequests": {
              // Includes only one of the fields `perSecond`, `perMinute`
              "perSecond": "string",
              "perMinute": "string"
              // end of the list of possible fields
            },
            "requestsPerIp": {
              // Includes only one of the fields `perSecond`, `perMinute`
              "perSecond": "string",
              "perMinute": "string"
              // end of the list of possible fields
            }
          }
        },
        "statusResponse": {
          "status": "string"
        }
        // end of the list of possible fields
      },
      // end of the list of possible fields
      "routeOptions": {
        "modifyRequestHeaders": [
          {
            "name": "string",
            // Includes only one of the fields `append`, `replace`, `remove`, `rename`
            "append": "string",
            "replace": "string",
            "remove": "boolean",
            "rename": "string"
            // end of the list of possible fields
          }
        ],
        "modifyResponseHeaders": [
          {
            "name": "string",
            // Includes only one of the fields `append`, `replace`, `remove`, `rename`
            "append": "string",
            "replace": "string",
            "remove": "boolean",
            "rename": "string"
            // end of the list of possible fields
          }
        ],
        "rbac": {
          "action": "string",
          "principals": [
            {
              "andPrincipals": [
                {
                  // Includes only one of the fields `header`, `remoteIp`, `any`
                  "header": {
                    "name": "string",
                    "value": {
                      // Includes only one of the fields `exactMatch`, `prefixMatch`, `regexMatch`
                      "exactMatch": "string",
                      "prefixMatch": "string",
                      "regexMatch": "string"
                      // end of the list of possible fields
                    }
                  },
                  "remoteIp": "string",
                  "any": "boolean"
                  // end of the list of possible fields
                }
              ]
            }
          ]
        },
        "securityProfileId": "string"
      },
      "disableSecurityProfile": "boolean"
    }
  },
  "requestParameters": "object",
  "response": "object"
}
```

## Field description {#yandex.cloud.audit.apploadbalancer.RemoveVirtualHostRoute2}

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
|| details | **[EventDetails](#yandex.cloud.audit.apploadbalancer.RemoveVirtualHostRoute.EventDetails)** ||
|| requestParameters | **object** ||
|| response | **object** ||
|#

## IamAuthentication {#yandex.cloud.audit.IamAuthentication}

#|
||Field | Description ||
|| authenticated | **boolean** ||
|| subjectType | **enum** (IamSubjectType)

- `YANDEX_PASSPORT_USER_ACCOUNT`
- `SERVICE_ACCOUNT`
- `FEDERATED_USER_ACCOUNT`
- `SSH_USER`
- `KUBERNETES_USER` ||
|| subjectId | **string** ||
|| subjectName | **string** ||
|| federationId | **string** ||
|| federationName | **string** ||
|| federationType | **enum** (FederationType)

- `GLOBAL_FEDERATION`
- `PRIVATE_FEDERATION` ||
|| tokenInfo | **[IamTokenInfo](#yandex.cloud.audit.IamAuthentication.IamTokenInfo)** ||
|#

## IamTokenInfo {#yandex.cloud.audit.IamAuthentication.IamTokenInfo}

#|
||Field | Description ||
|| maskedIamToken | **string** ||
|| iamTokenId | **string** ||
|| impersonatorId | **string** ||
|| impersonatorType | **enum** (IamSubjectType)

- `YANDEX_PASSPORT_USER_ACCOUNT`
- `SERVICE_ACCOUNT`
- `FEDERATED_USER_ACCOUNT`
- `SSH_USER`
- `KUBERNETES_USER` ||
|| impersonatorName | **string** ||
|| impersonatorFederationId | **string** ||
|| impersonatorFederationName | **string** ||
|| impersonatorFederationType | **enum** (FederationType)

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

## EventDetails {#yandex.cloud.audit.apploadbalancer.RemoveVirtualHostRoute.EventDetails}

#|
||Field | Description ||
|| httpRouterId | **string** ||
|| virtualHostName | **string** ||
|| routeName | **string** ||
|| route | **[Route](#yandex.cloud.apploadbalancer.v1.Route)** ||
|#

## Route {#yandex.cloud.apploadbalancer.v1.Route}

#|
||Field | Description ||
|| name | **string** ||
|| http | **[HttpRoute](#yandex.cloud.apploadbalancer.v1.HttpRoute)**

Includes only one of the fields `http`, `grpc`. ||
|| grpc | **[GrpcRoute](#yandex.cloud.apploadbalancer.v1.GrpcRoute)**

Includes only one of the fields `http`, `grpc`. ||
|| routeOptions | **[RouteOptions](#yandex.cloud.apploadbalancer.v1.RouteOptions)** ||
|| disableSecurityProfile | **boolean** ||
|#

## HttpRoute {#yandex.cloud.apploadbalancer.v1.HttpRoute}

#|
||Field | Description ||
|| match | **[HttpRouteMatch](#yandex.cloud.apploadbalancer.v1.HttpRouteMatch)** ||
|| route | **[HttpRouteAction](#yandex.cloud.apploadbalancer.v1.HttpRouteAction)**

Includes only one of the fields `route`, `redirect`, `directResponse`. ||
|| redirect | **[RedirectAction](#yandex.cloud.apploadbalancer.v1.RedirectAction)**

Includes only one of the fields `route`, `redirect`, `directResponse`. ||
|| directResponse | **[DirectResponseAction](#yandex.cloud.apploadbalancer.v1.DirectResponseAction)**

Includes only one of the fields `route`, `redirect`, `directResponse`. ||
|#

## HttpRouteMatch {#yandex.cloud.apploadbalancer.v1.HttpRouteMatch}

#|
||Field | Description ||
|| httpMethod[] | **string** ||
|| path | **[StringMatch](#yandex.cloud.apploadbalancer.v1.StringMatch)** ||
|| headers[] | **[HttpRouteHeaderMatch](#yandex.cloud.apploadbalancer.v1.HttpRouteHeaderMatch)**

The maximum number of elements is 32. ||
|| queryParameters[] | **[HttpRouteQueryParamMatch](#yandex.cloud.apploadbalancer.v1.HttpRouteQueryParamMatch)**

The maximum number of elements is 32. ||
|#

## StringMatch {#yandex.cloud.apploadbalancer.v1.StringMatch}

#|
||Field | Description ||
|| exactMatch | **string**

Includes only one of the fields `exactMatch`, `prefixMatch`, `regexMatch`. ||
|| prefixMatch | **string**

Includes only one of the fields `exactMatch`, `prefixMatch`, `regexMatch`. ||
|| regexMatch | **string**

Includes only one of the fields `exactMatch`, `prefixMatch`, `regexMatch`. ||
|#

## HttpRouteHeaderMatch {#yandex.cloud.apploadbalancer.v1.HttpRouteHeaderMatch}

#|
||Field | Description ||
|| name | **string**

The string length in characters must be 1-256. Value must match the regular expression ` [-0-9a-zA-Z]+ `. ||
|| value | **[StringMatch](#yandex.cloud.apploadbalancer.v1.StringMatch)** ||
|#

## HttpRouteQueryParamMatch {#yandex.cloud.apploadbalancer.v1.HttpRouteQueryParamMatch}

#|
||Field | Description ||
|| name | **string**

The string length in characters must be 1-256. Value must match the regular expression ` [-_0-9a-zA-Z]+ `. ||
|| value | **[StringMatch](#yandex.cloud.apploadbalancer.v1.StringMatch)** ||
|#

## HttpRouteAction {#yandex.cloud.apploadbalancer.v1.HttpRouteAction}

#|
||Field | Description ||
|| backendGroupId | **string** ||
|| timeout | **string** (duration) ||
|| idleTimeout | **string** (duration) ||
|| hostRewrite | **string**

Includes only one of the fields `hostRewrite`, `autoHostRewrite`. ||
|| autoHostRewrite | **boolean**

Includes only one of the fields `hostRewrite`, `autoHostRewrite`. ||
|| prefixRewrite | **string** ||
|| upgradeTypes[] | **string** ||
|| rateLimit | **[RateLimit](#yandex.cloud.apploadbalancer.v1.RateLimit)** ||
|| regexRewrite | **[RegexMatchAndSubstitute](#yandex.cloud.apploadbalancer.v1.RegexMatchAndSubstitute)** ||
|#

## RateLimit {#yandex.cloud.apploadbalancer.v1.RateLimit}

#|
||Field | Description ||
|| allRequests | **[Limit](#yandex.cloud.apploadbalancer.v1.RateLimit.Limit)** ||
|| requestsPerIp | **[Limit](#yandex.cloud.apploadbalancer.v1.RateLimit.Limit)** ||
|#

## Limit {#yandex.cloud.apploadbalancer.v1.RateLimit.Limit}

#|
||Field | Description ||
|| perSecond | **string** (int64)

Value must be greater than 0.

Includes only one of the fields `perSecond`, `perMinute`. ||
|| perMinute | **string** (int64)

Value must be greater than 0.

Includes only one of the fields `perSecond`, `perMinute`. ||
|#

## RegexMatchAndSubstitute {#yandex.cloud.apploadbalancer.v1.RegexMatchAndSubstitute}

#|
||Field | Description ||
|| regex | **string** ||
|| substitute | **string** ||
|#

## RedirectAction {#yandex.cloud.apploadbalancer.v1.RedirectAction}

#|
||Field | Description ||
|| replaceScheme | **string** ||
|| replaceHost | **string** ||
|| replacePort | **string** (int64) ||
|| replacePath | **string**

Includes only one of the fields `replacePath`, `replacePrefix`. ||
|| replacePrefix | **string**

Includes only one of the fields `replacePath`, `replacePrefix`. ||
|| removeQuery | **boolean** ||
|| responseCode | **enum** (RedirectResponseCode)

- `MOVED_PERMANENTLY`
- `FOUND`
- `SEE_OTHER`
- `TEMPORARY_REDIRECT`
- `PERMANENT_REDIRECT` ||
|#

## DirectResponseAction {#yandex.cloud.apploadbalancer.v1.DirectResponseAction}

#|
||Field | Description ||
|| status | **string** (int64)

Acceptable values are 100 to 599, inclusive. ||
|| body | **[Payload](#yandex.cloud.apploadbalancer.v1.Payload)** ||
|#

## Payload {#yandex.cloud.apploadbalancer.v1.Payload}

#|
||Field | Description ||
|| text | **string**

The string length in characters must be greater than 0.

Includes only one of the fields `text`. ||
|#

## GrpcRoute {#yandex.cloud.apploadbalancer.v1.GrpcRoute}

#|
||Field | Description ||
|| match | **[GrpcRouteMatch](#yandex.cloud.apploadbalancer.v1.GrpcRouteMatch)** ||
|| route | **[GrpcRouteAction](#yandex.cloud.apploadbalancer.v1.GrpcRouteAction)**

Includes only one of the fields `route`, `statusResponse`. ||
|| statusResponse | **[GrpcStatusResponseAction](#yandex.cloud.apploadbalancer.v1.GrpcStatusResponseAction)**

Includes only one of the fields `route`, `statusResponse`. ||
|#

## GrpcRouteMatch {#yandex.cloud.apploadbalancer.v1.GrpcRouteMatch}

#|
||Field | Description ||
|| fqmn | **[StringMatch](#yandex.cloud.apploadbalancer.v1.StringMatch)** ||
|#

## GrpcRouteAction {#yandex.cloud.apploadbalancer.v1.GrpcRouteAction}

#|
||Field | Description ||
|| backendGroupId | **string** ||
|| maxTimeout | **string** (duration) ||
|| idleTimeout | **string** (duration) ||
|| hostRewrite | **string**

Includes only one of the fields `hostRewrite`, `autoHostRewrite`. ||
|| autoHostRewrite | **boolean**

Includes only one of the fields `hostRewrite`, `autoHostRewrite`. ||
|| rateLimit | **[RateLimit](#yandex.cloud.apploadbalancer.v1.RateLimit)** ||
|#

## GrpcStatusResponseAction {#yandex.cloud.apploadbalancer.v1.GrpcStatusResponseAction}

#|
||Field | Description ||
|| status | **enum** (Status)

- `OK`
- `INVALID_ARGUMENT`
- `NOT_FOUND`
- `PERMISSION_DENIED`
- `UNAUTHENTICATED`
- `UNIMPLEMENTED`
- `INTERNAL`
- `UNAVAILABLE` ||
|#

## RouteOptions {#yandex.cloud.apploadbalancer.v1.RouteOptions}

#|
||Field | Description ||
|| modifyRequestHeaders[] | **[HeaderModification](#yandex.cloud.apploadbalancer.v1.HeaderModification)** ||
|| modifyResponseHeaders[] | **[HeaderModification](#yandex.cloud.apploadbalancer.v1.HeaderModification)** ||
|| rbac | **[RBAC](#yandex.cloud.apploadbalancer.v1.RBAC)** ||
|| securityProfileId | **string** ||
|#

## HeaderModification {#yandex.cloud.apploadbalancer.v1.HeaderModification}

#|
||Field | Description ||
|| name | **string** ||
|| append | **string**

Includes only one of the fields `append`, `replace`, `remove`, `rename`. ||
|| replace | **string**

Includes only one of the fields `append`, `replace`, `remove`, `rename`. ||
|| remove | **boolean**

Includes only one of the fields `append`, `replace`, `remove`, `rename`. ||
|| rename | **string**

Includes only one of the fields `append`, `replace`, `remove`, `rename`. ||
|#

## RBAC {#yandex.cloud.apploadbalancer.v1.RBAC}

#|
||Field | Description ||
|| action | **enum** (Action)

- `ALLOW`
- `DENY` ||
|| principals[] | **[Principals](#yandex.cloud.apploadbalancer.v1.Principals)**

The minimum number of elements is 1. ||
|#

## Principals {#yandex.cloud.apploadbalancer.v1.Principals}

#|
||Field | Description ||
|| andPrincipals[] | **[Principal](#yandex.cloud.apploadbalancer.v1.Principal)**

The minimum number of elements is 1. ||
|#

## Principal {#yandex.cloud.apploadbalancer.v1.Principal}

#|
||Field | Description ||
|| header | **[HeaderMatcher](#yandex.cloud.apploadbalancer.v1.Principal.HeaderMatcher)**

Includes only one of the fields `header`, `remoteIp`, `any`. ||
|| remoteIp | **string**

Includes only one of the fields `header`, `remoteIp`, `any`. ||
|| any | **boolean**

Includes only one of the fields `header`, `remoteIp`, `any`. ||
|#

## HeaderMatcher {#yandex.cloud.apploadbalancer.v1.Principal.HeaderMatcher}

#|
||Field | Description ||
|| name | **string** ||
|| value | **[StringMatch](#yandex.cloud.apploadbalancer.v1.StringMatch)** ||
|#