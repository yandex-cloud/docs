---
editable: false
sourcePath: en/_api-ref-grpc/compute/v1/api-ref/grpc/HostGroup/listHosts.md
---

# Compute Cloud API, gRPC: HostGroupService.ListHosts

Lists hosts that belongs to the specified host group.

## gRPC request

**rpc ListHosts ([ListHostGroupHostsRequest](#yandex.cloud.compute.v1.ListHostGroupHostsRequest)) returns ([ListHostGroupHostsResponse](#yandex.cloud.compute.v1.ListHostGroupHostsResponse))**

## ListHostGroupHostsRequest {#yandex.cloud.compute.v1.ListHostGroupHostsRequest}

```json
{
  "host_group_id": "string",
  "page_size": "int64",
  "page_token": "string"
}
```

#|
||Field | Description ||
|| host_group_id | **string**

Required field. ID of the host group to list hosts for.
To get the host group ID, use [HostGroupService.List](/docs/compute/api-ref/grpc/HostGroup/list#List) request. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`,
the service returns a [ListHostGroupHostsResponse.next_page_token](#yandex.cloud.compute.v1.ListHostGroupHostsResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| page_token | **string**

Page token. To get the next page of results,
set `page_token` to the [ListHostGroupHostsResponse.next_page_token](#yandex.cloud.compute.v1.ListHostGroupHostsResponse)
returned by a previous list request. ||
|#

## ListHostGroupHostsResponse {#yandex.cloud.compute.v1.ListHostGroupHostsResponse}

```json
{
  "hosts": [
    {
      "id": "string",
      "status": "Status",
      "server_id": "string",
      "replacement": {
        "host_id": "string",
        "deadline_at": "google.protobuf.Timestamp"
      }
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| hosts[] | **[Host](#yandex.cloud.compute.v1.Host)**

Lists hosts for the specified host group. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests. If the number of results
is more than [ListHostGroupHostsRequest.page_size](#yandex.cloud.compute.v1.ListHostGroupHostsRequest), use
`next_page_token` as the value
for the [ListHostGroupHostsRequest.page_token](#yandex.cloud.compute.v1.ListHostGroupHostsRequest) query parameter
in the next list request. Each subsequent list request will have its own
`next_page_token` to continue paging through the results. ||
|#

## Host {#yandex.cloud.compute.v1.Host}

Represents a dedicated host

#|
||Field | Description ||
|| id | **string**

ID of the host. ||
|| status | enum **Status**

Current status of the host. New instances are unable to start on host in DOWN status.

- `STATUS_UNSPECIFIED`
- `UP`
- `DOWN` ||
|| server_id | **string**

ID of the physical server that the host belongs to. ||
|| replacement | **[Replacement](#yandex.cloud.compute.v1.Replacement)**

Set temporarily if maintenance is planned for this host, and a new host was provided as a replacement. ||
|#

## Replacement {#yandex.cloud.compute.v1.Replacement}

#|
||Field | Description ||
|| host_id | **string**

ID of the host which replaces this one. ||
|| deadline_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The date and time when this host will be automatically freed of instances. ||
|#