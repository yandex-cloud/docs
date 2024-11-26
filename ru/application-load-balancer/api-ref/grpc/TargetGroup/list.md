---
editable: false
sourcePath: en/_api-ref-grpc/apploadbalancer/v1/api-ref/grpc/TargetGroup/list.md
---

# Application Load Balancer API, gRPC: TargetGroupService.List

Lists target groups in the specified folder.

## gRPC request

**rpc List ([ListTargetGroupsRequest](#yandex.cloud.apploadbalancer.v1.ListTargetGroupsRequest)) returns ([ListTargetGroupsResponse](#yandex.cloud.apploadbalancer.v1.ListTargetGroupsResponse))**

## ListTargetGroupsRequest {#yandex.cloud.apploadbalancer.v1.ListTargetGroupsRequest}

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

To get the folder ID, make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`, the service returns a [ListTargetGroupsResponse.next_page_token](#yandex.cloud.apploadbalancer.v1.ListTargetGroupsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the
[ListTargetGroupsResponse.next_page_token](#yandex.cloud.apploadbalancer.v1.ListTargetGroupsResponse) returned by a previous list request. ||
|| filter | **string**

A filter expression that filters target groups listed in the response.

The expression must specify:
1. The field name. Currently you can use filtering only on [TargetGroup.name](#yandex.cloud.apploadbalancer.v1.TargetGroup) field.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`.
Example of a filter: `name=my-target-group`. ||
|#

## ListTargetGroupsResponse {#yandex.cloud.apploadbalancer.v1.ListTargetGroupsResponse}

```json
{
  "target_groups": [
    {
      "id": "string",
      "name": "string",
      "description": "string",
      "folder_id": "string",
      "labels": "string",
      "targets": [
        {
          // Includes only one of the fields `ip_address`
          "ip_address": "string",
          // end of the list of possible fields
          "subnet_id": "string",
          "private_ipv4_address": "bool"
        }
      ],
      "created_at": "google.protobuf.Timestamp"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| target_groups[] | **[TargetGroup](#yandex.cloud.apploadbalancer.v1.TargetGroup)**

List of target groups in the specified folder. ||
|| next_page_token | **string**

Token for getting the next page of the list. If the number of results is greater than
the specified [ListTargetGroupsRequest.page_size](#yandex.cloud.apploadbalancer.v1.ListTargetGroupsRequest), use `next_page_token` as the value
for the [ListTargetGroupsRequest.page_token](#yandex.cloud.apploadbalancer.v1.ListTargetGroupsRequest) parameter in the next list request.

Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
|#

## TargetGroup {#yandex.cloud.apploadbalancer.v1.TargetGroup}

A target group resource.
For details about the concept, see [documentation](/docs/application-load-balancer/concepts/target-group).

#|
||Field | Description ||
|| id | **string**

ID of the target group. Generated at creation time. ||
|| name | **string**

Name of the target group. The name is unique within the folder. ||
|| description | **string**

Description of the target group. ||
|| folder_id | **string**

ID of the folder that the target group belongs to. ||
|| labels | **string**

Target group labels as `key:value` pairs.
For details about the concept, see [documentation](/docs/overview/concepts/services#labels). ||
|| targets[] | **[Target](#yandex.cloud.apploadbalancer.v1.Target)**

List of targets in the target group. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|#

## Target {#yandex.cloud.apploadbalancer.v1.Target}

A target resource.
For details about the concept, see [documentation](/docs/application-load-balancer/concepts/target-group).

#|
||Field | Description ||
|| ip_address | **string**

IP address of the target.

Includes only one of the fields `ip_address`.

Reference to the target. As of now, targets must only be referred to by their IP addresses. ||
|| subnet_id | **string**

ID of the subnet that the target is connected to. ||
|| private_ipv4_address | **bool**

If set, will not require `subnet_id` to validate the target.
Instead, the address should belong to one of the following ranges:
10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16
Only one of `subnet_id` or `private_ipv4_address` should be set. ||
|#