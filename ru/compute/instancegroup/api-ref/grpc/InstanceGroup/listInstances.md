---
editable: false
sourcePath: en/_api-ref-grpc/compute/v1/instancegroup/api-ref/grpc/InstanceGroup/listInstances.md
---

# Compute Cloud Instance Groups API, gRPC: InstanceGroupService.ListInstances {#ListInstances}

Lists instances for the specified instance group.

## gRPC request

**rpc ListInstances ([ListInstanceGroupInstancesRequest](#yandex.cloud.compute.v1.instancegroup.ListInstanceGroupInstancesRequest)) returns ([ListInstanceGroupInstancesResponse](#yandex.cloud.compute.v1.instancegroup.ListInstanceGroupInstancesResponse))**

## ListInstanceGroupInstancesRequest {#yandex.cloud.compute.v1.instancegroup.ListInstanceGroupInstancesRequest}

```json
{
  "instanceGroupId": "string",
  "pageSize": "int64",
  "pageToken": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| instanceGroupId | **string**

Required field. ID of the InstanceGroup resource to list instances for.
To get the instance group ID, use a [InstanceGroupService.List](/docs/compute/api-ref/grpc/InstanceGroup/list#List) request. ||
|| pageSize | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`,
the service returns a [ListInstanceGroupInstancesResponse.nextPageToken](#yandex.cloud.compute.v1.instancegroup.ListInstanceGroupInstancesResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| pageToken | **string**

Page token. To get the next page of results,
set `pageToken` to the [ListInstanceGroupInstancesResponse.nextPageToken](#yandex.cloud.compute.v1.instancegroup.ListInstanceGroupInstancesResponse)
returned by a previous list request. ||
|| filter | **string**

A filter expression that filters resources listed in the response.
Currently you can use filtering only on the [ManagedInstance.name](#yandex.cloud.compute.v1.instancegroup.ManagedInstance) field. ||
|#

## ListInstanceGroupInstancesResponse {#yandex.cloud.compute.v1.instancegroup.ListInstanceGroupInstancesResponse}

```json
{
  "instances": [
    {
      "id": "string",
      "status": "Status",
      "instanceId": "string",
      "fqdn": "string",
      "name": "string",
      "statusMessage": "string",
      "zoneId": "string",
      "networkInterfaces": [
        {
          "index": "string",
          "macAddress": "string",
          "subnetId": "string",
          "primaryV4Address": {
            "address": "string",
            "oneToOneNat": {
              "address": "string",
              "ipVersion": "IpVersion",
              "dnsRecords": [
                {
                  "fqdn": "string",
                  "dnsZoneId": "string",
                  "ttl": "int64",
                  "ptr": "bool"
                }
              ]
            },
            "dnsRecords": [
              {
                "fqdn": "string",
                "dnsZoneId": "string",
                "ttl": "int64",
                "ptr": "bool"
              }
            ]
          },
          "primaryV6Address": {
            "address": "string",
            "oneToOneNat": {
              "address": "string",
              "ipVersion": "IpVersion",
              "dnsRecords": [
                {
                  "fqdn": "string",
                  "dnsZoneId": "string",
                  "ttl": "int64",
                  "ptr": "bool"
                }
              ]
            },
            "dnsRecords": [
              {
                "fqdn": "string",
                "dnsZoneId": "string",
                "ttl": "int64",
                "ptr": "bool"
              }
            ]
          }
        }
      ],
      "statusChangedAt": "google.protobuf.Timestamp",
      "instanceTag": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| instances[] | **[ManagedInstance](#yandex.cloud.compute.v1.instancegroup.ManagedInstance)**

Lists instances for the specified instance group. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is more than [ListInstanceGroupInstancesRequest.pageSize](#yandex.cloud.compute.v1.instancegroup.ListInstanceGroupInstancesRequest), use
`nextPageToken` as the value
for the [ListInstanceGroupInstancesRequest.pageToken](#yandex.cloud.compute.v1.instancegroup.ListInstanceGroupInstancesRequest) query parameter
in the next list request. Each subsequent list request will have its own
`nextPageToken` to continue paging through the results. ||
|#

## ManagedInstance {#yandex.cloud.compute.v1.instancegroup.ManagedInstance}

A ManagedInstance resource. For more information, see [Instance Groups Concepts](/docs/compute/concepts/instance-groups/).

#|
||Field | Description ||
|| id | **string**

ID of the managed instance. ||
|| status | enum **Status**

Status of the managed instance.

- `STATUS_UNSPECIFIED`
- `CREATING_INSTANCE`: Instance is being created.
- `UPDATING_INSTANCE`: Instance is being updated.
- `DELETING_INSTANCE`: Instance is being deleted.
- `STARTING_INSTANCE`: Instance is being started.
- `STOPPING_INSTANCE`: Instance is being stopped.
- `AWAITING_STARTUP_DURATION`: Instance has been created successfully, but startup duration has not elapsed yet.
- `CHECKING_HEALTH`: Instance has been created successfully and startup duration has elapsed, but health checks have not passed yet and the managed instance is not ready to receive traffic.
- `OPENING_TRAFFIC`: Instance Groups is initiating health checks and routing traffic to the instances.
- `AWAITING_WARMUP_DURATION`: Instance is now receiving traffic, but warmup duration has not elapsed yet.
- `CLOSING_TRAFFIC`: Instance Groups has initiated the process of stopping routing traffic to the instances.
- `RUNNING_ACTUAL`: Instance is running normally and its attributes match the current InstanceTemplate.
- `RUNNING_OUTDATED`: Instance is running normally, but its attributes do not match the current InstanceTemplate.
It will be updated, recreated or deleted shortly.
- `STOPPED`: Instance was stopped.
- `DELETED`: Instance was deleted.
- `PREPARING_RESOURCES`: Instance Groups is preparing dependent resources. ||
|| instanceId | **string**

ID of the instance. ||
|| fqdn | **string**

Fully Qualified Domain Name. ||
|| name | **string**

The name of the managed instance. ||
|| statusMessage | **string**

Status message for the managed instance. ||
|| zoneId | **string**

ID of the availability zone where the instance resides. ||
|| networkInterfaces[] | **[NetworkInterface](#yandex.cloud.compute.v1.instancegroup.NetworkInterface)**

Array of network interfaces that are attached to the managed instance. ||
|| statusChangedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format when the status of the managed instance was last changed. ||
|| instanceTag | **string**

Managed instance tag. ||
|#

## NetworkInterface {#yandex.cloud.compute.v1.instancegroup.NetworkInterface}

#|
||Field | Description ||
|| index | **string**

The index of the network interface, generated by the server, 0,1,2... etc. ||
|| macAddress | **string**

MAC address that is assigned to the network interface. ||
|| subnetId | **string**

ID of the subnet. ||
|| primaryV4Address | **[PrimaryAddress](#yandex.cloud.compute.v1.instancegroup.PrimaryAddress)**

Primary IPv4 address that is assigned to the instance for this network interface. ||
|| primaryV6Address | **[PrimaryAddress](#yandex.cloud.compute.v1.instancegroup.PrimaryAddress)**

Primary IPv6 address that is assigned to the instance for this network interface. IPv6 is not available yet. ||
|#

## PrimaryAddress {#yandex.cloud.compute.v1.instancegroup.PrimaryAddress}

#|
||Field | Description ||
|| address | **string**

An IPv4 internal network address that is assigned to the managed instance for this network interface.
If not specified by the user, an unused internal IP is assigned by the system. ||
|| oneToOneNat | **[OneToOneNat](#yandex.cloud.compute.v1.instancegroup.OneToOneNat)**

One-to-one NAT configuration. If missing, NAT has not been set up. ||
|| dnsRecords[] | **[DnsRecord](#yandex.cloud.compute.v1.instancegroup.DnsRecord)**

Internal DNS configuration. ||
|#

## OneToOneNat {#yandex.cloud.compute.v1.instancegroup.OneToOneNat}

#|
||Field | Description ||
|| address | **string**

An IPv4 external network address that is assigned to the managed instance for this network interface. ||
|| ipVersion | enum **IpVersion**

External IP address version.

- `IP_VERSION_UNSPECIFIED`
- `IPV4`: IPv4 address, for example 192.168.0.0.
- `IPV6`: IPv6 address, not available yet. ||
|| dnsRecords[] | **[DnsRecord](#yandex.cloud.compute.v1.instancegroup.DnsRecord)**

External DNS configuration. ||
|#

## DnsRecord {#yandex.cloud.compute.v1.instancegroup.DnsRecord}

#|
||Field | Description ||
|| fqdn | **string**

Required field. Name of the A/AAAA record as specified when creating the instance.
Note that if `fqdn' has no trailing '.', it is specified relative to the zone (@see dns_zone_id). ||
|| dnsZoneId | **string**

DNS zone id (optional, if not set, some private zone is used). ||
|| ttl | **int64**

DNS record ttl (optional, if 0, a reasonable default is used). ||
|| ptr | **bool**

When true, indicates there is a corresponding auto-created PTR DNS record. ||
|#