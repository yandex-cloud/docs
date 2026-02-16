---
subcategory: Virtual Private Cloud
sourcePath: en/terraform/tf-ref/yandex-cloud/resources/vpc_route_table.md
---

# yandex_vpc_route_table (Resource)

Manages a route table within the Yandex Cloud. For more information, see [the official documentation](https://yandex.cloud/docs/vpc/concepts).

* How-to Guides
  * [Cloud Networking](https://yandex.cloud/docs/vpc/)

## Example usage

```terraform
//
// Create a new VPC Route Table.
//
resource "yandex_vpc_route_table" "lab-rt-a" {
  network_id = yandex_vpc_network.lab-net.id

  static_route {
    destination_prefix = "10.2.0.0/16"
    next_hop_address   = "172.16.10.10"
  }

  static_route {
    destination_prefix = "0.0.0.0/0"
    gateway_id         = yandex_vpc_gateway.egress-gateway.id
  }
}

// Auxiliary resources
resource "yandex_vpc_network" "lab-net" {
  name = "lab-network"
}

resource "yandex_vpc_gateway" "egress-gateway" {
  name = "egress-gateway"
  shared_egress_gateway {}
}
```

## Arguments & Attributes Reference

- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `description` (String). The resource description.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `id` (String). 
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `name` (String). The resource name.
- `network_id` (**Required**)(String). ID of the network this route table belongs to.
- `static_route` [Block]. A list of static route records for the route table.

{% note warning %}

Only one of `next_hop_address` or `gateway_id` should be specified.

{% endnote %}


  - `destination_prefix` (String). Route prefix in CIDR notation.
  - `gateway_id` (String). ID of the gateway used ad next hop.
  - `next_hop_address` (String). Address of the next hop.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_vpc_route_table.<resource Name> <resource Id>
terraform import yandex_vpc_route_table.lab-rt-a ...
```
