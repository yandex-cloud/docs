---
editable: false
---

# Application Load Balancer Audit Trails Events: CreateBackendGroup

## Event JSON schema {#yandex.cloud.audit.apploadbalancer.CreateBackendGroup2-schema}

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
    "backendGroupId": "string",
    "backendGroupName": "string",
    "backends": [
      {
        // Includes only one of the fields `http`, `grpc`, `stream`
        "http": {
          "name": "string",
          "backendWeight": "string",
          "loadBalancingConfig": {
            "panicThreshold": "string",
            "localityAwareRoutingPercent": "string",
            "strictLocality": "boolean",
            "mode": "string"
          },
          "port": "string",
          // Includes only one of the fields `targetGroups`, `storageBucket`
          "targetGroups": {
            "targetGroupIds": [
              "string"
            ]
          },
          "storageBucket": {
            "bucket": "string"
          },
          // end of the list of possible fields
          "healthchecks": [
            {
              "timeout": "string",
              "interval": "string",
              "intervalJitterPercent": "string",
              "healthyThreshold": "string",
              "unhealthyThreshold": "string",
              "healthcheckPort": "string",
              // Includes only one of the fields `stream`, `http`, `grpc`
              "stream": {
                "send": {
                  // Includes only one of the fields `text`
                  "text": "string"
                  // end of the list of possible fields
                },
                "receive": {
                  // Includes only one of the fields `text`
                  "text": "string"
                  // end of the list of possible fields
                }
              },
              "http": {
                "host": "string",
                "path": "string",
                "useHttp2": "boolean",
                "expectedStatuses": [
                  "string"
                ]
              },
              "grpc": {
                "serviceName": "string"
              },
              // end of the list of possible fields
              // Includes only one of the fields `plaintext`, `tls`
              "plaintext": "object",
              "tls": {
                "sni": "string",
                "validationContext": {
                  // Includes only one of the fields `trustedCaId`, `trustedCaBytes`
                  "trustedCaId": "string",
                  "trustedCaBytes": "string"
                  // end of the list of possible fields
                }
              }
              // end of the list of possible fields
            }
          ],
          "tls": {
            "sni": "string",
            "validationContext": {
              // Includes only one of the fields `trustedCaId`, `trustedCaBytes`
              "trustedCaId": "string",
              "trustedCaBytes": "string"
              // end of the list of possible fields
            }
          },
          "useHttp2": "boolean"
        },
        "grpc": {
          "name": "string",
          "backendWeight": "string",
          "loadBalancingConfig": {
            "panicThreshold": "string",
            "localityAwareRoutingPercent": "string",
            "strictLocality": "boolean",
            "mode": "string"
          },
          "port": "string",
          // Includes only one of the fields `targetGroups`
          "targetGroups": {
            "targetGroupIds": [
              "string"
            ]
          },
          // end of the list of possible fields
          "healthchecks": [
            {
              "timeout": "string",
              "interval": "string",
              "intervalJitterPercent": "string",
              "healthyThreshold": "string",
              "unhealthyThreshold": "string",
              "healthcheckPort": "string",
              // Includes only one of the fields `stream`, `http`, `grpc`
              "stream": {
                "send": {
                  // Includes only one of the fields `text`
                  "text": "string"
                  // end of the list of possible fields
                },
                "receive": {
                  // Includes only one of the fields `text`
                  "text": "string"
                  // end of the list of possible fields
                }
              },
              "http": {
                "host": "string",
                "path": "string",
                "useHttp2": "boolean",
                "expectedStatuses": [
                  "string"
                ]
              },
              "grpc": {
                "serviceName": "string"
              },
              // end of the list of possible fields
              // Includes only one of the fields `plaintext`, `tls`
              "plaintext": "object",
              "tls": {
                "sni": "string",
                "validationContext": {
                  // Includes only one of the fields `trustedCaId`, `trustedCaBytes`
                  "trustedCaId": "string",
                  "trustedCaBytes": "string"
                  // end of the list of possible fields
                }
              }
              // end of the list of possible fields
            }
          ],
          "tls": {
            "sni": "string",
            "validationContext": {
              // Includes only one of the fields `trustedCaId`, `trustedCaBytes`
              "trustedCaId": "string",
              "trustedCaBytes": "string"
              // end of the list of possible fields
            }
          }
        },
        "stream": {
          "name": "string",
          "backendWeight": "string",
          "loadBalancingConfig": {
            "panicThreshold": "string",
            "localityAwareRoutingPercent": "string",
            "strictLocality": "boolean",
            "mode": "string"
          },
          "port": "string",
          // Includes only one of the fields `targetGroups`
          "targetGroups": {
            "targetGroupIds": [
              "string"
            ]
          },
          // end of the list of possible fields
          "healthchecks": [
            {
              "timeout": "string",
              "interval": "string",
              "intervalJitterPercent": "string",
              "healthyThreshold": "string",
              "unhealthyThreshold": "string",
              "healthcheckPort": "string",
              // Includes only one of the fields `stream`, `http`, `grpc`
              "stream": {
                "send": {
                  // Includes only one of the fields `text`
                  "text": "string"
                  // end of the list of possible fields
                },
                "receive": {
                  // Includes only one of the fields `text`
                  "text": "string"
                  // end of the list of possible fields
                }
              },
              "http": {
                "host": "string",
                "path": "string",
                "useHttp2": "boolean",
                "expectedStatuses": [
                  "string"
                ]
              },
              "grpc": {
                "serviceName": "string"
              },
              // end of the list of possible fields
              // Includes only one of the fields `plaintext`, `tls`
              "plaintext": "object",
              "tls": {
                "sni": "string",
                "validationContext": {
                  // Includes only one of the fields `trustedCaId`, `trustedCaBytes`
                  "trustedCaId": "string",
                  "trustedCaBytes": "string"
                  // end of the list of possible fields
                }
              }
              // end of the list of possible fields
            }
          ],
          "tls": {
            "sni": "string",
            "validationContext": {
              // Includes only one of the fields `trustedCaId`, `trustedCaBytes`
              "trustedCaId": "string",
              "trustedCaBytes": "string"
              // end of the list of possible fields
            }
          },
          "enableProxyProtocol": "boolean",
          "keepConnectionsOnHostHealthFailure": "boolean"
        }
        // end of the list of possible fields
      }
    ],
    "description": "string",
    "labels": "object"
  },
  "requestParameters": "object",
  "response": "object"
}
```

## Field description {#yandex.cloud.audit.apploadbalancer.CreateBackendGroup2}

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
|| details | **[EventDetails](#yandex.cloud.audit.apploadbalancer.CreateBackendGroup.EventDetails)** ||
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

## EventDetails {#yandex.cloud.audit.apploadbalancer.CreateBackendGroup.EventDetails}

#|
||Field | Description ||
|| backendGroupId | **string** ||
|| backendGroupName | **string** ||
|| backends[] | **[BackendOneOf](#yandex.cloud.audit.apploadbalancer.BackendOneOf)** ||
|| description | **string** ||
|| labels | **object** (map<**string**, **string**>) ||
|#

## BackendOneOf {#yandex.cloud.audit.apploadbalancer.BackendOneOf}

#|
||Field | Description ||
|| http | **[HttpBackend](#yandex.cloud.apploadbalancer.v1.HttpBackend)**

Includes only one of the fields `http`, `grpc`, `stream`. ||
|| grpc | **[GrpcBackend](#yandex.cloud.apploadbalancer.v1.GrpcBackend)**

Includes only one of the fields `http`, `grpc`, `stream`. ||
|| stream | **[StreamBackend](#yandex.cloud.apploadbalancer.v1.StreamBackend)**

Includes only one of the fields `http`, `grpc`, `stream`. ||
|#

## HttpBackend {#yandex.cloud.apploadbalancer.v1.HttpBackend}

#|
||Field | Description ||
|| name | **string**

Value must match the regular expression ` [a-z][-a-z0-9]{1,61}[a-z0-9] `. ||
|| backendWeight | **string** (int64) ||
|| loadBalancingConfig | **[LoadBalancingConfig](#yandex.cloud.apploadbalancer.v1.LoadBalancingConfig)** ||
|| port | **string** (int64)

Acceptable values are 0 to 65535, inclusive. ||
|| targetGroups | **[TargetGroupsBackend](#yandex.cloud.apploadbalancer.v1.TargetGroupsBackend)**

Includes only one of the fields `targetGroups`, `storageBucket`. ||
|| storageBucket | **[StorageBucketBackend](#yandex.cloud.apploadbalancer.v1.StorageBucketBackend)**

Includes only one of the fields `targetGroups`, `storageBucket`. ||
|| healthchecks[] | **[HealthCheck](#yandex.cloud.apploadbalancer.v1.HealthCheck)** ||
|| tls | **[BackendTls](#yandex.cloud.apploadbalancer.v1.BackendTls)** ||
|| useHttp2 | **boolean** ||
|#

## LoadBalancingConfig {#yandex.cloud.apploadbalancer.v1.LoadBalancingConfig}

#|
||Field | Description ||
|| panicThreshold | **string** (int64)

Acceptable values are 0 to 100, inclusive. ||
|| localityAwareRoutingPercent | **string** (int64)

Acceptable values are 0 to 100, inclusive. ||
|| strictLocality | **boolean** ||
|| mode | **enum** (LoadBalancingMode)

- `ROUND_ROBIN`
- `RANDOM`
- `LEAST_REQUEST`
- `MAGLEV_HASH` ||
|#

## TargetGroupsBackend {#yandex.cloud.apploadbalancer.v1.TargetGroupsBackend}

#|
||Field | Description ||
|| targetGroupIds[] | **string**

The number of elements must be greater than 0. ||
|#

## StorageBucketBackend {#yandex.cloud.apploadbalancer.v1.StorageBucketBackend}

#|
||Field | Description ||
|| bucket | **string** ||
|#

## HealthCheck {#yandex.cloud.apploadbalancer.v1.HealthCheck}

#|
||Field | Description ||
|| timeout | **string** (duration) ||
|| interval | **string** (duration) ||
|| intervalJitterPercent | **string** ||
|| healthyThreshold | **string** (int64) ||
|| unhealthyThreshold | **string** (int64) ||
|| healthcheckPort | **string** (int64)

Acceptable values are 0 to 65535, inclusive. ||
|| stream | **[StreamHealthCheck](#yandex.cloud.apploadbalancer.v1.HealthCheck.StreamHealthCheck)**

Includes only one of the fields `stream`, `http`, `grpc`. ||
|| http | **[HttpHealthCheck](#yandex.cloud.apploadbalancer.v1.HealthCheck.HttpHealthCheck)**

Includes only one of the fields `stream`, `http`, `grpc`. ||
|| grpc | **[GrpcHealthCheck](#yandex.cloud.apploadbalancer.v1.HealthCheck.GrpcHealthCheck)**

Includes only one of the fields `stream`, `http`, `grpc`. ||
|| plaintext | **object**

Includes only one of the fields `plaintext`, `tls`. ||
|| tls | **[SecureTransportSettings](#yandex.cloud.apploadbalancer.v1.SecureTransportSettings)**

Includes only one of the fields `plaintext`, `tls`. ||
|#

## StreamHealthCheck {#yandex.cloud.apploadbalancer.v1.HealthCheck.StreamHealthCheck}

#|
||Field | Description ||
|| send | **[Payload](#yandex.cloud.apploadbalancer.v1.Payload)** ||
|| receive | **[Payload](#yandex.cloud.apploadbalancer.v1.Payload)** ||
|#

## Payload {#yandex.cloud.apploadbalancer.v1.Payload}

#|
||Field | Description ||
|| text | **string**

The string length in characters must be greater than 0.

Includes only one of the fields `text`. ||
|#

## HttpHealthCheck {#yandex.cloud.apploadbalancer.v1.HealthCheck.HttpHealthCheck}

#|
||Field | Description ||
|| host | **string** ||
|| path | **string** ||
|| useHttp2 | **boolean** ||
|| expectedStatuses[] | **string** (int64)

Acceptable values are 100 to 599, inclusive. ||
|#

## GrpcHealthCheck {#yandex.cloud.apploadbalancer.v1.HealthCheck.GrpcHealthCheck}

#|
||Field | Description ||
|| serviceName | **string** ||
|#

## SecureTransportSettings {#yandex.cloud.apploadbalancer.v1.SecureTransportSettings}

#|
||Field | Description ||
|| sni | **string** ||
|| validationContext | **[ValidationContext](#yandex.cloud.apploadbalancer.v1.ValidationContext)** ||
|#

## ValidationContext {#yandex.cloud.apploadbalancer.v1.ValidationContext}

#|
||Field | Description ||
|| trustedCaId | **string**

Includes only one of the fields `trustedCaId`, `trustedCaBytes`. ||
|| trustedCaBytes | **string**

Includes only one of the fields `trustedCaId`, `trustedCaBytes`. ||
|#

## BackendTls {#yandex.cloud.apploadbalancer.v1.BackendTls}

#|
||Field | Description ||
|| sni | **string** ||
|| validationContext | **[ValidationContext](#yandex.cloud.apploadbalancer.v1.ValidationContext)** ||
|#

## GrpcBackend {#yandex.cloud.apploadbalancer.v1.GrpcBackend}

#|
||Field | Description ||
|| name | **string**

Value must match the regular expression ` [a-z][-a-z0-9]{1,61}[a-z0-9] `. ||
|| backendWeight | **string** (int64) ||
|| loadBalancingConfig | **[LoadBalancingConfig](#yandex.cloud.apploadbalancer.v1.LoadBalancingConfig)** ||
|| port | **string** (int64)

Acceptable values are 0 to 65535, inclusive. ||
|| targetGroups | **[TargetGroupsBackend](#yandex.cloud.apploadbalancer.v1.TargetGroupsBackend)**

Includes only one of the fields `targetGroups`. ||
|| healthchecks[] | **[HealthCheck](#yandex.cloud.apploadbalancer.v1.HealthCheck)** ||
|| tls | **[BackendTls](#yandex.cloud.apploadbalancer.v1.BackendTls)** ||
|#

## StreamBackend {#yandex.cloud.apploadbalancer.v1.StreamBackend}

#|
||Field | Description ||
|| name | **string**

Value must match the regular expression ` [a-z][-a-z0-9]{1,61}[a-z0-9] `. ||
|| backendWeight | **string** (int64) ||
|| loadBalancingConfig | **[LoadBalancingConfig](#yandex.cloud.apploadbalancer.v1.LoadBalancingConfig)** ||
|| port | **string** (int64)

Acceptable values are 0 to 65535, inclusive. ||
|| targetGroups | **[TargetGroupsBackend](#yandex.cloud.apploadbalancer.v1.TargetGroupsBackend)**

Includes only one of the fields `targetGroups`. ||
|| healthchecks[] | **[HealthCheck](#yandex.cloud.apploadbalancer.v1.HealthCheck)** ||
|| tls | **[BackendTls](#yandex.cloud.apploadbalancer.v1.BackendTls)** ||
|| enableProxyProtocol | **boolean** ||
|| keepConnectionsOnHostHealthFailure | **boolean** ||
|#