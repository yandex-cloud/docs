---
editable: false
---

# Security Deck Audit Trails Events: TriggerRuntimeProcessInfo

## Event JSON schema {#yandex.cloud.audit.securitydeck.kspm.TriggerRuntimeProcessInfo2-schema}

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
    "projectId": "string",
    "projectName": "string",
    "infoType": "string",
    "process": {
      "pid": "string",
      "tid": "string",
      "execId": "string",
      "parentExecId": "string",
      "uid": "string",
      "auid": "string",
      "cwd": "string",
      "binary": "string",
      "arguments": "string",
      "startedAt": "string",
      "namespaces": {
        "uts": {
          "inum": "string",
          "isHost": "boolean"
        },
        "ipc": {
          "inum": "string",
          "isHost": "boolean"
        },
        "mnt": {
          "inum": "string",
          "isHost": "boolean"
        },
        "pid": {
          "inum": "string",
          "isHost": "boolean"
        },
        "pidForChildren": {
          "inum": "string",
          "isHost": "boolean"
        },
        "net": {
          "inum": "string",
          "isHost": "boolean"
        },
        "time": {
          "inum": "string",
          "isHost": "boolean"
        },
        "timeForChildren": {
          "inum": "string",
          "isHost": "boolean"
        },
        "cgroup": {
          "inum": "string",
          "isHost": "boolean"
        },
        "user": {
          "inum": "string",
          "isHost": "boolean"
        }
      },
      "podInfo": {
        "name": "string",
        "namespace": "string",
        "containerInfo": {
          "id": "string",
          "name": "string",
          "imageInfo": {
            "id": "string",
            "name": "string"
          },
          "startedAt": "string",
          "pid": "string"
        }
      }
    },
    "parent": {
      "pid": "string",
      "tid": "string",
      "execId": "string",
      "parentExecId": "string",
      "uid": "string",
      "auid": "string",
      "cwd": "string",
      "binary": "string",
      "arguments": "string",
      "startedAt": "string",
      "namespaces": {
        "uts": {
          "inum": "string",
          "isHost": "boolean"
        },
        "ipc": {
          "inum": "string",
          "isHost": "boolean"
        },
        "mnt": {
          "inum": "string",
          "isHost": "boolean"
        },
        "pid": {
          "inum": "string",
          "isHost": "boolean"
        },
        "pidForChildren": {
          "inum": "string",
          "isHost": "boolean"
        },
        "net": {
          "inum": "string",
          "isHost": "boolean"
        },
        "time": {
          "inum": "string",
          "isHost": "boolean"
        },
        "timeForChildren": {
          "inum": "string",
          "isHost": "boolean"
        },
        "cgroup": {
          "inum": "string",
          "isHost": "boolean"
        },
        "user": {
          "inum": "string",
          "isHost": "boolean"
        }
      },
      "podInfo": {
        "name": "string",
        "namespace": "string",
        "containerInfo": {
          "id": "string",
          "name": "string",
          "imageInfo": {
            "id": "string",
            "name": "string"
          },
          "startedAt": "string",
          "pid": "string"
        }
      }
    },
    // Includes only one of the fields `exitSignal`
    "exitSignal": "string",
    // end of the list of possible fields
    // Includes only one of the fields `exitStatus`
    "exitStatus": "string",
    // end of the list of possible fields
    "exitedAt": "string",
    "node": "string"
  },
  "requestParameters": "object",
  "response": "object"
}
```

## Field description {#yandex.cloud.audit.securitydeck.kspm.TriggerRuntimeProcessInfo2}

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
|| eventStatus | **enum** (SynchronousEventStatus)

- `ERROR`
- `DONE` ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation. ||
|| details | **[TriggerRuntimeProcessInfoDetails](#yandex.cloud.audit.securitydeck.kspm.TriggerRuntimeProcessInfoDetails)** ||
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

## TriggerRuntimeProcessInfoDetails {#yandex.cloud.audit.securitydeck.kspm.TriggerRuntimeProcessInfoDetails}

#|
||Field | Description ||
|| projectId | **string** ||
|| projectName | **string** ||
|| infoType | **enum** (ProcessInfoType)

- `EXEC`
- `EXIT` ||
|| process | **[ProcessDetails](#yandex.cloud.audit.securitydeck.kspm.TriggerRuntimeProcessInfoDetails.ProcessDetails)** ||
|| parent | **[ProcessDetails](#yandex.cloud.audit.securitydeck.kspm.TriggerRuntimeProcessInfoDetails.ProcessDetails)** ||
|| exitSignal | **string**

Includes only one of the fields `exitSignal`. ||
|| exitStatus | **string** (int64)

Includes only one of the fields `exitStatus`. ||
|| exitedAt | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| node | **string** ||
|#

## ProcessDetails {#yandex.cloud.audit.securitydeck.kspm.TriggerRuntimeProcessInfoDetails.ProcessDetails}

#|
||Field | Description ||
|| pid | **string** (int64) ||
|| tid | **string** (int64) ||
|| execId | **string** ||
|| parentExecId | **string** ||
|| uid | **string** (int64) ||
|| auid | **string** (int64) ||
|| cwd | **string** ||
|| binary | **string** ||
|| arguments | **string** ||
|| startedAt | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| namespaces | **[Namespaces](#yandex.cloud.audit.securitydeck.kspm.TriggerRuntimeProcessInfoDetails.Namespaces)** ||
|| podInfo | **[PodInfo](#yandex.cloud.audit.securitydeck.kspm.TriggerRuntimeProcessInfoDetails.PodInfo)** ||
|#

## Namespaces {#yandex.cloud.audit.securitydeck.kspm.TriggerRuntimeProcessInfoDetails.Namespaces}

#|
||Field | Description ||
|| uts | **[Namespace](#yandex.cloud.audit.securitydeck.kspm.TriggerRuntimeProcessInfoDetails.Namespace)** ||
|| ipc | **[Namespace](#yandex.cloud.audit.securitydeck.kspm.TriggerRuntimeProcessInfoDetails.Namespace)** ||
|| mnt | **[Namespace](#yandex.cloud.audit.securitydeck.kspm.TriggerRuntimeProcessInfoDetails.Namespace)** ||
|| pid | **[Namespace](#yandex.cloud.audit.securitydeck.kspm.TriggerRuntimeProcessInfoDetails.Namespace)** ||
|| pidForChildren | **[Namespace](#yandex.cloud.audit.securitydeck.kspm.TriggerRuntimeProcessInfoDetails.Namespace)** ||
|| net | **[Namespace](#yandex.cloud.audit.securitydeck.kspm.TriggerRuntimeProcessInfoDetails.Namespace)** ||
|| time | **[Namespace](#yandex.cloud.audit.securitydeck.kspm.TriggerRuntimeProcessInfoDetails.Namespace)** ||
|| timeForChildren | **[Namespace](#yandex.cloud.audit.securitydeck.kspm.TriggerRuntimeProcessInfoDetails.Namespace)** ||
|| cgroup | **[Namespace](#yandex.cloud.audit.securitydeck.kspm.TriggerRuntimeProcessInfoDetails.Namespace)** ||
|| user | **[Namespace](#yandex.cloud.audit.securitydeck.kspm.TriggerRuntimeProcessInfoDetails.Namespace)** ||
|#

## Namespace {#yandex.cloud.audit.securitydeck.kspm.TriggerRuntimeProcessInfoDetails.Namespace}

#|
||Field | Description ||
|| inum | **string** (int64) ||
|| isHost | **boolean** ||
|#

## PodInfo {#yandex.cloud.audit.securitydeck.kspm.TriggerRuntimeProcessInfoDetails.PodInfo}

#|
||Field | Description ||
|| name | **string** ||
|| namespace | **string** ||
|| containerInfo | **[ContainerInfo](#yandex.cloud.audit.securitydeck.kspm.TriggerRuntimeProcessInfoDetails.PodInfo.ContainerInfo)** ||
|#

## ContainerInfo {#yandex.cloud.audit.securitydeck.kspm.TriggerRuntimeProcessInfoDetails.PodInfo.ContainerInfo}

#|
||Field | Description ||
|| id | **string** ||
|| name | **string** ||
|| imageInfo | **[ImageInfo](#yandex.cloud.audit.securitydeck.kspm.TriggerRuntimeProcessInfoDetails.PodInfo.ContainerInfo.ImageInfo)** ||
|| startedAt | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| pid | **string** (int64) ||
|#

## ImageInfo {#yandex.cloud.audit.securitydeck.kspm.TriggerRuntimeProcessInfoDetails.PodInfo.ContainerInfo.ImageInfo}

#|
||Field | Description ||
|| id | **string** ||
|| name | **string** ||
|#