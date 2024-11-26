---
editable: false
sourcePath: en/_api-ref-grpc/loadtesting/api/v1/user/api-ref/grpc/Config/create.md
---

# Load Testing API, gRPC: ConfigService.Create

Creates a test config in the specified folder.

## gRPC request

**rpc Create ([CreateConfigRequest](#yandex.cloud.loadtesting.api.v1.CreateConfigRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateConfigRequest {#yandex.cloud.loadtesting.api.v1.CreateConfigRequest}

```json
{
  "folder_id": "string",
  // Includes only one of the fields `yaml_string`
  "yaml_string": "string",
  // end of the list of possible fields
  "name": "string"
}
```

#|
||Field | Description ||
|| folder_id | **string**

Required field. ID of the folder to create a config in. ||
|| yaml_string | **string**

Config content provided as a string in YAML format.

Includes only one of the fields `yaml_string`.

Config content. ||
|| name | **string**

Name of the config. ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "created_at": "google.protobuf.Timestamp",
  "created_by": "string",
  "modified_at": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "config_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "folder_id": "string",
    "yaml_string": "string",
    "name": "string",
    "created_at": "google.protobuf.Timestamp",
    "created_by": "string"
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
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[CreateConfigMetadata](#yandex.cloud.loadtesting.api.v1.CreateConfigMetadata)**

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
|| response | **[Config](#yandex.cloud.loadtesting.api.v1.config.Config)**

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

## CreateConfigMetadata {#yandex.cloud.loadtesting.api.v1.CreateConfigMetadata}

#|
||Field | Description ||
|| config_id | **string**

ID of the config that is being created. ||
|#

## Config {#yandex.cloud.loadtesting.api.v1.config.Config}

Test config.

#|
||Field | Description ||
|| id | **string**

ID of the test config. Generated at creation time. ||
|| folder_id | **string**

ID of the folder that the config belongs to. ||
|| yaml_string | **string**

Config content in YAML format. ||
|| name | **string**

Name of the config. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

UA or SA that created the config. ||
|#