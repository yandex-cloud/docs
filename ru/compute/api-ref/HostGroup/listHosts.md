---
editable: false
sourcePath: en/_api-ref/compute/v1/api-ref/HostGroup/listHosts.md
---

# Compute Cloud API, REST: HostGroup.ListHosts

Lists hosts that belongs to the specified host group.

## HTTP request

```
GET https://compute.{{ api-host }}/compute/v1/hostGroups/{hostGroupId}/hosts
```

## Path parameters

#|
||Field | Description ||
|| hostGroupId | **string**

Required field. ID of the host group to list hosts for.
To get the host group ID, use [HostGroupService.List](/docs/compute/api-ref/HostGroup/list#List) request. ||
|#

## Query parameters {#yandex.cloud.compute.v1.ListHostGroupHostsRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`,
the service returns a [ListHostGroupHostsResponse.nextPageToken](#yandex.cloud.compute.v1.ListHostGroupHostsResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| pageToken | **string**

Page token. To get the next page of results,
set `pageToken` to the [ListHostGroupHostsResponse.nextPageToken](#yandex.cloud.compute.v1.ListHostGroupHostsResponse)
returned by a previous list request. ||
|#

## Response {#yandex.cloud.compute.v1.ListHostGroupHostsResponse}

**HTTP Code: 200 - OK**

```json
{
  "hosts": [
    {
      "id": "string",
      "status": "string",
      "serverId": "string",
      "replacement": {
        "hostId": "string",
        "deadlineAt": "string"
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
|| status | **enum** (Status)

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
|| deadlineAt | **string** (date-time)

The date and time when this host will be automatically freed of instances.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#