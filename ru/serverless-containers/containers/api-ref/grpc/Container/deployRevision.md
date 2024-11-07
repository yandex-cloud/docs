---
editable: false
sourcePath: en/_api-ref-grpc/serverless/containers/v1/containers/api-ref/grpc/Container/deployRevision.md
---

# Serverless Containers Service, gRPC: ContainerService.DeployRevision {#DeployRevision}

Deploys a revision for the specified container.

## gRPC request

**rpc DeployRevision ([DeployContainerRevisionRequest](#yandex.cloud.serverless.containers.v1.DeployContainerRevisionRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## DeployContainerRevisionRequest {#yandex.cloud.serverless.containers.v1.DeployContainerRevisionRequest}

```json
{
  "containerId": "string",
  "description": "string",
  "resources": {
    "memory": "int64",
    "cores": "int64",
    "coreFraction": "int64"
  },
  "executionTimeout": "google.protobuf.Duration",
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
    "environment": "string",
    "workingDir": "string"
  },
  "concurrency": "int64",
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
    "minInstances": "int64"
  },
  "scalingPolicy": {
    "zoneInstancesLimit": "int64",
    "zoneRequestsLimit": "int64"
  },
  "logOptions": {
    "disabled": "bool",
    // Includes only one of the fields `logGroupId`, `folderId`
    "logGroupId": "string",
    "folderId": "string",
    // end of the list of possible fields
    "minLevel": "Level"
  },
  "storageMounts": [
    {
      "bucketId": "string",
      "prefix": "string",
      "readOnly": "bool",
      "mountPointPath": "string"
    }
  ],
  "mounts": [
    {
      "mountPointPath": "string",
      "mode": "Mode",
      // Includes only one of the fields `objectStorage`, `ephemeralDiskSpec`
      "objectStorage": {
        "bucketId": "string",
        "prefix": "string"
      },
      "ephemeralDiskSpec": {
        "size": "int64",
        "blockSize": "int64"
      }
      // end of the list of possible fields
    }
  ],
  "runtime": {
    // Includes only one of the fields `http`, `task`
    "http": "Http",
    "task": "Task"
    // end of the list of possible fields
  }
}
```

#|
||Field | Description ||
|| containerId | **string**

Required field. ID of the container to create a revision for.

To get a container ID, make a [ContainerService.List](/docs/serverless/containers/api-ref/grpc/Container/list#List) request. ||
|| description | **string**

Description of the revision. ||
|| resources | **[Resources](#yandex.cloud.serverless.containers.v1.Resources)**

Required field. Resources allocated to the revision. ||
|| executionTimeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Timeout for the execution of the revision.

If the timeout is exceeded, Serverless Containers responds with a 504 HTTP code. ||
|| serviceAccountId | **string**

ID of the service account to associate with the revision. ||
|| imageSpec | **[ImageSpec](#yandex.cloud.serverless.containers.v1.ImageSpec)**

Required field. Image configuration for the revision. ||
|| concurrency | **int64**

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

The container's execution mode ||
|#

## Resources {#yandex.cloud.serverless.containers.v1.Resources}

Resources allocated to a revision.

#|
||Field | Description ||
|| memory | **int64**

Amount of memory available to the revision, specified in bytes, multiple of 128MB. ||
|| cores | **int64**

Number of cores available to the revision. ||
|| coreFraction | **int64**

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
|| environment | **string**

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
|| minInstances | **int64**

Minimum number of guaranteed provisioned container instances for all zones
in total. ||
|#

## ScalingPolicy {#yandex.cloud.serverless.containers.v1.ScalingPolicy}

#|
||Field | Description ||
|| zoneInstancesLimit | **int64**

Upper limit for instance count in each zone.
0 means no limit. ||
|| zoneRequestsLimit | **int64**

Upper limit of requests count in each zone.
0 means no limit. ||
|#

## LogOptions {#yandex.cloud.serverless.containers.v1.LogOptions}

#|
||Field | Description ||
|| disabled | **bool**

Is logging from container disabled. ||
|| logGroupId | **string**

Entry should be written to log group resolved by ID.

Includes only one of the fields `logGroupId`, `folderId`.

Log entries destination. ||
|| folderId | **string**

Entry should be written to default log group for specified folder.

Includes only one of the fields `logGroupId`, `folderId`.

Log entries destination. ||
|| minLevel | enum **Level**

Minimum log entry level.

See [LogLevel.Level](/docs/logging/api-ref/grpc/Export/run#yandex.cloud.logging.v1.LogLevel.Level) for details.

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
|| readOnly | **bool**

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
|| mode | enum **Mode**

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
|| size | **int64**

The size of disk for mount in bytes ||
|| blockSize | **int64**

Optional block size of disk for mount in bytes ||
|#

## Runtime {#yandex.cloud.serverless.containers.v1.Runtime}

The container's execution mode

#|
||Field | Description ||
|| http | **[Http](#yandex.cloud.serverless.containers.v1.Runtime.Http)**

The classic one. You need to run an HTTP server inside the container.

Includes only one of the fields `http`, `task`. ||
|| task | **[Task](#yandex.cloud.serverless.containers.v1.Runtime.Task)**

We run a process from ENTRYPOINT inside the container for each user request.

Includes only one of the fields `http`, `task`. ||
|#

## Http {#yandex.cloud.serverless.containers.v1.Runtime.Http}

#|
||Field | Description ||
|| Empty | > ||
|#

## Task {#yandex.cloud.serverless.containers.v1.Runtime.Task}

#|
||Field | Description ||
|| Empty | > ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "google.protobuf.Timestamp",
  "createdBy": "string",
  "modifiedAt": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "containerRevisionId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "containerId": "string",
    "description": "string",
    "createdAt": "google.protobuf.Timestamp",
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
      "environment": "string",
      "workingDir": "string"
    },
    "resources": {
      "memory": "int64",
      "cores": "int64",
      "coreFraction": "int64"
    },
    "executionTimeout": "google.protobuf.Duration",
    "concurrency": "int64",
    "serviceAccountId": "string",
    "status": "Status",
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
      "minInstances": "int64"
    },
    "scalingPolicy": {
      "zoneInstancesLimit": "int64",
      "zoneRequestsLimit": "int64"
    },
    "logOptions": {
      "disabled": "bool",
      // Includes only one of the fields `logGroupId`, `folderId`
      "logGroupId": "string",
      "folderId": "string",
      // end of the list of possible fields
      "minLevel": "Level"
    },
    "storageMounts": [
      {
        "bucketId": "string",
        "prefix": "string",
        "readOnly": "bool",
        "mountPointPath": "string"
      }
    ],
    "mounts": [
      {
        "mountPointPath": "string",
        "mode": "Mode",
        // Includes only one of the fields `objectStorage`, `ephemeralDiskSpec`
        "objectStorage": {
          "bucketId": "string",
          "prefix": "string"
        },
        "ephemeralDiskSpec": {
          "size": "int64",
          "blockSize": "int64"
        }
        // end of the list of possible fields
      }
    ],
    "runtime": {
      // Includes only one of the fields `http`, `task`
      "http": "Http",
      "task": "Task"
      // end of the list of possible fields
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
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[DeployContainerRevisionMetadata](#yandex.cloud.serverless.containers.v1.DeployContainerRevisionMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

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

## Revision {#yandex.cloud.serverless.containers.v1.Revision}

#|
||Field | Description ||
|| id | **string**

ID of the revision. ||
|| containerId | **string**

ID of the container that the revision belongs to. ||
|| description | **string**

Description of the revision. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp for the revision. ||
|| image | **[Image](#yandex.cloud.serverless.containers.v1.Image)**

Image configuration for the revision. ||
|| resources | **[Resources](#yandex.cloud.serverless.containers.v1.Resources2)**

Resources allocated to the revision. ||
|| executionTimeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Timeout for the execution of the revision.

If the timeout is exceeded, Serverless Containers responds with a 504 HTTP code. ||
|| concurrency | **int64**

The number of concurrent requests allowed per container instance. ||
|| serviceAccountId | **string**

ID of the service account associated with the revision. ||
|| status | enum **Status**

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

The container's execution mode ||
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
|| environment | **string**

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
|| memory | **int64**

Amount of memory available to the revision, specified in bytes, multiple of 128MB. ||
|| cores | **int64**

Number of cores available to the revision. ||
|| coreFraction | **int64**

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
|| minInstances | **int64**

Minimum number of guaranteed provisioned container instances for all zones
in total. ||
|#

## ScalingPolicy {#yandex.cloud.serverless.containers.v1.ScalingPolicy2}

#|
||Field | Description ||
|| zoneInstancesLimit | **int64**

Upper limit for instance count in each zone.
0 means no limit. ||
|| zoneRequestsLimit | **int64**

Upper limit of requests count in each zone.
0 means no limit. ||
|#

## LogOptions {#yandex.cloud.serverless.containers.v1.LogOptions2}

#|
||Field | Description ||
|| disabled | **bool**

Is logging from container disabled. ||
|| logGroupId | **string**

Entry should be written to log group resolved by ID.

Includes only one of the fields `logGroupId`, `folderId`.

Log entries destination. ||
|| folderId | **string**

Entry should be written to default log group for specified folder.

Includes only one of the fields `logGroupId`, `folderId`.

Log entries destination. ||
|| minLevel | enum **Level**

Minimum log entry level.

See [LogLevel.Level](/docs/logging/api-ref/grpc/Export/run#yandex.cloud.logging.v1.LogLevel.Level) for details.

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
|| readOnly | **bool**

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
|| mode | enum **Mode**

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
|| size | **int64**

The size of disk for mount in bytes ||
|| blockSize | **int64**

Optional block size of disk for mount in bytes ||
|#

## Runtime {#yandex.cloud.serverless.containers.v1.Runtime2}

The container's execution mode

#|
||Field | Description ||
|| http | **[Http](#yandex.cloud.serverless.containers.v1.Runtime.Http2)**

The classic one. You need to run an HTTP server inside the container.

Includes only one of the fields `http`, `task`. ||
|| task | **[Task](#yandex.cloud.serverless.containers.v1.Runtime.Task2)**

We run a process from ENTRYPOINT inside the container for each user request.

Includes only one of the fields `http`, `task`. ||
|#

## Http {#yandex.cloud.serverless.containers.v1.Runtime.Http2}

#|
||Field | Description ||
|| Empty | > ||
|#

## Task {#yandex.cloud.serverless.containers.v1.Runtime.Task2}

#|
||Field | Description ||
|| Empty | > ||
|#