---
editable: false
sourcePath: en/_api-ref-grpc/serverless/functions/v1/functions/api-ref/grpc/Function/listFunctionVersions.md
---

# Cloud Functions Service, gRPC: FunctionService.ListFunctionVersions

Deprecated. Use [ListVersions](/docs/functions/functions/api-ref/grpc/Function/listVersions#ListVersions).

## gRPC request

**rpc ListFunctionVersions ([ListFunctionsVersionsRequest](#yandex.cloud.serverless.functions.v1.ListFunctionsVersionsRequest)) returns ([ListFunctionsVersionsResponse](#yandex.cloud.serverless.functions.v1.ListFunctionsVersionsResponse))**

## ListFunctionsVersionsRequest {#yandex.cloud.serverless.functions.v1.ListFunctionsVersionsRequest}

```json
{
  // Includes only one of the fields `folder_id`, `function_id`
  "folder_id": "string",
  "function_id": "string",
  // end of the list of possible fields
  "page_size": "int64",
  "page_token": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| folder_id | **string**

ID of the folder to list function versions for.
To get a folder ID make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request.

Includes only one of the fields `folder_id`, `function_id`. ||
|| function_id | **string**

ID of the function to list versions for.
To get a function ID use a [FunctionService.List](/docs/functions/functions/api-ref/grpc/Function/list#List) request.

Includes only one of the fields `folder_id`, `function_id`. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available results
is larger than `pageSize`, the service returns a [ListFunctionsVersionsResponse.next_page_token](#yandex.cloud.serverless.functions.v1.ListFunctionsVersionsResponse)
that can be used to get the next page of results in subsequent list requests.

Default value: 100. ||
|| page_token | **string**

Page token. To get the next page of results, set `pageToken` to the
[ListFunctionsVersionsResponse.next_page_token](#yandex.cloud.serverless.functions.v1.ListFunctionsVersionsResponse) returned by a previous list request. ||
|| filter | **string**

A filter expression that filters resources listed in the response.

The expression must specify:
1. The field name. Currently filtering can only be applied to the [Version.status](#yandex.cloud.serverless.functions.v1.Version) and [Version.runtime](#yandex.cloud.serverless.functions.v1.Version) fields.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`.
Example of a filter: `status="ACTIVE"`. ||
|#

## ListFunctionsVersionsResponse {#yandex.cloud.serverless.functions.v1.ListFunctionsVersionsResponse}

```json
{
  "versions": [
    {
      "id": "string",
      "function_id": "string",
      "description": "string",
      "created_at": "google.protobuf.Timestamp",
      "runtime": "string",
      "entrypoint": "string",
      "resources": {
        "memory": "int64"
      },
      "execution_timeout": "google.protobuf.Duration",
      "service_account_id": "string",
      "image_size": "int64",
      "status": "Status",
      "tags": [
        "string"
      ],
      "environment": "string",
      "connectivity": {
        "network_id": "string",
        "subnet_id": [
          "string"
        ]
      },
      "named_service_accounts": "string",
      "secrets": [
        {
          "id": "string",
          "version_id": "string",
          "key": "string",
          // Includes only one of the fields `environment_variable`
          "environment_variable": "string"
          // end of the list of possible fields
        }
      ],
      "log_options": {
        "disabled": "bool",
        // Includes only one of the fields `log_group_id`, `folder_id`
        "log_group_id": "string",
        "folder_id": "string",
        // end of the list of possible fields
        "min_level": "Level"
      },
      "storage_mounts": [
        {
          "bucket_id": "string",
          "prefix": "string",
          "mount_point_name": "string",
          "read_only": "bool"
        }
      ],
      "async_invocation_config": {
        "retries_count": "int64",
        "success_target": {
          // Includes only one of the fields `empty_target`, `ymq_target`
          "empty_target": "EmptyTarget",
          "ymq_target": {
            "queue_arn": "string",
            "service_account_id": "string"
          }
          // end of the list of possible fields
        },
        "failure_target": {
          // Includes only one of the fields `empty_target`, `ymq_target`
          "empty_target": "EmptyTarget",
          "ymq_target": {
            "queue_arn": "string",
            "service_account_id": "string"
          }
          // end of the list of possible fields
        },
        "service_account_id": "string"
      },
      "tmpfs_size": "int64",
      "concurrency": "int64",
      "mounts": [
        {
          "name": "string",
          "mode": "Mode",
          // Includes only one of the fields `object_storage`, `ephemeral_disk_spec`
          "object_storage": {
            "bucket_id": "string",
            "prefix": "string"
          },
          "ephemeral_disk_spec": {
            "size": "int64",
            "block_size": "int64"
          }
          // end of the list of possible fields
        }
      ]
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| versions[] | **[Version](#yandex.cloud.serverless.functions.v1.Version)**

List of versions for the specified folder or function. ||
|| next_page_token | **string**

Token for getting the next page of the list. If the number of results is greater than
the specified [ListFunctionsVersionsRequest.page_size](#yandex.cloud.serverless.functions.v1.ListFunctionsVersionsRequest), use `nextPageToken` as the value
for the [ListFunctionsVersionsRequest.page_token](#yandex.cloud.serverless.functions.v1.ListFunctionsVersionsRequest) parameter in the next list request.

Each subsequent page will have its own `nextPageToken` to continue paging through the results. ||
|#

## Version {#yandex.cloud.serverless.functions.v1.Version}

Version of a function. For details about the concept, see [Function versions](/docs/functions/concepts/function#version).

#|
||Field | Description ||
|| id | **string**

ID of the version. ||
|| function_id | **string**

ID of the function that the version belongs to. ||
|| description | **string**

Description of the version. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp for the version. ||
|| runtime | **string**

ID of the runtime environment for the function.

Supported environments and their identifiers are listed in the [Runtime environments](/docs/functions/concepts/runtime). ||
|| entrypoint | **string**

Entrypoint for the function: the name of the function to be called as the handler.

Specified in the format `<function file name>.<handler name>`, for example, `index.myFunction`. ||
|| resources | **[Resources](#yandex.cloud.serverless.functions.v1.Resources)**

Resources allocated to the version. ||
|| execution_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Timeout for the execution of the version.

If the timeout is exceeded, Cloud Functions responds with a 504 HTTP code. ||
|| service_account_id | **string**

ID of the service account associated with the version. ||
|| image_size | **int64**

Final size of the deployment package after unpacking. ||
|| status | enum **Status**

Status of the version.

- `STATUS_UNSPECIFIED`
- `CREATING`: Version is being created.
- `ACTIVE`: Version is ready to use.
- `OBSOLETE`: Version will be deleted soon.
- `DELETING`: Version is being deleted. ||
|| tags[] | **string**

Version tags. For details, see [Version tag](/docs/functions/concepts/function#tag). ||
|| environment | **string**

Environment settings for the version. ||
|| connectivity | **[Connectivity](#yandex.cloud.serverless.functions.v1.Connectivity)**

Network access. If specified the version will be attached to specified network/subnet(s). ||
|| named_service_accounts | **string**

Additional service accounts to be used by the version. ||
|| secrets[] | **[Secret](#yandex.cloud.serverless.functions.v1.Secret)**

Yandex Lockbox secrets to be used by the version. ||
|| log_options | **[LogOptions](#yandex.cloud.serverless.functions.v1.LogOptions)**

Options for logging from the function ||
|| storage_mounts[] | **[StorageMount](#yandex.cloud.serverless.functions.v1.StorageMount)**

S3 mounts to be used by the version. ||
|| async_invocation_config | **[AsyncInvocationConfig](#yandex.cloud.serverless.functions.v1.AsyncInvocationConfig)**

Config for asynchronous invocations of the version ||
|| tmpfs_size | **int64**

Optional size of in-memory mounted /tmp directory in bytes. ||
|| concurrency | **int64**

The maximum number of requests processed by a function instance at the same time ||
|| mounts[] | **[Mount](#yandex.cloud.serverless.functions.v1.Mount)**

Mounts to be used by the version. ||
|#

## Resources {#yandex.cloud.serverless.functions.v1.Resources}

Resources allocated to a version.

#|
||Field | Description ||
|| memory | **int64**

Amount of memory available to the version, specified in bytes, multiple of 128MB. ||
|#

## Connectivity {#yandex.cloud.serverless.functions.v1.Connectivity}

Version connectivity specification.

#|
||Field | Description ||
|| network_id | **string**

Network the version will have access to.
It's essential to specify network with subnets in all availability zones. ||
|| subnet_id[] | **string**

Complete list of subnets (from the same network) the version can be attached to.
It's essential to specify at least one subnet for each availability zones. ||
|#

## Secret {#yandex.cloud.serverless.functions.v1.Secret}

Secret for serverless function.

#|
||Field | Description ||
|| id | **string**

ID of Yandex Lockbox secret. ||
|| version_id | **string**

ID of Yandex Lockbox version. ||
|| key | **string**

Key in secret's payload, which value to be delivered into function environment. ||
|| environment_variable | **string**

environment variable in which secret's value to be delivered.

Includes only one of the fields `environment_variable`. ||
|#

## LogOptions {#yandex.cloud.serverless.functions.v1.LogOptions}

#|
||Field | Description ||
|| disabled | **bool**

Is logging from function disabled. ||
|| log_group_id | **string**

Entry should be written to log group resolved by ID.

Includes only one of the fields `log_group_id`, `folder_id`.

Log entries destination. ||
|| folder_id | **string**

Entry should be written to default log group for specified folder.

Includes only one of the fields `log_group_id`, `folder_id`.

Log entries destination. ||
|| min_level | enum **Level**

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

## StorageMount {#yandex.cloud.serverless.functions.v1.StorageMount}

#|
||Field | Description ||
|| bucket_id | **string**

Required field. S3 bucket name for mounting. ||
|| prefix | **string**

S3 bucket prefix for mounting. ||
|| mount_point_name | **string**

Required field. Mount point directory name (not path) for mounting. ||
|| read_only | **bool**

Is mount read only. ||
|#

## AsyncInvocationConfig {#yandex.cloud.serverless.functions.v1.AsyncInvocationConfig}

#|
||Field | Description ||
|| retries_count | **int64**

Number of retries of version invocation ||
|| success_target | **[ResponseTarget](#yandex.cloud.serverless.functions.v1.AsyncInvocationConfig.ResponseTarget)**

Required field. Target for successful result of the version's invocation ||
|| failure_target | **[ResponseTarget](#yandex.cloud.serverless.functions.v1.AsyncInvocationConfig.ResponseTarget)**

Required field. Target for unsuccessful result, if all retries failed ||
|| service_account_id | **string**

Service account which can invoke version ||
|#

## ResponseTarget {#yandex.cloud.serverless.functions.v1.AsyncInvocationConfig.ResponseTarget}

Target to which a result of an invocation will be sent

#|
||Field | Description ||
|| empty_target | **[EmptyTarget](#yandex.cloud.serverless.functions.v1.EmptyTarget)**

Target to ignore a result

Includes only one of the fields `empty_target`, `ymq_target`. ||
|| ymq_target | **[YMQTarget](#yandex.cloud.serverless.functions.v1.YMQTarget)**

Target to send a result to ymq

Includes only one of the fields `empty_target`, `ymq_target`. ||
|#

## EmptyTarget {#yandex.cloud.serverless.functions.v1.EmptyTarget}

#|
||Field | Description ||
|| Empty | > ||
|#

## YMQTarget {#yandex.cloud.serverless.functions.v1.YMQTarget}

#|
||Field | Description ||
|| queue_arn | **string**

Required field. Queue ARN ||
|| service_account_id | **string**

Required field. Service account which has write permission on the queue. ||
|#

## Mount {#yandex.cloud.serverless.functions.v1.Mount}

Mount contains an information about version's external storage mount

#|
||Field | Description ||
|| name | **string**

Required field. Unique mount point name. Device will be mounted into /function/storage/<name> ||
|| mode | enum **Mode**

Mount's mode

- `MODE_UNSPECIFIED`
- `READ_ONLY`
- `READ_WRITE` ||
|| object_storage | **[ObjectStorage](#yandex.cloud.serverless.functions.v1.Mount.ObjectStorage)**

Object storage mounts

Includes only one of the fields `object_storage`, `ephemeral_disk_spec`.

Target mount option ||
|| ephemeral_disk_spec | **[DiskSpec](#yandex.cloud.serverless.functions.v1.Mount.DiskSpec)**

Working disk (worker-local non-shared read-write NBS disk templates)

Includes only one of the fields `object_storage`, `ephemeral_disk_spec`.

Target mount option ||
|#

## ObjectStorage {#yandex.cloud.serverless.functions.v1.Mount.ObjectStorage}

ObjectStorage as a mount

#|
||Field | Description ||
|| bucket_id | **string**

Required field. ObjectStorage bucket name for mounting. ||
|| prefix | **string**

ObjectStorage bucket prefix for mounting. ||
|#

## DiskSpec {#yandex.cloud.serverless.functions.v1.Mount.DiskSpec}

Disk as a mount

#|
||Field | Description ||
|| size | **int64**

The size of disk for mount in bytes ||
|| block_size | **int64**

Optional block size of disk for mount in bytes ||
|#