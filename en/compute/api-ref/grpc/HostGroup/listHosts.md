---
editable: false
sourcePath: en/_api-ref-grpc/compute/v1/api-ref/grpc/HostGroup/listHosts.md
---

# Compute Cloud API, gRPC: HostGroupService.ListHosts {#ListHosts}

Lists hosts that belongs to the specified host group.

## gRPC request

**rpc ListHosts ([ListHostGroupHostsRequest](#yandex.cloud.compute.v1.ListHostGroupHostsRequest)) returns ([ListHostGroupHostsResponse](#yandex.cloud.compute.v1.ListHostGroupHostsResponse))**

## ListHostGroupHostsRequest {#yandex.cloud.compute.v1.ListHostGroupHostsRequest}

```json
{
  "hostGroupId": "string",
  "pageSize": "int64",
  "pageToken": "string"
}
```

#|
||Field | Description ||
|| hostGroupId | **string**

Required field. ID of the host group to list hosts for.
To get the host group ID, use [HostGroupService.List](/docs/compute/api-ref/grpc/HostGroup/list#List) request. ||
|| pageSize | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`,
the service returns a [ListHostGroupHostsResponse.nextPageToken](#yandex.cloud.compute.v1.ListHostGroupHostsResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| pageToken | **string**

Page token. To get the next page of results,
set `pageToken` to the [ListHostGroupHostsResponse.nextPageToken](#yandex.cloud.compute.v1.ListHostGroupHostsResponse)
returned by a previous list request. ||
|#

## ListHostGroupHostsResponse {#yandex.cloud.compute.v1.ListHostGroupHostsResponse}

```json
{
  "hosts": [
    {
      "id": "string",
      "status": "Status",
      "serverId": "string",
      "replacement": {
        "hostId": "string",
        "deadlineAt": "google.protobuf.Timestamp"
      }
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| hosts[] | **[Host](#yandex.cloud.compute.v1.Host)**

Lists hosts for the specified host group. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is more than [ListHostGroupHostsRequest.pageSize](#yandex.cloud.compute.v1.ListHostGroupHostsRequest), use
`nextPageToken` as the value
for the [ListHostGroupHostsRequest.pageToken](#yandex.cloud.compute.v1.ListHostGroupHostsRequest) query parameter
in the next list request. Each subsequent list request will have its own
`nextPageToken` to continue paging through the results. ||
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
|| serverId | **string**

ID of the physical server that the host belongs to. ||
|| replacement | **[Replacement](#yandex.cloud.compute.v1.Replacement)**

Set temporarily if maintenance is planned for this host, and a new host was provided as a replacement. ||
|#

## Replacement {#yandex.cloud.compute.v1.Replacement}

#|
||Field | Description ||
|| hostId | **string**

ID of the host which replaces this one. ||
|| deadlineAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The date and time when this host will be automatically freed of instances. ||
|#