---
editable: false
---

# Managed Services for Kubernetes Audit Trails Events: ApiServerList

## Event JSON schema {#yandex.cloud.audit.k8s.apiserver.ApiServerList2-schema}

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
    "nativeApiServerEvent": {
      "apiVersion": "string",
      "kind": "string",
      "level": "string",
      "auditID": "string",
      "stage": "string",
      "requestURI": "string",
      "verb": "string",
      "user": {
        "username": "string",
        "uid": "string",
        "groups": [
          "string"
        ],
        "extra": {
          // Includes only one of the fields `nullValue`, `numberValue`, `stringValue`, `boolValue`, `structValue`, `listValue`
          "nullValue": "string",
          "numberValue": "string",
          "stringValue": "string",
          "boolValue": "boolean",
          "structValue": "object",
          "listValue": {
            "values": [
              "object"
            ]
          }
          // end of the list of possible fields
        }
      },
      "impersonatedUser": {
        "username": "string",
        "uid": "string",
        "groups": [
          "string"
        ],
        "extra": {
          // Includes only one of the fields `nullValue`, `numberValue`, `stringValue`, `boolValue`, `structValue`, `listValue`
          "nullValue": "string",
          "numberValue": "string",
          "stringValue": "string",
          "boolValue": "boolean",
          "structValue": "object",
          "listValue": {
            "values": [
              "object"
            ]
          }
          // end of the list of possible fields
        }
      },
      "sourceIPs": [
        "string"
      ],
      "userAgent": "string",
      "objectRef": {
        // Includes only one of the fields `nullValue`, `numberValue`, `stringValue`, `boolValue`, `structValue`, `listValue`
        "nullValue": "string",
        "numberValue": "string",
        "stringValue": "string",
        "boolValue": "boolean",
        "structValue": "object",
        "listValue": {
          "values": [
            "object"
          ]
        }
        // end of the list of possible fields
      },
      "responseStatus": {
        "apiVersion": "string",
        "code": "string",
        "details": {
          // Includes only one of the fields `nullValue`, `numberValue`, `stringValue`, `boolValue`, `structValue`, `listValue`
          "nullValue": "string",
          "numberValue": "string",
          "stringValue": "string",
          "boolValue": "boolean",
          "structValue": "object",
          "listValue": {
            "values": [
              "object"
            ]
          }
          // end of the list of possible fields
        },
        "kind": "string",
        "message": "string",
        "metadata": {
          // Includes only one of the fields `nullValue`, `numberValue`, `stringValue`, `boolValue`, `structValue`, `listValue`
          "nullValue": "string",
          "numberValue": "string",
          "stringValue": "string",
          "boolValue": "boolean",
          "structValue": "object",
          "listValue": {
            "values": [
              "object"
            ]
          }
          // end of the list of possible fields
        },
        "reason": "string",
        "status": "string"
      },
      "requestObject": {
        // Includes only one of the fields `nullValue`, `numberValue`, `stringValue`, `boolValue`, `structValue`, `listValue`
        "nullValue": "string",
        "numberValue": "string",
        "stringValue": "string",
        "boolValue": "boolean",
        "structValue": "object",
        "listValue": {
          "values": [
            "object"
          ]
        }
        // end of the list of possible fields
      },
      "responseObject": {
        // Includes only one of the fields `nullValue`, `numberValue`, `stringValue`, `boolValue`, `structValue`, `listValue`
        "nullValue": "string",
        "numberValue": "string",
        "stringValue": "string",
        "boolValue": "boolean",
        "structValue": "object",
        "listValue": {
          "values": [
            "object"
          ]
        }
        // end of the list of possible fields
      },
      "requestReceivedTimestamp": "string",
      "stageTimestamp": "string",
      "annotations": "object"
    },
    "clusterId": "string"
  },
  "requestParameters": "object",
  "response": "object"
}
```

## Field description {#yandex.cloud.audit.k8s.apiserver.ApiServerList2}

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
|| details | **[EventDetails](#yandex.cloud.audit.k8s.apiserver.EventDetails)** ||
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

## EventDetails {#yandex.cloud.audit.k8s.apiserver.EventDetails}

#|
||Field | Description ||
|| nativeApiServerEvent | **[NativeApiServerEvent](#yandex.cloud.audit.k8s.apiserver.NativeApiServerEvent)** ||
|| clusterId | **string** ||
|#

## NativeApiServerEvent {#yandex.cloud.audit.k8s.apiserver.NativeApiServerEvent}

#|
||Field | Description ||
|| apiVersion | **string** ||
|| kind | **string** ||
|| level | **string** ||
|| auditID | **string** ||
|| stage | **string** ||
|| requestURI | **string** ||
|| verb | **string** ||
|| user | **[UserInfo](#yandex.cloud.audit.k8s.apiserver.UserInfo)** ||
|| impersonatedUser | **[UserInfo](#yandex.cloud.audit.k8s.apiserver.UserInfo)** ||
|| sourceIPs[] | **string** ||
|| userAgent | **string** ||
|| objectRef | **[Value](#google.protobuf.Value)** ||
|| responseStatus | **[ResponseStatus](#yandex.cloud.audit.k8s.apiserver.ResponseStatus)** ||
|| requestObject | **[Value](#google.protobuf.Value)** ||
|| responseObject | **[Value](#google.protobuf.Value)** ||
|| requestReceivedTimestamp | **string** ||
|| stageTimestamp | **string** ||
|| annotations | **object** (map<**string**, **string**>) ||
|#

## UserInfo {#yandex.cloud.audit.k8s.apiserver.UserInfo}

#|
||Field | Description ||
|| username | **string** ||
|| uid | **string** ||
|| groups[] | **string** ||
|| extra | **[Value](#google.protobuf.Value)** ||
|#

## Value {#google.protobuf.Value}

#|
||Field | Description ||
|| nullValue | **enum** (NullValue)

Includes only one of the fields `nullValue`, `numberValue`, `stringValue`, `boolValue`, `structValue`, `listValue`.

 ||
|| numberValue | **string**

Includes only one of the fields `nullValue`, `numberValue`, `stringValue`, `boolValue`, `structValue`, `listValue`. ||
|| stringValue | **string**

Includes only one of the fields `nullValue`, `numberValue`, `stringValue`, `boolValue`, `structValue`, `listValue`. ||
|| boolValue | **boolean**

Includes only one of the fields `nullValue`, `numberValue`, `stringValue`, `boolValue`, `structValue`, `listValue`. ||
|| structValue | **object**

Includes only one of the fields `nullValue`, `numberValue`, `stringValue`, `boolValue`, `structValue`, `listValue`. ||
|| listValue | **[ListValue](#google.protobuf.ListValue)**

Includes only one of the fields `nullValue`, `numberValue`, `stringValue`, `boolValue`, `structValue`, `listValue`. ||
|#

## ListValue {#google.protobuf.ListValue}

#|
||Field | Description ||
|| values[] | **[Value](#google.protobuf.Value)** ||
|#

## ResponseStatus {#yandex.cloud.audit.k8s.apiserver.ResponseStatus}

#|
||Field | Description ||
|| apiVersion | **string** ||
|| code | **string** (int64) ||
|| details | **[Value](#google.protobuf.Value)** ||
|| kind | **string** ||
|| message | **string** ||
|| metadata | **[Value](#google.protobuf.Value)** ||
|| reason | **string** ||
|| status | **string** ||
|#