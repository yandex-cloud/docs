---
editable: false
sourcePath: en/_api-ref-grpc/loadbalancer/v1/api-ref/grpc/TargetGroup/list.md
---

# Network Load Balancer API, gRPC: TargetGroupService.List

Retrieves the list of TargetGroup resources in the specified folder.

## gRPC request

**rpc List ([ListTargetGroupsRequest](#yandex.cloud.loadbalancer.v1.ListTargetGroupsRequest)) returns ([ListTargetGroupsResponse](#yandex.cloud.loadbalancer.v1.ListTargetGroupsResponse))**

## ListTargetGroupsRequest {#yandex.cloud.loadbalancer.v1.ListTargetGroupsRequest}

```json
{
  "folder_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| folder_id | **string**

Required field. ID of the folder to list target groups in.
To get the folder ID, use a [TargetGroupService.List](#List) request. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`,
the service returns a [ListTargetGroupsResponse.next_page_token](#yandex.cloud.loadbalancer.v1.ListTargetGroupsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the
[ListTargetGroupsResponse.next_page_token](#yandex.cloud.loadbalancer.v1.ListTargetGroupsResponse) returned by a previous list request. ||
|| filter | **string**

A filter expression that filters resources listed in the response.
The expression must specify:
1. The field name. Currently you can only filter by the [TargetGroup.name](#yandex.cloud.loadbalancer.v1.TargetGroup) field.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`. ||
|#

## ListTargetGroupsResponse {#yandex.cloud.loadbalancer.v1.ListTargetGroupsResponse}

```json
{
  "target_groups": [
    {
      "id": "string",
      "folder_id": "string",
      "created_at": "google.protobuf.Timestamp",
      "name": "string",
      "description": "string",
      "labels": "string",
      "region_id": "string",
      "targets": [
        {
          "subnet_id": "string",
          "address": "string"
        }
      ]
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| target_groups[] | **[TargetGroup](#yandex.cloud.loadbalancer.v1.TargetGroup)**

List of TargetGroup resources. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListTargetGroupsRequest.page_size](#yandex.cloud.loadbalancer.v1.ListTargetGroupsRequest), use
the `next_page_token` as the value
for the [ListTargetGroupsRequest.page_token](#yandex.cloud.loadbalancer.v1.ListTargetGroupsRequest) query parameter
in the next list request. Each subsequent list request will have its own
`next_page_token` to continue paging through the results. ||
|#

## TargetGroup {#yandex.cloud.loadbalancer.v1.TargetGroup}

A TargetGroup resource. For more information, see [Target groups and resources](/docs/network-load-balancer/concepts/target-resources).

#|
||Field | Description ||
|| id | **string**

Output only. ID of the target group. ||
|| folder_id | **string**

ID of the folder that the target group belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Output only. Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. ||
|| name | **string**

Name of the target group.
The name is unique within the folder. 3-63 characters long. ||
|| description | **string**

Description of the target group. 0-256 characters long. ||
|| labels | **string**

Resource labels as `` key:value `` pairs. Maximum of 64 per resource. ||
|| region_id | **string**

ID of the region where the target group resides. ||
|| targets[] | **[Target](#yandex.cloud.loadbalancer.v1.Target)**

A list of targets in the target group. ||
|#

## Target {#yandex.cloud.loadbalancer.v1.Target}

A Target resource. For more information, see [Target groups and resources](/docs/network-load-balancer/concepts/target-resources).

#|
||Field | Description ||
|| subnet_id | **string**

ID of the subnet that targets are connected to.
All targets in the target group must be connected to the same subnet within a single availability zone. ||
|| address | **string**

IP address of the target. ||
|#