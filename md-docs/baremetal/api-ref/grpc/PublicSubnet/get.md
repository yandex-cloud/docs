[Документация Yandex Cloud](../../../../index.md) > [Yandex BareMetal](../../../index.md) > Концепции > Настройка и управление > Справочник API > API v1alpha > [gRPC (англ.)](../index.md) > [PublicSubnet](index.md) > Get

# BareMetal API, gRPC: PublicSubnetService.Get

Returns the specific PublicSubnet resource.
To get the list of available PublicSubnet resources, make a [List](list.md#List) request.

## gRPC request

**rpc Get ([GetPublicSubnetRequest](#yandex.cloud.baremetal.v1alpha.GetPublicSubnetRequest)) returns ([PublicSubnet](#yandex.cloud.baremetal.v1alpha.PublicSubnet))**

## GetPublicSubnetRequest {#yandex.cloud.baremetal.v1alpha.GetPublicSubnetRequest}

```json
{
  "public_subnet_id": "string"
}
```

#|
||Field | Description ||
|| public_subnet_id | **string**

Required field. ID of the PublicSubnet resource to return.
To get the public subnet ID use a [PublicSubnetService.List](list.md#List) request. ||
|#

## PublicSubnet {#yandex.cloud.baremetal.v1alpha.PublicSubnet}

```json
{
  "id": "string",
  "cloud_id": "string",
  "folder_id": "string",
  "name": "string",
  "description": "string",
  "zone_id": "string",
  "hardware_pool_ids": [
    "string"
  ],
  "type": "PublicSubnetType",
  "prefix_length": "int64",
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
  "gateway_ip": "string",
  "public_prefix_pool_id": "google.protobuf.StringValue",
  "created_at": "google.protobuf.Timestamp",
  "labels": "map<string, string>",
  "deletion_unlocked_at": "google.protobuf.Timestamp"
}
```

A PublicSubnet resource.

#|
||Field | Description ||
|| id | **string**

ID of the public subnet. ||
|| cloud_id | **string**

ID of the cloud that the public subnet belongs to. ||
|| folder_id | **string**

ID of the folder that the public subnet belongs to. ||
|| name | **string**

Name of the public subnet.
The name is unique within the folder. ||
|| description | **string**

Optional description of the public subnet. ||
|| zone_id | **string**

ID of the availability zone where the server resides. ||
|| hardware_pool_ids[] | **string**

IDs of the hardware pool that the public subnet belongs to. ||
|| type | enum **PublicSubnetType**

Type of the public subnet (static or ephemeral).

- `DEDICATED`: Dedicated public subnet.
- `EPHEMERAL`: Ephemeral public subnet. ||
|| prefix_length | **int64**

Prefix length of the public subnet CIDR block. ||
|| cidr | **string**

CIDR block for the public subnet. ||
|| dhcp_options | **[DhcpOptions](#yandex.cloud.baremetal.v1alpha.DhcpOptions)**

DHCP options for the public subnet. ||
|| gateway_ip | **string**

Gateway IP address for the public subnet. ||
|| public_prefix_pool_id | **[google.protobuf.StringValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/string-value)**

ID of the public prefix pool that the public subnet belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. ||
|| deletion_unlocked_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp when deletion of the public subnet is allowed. ||
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