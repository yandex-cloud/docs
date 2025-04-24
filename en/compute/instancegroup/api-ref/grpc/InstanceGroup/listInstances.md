---
editable: false
sourcePath: en/_api-ref-grpc/compute/v1/instancegroup/api-ref/grpc/InstanceGroup/listInstances.md
---

# Compute Cloud Instance Groups API, gRPC: InstanceGroupService.ListInstances

Lists instances for the specified instance group.

## gRPC request

**rpc ListInstances ([ListInstanceGroupInstancesRequest](#yandex.cloud.compute.v1.instancegroup.ListInstanceGroupInstancesRequest)) returns ([ListInstanceGroupInstancesResponse](#yandex.cloud.compute.v1.instancegroup.ListInstanceGroupInstancesResponse))**

## ListInstanceGroupInstancesRequest {#yandex.cloud.compute.v1.instancegroup.ListInstanceGroupInstancesRequest}

```json
{
  "instance_group_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| instance_group_id | **string**

Required field. ID of the InstanceGroup resource to list instances for.
To get the instance group ID, use a [InstanceGroupService.List](/docs/compute/instancegroup/api-ref/grpc/InstanceGroup/list#List) request. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`,
the service returns a [ListInstanceGroupInstancesResponse.next_page_token](#yandex.cloud.compute.v1.instancegroup.ListInstanceGroupInstancesResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| page_token | **string**

Page token. To get the next page of results,
set `page_token` to the [ListInstanceGroupInstancesResponse.next_page_token](#yandex.cloud.compute.v1.instancegroup.ListInstanceGroupInstancesResponse)
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
      "instance_id": "string",
      "fqdn": "string",
      "name": "string",
      "status_message": "string",
      "zone_id": "string",
      "network_interfaces": [
        {
          "index": "string",
          "mac_address": "string",
          "subnet_id": "string",
          "primary_v4_address": {
            "address": "string",
            "one_to_one_nat": {
              "address": "string",
              "ip_version": "IpVersion",
              "dns_records": [
                {
                  "fqdn": "string",
                  "dns_zone_id": "string",
                  "ttl": "int64",
                  "ptr": "bool"
                }
              ]
            },
            "dns_records": [
              {
                "fqdn": "string",
                "dns_zone_id": "string",
                "ttl": "int64",
                "ptr": "bool"
              }
            ]
          },
          "primary_v6_address": {
            "address": "string",
            "one_to_one_nat": {
              "address": "string",
              "ip_version": "IpVersion",
              "dns_records": [
                {
                  "fqdn": "string",
                  "dns_zone_id": "string",
                  "ttl": "int64",
                  "ptr": "bool"
                }
              ]
            },
            "dns_records": [
              {
                "fqdn": "string",
                "dns_zone_id": "string",
                "ttl": "int64",
                "ptr": "bool"
              }
            ]
          }
        }
      ],
      "status_changed_at": "google.protobuf.Timestamp",
      "instance_tag": "string"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| instances[] | **[ManagedInstance](#yandex.cloud.compute.v1.instancegroup.ManagedInstance)**

Lists instances for the specified instance group. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests. If the number of results
is more than [ListInstanceGroupInstancesRequest.page_size](#yandex.cloud.compute.v1.instancegroup.ListInstanceGroupInstancesRequest), use
`next_page_token` as the value
for the [ListInstanceGroupInstancesRequest.page_token](#yandex.cloud.compute.v1.instancegroup.ListInstanceGroupInstancesRequest) query parameter
in the next list request. Each subsequent list request will have its own
`next_page_token` to continue paging through the results. ||
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
|| instance_id | **string**

ID of the instance. ||
|| fqdn | **string**

Fully Qualified Domain Name. ||
|| name | **string**

The name of the managed instance. ||
|| status_message | **string**

Status message for the managed instance. ||
|| zone_id | **string**

ID of the availability zone where the instance resides. ||
|| network_interfaces[] | **[NetworkInterface](#yandex.cloud.compute.v1.instancegroup.NetworkInterface)**

Array of network interfaces that are attached to the managed instance. ||
|| status_changed_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format when the status of the managed instance was last changed. ||
|| instance_tag | **string**

Managed instance tag. ||
|#

## NetworkInterface {#yandex.cloud.compute.v1.instancegroup.NetworkInterface}

#|
||Field | Description ||
|| index | **string**

The index of the network interface, generated by the server, 0,1,2... etc. ||
|| mac_address | **string**

MAC address that is assigned to the network interface. ||
|| subnet_id | **string**

ID of the subnet. ||
|| primary_v4_address | **[PrimaryAddress](#yandex.cloud.compute.v1.instancegroup.PrimaryAddress)**

Primary IPv4 address that is assigned to the instance for this network interface. ||
|| primary_v6_address | **[PrimaryAddress](#yandex.cloud.compute.v1.instancegroup.PrimaryAddress)**

Primary IPv6 address that is assigned to the instance for this network interface. IPv6 is not available yet. ||
|#

## PrimaryAddress {#yandex.cloud.compute.v1.instancegroup.PrimaryAddress}

#|
||Field | Description ||
|| address | **string**

An IPv4 internal network address that is assigned to the managed instance for this network interface.
If not specified by the user, an unused internal IP is assigned by the system. ||
|| one_to_one_nat | **[OneToOneNat](#yandex.cloud.compute.v1.instancegroup.OneToOneNat)**

One-to-one NAT configuration. If missing, NAT has not been set up. ||
|| dns_records[] | **[DnsRecord](#yandex.cloud.compute.v1.instancegroup.DnsRecord)**

Internal DNS configuration. ||
|#

## OneToOneNat {#yandex.cloud.compute.v1.instancegroup.OneToOneNat}

#|
||Field | Description ||
|| address | **string**

An IPv4 external network address that is assigned to the managed instance for this network interface. ||
|| ip_version | enum **IpVersion**

External IP address version.

- `IP_VERSION_UNSPECIFIED`
- `IPV4`: IPv4 address, for example 192.168.0.0.
- `IPV6`: IPv6 address, not available yet. ||
|| dns_records[] | **[DnsRecord](#yandex.cloud.compute.v1.instancegroup.DnsRecord)**

External DNS configuration. ||
|#

## DnsRecord {#yandex.cloud.compute.v1.instancegroup.DnsRecord}

#|
||Field | Description ||
|| fqdn | **string**

Required field. Name of the A/AAAA record as specified when creating the instance.
Note that if `fqdn' has no trailing '.', it is specified relative to the zone (@see dns_zone_id). ||
|| dns_zone_id | **string**

DNS zone id (optional, if not set, some private zone is used). ||
|| ttl | **int64**

DNS record ttl (optional, if 0, a reasonable default is used). ||
|| ptr | **bool**

When true, indicates there is a corresponding auto-created PTR DNS record. ||
|#