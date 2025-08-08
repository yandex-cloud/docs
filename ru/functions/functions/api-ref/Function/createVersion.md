---
editable: false
apiPlayground:
  - url: https://serverless-functions.{{ api-host }}/functions/v1/versions
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        functionId:
          description: |-
            **string**
            Required field. ID of the function to create a version for.
            To get a function ID, make a [FunctionService.List](/docs/functions/functions/api-ref/Function/list#List) request.
          type: string
        runtime:
          description: |-
            **string**
            Required field. Runtime environment for the version.
          type: string
        description:
          description: |-
            **string**
            Description of the version
          type: string
        entrypoint:
          description: |-
            **string**
            Required field. Entrypoint of the version.
          type: string
        resources:
          description: |-
            **[Resources](/docs/functions/functions/api-ref/Function/getVersion#yandex.cloud.serverless.functions.v1.Resources)**
            Required field. Resources allocated to the version.
          $ref: '#/definitions/Resources'
        executionTimeout:
          description: |-
            **string** (duration)
            Required field. Timeout for the execution of the version.
            If the timeout is exceeded, Cloud Functions responds with a 504 HTTP code.
          type: string
          format: duration
        serviceAccountId:
          description: |-
            **string**
            ID of the service account to associate with the version.
          type: string
        package:
          description: |-
            **[Package](/docs/functions/functions/api-ref/Function/createVersion#yandex.cloud.serverless.functions.v1.Package)**
            Functions deployment package.
            Includes only one of the fields `package`, `content`, `versionId`.
            Source of the deployment package for the version.
          $ref: '#/definitions/Package'
        content:
          description: |-
            **string** (bytes)
            Content of the deployment package.
            Includes only one of the fields `package`, `content`, `versionId`.
            Source of the deployment package for the version.
          type: string
          format: bytes
        versionId:
          description: |-
            **string**
            ID of the version to be copied from. Source version must belong to the same folder as the created version
            and the user must have read permissions to the source version.
            Includes only one of the fields `package`, `content`, `versionId`.
            Source of the deployment package for the version.
          type: string
        environment:
          description: |-
            **object** (map<**string**, **string**>)
            Environment settings for the version.
          pattern: '[a-zA-Z][a-zA-Z0-9_]*'
          type: string
        tag:
          description: |-
            **string**
            Function version tags. For details, see [Version tag](/docs/functions/concepts/function#tag).
          pattern: '[a-z][-_0-9a-z]*'
          type: array
          items:
            type: string
        connectivity:
          description: |-
            **[Connectivity](/docs/functions/functions/api-ref/Function/getVersion#yandex.cloud.serverless.functions.v1.Connectivity)**
            Function version connectivity. If specified the version will be attached to specified network/subnet(s).
          $ref: '#/definitions/Connectivity'
        namedServiceAccounts:
          description: |-
            **object** (map<**string**, **string**>)
            Additional service accounts to be used by the version.
          type: string
        secrets:
          description: |-
            **[Secret](/docs/functions/functions/api-ref/Function/getVersion#yandex.cloud.serverless.functions.v1.Secret)**
            Yandex Lockbox secrets to be used by the version.
          type: array
          items:
            oneOf:
              - type: object
                properties:
                  environmentVariable:
                    description: |-
                      **string**
                      environment variable in which secret's value to be delivered.
                      Includes only one of the fields `environmentVariable`.
                    type: string
        logOptions:
          description: |-
            **[LogOptions](/docs/functions/functions/api-ref/Function/getVersion#yandex.cloud.serverless.functions.v1.LogOptions)**
            Options for logging from the function
          oneOf:
            - type: object
              properties:
                logGroupId:
                  description: |-
                    **string**
                    Entry should be written to log group resolved by ID.
                    Includes only one of the fields `logGroupId`, `folderId`.
                    Log entries destination.
                  pattern: ([a-zA-Z][-a-zA-Z0-9_.]{0,63})?
                  type: string
                folderId:
                  description: |-
                    **string**
                    Entry should be written to default log group for specified folder.
                    Includes only one of the fields `logGroupId`, `folderId`.
                    Log entries destination.
                  pattern: ([a-zA-Z][-a-zA-Z0-9_.]{0,63})?
                  type: string
        storageMounts:
          description: |-
            **[StorageMount](/docs/functions/functions/api-ref/Function/getVersion#yandex.cloud.serverless.functions.v1.StorageMount)**
            S3 mounts to be used by the version.
          type: array
          items:
            $ref: '#/definitions/StorageMount'
        asyncInvocationConfig:
          description: |-
            **[AsyncInvocationConfig](/docs/functions/functions/api-ref/Function/getVersion#yandex.cloud.serverless.functions.v1.AsyncInvocationConfig)**
            Config for asynchronous invocations of the version
          $ref: '#/definitions/AsyncInvocationConfig'
        tmpfsSize:
          description: |-
            **string** (int64)
            Optional size of in-memory mounted /tmp directory in bytes.
            Available for versions with resources.memory greater or equal to 1024 MiB.
            0 or in range from 512 MiB to 3/4 of resources.memory.
          type: string
          format: int64
        concurrency:
          description: |-
            **string** (int64)
            The maximum number of requests processed by a function instance at the same time
          type: string
          format: int64
        mounts:
          description: |-
            **[Mount](/docs/functions/functions/api-ref/Function/getVersion#yandex.cloud.serverless.functions.v1.Mount)**
            Mounts to be used by the version.
          type: array
          items:
            oneOf:
              - type: object
                properties:
                  objectStorage:
                    description: |-
                      **[ObjectStorage](/docs/functions/functions/api-ref/Function/getVersion#yandex.cloud.serverless.functions.v1.Mount.ObjectStorage)**
                      Object storage mounts
                      Includes only one of the fields `objectStorage`, `ephemeralDiskSpec`.
                      Target mount option
                    $ref: '#/definitions/ObjectStorage'
                  ephemeralDiskSpec:
                    description: |-
                      **[DiskSpec](/docs/functions/functions/api-ref/Function/getVersion#yandex.cloud.serverless.functions.v1.Mount.DiskSpec)**
                      Working disk (worker-local non-shared read-write NBS disk templates)
                      Includes only one of the fields `objectStorage`, `ephemeralDiskSpec`.
                      Target mount option
                    $ref: '#/definitions/DiskSpec'
        metadataOptions:
          description: |-
            **[MetadataOptions](/docs/functions/functions/api-ref/Function/getVersion#yandex.cloud.serverless.functions.v1.MetadataOptions)**
            Metadata options for the version.
          $ref: '#/definitions/MetadataOptions'
      required:
        - functionId
        - runtime
        - entrypoint
        - resources
        - executionTimeout
      additionalProperties: false
    definitions:
      Resources:
        type: object
        properties:
          memory:
            description: |-
              **string** (int64)
              Amount of memory available to the version, specified in bytes, multiple of 128MB.
            type: string
            format: int64
      Package:
        type: object
        properties:
          bucketName:
            description: |-
              **string**
              Required field. Name of the bucket that stores the code for the version.
            type: string
          objectName:
            description: |-
              **string**
              Required field. Name of the object in the bucket that stores the code for the version.
            type: string
          sha256:
            description: |-
              **string**
              SHA256 hash of the version deployment package.
            type: string
        required:
          - bucketName
          - objectName
      Connectivity:
        type: object
        properties:
          networkId:
            description: |-
              **string**
              Network the version will have access to.
              It's essential to specify network with subnets in all availability zones.
            type: string
          subnetId:
            description: |-
              **string**
              Complete list of subnets (from the same network) the version can be attached to.
              It's essential to specify at least one subnet for each availability zones.
            uniqueItems: true
            type: array
            items:
              type: string
      StorageMount:
        type: object
        properties:
          bucketId:
            description: |-
              **string**
              Required field. S3 bucket name for mounting.
            pattern: '[-.0-9a-zA-Z]*'
            type: string
          prefix:
            description: |-
              **string**
              S3 bucket prefix for mounting.
            type: string
          mountPointName:
            description: |-
              **string**
              Required field. Mount point directory name (not path) for mounting.
            pattern: '[-_0-9a-zA-Z]*'
            type: string
          readOnly:
            description: |-
              **boolean**
              Is mount read only.
            type: boolean
        required:
          - bucketId
          - mountPointName
      EmptyTarget:
        type: object
        properties: {}
      YMQTarget:
        type: object
        properties:
          queueArn:
            description: |-
              **string**
              Required field. Queue ARN
            type: string
          serviceAccountId:
            description: |-
              **string**
              Required field. Service account which has write permission on the queue.
            type: string
        required:
          - queueArn
          - serviceAccountId
      AsyncInvocationConfig:
        type: object
        properties:
          retriesCount:
            description: |-
              **string** (int64)
              Number of retries of version invocation
            type: string
            format: int64
          successTarget:
            description: |-
              **[ResponseTarget](/docs/functions/functions/api-ref/Function/getVersion#yandex.cloud.serverless.functions.v1.AsyncInvocationConfig.ResponseTarget)**
              Required field. Target for successful result of the version's invocation
            oneOf:
              - type: object
                properties:
                  emptyTarget:
                    description: |-
                      **object**
                      Target to ignore a result
                      Includes only one of the fields `emptyTarget`, `ymqTarget`.
                    $ref: '#/definitions/EmptyTarget'
                  ymqTarget:
                    description: |-
                      **[YMQTarget](/docs/functions/functions/api-ref/Function/getVersion#yandex.cloud.serverless.functions.v1.YMQTarget)**
                      Target to send a result to ymq
                      Includes only one of the fields `emptyTarget`, `ymqTarget`.
                    $ref: '#/definitions/YMQTarget'
          failureTarget:
            description: |-
              **[ResponseTarget](/docs/functions/functions/api-ref/Function/getVersion#yandex.cloud.serverless.functions.v1.AsyncInvocationConfig.ResponseTarget)**
              Required field. Target for unsuccessful result, if all retries failed
            oneOf:
              - type: object
                properties:
                  emptyTarget:
                    description: |-
                      **object**
                      Target to ignore a result
                      Includes only one of the fields `emptyTarget`, `ymqTarget`.
                    $ref: '#/definitions/EmptyTarget'
                  ymqTarget:
                    description: |-
                      **[YMQTarget](/docs/functions/functions/api-ref/Function/getVersion#yandex.cloud.serverless.functions.v1.YMQTarget)**
                      Target to send a result to ymq
                      Includes only one of the fields `emptyTarget`, `ymqTarget`.
                    $ref: '#/definitions/YMQTarget'
          serviceAccountId:
            description: |-
              **string**
              Service account which can invoke version
            type: string
        required:
          - successTarget
          - failureTarget
      ObjectStorage:
        type: object
        properties:
          bucketId:
            description: |-
              **string**
              Required field. ObjectStorage bucket name for mounting.
            pattern: '[-.0-9a-zA-Z]*'
            type: string
          prefix:
            description: |-
              **string**
              ObjectStorage bucket prefix for mounting.
            type: string
        required:
          - bucketId
      DiskSpec:
        type: object
        properties:
          size:
            description: |-
              **string** (int64)
              The size of disk for mount in bytes
            type: string
            format: int64
          blockSize:
            description: |-
              **string** (int64)
              Optional block size of disk for mount in bytes
            type: string
            format: int64
      MetadataOptions:
        type: object
        properties:
          gceHttpEndpoint:
            description: |-
              **enum** (MetadataOption)
              Enabled access to GCE flavored metadata
              - `METADATA_OPTION_UNSPECIFIED`: Option is default
              - `ENABLED`: Option is enabled
              - `DISABLED`: Option is disabled
            type: string
            enum:
              - METADATA_OPTION_UNSPECIFIED
              - ENABLED
              - DISABLED
          awsV1HttpEndpoint:
            description: |-
              **enum** (MetadataOption)
              Enabled access to AWS flavored metadata (IMDSv1)
              - `METADATA_OPTION_UNSPECIFIED`: Option is default
              - `ENABLED`: Option is enabled
              - `DISABLED`: Option is disabled
            type: string
            enum:
              - METADATA_OPTION_UNSPECIFIED
              - ENABLED
              - DISABLED
sourcePath: en/_api-ref/serverless/functions/v1/functions/api-ref/Function/createVersion.md
---

# Cloud Functions Service, REST: Function.CreateVersion

Creates a version for the specified function.

## HTTP request

```
POST https://serverless-functions.{{ api-host }}/functions/v1/versions
```

## Body parameters {#yandex.cloud.serverless.functions.v1.CreateFunctionVersionRequest}

```json
{
  "functionId": "string",
  "runtime": "string",
  "description": "string",
  "entrypoint": "string",
  "resources": {
    "memory": "string"
  },
  "executionTimeout": "string",
  "serviceAccountId": "string",
  // Includes only one of the fields `package`, `content`, `versionId`
  "package": {
    "bucketName": "string",
    "objectName": "string",
    "sha256": "string"
  },
  "content": "string",
  "versionId": "string",
  // end of the list of possible fields
  "environment": "object",
  "tag": [
    "string"
  ],
  "connectivity": {
    "networkId": "string",
    "subnetId": [
      "string"
    ]
  },
  "namedServiceAccounts": "object",
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
  "logOptions": {
    "disabled": "boolean",
    // Includes only one of the fields `logGroupId`, `folderId`
    "logGroupId": "string",
    "folderId": "string",
    // end of the list of possible fields
    "minLevel": "string"
  },
  "storageMounts": [
    {
      "bucketId": "string",
      "prefix": "string",
      "mountPointName": "string",
      "readOnly": "boolean"
    }
  ],
  "asyncInvocationConfig": {
    "retriesCount": "string",
    "successTarget": {
      // Includes only one of the fields `emptyTarget`, `ymqTarget`
      "emptyTarget": "object",
      "ymqTarget": {
        "queueArn": "string",
        "serviceAccountId": "string"
      }
      // end of the list of possible fields
    },
    "failureTarget": {
      // Includes only one of the fields `emptyTarget`, `ymqTarget`
      "emptyTarget": "object",
      "ymqTarget": {
        "queueArn": "string",
        "serviceAccountId": "string"
      }
      // end of the list of possible fields
    },
    "serviceAccountId": "string"
  },
  "tmpfsSize": "string",
  "concurrency": "string",
  "mounts": [
    {
      "name": "string",
      "mode": "string",
      // Includes only one of the fields `objectStorage`, `ephemeralDiskSpec`
      "objectStorage": {
        "bucketId": "string",
        "prefix": "string"
      },
      "ephemeralDiskSpec": {
        "size": "string",
        "blockSize": "string"
      }
      // end of the list of possible fields
    }
  ],
  "metadataOptions": {
    "gceHttpEndpoint": "string",
    "awsV1HttpEndpoint": "string"
  }
}
```

#|
||Field | Description ||
|| functionId | **string**

Required field. ID of the function to create a version for.

To get a function ID, make a [FunctionService.List](/docs/functions/functions/api-ref/Function/list#List) request. ||
|| runtime | **string**

Required field. Runtime environment for the version. ||
|| description | **string**

Description of the version ||
|| entrypoint | **string**

Required field. Entrypoint of the version. ||
|| resources | **[Resources](#yandex.cloud.serverless.functions.v1.Resources)**

Required field. Resources allocated to the version. ||
|| executionTimeout | **string** (duration)

Required field. Timeout for the execution of the version.

If the timeout is exceeded, Cloud Functions responds with a 504 HTTP code. ||
|| serviceAccountId | **string**

ID of the service account to associate with the version. ||
|| package | **[Package](#yandex.cloud.serverless.functions.v1.Package)**

Functions deployment package.

Includes only one of the fields `package`, `content`, `versionId`.

Source of the deployment package for the version. ||
|| content | **string** (bytes)

Content of the deployment package.

Includes only one of the fields `package`, `content`, `versionId`.

Source of the deployment package for the version. ||
|| versionId | **string**

ID of the version to be copied from. Source version must belong to the same folder as the created version
and the user must have read permissions to the source version.

Includes only one of the fields `package`, `content`, `versionId`.

Source of the deployment package for the version. ||
|| environment | **object** (map<**string**, **string**>)

Environment settings for the version. ||
|| tag[] | **string**

Function version tags. For details, see [Version tag](/docs/functions/concepts/function#tag). ||
|| connectivity | **[Connectivity](#yandex.cloud.serverless.functions.v1.Connectivity)**

Function version connectivity. If specified the version will be attached to specified network/subnet(s). ||
|| namedServiceAccounts | **object** (map<**string**, **string**>)

Additional service accounts to be used by the version. ||
|| secrets[] | **[Secret](#yandex.cloud.serverless.functions.v1.Secret)**

Yandex Lockbox secrets to be used by the version. ||
|| logOptions | **[LogOptions](#yandex.cloud.serverless.functions.v1.LogOptions)**

Options for logging from the function ||
|| storageMounts[] | **[StorageMount](#yandex.cloud.serverless.functions.v1.StorageMount)**

S3 mounts to be used by the version. ||
|| asyncInvocationConfig | **[AsyncInvocationConfig](#yandex.cloud.serverless.functions.v1.AsyncInvocationConfig)**

Config for asynchronous invocations of the version ||
|| tmpfsSize | **string** (int64)

Optional size of in-memory mounted /tmp directory in bytes.
Available for versions with resources.memory greater or equal to 1024 MiB.

0 or in range from 512 MiB to 3/4 of resources.memory. ||
|| concurrency | **string** (int64)

The maximum number of requests processed by a function instance at the same time ||
|| mounts[] | **[Mount](#yandex.cloud.serverless.functions.v1.Mount)**

Mounts to be used by the version. ||
|| metadataOptions | **[MetadataOptions](#yandex.cloud.serverless.functions.v1.MetadataOptions)**

Metadata options for the version. ||
|#

## Resources {#yandex.cloud.serverless.functions.v1.Resources}

Resources allocated to a version.

#|
||Field | Description ||
|| memory | **string** (int64)

Amount of memory available to the version, specified in bytes, multiple of 128MB. ||
|#

## Package {#yandex.cloud.serverless.functions.v1.Package}

Version deployment package.

#|
||Field | Description ||
|| bucketName | **string**

Required field. Name of the bucket that stores the code for the version. ||
|| objectName | **string**

Required field. Name of the object in the bucket that stores the code for the version. ||
|| sha256 | **string**

SHA256 hash of the version deployment package. ||
|#

## Connectivity {#yandex.cloud.serverless.functions.v1.Connectivity}

Version connectivity specification.

#|
||Field | Description ||
|| networkId | **string**

Network the version will have access to.
It's essential to specify network with subnets in all availability zones. ||
|| subnetId[] | **string**

Complete list of subnets (from the same network) the version can be attached to.
It's essential to specify at least one subnet for each availability zones. ||
|#

## Secret {#yandex.cloud.serverless.functions.v1.Secret}

Secret for serverless function.

#|
||Field | Description ||
|| id | **string**

ID of Yandex Lockbox secret. ||
|| versionId | **string**

ID of Yandex Lockbox version. ||
|| key | **string**

Key in secret's payload, which value to be delivered into function environment. ||
|| environmentVariable | **string**

environment variable in which secret's value to be delivered.

Includes only one of the fields `environmentVariable`. ||
|#

## LogOptions {#yandex.cloud.serverless.functions.v1.LogOptions}

#|
||Field | Description ||
|| disabled | **boolean**

Is logging from function disabled. ||
|| logGroupId | **string**

Entry should be written to log group resolved by ID.

Includes only one of the fields `logGroupId`, `folderId`.

Log entries destination. ||
|| folderId | **string**

Entry should be written to default log group for specified folder.

Includes only one of the fields `logGroupId`, `folderId`.

Log entries destination. ||
|| minLevel | **enum** (Level)

Minimum log entry level.

See [LogLevel.Level](/docs/logging/api-ref/Export/run#yandex.cloud.logging.v1.LogLevel.Level) for details.

- `LEVEL_UNSPECIFIED`: Default log level.

  Equivalent to not specifying log level at all.
- `TRACE`: Trace log level.

  Possible use case: verbose logging of some business logic.
- `DEBUG`: Debug log level.

  Possible use case: debugging special cases in application logic.
- `INFO`: Info log level.

  Mostly used for information messages.
- `WARN`: Warn log level.

  May be used to alert about significant events.
- `ERROR`: Error log level.

  May be used to alert about errors in infrastructure, logic, etc.
- `FATAL`: Fatal log level.

  May be used to alert about unrecoverable failures and events. ||
|#

## StorageMount {#yandex.cloud.serverless.functions.v1.StorageMount}

#|
||Field | Description ||
|| bucketId | **string**

Required field. S3 bucket name for mounting. ||
|| prefix | **string**

S3 bucket prefix for mounting. ||
|| mountPointName | **string**

Required field. Mount point directory name (not path) for mounting. ||
|| readOnly | **boolean**

Is mount read only. ||
|#

## AsyncInvocationConfig {#yandex.cloud.serverless.functions.v1.AsyncInvocationConfig}

#|
||Field | Description ||
|| retriesCount | **string** (int64)

Number of retries of version invocation ||
|| successTarget | **[ResponseTarget](#yandex.cloud.serverless.functions.v1.AsyncInvocationConfig.ResponseTarget)**

Required field. Target for successful result of the version's invocation ||
|| failureTarget | **[ResponseTarget](#yandex.cloud.serverless.functions.v1.AsyncInvocationConfig.ResponseTarget)**

Required field. Target for unsuccessful result, if all retries failed ||
|| serviceAccountId | **string**

Service account which can invoke version ||
|#

## ResponseTarget {#yandex.cloud.serverless.functions.v1.AsyncInvocationConfig.ResponseTarget}

Target to which a result of an invocation will be sent

#|
||Field | Description ||
|| emptyTarget | **object**

Target to ignore a result

Includes only one of the fields `emptyTarget`, `ymqTarget`. ||
|| ymqTarget | **[YMQTarget](#yandex.cloud.serverless.functions.v1.YMQTarget)**

Target to send a result to ymq

Includes only one of the fields `emptyTarget`, `ymqTarget`. ||
|#

## YMQTarget {#yandex.cloud.serverless.functions.v1.YMQTarget}

#|
||Field | Description ||
|| queueArn | **string**

Required field. Queue ARN ||
|| serviceAccountId | **string**

Required field. Service account which has write permission on the queue. ||
|#

## Mount {#yandex.cloud.serverless.functions.v1.Mount}

Mount contains an information about version's external storage mount

#|
||Field | Description ||
|| name | **string**

Required field. Unique mount point name. Device will be mounted into /function/storage/<name> ||
|| mode | **enum** (Mode)

Mount's mode

- `MODE_UNSPECIFIED`
- `READ_ONLY`
- `READ_WRITE` ||
|| objectStorage | **[ObjectStorage](#yandex.cloud.serverless.functions.v1.Mount.ObjectStorage)**

Object storage mounts

Includes only one of the fields `objectStorage`, `ephemeralDiskSpec`.

Target mount option ||
|| ephemeralDiskSpec | **[DiskSpec](#yandex.cloud.serverless.functions.v1.Mount.DiskSpec)**

Working disk (worker-local non-shared read-write NBS disk templates)

Includes only one of the fields `objectStorage`, `ephemeralDiskSpec`.

Target mount option ||
|#

## ObjectStorage {#yandex.cloud.serverless.functions.v1.Mount.ObjectStorage}

ObjectStorage as a mount

#|
||Field | Description ||
|| bucketId | **string**

Required field. ObjectStorage bucket name for mounting. ||
|| prefix | **string**

ObjectStorage bucket prefix for mounting. ||
|#

## DiskSpec {#yandex.cloud.serverless.functions.v1.Mount.DiskSpec}

Disk as a mount

#|
||Field | Description ||
|| size | **string** (int64)

The size of disk for mount in bytes ||
|| blockSize | **string** (int64)

Optional block size of disk for mount in bytes ||
|#

## MetadataOptions {#yandex.cloud.serverless.functions.v1.MetadataOptions}

#|
||Field | Description ||
|| gceHttpEndpoint | **enum** (MetadataOption)

Enabled access to GCE flavored metadata

- `METADATA_OPTION_UNSPECIFIED`: Option is default
- `ENABLED`: Option is enabled
- `DISABLED`: Option is disabled ||
|| awsV1HttpEndpoint | **enum** (MetadataOption)

Enabled access to AWS flavored metadata (IMDSv1)

- `METADATA_OPTION_UNSPECIFIED`: Option is default
- `ENABLED`: Option is enabled
- `DISABLED`: Option is disabled ||
|#

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": {
    "functionVersionId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": {
    "id": "string",
    "functionId": "string",
    "description": "string",
    "createdAt": "string",
    "runtime": "string",
    "entrypoint": "string",
    "resources": {
      "memory": "string"
    },
    "executionTimeout": "string",
    "serviceAccountId": "string",
    "imageSize": "string",
    "status": "string",
    "tags": [
      "string"
    ],
    "environment": "object",
    "connectivity": {
      "networkId": "string",
      "subnetId": [
        "string"
      ]
    },
    "namedServiceAccounts": "object",
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
    "logOptions": {
      "disabled": "boolean",
      // Includes only one of the fields `logGroupId`, `folderId`
      "logGroupId": "string",
      "folderId": "string",
      // end of the list of possible fields
      "minLevel": "string"
    },
    "storageMounts": [
      {
        "bucketId": "string",
        "prefix": "string",
        "mountPointName": "string",
        "readOnly": "boolean"
      }
    ],
    "asyncInvocationConfig": {
      "retriesCount": "string",
      "successTarget": {
        // Includes only one of the fields `emptyTarget`, `ymqTarget`
        "emptyTarget": "object",
        "ymqTarget": {
          "queueArn": "string",
          "serviceAccountId": "string"
        }
        // end of the list of possible fields
      },
      "failureTarget": {
        // Includes only one of the fields `emptyTarget`, `ymqTarget`
        "emptyTarget": "object",
        "ymqTarget": {
          "queueArn": "string",
          "serviceAccountId": "string"
        }
        // end of the list of possible fields
      },
      "serviceAccountId": "string"
    },
    "tmpfsSize": "string",
    "concurrency": "string",
    "mounts": [
      {
        "name": "string",
        "mode": "string",
        // Includes only one of the fields `objectStorage`, `ephemeralDiskSpec`
        "objectStorage": {
          "bucketId": "string",
          "prefix": "string"
        },
        "ephemeralDiskSpec": {
          "size": "string",
          "blockSize": "string"
        }
        // end of the list of possible fields
      }
    ],
    "metadataOptions": {
      "gceHttpEndpoint": "string",
      "awsV1HttpEndpoint": "string"
    }
  }
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[CreateFunctionVersionMetadata](#yandex.cloud.serverless.functions.v1.CreateFunctionVersionMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[Version](#yandex.cloud.serverless.functions.v1.Version)**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## CreateFunctionVersionMetadata {#yandex.cloud.serverless.functions.v1.CreateFunctionVersionMetadata}

#|
||Field | Description ||
|| functionVersionId | **string**

ID of the version that is being created. ||
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

## Version {#yandex.cloud.serverless.functions.v1.Version}

Version of a function. For details about the concept, see [Function versions](/docs/functions/concepts/function#version).

#|
||Field | Description ||
|| id | **string**

ID of the version. ||
|| functionId | **string**

ID of the function that the version belongs to. ||
|| description | **string**

Description of the version. ||
|| createdAt | **string** (date-time)

Creation timestamp for the version.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| runtime | **string**

ID of the runtime environment for the function.

Supported environments and their identifiers are listed in the [Runtime environments](/docs/functions/concepts/runtime). ||
|| entrypoint | **string**

Entrypoint for the function: the name of the function to be called as the handler.

Specified in the format `<function file name>.<handler name>`, for example, `index.myFunction`. ||
|| resources | **[Resources](#yandex.cloud.serverless.functions.v1.Resources2)**

Resources allocated to the version. ||
|| executionTimeout | **string** (duration)

Timeout for the execution of the version.

If the timeout is exceeded, Cloud Functions responds with a 504 HTTP code. ||
|| serviceAccountId | **string**

ID of the service account associated with the version. ||
|| imageSize | **string** (int64)

Final size of the deployment package after unpacking. ||
|| status | **enum** (Status)

Status of the version.

- `STATUS_UNSPECIFIED`
- `CREATING`: Version is being created.
- `ACTIVE`: Version is ready to use.
- `OBSOLETE`: Version will be deleted soon.
- `DELETING`: Version is being deleted. ||
|| tags[] | **string**

Version tags. For details, see [Version tag](/docs/functions/concepts/function#tag). ||
|| environment | **object** (map<**string**, **string**>)

Environment settings for the version. ||
|| connectivity | **[Connectivity](#yandex.cloud.serverless.functions.v1.Connectivity2)**

Network access. If specified the version will be attached to specified network/subnet(s). ||
|| namedServiceAccounts | **object** (map<**string**, **string**>)

Additional service accounts to be used by the version. ||
|| secrets[] | **[Secret](#yandex.cloud.serverless.functions.v1.Secret2)**

Yandex Lockbox secrets to be used by the version. ||
|| logOptions | **[LogOptions](#yandex.cloud.serverless.functions.v1.LogOptions2)**

Options for logging from the function ||
|| storageMounts[] | **[StorageMount](#yandex.cloud.serverless.functions.v1.StorageMount2)**

S3 mounts to be used by the version. ||
|| asyncInvocationConfig | **[AsyncInvocationConfig](#yandex.cloud.serverless.functions.v1.AsyncInvocationConfig2)**

Config for asynchronous invocations of the version ||
|| tmpfsSize | **string** (int64)

Optional size of in-memory mounted /tmp directory in bytes. ||
|| concurrency | **string** (int64)

The maximum number of requests processed by a function instance at the same time ||
|| mounts[] | **[Mount](#yandex.cloud.serverless.functions.v1.Mount2)**

Mounts to be used by the version. ||
|| metadataOptions | **[MetadataOptions](#yandex.cloud.serverless.functions.v1.MetadataOptions2)**

Metadata options for the version. ||
|#

## Resources {#yandex.cloud.serverless.functions.v1.Resources2}

Resources allocated to a version.

#|
||Field | Description ||
|| memory | **string** (int64)

Amount of memory available to the version, specified in bytes, multiple of 128MB. ||
|#

## Connectivity {#yandex.cloud.serverless.functions.v1.Connectivity2}

Version connectivity specification.

#|
||Field | Description ||
|| networkId | **string**

Network the version will have access to.
It's essential to specify network with subnets in all availability zones. ||
|| subnetId[] | **string**

Complete list of subnets (from the same network) the version can be attached to.
It's essential to specify at least one subnet for each availability zones. ||
|#

## Secret {#yandex.cloud.serverless.functions.v1.Secret2}

Secret for serverless function.

#|
||Field | Description ||
|| id | **string**

ID of Yandex Lockbox secret. ||
|| versionId | **string**

ID of Yandex Lockbox version. ||
|| key | **string**

Key in secret's payload, which value to be delivered into function environment. ||
|| environmentVariable | **string**

environment variable in which secret's value to be delivered.

Includes only one of the fields `environmentVariable`. ||
|#

## LogOptions {#yandex.cloud.serverless.functions.v1.LogOptions2}

#|
||Field | Description ||
|| disabled | **boolean**

Is logging from function disabled. ||
|| logGroupId | **string**

Entry should be written to log group resolved by ID.

Includes only one of the fields `logGroupId`, `folderId`.

Log entries destination. ||
|| folderId | **string**

Entry should be written to default log group for specified folder.

Includes only one of the fields `logGroupId`, `folderId`.

Log entries destination. ||
|| minLevel | **enum** (Level)

Minimum log entry level.

See [LogLevel.Level](/docs/logging/api-ref/Export/run#yandex.cloud.logging.v1.LogLevel.Level) for details.

- `LEVEL_UNSPECIFIED`: Default log level.

  Equivalent to not specifying log level at all.
- `TRACE`: Trace log level.

  Possible use case: verbose logging of some business logic.
- `DEBUG`: Debug log level.

  Possible use case: debugging special cases in application logic.
- `INFO`: Info log level.

  Mostly used for information messages.
- `WARN`: Warn log level.

  May be used to alert about significant events.
- `ERROR`: Error log level.

  May be used to alert about errors in infrastructure, logic, etc.
- `FATAL`: Fatal log level.

  May be used to alert about unrecoverable failures and events. ||
|#

## StorageMount {#yandex.cloud.serverless.functions.v1.StorageMount2}

#|
||Field | Description ||
|| bucketId | **string**

Required field. S3 bucket name for mounting. ||
|| prefix | **string**

S3 bucket prefix for mounting. ||
|| mountPointName | **string**

Required field. Mount point directory name (not path) for mounting. ||
|| readOnly | **boolean**

Is mount read only. ||
|#

## AsyncInvocationConfig {#yandex.cloud.serverless.functions.v1.AsyncInvocationConfig2}

#|
||Field | Description ||
|| retriesCount | **string** (int64)

Number of retries of version invocation ||
|| successTarget | **[ResponseTarget](#yandex.cloud.serverless.functions.v1.AsyncInvocationConfig.ResponseTarget2)**

Required field. Target for successful result of the version's invocation ||
|| failureTarget | **[ResponseTarget](#yandex.cloud.serverless.functions.v1.AsyncInvocationConfig.ResponseTarget2)**

Required field. Target for unsuccessful result, if all retries failed ||
|| serviceAccountId | **string**

Service account which can invoke version ||
|#

## ResponseTarget {#yandex.cloud.serverless.functions.v1.AsyncInvocationConfig.ResponseTarget2}

Target to which a result of an invocation will be sent

#|
||Field | Description ||
|| emptyTarget | **object**

Target to ignore a result

Includes only one of the fields `emptyTarget`, `ymqTarget`. ||
|| ymqTarget | **[YMQTarget](#yandex.cloud.serverless.functions.v1.YMQTarget2)**

Target to send a result to ymq

Includes only one of the fields `emptyTarget`, `ymqTarget`. ||
|#

## YMQTarget {#yandex.cloud.serverless.functions.v1.YMQTarget2}

#|
||Field | Description ||
|| queueArn | **string**

Required field. Queue ARN ||
|| serviceAccountId | **string**

Required field. Service account which has write permission on the queue. ||
|#

## Mount {#yandex.cloud.serverless.functions.v1.Mount2}

Mount contains an information about version's external storage mount

#|
||Field | Description ||
|| name | **string**

Required field. Unique mount point name. Device will be mounted into /function/storage/<name> ||
|| mode | **enum** (Mode)

Mount's mode

- `MODE_UNSPECIFIED`
- `READ_ONLY`
- `READ_WRITE` ||
|| objectStorage | **[ObjectStorage](#yandex.cloud.serverless.functions.v1.Mount.ObjectStorage2)**

Object storage mounts

Includes only one of the fields `objectStorage`, `ephemeralDiskSpec`.

Target mount option ||
|| ephemeralDiskSpec | **[DiskSpec](#yandex.cloud.serverless.functions.v1.Mount.DiskSpec2)**

Working disk (worker-local non-shared read-write NBS disk templates)

Includes only one of the fields `objectStorage`, `ephemeralDiskSpec`.

Target mount option ||
|#

## ObjectStorage {#yandex.cloud.serverless.functions.v1.Mount.ObjectStorage2}

ObjectStorage as a mount

#|
||Field | Description ||
|| bucketId | **string**

Required field. ObjectStorage bucket name for mounting. ||
|| prefix | **string**

ObjectStorage bucket prefix for mounting. ||
|#

## DiskSpec {#yandex.cloud.serverless.functions.v1.Mount.DiskSpec2}

Disk as a mount

#|
||Field | Description ||
|| size | **string** (int64)

The size of disk for mount in bytes ||
|| blockSize | **string** (int64)

Optional block size of disk for mount in bytes ||
|#

## MetadataOptions {#yandex.cloud.serverless.functions.v1.MetadataOptions2}

#|
||Field | Description ||
|| gceHttpEndpoint | **enum** (MetadataOption)

Enabled access to GCE flavored metadata

- `METADATA_OPTION_UNSPECIFIED`: Option is default
- `ENABLED`: Option is enabled
- `DISABLED`: Option is disabled ||
|| awsV1HttpEndpoint | **enum** (MetadataOption)

Enabled access to AWS flavored metadata (IMDSv1)

- `METADATA_OPTION_UNSPECIFIED`: Option is default
- `ENABLED`: Option is enabled
- `DISABLED`: Option is disabled ||
|#