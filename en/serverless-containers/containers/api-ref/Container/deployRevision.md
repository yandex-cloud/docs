---
editable: false
apiPlayground:
  - url: https://serverless-containers.{{ api-host }}/containers/v1/revisions:deploy
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        containerId:
          description: |-
            **string**
            Required field. ID of the container to create a revision for.
            To get a container ID, make a [ContainerService.List](/docs/serverless-containers/containers/api-ref/Container/list#List) request.
          type: string
        description:
          description: |-
            **string**
            Description of the revision.
          type: string
        resources:
          description: |-
            **[Resources](#yandex.cloud.serverless.containers.v1.Resources)**
            Required field. Resources allocated to the revision.
          $ref: '#/definitions/Resources'
        executionTimeout:
          description: |-
            **string** (duration)
            Timeout for the execution of the revision.
            If the timeout is exceeded, Serverless Containers responds with a 504 HTTP code.
          type: string
          format: duration
        serviceAccountId:
          description: |-
            **string**
            ID of the service account to associate with the revision.
          type: string
        imageSpec:
          description: |-
            **[ImageSpec](#yandex.cloud.serverless.containers.v1.ImageSpec)**
            Required field. Image configuration for the revision.
          $ref: '#/definitions/ImageSpec'
        concurrency:
          description: |-
            **string** (int64)
            The number of concurrent requests allowed per container instance.
            The default value is 1.
          type: string
          format: int64
        secrets:
          description: |-
            **[Secret](#yandex.cloud.serverless.containers.v1.Secret)**
            Yandex Lockbox secrets to be used by the revision.
          type: array
          items:
            $ref: '#/definitions/Secret'
        connectivity:
          description: |-
            **[Connectivity](#yandex.cloud.serverless.containers.v1.Connectivity)**
            Network access. If specified the revision will be attached to specified network/subnet(s).
          $ref: '#/definitions/Connectivity'
        provisionPolicy:
          description: |-
            **[ProvisionPolicy](#yandex.cloud.serverless.containers.v1.ProvisionPolicy)**
            Policy for provisioning instances of the revision.
            The policy is only applied when the revision is ACTIVE.
          $ref: '#/definitions/ProvisionPolicy'
        scalingPolicy:
          description: |-
            **[ScalingPolicy](#yandex.cloud.serverless.containers.v1.ScalingPolicy)**
            Policy for scaling instances of the revision.
          $ref: '#/definitions/ScalingPolicy'
        logOptions:
          description: |-
            **[LogOptions](#yandex.cloud.serverless.containers.v1.LogOptions)**
            Options for logging from the container.
          $ref: '#/definitions/LogOptions'
        storageMounts:
          description: |-
            **[StorageMount](#yandex.cloud.serverless.containers.v1.StorageMount)**
            S3 mounts to be used by the revision.
          type: array
          items:
            $ref: '#/definitions/StorageMount'
        mounts:
          description: |-
            **[Mount](#yandex.cloud.serverless.containers.v1.Mount)**
            Mounts to be used by the revision.
          type: array
          items:
            $ref: '#/definitions/Mount'
        runtime:
          description: |-
            **[Runtime](#yandex.cloud.serverless.containers.v1.Runtime)**
            The container's execution mode.
          $ref: '#/definitions/Runtime'
        metadataOptions:
          description: |-
            **[MetadataOptions](#yandex.cloud.serverless.containers.v1.MetadataOptions)**
            Metadata options for the revision.
          $ref: '#/definitions/MetadataOptions'
        asyncInvocationConfig:
          description: |-
            **[AsyncInvocationConfig](#yandex.cloud.serverless.containers.v1.AsyncInvocationConfig)**
            Config for asynchronous invocations of the revision.
          $ref: '#/definitions/AsyncInvocationConfig'
      required:
        - containerId
        - resources
        - imageSpec
      additionalProperties: false
    definitions:
      Resources:
        type: object
        properties:
          memory:
            description: |-
              **string** (int64)
              Amount of memory available to the revision, specified in bytes, multiple of 128MB.
            type: string
            format: int64
          cores:
            description: |-
              **string** (int64)
              Number of cores available to the revision.
            type: string
            format: int64
          coreFraction:
            description: |-
              **string** (int64)
              Specifies baseline performance for a core in percent, multiple of 5%.
              Should be 100% for cores > 1.
            type: string
            format: int64
      Command:
        type: object
        properties:
          command:
            description: |-
              **string**
              Command that will override ENTRYPOINT of an image.
              Commands will be executed as is. The runtime will not substitute environment
              variables or execute shell commands. If one wants to do that, they should
              invoke shell interpreter with an appropriate shell script.
            type: array
            items:
              type: string
      Args:
        type: object
        properties:
          args:
            description: |-
              **string**
              Arguments that will override CMD of an image.
              Arguments will be passed as is. The runtime will not substitute environment
              variables or execute shell commands. If one wants to do that, they should
              invoke shell interpreter with an appropriate shell script.
            type: array
            items:
              type: string
      ImageSpec:
        type: object
        properties:
          imageUrl:
            description: |-
              **string**
              Required field. Image URL, that is used by the revision.
            type: string
          command:
            description: |-
              **[Command](#yandex.cloud.serverless.containers.v1.Command)**
              Override for the image's ENTRYPOINT.
            $ref: '#/definitions/Command'
          args:
            description: |-
              **[Args](#yandex.cloud.serverless.containers.v1.Args)**
              Override for the image's CMD.
            $ref: '#/definitions/Args'
          environment:
            description: |-
              **object** (map<**string**, **string**>)
              Additional environment for the container.
            type: object
            additionalProperties:
              type: string
              maxLength: 4096
            propertyNames:
              type: string
              pattern: '[a-zA-Z][a-zA-Z0-9_]*'
          workingDir:
            description: |-
              **string**
              Override for the image's WORKDIR.
            type: string
        required:
          - imageUrl
      Secret:
        type: object
        properties:
          id:
            description: |-
              **string**
              ID of Yandex Lockbox secret.
            type: string
          versionId:
            description: |-
              **string**
              ID of Yandex Lockbox secret.
            type: string
          key:
            description: |-
              **string**
              Key in secret's payload, which value to be delivered into container environment.
            type: string
          environmentVariable:
            description: |-
              **string**
              Environment variable in which secret's value is delivered.
              Includes only one of the fields `environmentVariable`.
            type: string
        oneOf:
          - required:
              - environmentVariable
      Connectivity:
        type: object
        properties:
          networkId:
            description: |-
              **string**
              Network the revision will have access to.
            type: string
          subnetIds:
            description: |-
              **string**
              The list of subnets (from the same network) the revision can be attached to.
              Deprecated, it is sufficient to specify only network_id, without the list of subnet_ids.
            uniqueItems: true
            type: array
            items:
              type: string
      ProvisionPolicy:
        type: object
        properties:
          minInstances:
            description: |-
              **string** (int64)
              Minimum number of guaranteed provisioned container instances for all zones
              in total.
            type: string
            format: int64
      ScalingPolicy:
        type: object
        properties:
          zoneInstancesLimit:
            description: |-
              **string** (int64)
              Upper limit for instance count in each zone.
              0 means no limit.
            type: string
            format: int64
          zoneRequestsLimit:
            description: |-
              **string** (int64)
              Upper limit of requests count in each zone.
              0 means no limit.
            type: string
            format: int64
      LogOptions:
        type: object
        properties:
          disabled:
            description: |-
              **boolean**
              Is logging from container disabled.
            type: boolean
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
          minLevel:
            description: |-
              **enum** (Level)
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
                May be used to alert about unrecoverable failures and events.
            type: string
            enum:
              - LEVEL_UNSPECIFIED
              - TRACE
              - DEBUG
              - INFO
              - WARN
              - ERROR
              - FATAL
        oneOf:
          - required:
              - logGroupId
          - required:
              - folderId
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
          readOnly:
            description: |-
              **boolean**
              Is mount read only.
            type: boolean
          mountPointPath:
            description: |-
              **string**
              Required field. Mount point path inside the container for mounting.
            pattern: '[-_0-9a-zA-Z/]*'
            type: string
        required:
          - bucketId
          - mountPointPath
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
      Mount:
        type: object
        properties:
          mountPointPath:
            description: |-
              **string**
              Required field. The absolute mount point path inside the container for mounting.
            pattern: '[-_0-9a-zA-Z/]*'
            type: string
          mode:
            description: |-
              **enum** (Mode)
              Mount's mode
              - `MODE_UNSPECIFIED`
              - `READ_ONLY`
              - `READ_WRITE`
            type: string
            enum:
              - MODE_UNSPECIFIED
              - READ_ONLY
              - READ_WRITE
          objectStorage:
            description: |-
              **[ObjectStorage](#yandex.cloud.serverless.containers.v1.Mount.ObjectStorage)**
              Object storage mounts
              Includes only one of the fields `objectStorage`, `ephemeralDiskSpec`.
              Target mount option
            $ref: '#/definitions/ObjectStorage'
          ephemeralDiskSpec:
            description: |-
              **[DiskSpec](#yandex.cloud.serverless.containers.v1.Mount.DiskSpec)**
              Working disk (worker-local non-shared read-write NBS disk templates)
              Includes only one of the fields `objectStorage`, `ephemeralDiskSpec`.
              Target mount option
            $ref: '#/definitions/DiskSpec'
        required:
          - mountPointPath
        oneOf:
          - required:
              - objectStorage
          - required:
              - ephemeralDiskSpec
      Http:
        type: object
        properties: {}
      Task:
        type: object
        properties: {}
      Runtime:
        type: object
        properties:
          http:
            description: |-
              **object**
              The classic one. You need to run an HTTP server inside the container.
              Includes only one of the fields `http`, `task`.
            $ref: '#/definitions/Http'
          task:
            description: |-
              **object**
              We run a process from ENTRYPOINT inside the container for each user request.
              Includes only one of the fields `http`, `task`.
            $ref: '#/definitions/Task'
        oneOf:
          - required:
              - http
          - required:
              - task
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
      AsyncInvocationConfig:
        type: object
        properties:
          serviceAccountId:
            description: |-
              **string**
              Optional id of service account with permission to invoke container.
            type: string
sourcePath: en/_api-ref/serverless/containers/v1/containers/api-ref/Container/deployRevision.md
---

# Serverless Containers Service, REST: Container.DeployRevision

Deploys a revision for the specified container.

## HTTP request

```
POST https://serverless-containers.{{ api-host }}/containers/v1/revisions:deploy
```

## Body parameters {#yandex.cloud.serverless.containers.v1.DeployContainerRevisionRequest}

```json
{
  "containerId": "string",
  "description": "string",
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
    "workingDir": "string"
  },
  "concurrency": "string",
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
  "connectivity": {
    "networkId": "string",
    "subnetIds": [
      "string"
    ]
  },
  "provisionPolicy": {
    "minInstances": "string"
  },
  "scalingPolicy": {
    "zoneInstancesLimit": "string",
    "zoneRequestsLimit": "string"
  },
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
      "readOnly": "boolean",
      "mountPointPath": "string"
    }
  ],
  "mounts": [
    {
      "mountPointPath": "string",
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
  "runtime": {
    // Includes only one of the fields `http`, `task`
    "http": "object",
    "task": "object"
    // end of the list of possible fields
  },
  "metadataOptions": {
    "gceHttpEndpoint": "string",
    "awsV1HttpEndpoint": "string"
  },
  "asyncInvocationConfig": {
    "serviceAccountId": "string"
  }
}
```

#|
||Field | Description ||
|| containerId | **string**

Required field. ID of the container to create a revision for.

To get a container ID, make a [ContainerService.List](/docs/serverless-containers/containers/api-ref/Container/list#List) request. ||
|| description | **string**

Description of the revision. ||
|| resources | **[Resources](#yandex.cloud.serverless.containers.v1.Resources)**

Required field. Resources allocated to the revision. ||
|| executionTimeout | **string** (duration)

Timeout for the execution of the revision.

If the timeout is exceeded, Serverless Containers responds with a 504 HTTP code. ||
|| serviceAccountId | **string**

ID of the service account to associate with the revision. ||
|| imageSpec | **[ImageSpec](#yandex.cloud.serverless.containers.v1.ImageSpec)**

Required field. Image configuration for the revision. ||
|| concurrency | **string** (int64)

The number of concurrent requests allowed per container instance.

The default value is 1. ||
|| secrets[] | **[Secret](#yandex.cloud.serverless.containers.v1.Secret)**

Yandex Lockbox secrets to be used by the revision. ||
|| connectivity | **[Connectivity](#yandex.cloud.serverless.containers.v1.Connectivity)**

Network access. If specified the revision will be attached to specified network/subnet(s). ||
|| provisionPolicy | **[ProvisionPolicy](#yandex.cloud.serverless.containers.v1.ProvisionPolicy)**

Policy for provisioning instances of the revision.

The policy is only applied when the revision is ACTIVE. ||
|| scalingPolicy | **[ScalingPolicy](#yandex.cloud.serverless.containers.v1.ScalingPolicy)**

Policy for scaling instances of the revision. ||
|| logOptions | **[LogOptions](#yandex.cloud.serverless.containers.v1.LogOptions)**

Options for logging from the container. ||
|| storageMounts[] | **[StorageMount](#yandex.cloud.serverless.containers.v1.StorageMount)**

S3 mounts to be used by the revision. ||
|| mounts[] | **[Mount](#yandex.cloud.serverless.containers.v1.Mount)**

Mounts to be used by the revision. ||
|| runtime | **[Runtime](#yandex.cloud.serverless.containers.v1.Runtime)**

The container's execution mode. ||
|| metadataOptions | **[MetadataOptions](#yandex.cloud.serverless.containers.v1.MetadataOptions)**

Metadata options for the revision. ||
|| asyncInvocationConfig | **[AsyncInvocationConfig](#yandex.cloud.serverless.containers.v1.AsyncInvocationConfig)**

Config for asynchronous invocations of the revision. ||
|#

## Resources {#yandex.cloud.serverless.containers.v1.Resources}

Resources allocated to a revision.

#|
||Field | Description ||
|| memory | **string** (int64)

Amount of memory available to the revision, specified in bytes, multiple of 128MB. ||
|| cores | **string** (int64)

Number of cores available to the revision. ||
|| coreFraction | **string** (int64)

Specifies baseline performance for a core in percent, multiple of 5%.
Should be 100% for cores > 1. ||
|#

## ImageSpec {#yandex.cloud.serverless.containers.v1.ImageSpec}

Revision image specification.

#|
||Field | Description ||
|| imageUrl | **string**

Required field. Image URL, that is used by the revision. ||
|| command | **[Command](#yandex.cloud.serverless.containers.v1.Command)**

Override for the image's ENTRYPOINT. ||
|| args | **[Args](#yandex.cloud.serverless.containers.v1.Args)**

Override for the image's CMD. ||
|| environment | **object** (map<**string**, **string**>)

Additional environment for the container. ||
|| workingDir | **string**

Override for the image's WORKDIR. ||
|#

## Command {#yandex.cloud.serverless.containers.v1.Command}

#|
||Field | Description ||
|| command[] | **string**

Command that will override ENTRYPOINT of an image.

Commands will be executed as is. The runtime will not substitute environment
variables or execute shell commands. If one wants to do that, they should
invoke shell interpreter with an appropriate shell script. ||
|#

## Args {#yandex.cloud.serverless.containers.v1.Args}

#|
||Field | Description ||
|| args[] | **string**

Arguments that will override CMD of an image.

Arguments will be passed as is. The runtime will not substitute environment
variables or execute shell commands. If one wants to do that, they should
invoke shell interpreter with an appropriate shell script. ||
|#

## Secret {#yandex.cloud.serverless.containers.v1.Secret}

Secret that is available to the container at run time.

#|
||Field | Description ||
|| id | **string**

ID of Yandex Lockbox secret. ||
|| versionId | **string**

ID of Yandex Lockbox secret. ||
|| key | **string**

Key in secret's payload, which value to be delivered into container environment. ||
|| environmentVariable | **string**

Environment variable in which secret's value is delivered.

Includes only one of the fields `environmentVariable`. ||
|#

## Connectivity {#yandex.cloud.serverless.containers.v1.Connectivity}

Revision connectivity specification.

#|
||Field | Description ||
|| networkId | **string**

Network the revision will have access to. ||
|| subnetIds[] | **string**

The list of subnets (from the same network) the revision can be attached to.

Deprecated, it is sufficient to specify only network_id, without the list of subnet_ids. ||
|#

## ProvisionPolicy {#yandex.cloud.serverless.containers.v1.ProvisionPolicy}

#|
||Field | Description ||
|| minInstances | **string** (int64)

Minimum number of guaranteed provisioned container instances for all zones
in total. ||
|#

## ScalingPolicy {#yandex.cloud.serverless.containers.v1.ScalingPolicy}

#|
||Field | Description ||
|| zoneInstancesLimit | **string** (int64)

Upper limit for instance count in each zone.
0 means no limit. ||
|| zoneRequestsLimit | **string** (int64)

Upper limit of requests count in each zone.
0 means no limit. ||
|#

## LogOptions {#yandex.cloud.serverless.containers.v1.LogOptions}

#|
||Field | Description ||
|| disabled | **boolean**

Is logging from container disabled. ||
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

## StorageMount {#yandex.cloud.serverless.containers.v1.StorageMount}

#|
||Field | Description ||
|| bucketId | **string**

Required field. S3 bucket name for mounting. ||
|| prefix | **string**

S3 bucket prefix for mounting. ||
|| readOnly | **boolean**

Is mount read only. ||
|| mountPointPath | **string**

Required field. Mount point path inside the container for mounting. ||
|#

## Mount {#yandex.cloud.serverless.containers.v1.Mount}

Mount contains an information about version's external storage mount

#|
||Field | Description ||
|| mountPointPath | **string**

Required field. The absolute mount point path inside the container for mounting. ||
|| mode | **enum** (Mode)

Mount's mode

- `MODE_UNSPECIFIED`
- `READ_ONLY`
- `READ_WRITE` ||
|| objectStorage | **[ObjectStorage](#yandex.cloud.serverless.containers.v1.Mount.ObjectStorage)**

Object storage mounts

Includes only one of the fields `objectStorage`, `ephemeralDiskSpec`.

Target mount option ||
|| ephemeralDiskSpec | **[DiskSpec](#yandex.cloud.serverless.containers.v1.Mount.DiskSpec)**

Working disk (worker-local non-shared read-write NBS disk templates)

Includes only one of the fields `objectStorage`, `ephemeralDiskSpec`.

Target mount option ||
|#

## ObjectStorage {#yandex.cloud.serverless.containers.v1.Mount.ObjectStorage}

ObjectStorage as a mount

#|
||Field | Description ||
|| bucketId | **string**

Required field. ObjectStorage bucket name for mounting. ||
|| prefix | **string**

ObjectStorage bucket prefix for mounting. ||
|#

## DiskSpec {#yandex.cloud.serverless.containers.v1.Mount.DiskSpec}

Disk as a mount

#|
||Field | Description ||
|| size | **string** (int64)

The size of disk for mount in bytes ||
|| blockSize | **string** (int64)

Optional block size of disk for mount in bytes ||
|#

## Runtime {#yandex.cloud.serverless.containers.v1.Runtime}

The container's execution mode

#|
||Field | Description ||
|| http | **object**

The classic one. You need to run an HTTP server inside the container.

Includes only one of the fields `http`, `task`. ||
|| task | **object**

We run a process from ENTRYPOINT inside the container for each user request.

Includes only one of the fields `http`, `task`. ||
|#

## MetadataOptions {#yandex.cloud.serverless.containers.v1.MetadataOptions}

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

## AsyncInvocationConfig {#yandex.cloud.serverless.containers.v1.AsyncInvocationConfig}

#|
||Field | Description ||
|| serviceAccountId | **string**

Optional id of service account with permission to invoke container. ||
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
    "containerRevisionId": "string"
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
    "containerId": "string",
    "description": "string",
    "createdAt": "string",
    "image": {
      "imageUrl": "string",
      "imageDigest": "string",
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
      "workingDir": "string"
    },
    "resources": {
      "memory": "string",
      "cores": "string",
      "coreFraction": "string"
    },
    "executionTimeout": "string",
    "concurrency": "string",
    "serviceAccountId": "string",
    "status": "string",
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
    "connectivity": {
      "networkId": "string",
      "subnetIds": [
        "string"
      ]
    },
    "provisionPolicy": {
      "minInstances": "string"
    },
    "scalingPolicy": {
      "zoneInstancesLimit": "string",
      "zoneRequestsLimit": "string"
    },
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
        "readOnly": "boolean",
        "mountPointPath": "string"
      }
    ],
    "mounts": [
      {
        "mountPointPath": "string",
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
    "runtime": {
      // Includes only one of the fields `http`, `task`
      "http": "object",
      "task": "object"
      // end of the list of possible fields
    },
    "metadataOptions": {
      "gceHttpEndpoint": "string",
      "awsV1HttpEndpoint": "string"
    },
    "asyncInvocationConfig": {
      "serviceAccountId": "string"
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
|| metadata | **[DeployContainerRevisionMetadata](#yandex.cloud.serverless.containers.v1.DeployContainerRevisionMetadata)**

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
|| response | **[Revision](#yandex.cloud.serverless.containers.v1.Revision)**

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

## DeployContainerRevisionMetadata {#yandex.cloud.serverless.containers.v1.DeployContainerRevisionMetadata}

#|
||Field | Description ||
|| containerRevisionId | **string**

ID of the revision that is being created. ||
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

## Revision {#yandex.cloud.serverless.containers.v1.Revision}

#|
||Field | Description ||
|| id | **string**

ID of the revision. ||
|| containerId | **string**

ID of the container that the revision belongs to. ||
|| description | **string**

Description of the revision. ||
|| createdAt | **string** (date-time)

Creation timestamp for the revision.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| image | **[Image](#yandex.cloud.serverless.containers.v1.Image)**

Image configuration for the revision. ||
|| resources | **[Resources](#yandex.cloud.serverless.containers.v1.Resources2)**

Resources allocated to the revision. ||
|| executionTimeout | **string** (duration)

Timeout for the execution of the revision.

If the timeout is exceeded, Serverless Containers responds with a 504 HTTP code. ||
|| concurrency | **string** (int64)

The number of concurrent requests allowed per container instance. ||
|| serviceAccountId | **string**

ID of the service account associated with the revision. ||
|| status | **enum** (Status)

Status of the revision.

- `STATUS_UNSPECIFIED`
- `CREATING`: Revision is being created.
- `ACTIVE`: Revision is currently used by the container.
- `OBSOLETE`: Revision is not used by the container. May be deleted later. ||
|| secrets[] | **[Secret](#yandex.cloud.serverless.containers.v1.Secret2)**

Yandex Lockbox secrets to be used by the revision. ||
|| connectivity | **[Connectivity](#yandex.cloud.serverless.containers.v1.Connectivity2)**

Network access. If specified the revision will be attached to specified network/subnet(s). ||
|| provisionPolicy | **[ProvisionPolicy](#yandex.cloud.serverless.containers.v1.ProvisionPolicy2)**

Policy for provisioning instances of the revision.

The policy is only applied when the revision is ACTIVE. ||
|| scalingPolicy | **[ScalingPolicy](#yandex.cloud.serverless.containers.v1.ScalingPolicy2)**

Policy for scaling instances of the revision. ||
|| logOptions | **[LogOptions](#yandex.cloud.serverless.containers.v1.LogOptions2)**

Options for logging from the container. ||
|| storageMounts[] | **[StorageMount](#yandex.cloud.serverless.containers.v1.StorageMount2)**

S3 mounts to be used by the revision. ||
|| mounts[] | **[Mount](#yandex.cloud.serverless.containers.v1.Mount2)**

Mounts to be used by the revision. ||
|| runtime | **[Runtime](#yandex.cloud.serverless.containers.v1.Runtime2)**

The container's execution mode. ||
|| metadataOptions | **[MetadataOptions](#yandex.cloud.serverless.containers.v1.MetadataOptions2)**

Metadata options for the revision. ||
|| asyncInvocationConfig | **[AsyncInvocationConfig](#yandex.cloud.serverless.containers.v1.AsyncInvocationConfig2)**

Config for asynchronous invocations of the revision. ||
|#

## Image {#yandex.cloud.serverless.containers.v1.Image}

Revision image specification.

#|
||Field | Description ||
|| imageUrl | **string**

Image URL, that is used by the revision. ||
|| imageDigest | **string**

Digest of the image. Calculated at creation time. ||
|| command | **[Command](#yandex.cloud.serverless.containers.v1.Command2)**

Override for the image's ENTRYPOINT. ||
|| args | **[Args](#yandex.cloud.serverless.containers.v1.Args2)**

Override for the image's CMD. ||
|| environment | **object** (map<**string**, **string**>)

Additional environment for the container. ||
|| workingDir | **string**

Override for the image's WORKDIR. ||
|#

## Command {#yandex.cloud.serverless.containers.v1.Command2}

#|
||Field | Description ||
|| command[] | **string**

Command that will override ENTRYPOINT of an image.

Commands will be executed as is. The runtime will not substitute environment
variables or execute shell commands. If one wants to do that, they should
invoke shell interpreter with an appropriate shell script. ||
|#

## Args {#yandex.cloud.serverless.containers.v1.Args2}

#|
||Field | Description ||
|| args[] | **string**

Arguments that will override CMD of an image.

Arguments will be passed as is. The runtime will not substitute environment
variables or execute shell commands. If one wants to do that, they should
invoke shell interpreter with an appropriate shell script. ||
|#

## Resources {#yandex.cloud.serverless.containers.v1.Resources2}

Resources allocated to a revision.

#|
||Field | Description ||
|| memory | **string** (int64)

Amount of memory available to the revision, specified in bytes, multiple of 128MB. ||
|| cores | **string** (int64)

Number of cores available to the revision. ||
|| coreFraction | **string** (int64)

Specifies baseline performance for a core in percent, multiple of 5%.
Should be 100% for cores > 1. ||
|#

## Secret {#yandex.cloud.serverless.containers.v1.Secret2}

Secret that is available to the container at run time.

#|
||Field | Description ||
|| id | **string**

ID of Yandex Lockbox secret. ||
|| versionId | **string**

ID of Yandex Lockbox secret. ||
|| key | **string**

Key in secret's payload, which value to be delivered into container environment. ||
|| environmentVariable | **string**

Environment variable in which secret's value is delivered.

Includes only one of the fields `environmentVariable`. ||
|#

## Connectivity {#yandex.cloud.serverless.containers.v1.Connectivity2}

Revision connectivity specification.

#|
||Field | Description ||
|| networkId | **string**

Network the revision will have access to. ||
|| subnetIds[] | **string**

The list of subnets (from the same network) the revision can be attached to.

Deprecated, it is sufficient to specify only network_id, without the list of subnet_ids. ||
|#

## ProvisionPolicy {#yandex.cloud.serverless.containers.v1.ProvisionPolicy2}

#|
||Field | Description ||
|| minInstances | **string** (int64)

Minimum number of guaranteed provisioned container instances for all zones
in total. ||
|#

## ScalingPolicy {#yandex.cloud.serverless.containers.v1.ScalingPolicy2}

#|
||Field | Description ||
|| zoneInstancesLimit | **string** (int64)

Upper limit for instance count in each zone.
0 means no limit. ||
|| zoneRequestsLimit | **string** (int64)

Upper limit of requests count in each zone.
0 means no limit. ||
|#

## LogOptions {#yandex.cloud.serverless.containers.v1.LogOptions2}

#|
||Field | Description ||
|| disabled | **boolean**

Is logging from container disabled. ||
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

## StorageMount {#yandex.cloud.serverless.containers.v1.StorageMount2}

#|
||Field | Description ||
|| bucketId | **string**

Required field. S3 bucket name for mounting. ||
|| prefix | **string**

S3 bucket prefix for mounting. ||
|| readOnly | **boolean**

Is mount read only. ||
|| mountPointPath | **string**

Required field. Mount point path inside the container for mounting. ||
|#

## Mount {#yandex.cloud.serverless.containers.v1.Mount2}

Mount contains an information about version's external storage mount

#|
||Field | Description ||
|| mountPointPath | **string**

Required field. The absolute mount point path inside the container for mounting. ||
|| mode | **enum** (Mode)

Mount's mode

- `MODE_UNSPECIFIED`
- `READ_ONLY`
- `READ_WRITE` ||
|| objectStorage | **[ObjectStorage](#yandex.cloud.serverless.containers.v1.Mount.ObjectStorage2)**

Object storage mounts

Includes only one of the fields `objectStorage`, `ephemeralDiskSpec`.

Target mount option ||
|| ephemeralDiskSpec | **[DiskSpec](#yandex.cloud.serverless.containers.v1.Mount.DiskSpec2)**

Working disk (worker-local non-shared read-write NBS disk templates)

Includes only one of the fields `objectStorage`, `ephemeralDiskSpec`.

Target mount option ||
|#

## ObjectStorage {#yandex.cloud.serverless.containers.v1.Mount.ObjectStorage2}

ObjectStorage as a mount

#|
||Field | Description ||
|| bucketId | **string**

Required field. ObjectStorage bucket name for mounting. ||
|| prefix | **string**

ObjectStorage bucket prefix for mounting. ||
|#

## DiskSpec {#yandex.cloud.serverless.containers.v1.Mount.DiskSpec2}

Disk as a mount

#|
||Field | Description ||
|| size | **string** (int64)

The size of disk for mount in bytes ||
|| blockSize | **string** (int64)

Optional block size of disk for mount in bytes ||
|#

## Runtime {#yandex.cloud.serverless.containers.v1.Runtime2}

The container's execution mode

#|
||Field | Description ||
|| http | **object**

The classic one. You need to run an HTTP server inside the container.

Includes only one of the fields `http`, `task`. ||
|| task | **object**

We run a process from ENTRYPOINT inside the container for each user request.

Includes only one of the fields `http`, `task`. ||
|#

## MetadataOptions {#yandex.cloud.serverless.containers.v1.MetadataOptions2}

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

## AsyncInvocationConfig {#yandex.cloud.serverless.containers.v1.AsyncInvocationConfig2}

#|
||Field | Description ||
|| serviceAccountId | **string**

Optional id of service account with permission to invoke container. ||
|#