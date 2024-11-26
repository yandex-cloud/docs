---
editable: false
sourcePath: en/_api-ref-grpc/logging/v1/api-ref/grpc/LogGroup/listResources.md
---

# Cloud Logging Service, gRPC: LogGroupService.ListResources

Retrieves the resources (type and IDs) in the specified log group.

## gRPC request

**rpc ListResources ([ListResourcesRequest](#yandex.cloud.logging.v1.ListResourcesRequest)) returns ([ListResourcesResponse](#yandex.cloud.logging.v1.ListResourcesResponse))**

## ListResourcesRequest {#yandex.cloud.logging.v1.ListResourcesRequest}

```json
{
  "log_group_id": "string",
  "type": "string"
}
```

#|
||Field | Description ||
|| log_group_id | **string**

Required field. ID of the log group to list resources for.

To get a log group ID make a [LogGroupService.List](/docs/logging/api-ref/grpc/LogGroup/list#List) request. ||
|| type | **string**

Resource type to return resources for.

If not specified, [ListResourcesResponse](#yandex.cloud.logging.v1.ListResourcesResponse) will contain information about all resource types. ||
|#

## ListResourcesResponse {#yandex.cloud.logging.v1.ListResourcesResponse}

```json
{
  "resources": [
    {
      "type": "string",
      "ids": [
        "string"
      ]
    }
  ]
}
```

#|
||Field | Description ||
|| resources[] | **[LogGroupResource](#yandex.cloud.logging.v1.LogGroupResource)**

List of resources present in log group. ||
|#

## LogGroupResource {#yandex.cloud.logging.v1.LogGroupResource}

Log group resource.

#|
||Field | Description ||
|| type | **string**

Resource type.

Collected from log entries inside log group. ||
|| ids[] | **string**

List of resource IDs with the same resource type. ||
|#