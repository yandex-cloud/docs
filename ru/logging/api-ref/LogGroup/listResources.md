---
editable: false
sourcePath: en/_api-ref/logging/v1/api-ref/LogGroup/listResources.md
---

# Cloud Logging Service, REST: LogGroup.ListResources

Retrieves the resources (type and IDs) in the specified log group.

## HTTP request

```
GET https://logging.{{ api-host }}/logging/v1/logGroups/{logGroupId}:listResources
```

## Path parameters

#|
||Field | Description ||
|| logGroupId | **string**

Required field. ID of the log group to list resources for.

To get a log group ID make a [LogGroupService.List](/docs/logging/api-ref/LogGroup/list#List) request. ||
|#

## Query parameters {#yandex.cloud.logging.v1.ListResourcesRequest}

#|
||Field | Description ||
|| type | **string**

Resource type to return resources for.

If not specified, [ListResourcesResponse](#yandex.cloud.logging.v1.ListResourcesResponse) will contain information about all resource types. ||
|#

## Response {#yandex.cloud.logging.v1.ListResourcesResponse}

**HTTP Code: 200 - OK**

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