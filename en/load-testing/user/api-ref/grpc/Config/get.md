---
editable: false
sourcePath: en/_api-ref-grpc/loadtesting/api/v1/user/api-ref/grpc/Config/get.md
---

# Load Testing API, gRPC: ConfigService.Get {#Get}

Returns the specified config.

To get the list of all available configs, make a [List](/docs/load-testing/user/api-ref/grpc/Config/list#List) request.

## gRPC request

**rpc Get ([GetConfigRequest](#yandex.cloud.loadtesting.api.v1.GetConfigRequest)) returns ([config.Config](#yandex.cloud.loadtesting.api.v1.config.Config))**

## GetConfigRequest {#yandex.cloud.loadtesting.api.v1.GetConfigRequest}

```json
{
  "configId": "string"
}
```

#|
||Field | Description ||
|| configId | **string**

ID of the config to return. ||
|#

## config.Config {#yandex.cloud.loadtesting.api.v1.config.Config}

```json
{
  "id": "string",
  "folderId": "string",
  "yamlString": "string",
  "name": "string",
  "createdAt": "google.protobuf.Timestamp",
  "createdBy": "string"
}
```

Test config.

#|
||Field | Description ||
|| id | **string**

ID of the test config. Generated at creation time. ||
|| folderId | **string**

ID of the folder that the config belongs to. ||
|| yamlString | **string**

Config content in YAML format. ||
|| name | **string**

Name of the config. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| createdBy | **string**

UA or SA that created the config. ||
|#