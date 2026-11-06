[Документация Yandex Cloud](../../../../index.md) > [Yandex BareMetal](../../../index.md) > Концепции > Настройка и управление > Справочник API > API v1alpha > [gRPC (англ.)](../index.md) > [PrivateSubnet](index.md) > Get

# BareMetal API, gRPC: PrivateSubnetService.Get

Returns the specific PrivateSubnet resource.
To get the list of available PrivateSubnet resources, make a [List](list.md#List) request.

## gRPC request

**rpc Get ([GetPrivateSubnetRequest](#yandex.cloud.baremetal.v1alpha.GetPrivateSubnetRequest)) returns ([PrivateSubnet](#yandex.cloud.baremetal.v1alpha.PrivateSubnet))**

## GetPrivateSubnetRequest {#yandex.cloud.baremetal.v1alpha.GetPrivateSubnetRequest}

```json
{
  "private_subnet_id": "string"
}
```

#|
||Field | Description ||
|| private_subnet_id | **string**

ID of the PrivateSubnet resource to return.
To get the private subnet ID use a [PrivateSubnetService.List](list.md#List) request.

Value must match the regular expression ` [a-z][a-z0-9]* `. ||
|#

## PrivateSubnet {#yandex.cloud.baremetal.v1alpha.PrivateSubnet}

```json
{
  "id": "string",
  "cloud_id": "string",
  "folder_id": "string",
  "name": "string",
  "description": "string",
  "status": "Status",
  "zone_id": "string",
  "hardware_pool_id": "string",
  "vrf_options": {
    "vrf_id": "string",
    "cidr": "string",
    "dhcp_options": {
      "start_ip": "string",
      "end_ip": "string",
      "dns_options": {
        "servers": [
          {
            // Includes only one of the fields `ip_address`, `dns_inbound_endpoint_id`
            "ip_address": "string",
            "dns_inbound_endpoint_id": "string"
            // end of the list of possible fields
          }
        ],
        "domain_name": "string"
      }
    },
    "gateway_ip": "string"
  },
  "created_at": "google.protobuf.Timestamp",
  "labels": "map<string, string>"
}
```

A PrivateSubnet resource.

#|
||Field | Description ||
|| id | **string**

ID of the private subnet. ||
|| cloud_id | **string**

ID of the cloud that the private subnet belongs to. ||
|| folder_id | **string**

ID of the folder that the private subnet belongs to. ||
|| name | **string**

Name of the private subnet.
The name is unique within the folder. ||
|| description | **string**

Optional description of the private subnet. ||
|| status | enum **Status**

Status of the private subnet.

- `CREATING`: Private subnet is being created.
- `READY`: Private subnet is ready to use.
- `UPDATING`: Private subnet is being updated.
- `DELETING`: Private subnet is being deleted.
- `ERROR`: Private subnet encountered a problem and cannot operate. ||
|| zone_id | **string**

ID of the availability zone where the server resides. ||
|| hardware_pool_id | **string**

ID of the hardware pool that the private subnet belongs to. ||
|| vrf_options | **[VrfOptions](#yandex.cloud.baremetal.v1alpha.PrivateSubnet.VrfOptions)**

Optional VRF options for the private subnet. If missing, the private subnet will be unrouted,
i.e. it will lack a DHCP server and routing capabilities between this subnet and other private
subnets. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. ||
|#

## VrfOptions {#yandex.cloud.baremetal.v1alpha.PrivateSubnet.VrfOptions}

VRF options for the private subnet.

#|
||Field | Description ||
|| vrf_id | **string**

ID of the VRF. ||
|| cidr | **string**

CIDR block for the subnet. ||
|| dhcp_options | **[DhcpOptions](#yandex.cloud.baremetal.v1alpha.DhcpOptions)**

DHCP options for the subnet. ||
|| gateway_ip | **string**

Gateway IP address for the subnet. ||
|#

## DhcpOptions {#yandex.cloud.baremetal.v1alpha.DhcpOptions}

DHCP options for a subnet.

#|
||Field | Description ||
|| start_ip | **string**

Start IP address of the DHCP range (inclusive). ||
|| end_ip | **string**

End IP address of the DHCP range (inclusive). ||
|| dns_options | **[DnsOptions](#yandex.cloud.baremetal.v1alpha.DnsOptions)**

DNS configuration handed out to servers via DHCP. ||
|#

## DnsOptions {#yandex.cloud.baremetal.v1alpha.DnsOptions}

DNS configuration distributed through DHCP.

#|
||Field | Description ||
|| servers[] | **[DnsServer](#yandex.cloud.baremetal.v1alpha.DnsServer)**

DNS servers handed out to servers via DHCP option 6.
The order is preserved.

The maximum number of elements is 3. ||
|| domain_name | **string**

DNS Domain name handed out to servers via DHCP options 15 and 119.

The maximum string length in characters is 253. Value must match the regular expression ``` ([a-zA-Z0-9]([-a-zA-Z0-9]*[a-zA-Z0-9])?([.][a-zA-Z0-9]([-a-zA-Z0-9]*[a-zA-Z0-9])?)*)| ```. ||
|#

## DnsServer {#yandex.cloud.baremetal.v1alpha.DnsServer}

Represents a DNS server specified either by an IP address or by a Cloud DNS inbound endpoint.

#|
||Field | Description ||
|| ip_address | **string**

Manual DNS server IP address.

The maximum string length in characters is 15. Value must match the regular expression ``` (?:0|[1-9][0-9]?|1[0-9]{2}|2[0-4][0-9]|25[0-5])(?:[.](?:0|[1-9][0-9]?|1[0-9]{2}|2[0-4][0-9]|25[0-5])){3} ```.

Includes only one of the fields `ip_address`, `dns_inbound_endpoint_id`. ||
|| dns_inbound_endpoint_id | **string**

ID of the Cloud DNS inbound endpoint.

Value must match the regular expression ` [a-z][a-z0-9]* `.

Includes only one of the fields `ip_address`, `dns_inbound_endpoint_id`. ||
|#