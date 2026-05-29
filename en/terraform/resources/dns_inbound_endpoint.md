---
subcategory: Cloud DNS
---

# yandex_dns_inbound_endpoint (Resource)



## Example usage

```terraform
//
// Create a new DNS Inbound Endpoint.
//
resource "yandex_dns_inbound_endpoint" "endpoint1" {
  name        = "my-inbound-endpoint"
  description = "My DNS inbound endpoint"

  labels = {
    label1 = "label-1-value"
  }

  folder_id   = "my-folder-id"
  network_id  = yandex_vpc_network.foo.id
  address_id  = yandex_vpc_address.addr1.id

  deletion_protection = true
}

// Auxiliary resources for DNS Inbound Endpoint
resource "yandex_vpc_network" "foo" {}

resource "yandex_vpc_subnet" "subnet1" {
  name           = "my-subnet"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.foo.id
  v4_cidr_blocks = ["192.168.0.0/24"]
}

resource "yandex_vpc_address" "addr1" {
  name        = "my-addr"
  description = "internal address for DNS inbound endpoint"

  internal_ipv4_address {
    subnet_id = yandex_vpc_subnet.subnet1.id
  }
  deletion_protection = false
}
```

## Arguments & Attributes Reference

- `address` (*Read-Only*) (String). IP address of the DNS inbound endpoint.
- `address_id` (**Required**)(String). ID of the address resource.
- `created_at` (*Read-Only*) (String). Creation timestamp.
- `deletion_protection` (Bool). Prevents accidental endpoint removal.
- `description` (String). Description of the DNS inbound endpoint.
- `dns_inbound_endpoint_id` (String). ID of the DNS inbound endpoint to return.
- `folder_id` (String). ID of the folder that the DNS inbound endpoint belongs to.
- `id` (String). ID of the DNS inbound endpoint to return.
- `labels` (Map Of String). DNS inbound endpoint labels as `key:value` pairs.
- `name` (String). Name of the DNS inbound endpoint.
 The name is unique within the folder.
- `network_id` (**Required**)(String). ID of the network that the DNS inbound endpoint belongs to.
- `status` (*Read-Only*) (String). Status of the DNS inbound endpoint.
- `timeouts` [Block]. 
  - `create` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
  - `delete` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Setting a timeout for a Delete operation is only applicable if changes are saved into state before the destroy operation occurs.
  - `read` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Read operations occur during any refresh or planning operation when refresh is enabled.
  - `update` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_dns_inbound_endpoint.<resource Name> <resource Id>
terraform import yandex_dns_inbound_endpoint.endpoint1 dns7ie**********dkhh6
```
