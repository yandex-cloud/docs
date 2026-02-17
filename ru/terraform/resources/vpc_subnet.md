---
subcategory: Virtual Private Cloud
---

# yandex_vpc_subnet (Resource)

Manages a subnet within the Yandex Cloud. For more information, see [the official documentation](https://yandex.cloud/docs/vpc/concepts/network#subnet).

* How-to Guides
  * [Cloud Networking](https://yandex.cloud/docs/vpc/)
  * [VPC Addressing](https://yandex.cloud/docs/vpc/concepts/address)

## Example usage

```terraform
//
// Create a new VPC Subnet.
//
resource "yandex_vpc_subnet" "my_subnet" {
  v4_cidr_blocks = ["10.2.0.0/16"]
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.lab-net.id
}

resource "yandex_vpc_network" "lab-net" {
  name = "lab-network"
}
```

## Arguments & Attributes Reference

- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `description` (String). The resource description.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `id` (String). 
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `name` (String). The resource name.
- `network_id` (**Required**)(String). ID of the network this subnet belongs to. Only networks that are in the distributed mode can have subnets.
- `route_table_id` (String). The ID of the route table to assign to this subnet. Assigned route table should belong to the same network as this subnet.
- `v4_cidr_blocks` (**Required**)(List Of String). A list of blocks of internal IPv4 addresses that are owned by this subnet. Provide this property when you create the subnet. For example, `10.0.0.0/22` or `192.168.0.0/16`. Blocks of addresses must be unique and non-overlapping within a network. Minimum subnet size is `/28`, and maximum subnet size is `/16`. Only IPv4 is supported.
- `v6_cidr_blocks` (*Read-Only*) (List Of String). An optional list of blocks of IPv6 addresses that are owned by this subnet.
- `zone` (String). The [availability zone](https://yandex.cloud/docs/overview/concepts/geo-scope) where resource is located. If it is not provided, the default provider zone will be used.
- `dhcp_options` [Block]. Options for DHCP client.
  - `domain_name` (String). Domain name.
  - `domain_name_servers` (List Of String). Domain name server IP addresses.
  - `ntp_servers` (List Of String). NTP server IP addresses.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_vpc_subnet.<resource Name> <resource Id>
terraform import yandex_vpc_subnet.my_subnet ...
```
