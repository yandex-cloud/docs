[Документация Yandex Cloud](../../../../index.md) > [Yandex Audit Trails](../../../index.md) > Справочник аудитных логов (англ.) > spark > CreateEnvironment

# Managed Spark Audit Trails Events: CreateEnvironment

## Event JSON schema {#yandex.cloud.audit.spark.CreateEnvironment2-schema}

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
    "environmentId": "string",
    "environmentName": "string",
    "environment": {
      "info": {
        "id": "string",
        "lifeStage": "string",
        "name": "string",
        "description": "string",
        "labels": "object",
        "createdAt": "string",
        "deletedAt": "string",
        "buildRevision": "string",
        "buildBaseRevision": "string",
        "buildStatus": "string",
        "buildError": {
          "type": "string",
          "message": "string"
        },
        "buildCreatedAt": "string",
        "buildDeletedAt": "string"
      },
      "baseInfo": {
        "id": "string",
        "lifeStage": "string",
        "name": "string",
        "description": "string",
        "labels": "object",
        "createdAt": "string",
        "deletedAt": "string",
        "buildRevision": "string",
        "buildBaseRevision": "string",
        "buildStatus": "string",
        "buildError": {
          "type": "string",
          "message": "string"
        },
        "buildCreatedAt": "string",
        "buildDeletedAt": "string"
      },
      "folderId": "string",
      "config": {
        "pipPackages": [
          "string"
        ],
        "debPackages": [
          "string"
        ]
      }
    }
  },
  "requestParameters": "object",
  "response": "object"
}
```

## Field description {#yandex.cloud.audit.spark.CreateEnvironment2}

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
|| details | **[EnvironmentEventDetails](#yandex.cloud.audit.spark.EnvironmentEventDetails)** ||
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

## EnvironmentEventDetails {#yandex.cloud.audit.spark.EnvironmentEventDetails}

#|
||Field | Description ||
|| environmentId | **string** ||
|| environmentName | **string** ||
|| environment | **[Environment](#yandex.cloud.spark.v1.environment.Environment)** ||
|#

## Environment {#yandex.cloud.spark.v1.environment.Environment}

#|
||Field | Description ||
|| info | **[EnvironmentInfo](#yandex.cloud.spark.v1.environment.EnvironmentInfo)** ||
|| baseInfo | **[EnvironmentInfo](#yandex.cloud.spark.v1.environment.EnvironmentInfo)** ||
|| folderId | **string** ||
|| config | **[EnvironmentConfig](#yandex.cloud.spark.v1.environment.EnvironmentConfig)** ||
|#

## EnvironmentInfo {#yandex.cloud.spark.v1.environment.EnvironmentInfo}

#|
||Field | Description ||
|| id | **string**

The maximum string length in characters is 50. ||
|| lifeStage | **enum** (EnvironmentLifeStage)

- `ENVIRONMENT_LIFESTAGE_UNKNOWN`
- `ENVIRONMENT_LIFESTAGE_UNSTABLE`
- `ENVIRONMENT_LIFESTAGE_STABLE`
- `ENVIRONMENT_LIFESTAGE_DEPRECATED`
- `ENVIRONMENT_LIFESTAGE_DELETED` ||
|| name | **string**

The maximum string length in characters is 63. Value must match the regular expression ` ^[a-z][-a-z0-9]{1,61}[a-z0-9]$ `. ||
|| description | **string** ||
|| labels | **object** (map<**string**, **string**>)

The maximum string length in characters for each value is 63. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. Each value must match the regular expression ` [-_0-9a-z]* `. No more than 64 per resource. ||
|| createdAt | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| deletedAt | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| buildRevision | **string** (int64)

Value must be greater than 0. ||
|| buildBaseRevision | **string** (int64) ||
|| buildStatus | **enum** (BuildStatus)

- `BUILD_STATUS_UNKNOWN`
- `BUILD_STATUS_NEW`
- `BUILD_STATUS_BUILDING`
- `BUILD_STATUS_BUILT`
- `BUILD_STATUS_VALIDATING`
- `BUILD_STATUS_READY`
- `BUILD_STATUS_STABLE`
- `BUILD_STATUS_ERROR`
- `BUILD_STATUS_DELETING`
- `BUILD_STATUS_DELETED` ||
|| buildError | **[BuildError](#yandex.cloud.spark.v1.environment.BuildError)** ||
|| buildCreatedAt | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| buildDeletedAt | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#

## BuildError {#yandex.cloud.spark.v1.environment.BuildError}

#|
||Field | Description ||
|| type | **string**

The maximum string length in characters is 100. ||
|| message | **string**

The maximum string length in characters is 2000. ||
|#

## EnvironmentConfig {#yandex.cloud.spark.v1.environment.EnvironmentConfig}

#|
||Field | Description ||
|| pipPackages[] | **string**

The maximum string length in characters for each value is 256. The maximum number of elements is 100. ||
|| debPackages[] | **string**

The maximum string length in characters for each value is 256. The maximum number of elements is 100. ||
|#