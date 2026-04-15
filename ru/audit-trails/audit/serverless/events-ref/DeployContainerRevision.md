---
editable: false
---

# Cloud Functions Audit Trails Events: DeployContainerRevision

## Event JSON schema {#yandex.cloud.audit.serverless.containers.DeployContainerRevision2-schema}

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
    "containerId": "string",
    "containerRevisionId": "string",
    "containerName": "string",
    "containerRevisionStatus": "string",
    "resources": {
      "memory": "string",
      "cores": "string",
      "coreFraction": "string"
    },
    "executionTimeout": "string",
    "serviceAccountId": "string",
    "imageSpec": {
      "imageUrl": "string",
      "command": {
        "command": [
          "string"
        ]
      },
      "args": {
        "args": [
          "string"
        ]
      },
      "environment": "object",
      "workingDir": "string",
      "size": "string",
      "hash": "string"
    },
    "concurrency": "string",
    "containerRevisionConnectivity": {
      "networkId": "string",
      "subnetIds": [
        "string"
      ]
    },
    "secrets": [
      {
        "id": "string",
        "versionId": "string",
        "key": "string",
        // Includes only one of the fields `environmentVariable`
        "environmentVariable": "string"
        // end of the list of possible fields
      }
    ],
    "containerRevisionMetadataOptions": {
      "gceHttpEndpoint": "string",
      "awsV1HttpEndpoint": "string"
    }
  },
  "requestParameters": "object",
  "response": "object"
}
```

## Field description {#yandex.cloud.audit.serverless.containers.DeployContainerRevision2}

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
|| details | **[EventDetails](#yandex.cloud.audit.serverless.containers.DeployContainerRevision.EventDetails)** ||
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

## EventDetails {#yandex.cloud.audit.serverless.containers.DeployContainerRevision.EventDetails}

#|
||Field | Description ||
|| containerId | **string** ||
|| containerRevisionId | **string** ||
|| containerName | **string** ||
|| containerRevisionStatus | **string** ||
|| resources | **[Resources](#yandex.cloud.audit.serverless.containers.Resources)** ||
|| executionTimeout | **string** (duration) ||
|| serviceAccountId | **string** ||
|| imageSpec | **[ImageSpec](#yandex.cloud.audit.serverless.containers.ImageSpec)** ||
|| concurrency | **string** (int64) ||
|| containerRevisionConnectivity | **[Connectivity](#yandex.cloud.serverless.containers.v1.Connectivity)** ||
|| secrets[] | **[Secret](#yandex.cloud.serverless.containers.v1.Secret)** ||
|| containerRevisionMetadataOptions | **[MetadataOptions](#yandex.cloud.serverless.containers.v1.MetadataOptions)** ||
|#

## Resources {#yandex.cloud.audit.serverless.containers.Resources}

#|
||Field | Description ||
|| memory | **string** (int64) ||
|| cores | **string** (int64) ||
|| coreFraction | **string** (int64) ||
|#

## ImageSpec {#yandex.cloud.audit.serverless.containers.ImageSpec}

#|
||Field | Description ||
|| imageUrl | **string** ||
|| command | **[Command](#yandex.cloud.audit.serverless.containers.Command)** ||
|| args | **[Args](#yandex.cloud.audit.serverless.containers.Args)** ||
|| environment | **object** (map<**string**, **string**>) ||
|| workingDir | **string** ||
|| size | **string** (int64) ||
|| hash | **string** ||
|#

## Command {#yandex.cloud.audit.serverless.containers.Command}

#|
||Field | Description ||
|| command[] | **string** ||
|#

## Args {#yandex.cloud.audit.serverless.containers.Args}

#|
||Field | Description ||
|| args[] | **string** ||
|#

## Connectivity {#yandex.cloud.serverless.containers.v1.Connectivity}

#|
||Field | Description ||
|| networkId | **string** ||
|| subnetIds[] | **string**

The string length in characters for each value must be greater than 0. ||
|#

## Secret {#yandex.cloud.serverless.containers.v1.Secret}

#|
||Field | Description ||
|| id | **string** ||
|| versionId | **string** ||
|| key | **string** ||
|| environmentVariable | **string**

Includes only one of the fields `environmentVariable`. ||
|#

## MetadataOptions {#yandex.cloud.serverless.containers.v1.MetadataOptions}

#|
||Field | Description ||
|| gceHttpEndpoint | **enum** (MetadataOption)

- `ENABLED`
- `DISABLED` ||
|| awsV1HttpEndpoint | **enum** (MetadataOption)

- `ENABLED`
- `DISABLED` ||
|#