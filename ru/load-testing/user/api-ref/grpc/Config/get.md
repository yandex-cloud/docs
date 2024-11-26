---
editable: false
sourcePath: en/_api-ref-grpc/loadtesting/api/v1/user/api-ref/grpc/Config/get.md
---

# Load Testing API, gRPC: ConfigService.Get

Returns the specified config.

To get the list of all available configs, make a [List](/docs/load-testing/user/api-ref/grpc/Config/list#List) request.

## gRPC request

**rpc Get ([GetConfigRequest](#yandex.cloud.loadtesting.api.v1.GetConfigRequest)) returns ([config.Config](#yandex.cloud.loadtesting.api.v1.config.Config))**

## GetConfigRequest {#yandex.cloud.loadtesting.api.v1.GetConfigRequest}

```json
{
  "config_id": "string"
}
```

#|
||Field | Description ||
|| config_id | **string**

ID of the config to return. ||
|#

## config.Config {#yandex.cloud.loadtesting.api.v1.config.Config}

```json
{
  "id": "string",
  "folder_id": "string",
  "yaml_string": "string",
  "name": "string",
  "created_at": "google.protobuf.Timestamp",
  "created_by": "string"
}
```

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