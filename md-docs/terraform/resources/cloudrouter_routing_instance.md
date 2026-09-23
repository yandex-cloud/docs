[Документация Yandex Cloud](../../index.md) > [Terraform в Yandex Cloud](../index.md) > Справочник Terraform > Ресурсы (англ.) > Cloud Router > Resources > cloudrouter_routing_instance

# yandex_cloudrouter_routing_instance (Resource)



## Example usage

```terraform
//
// Create a routing instance and attach a VPC network.
//
resource "yandex_cloudrouter_routing_instance" "example" {
  name = "my-routing-instance"

  vpc_info = [{
    vpc_network_id = yandex_vpc_network.example.id
  }]
}

// Auxiliary resource for the routing instance.
resource "yandex_vpc_network" "example" {
  name = "my-network"
}
```
```terraform
//
// Attach a VPC network and an existing Cloud Interconnect private connection.
//
variable "cic_private_connection_id" {
  type        = string
  description = "ID of an existing Cloud Interconnect private connection to attach."
}

resource "yandex_cloudrouter_routing_instance" "with_private_connection" {
  name        = "my-interconnect-routing-instance"
  description = "Routing between a VPC network and a private connection"

  labels = {
    environment = "production"
  }

  // Each configured collection replaces its full set of entries.
  // Omit a collection to keep its current entries. Set it to [] to remove all.
  vpc_info = [{
    vpc_network_id = yandex_vpc_network.interconnect.id
    az_infos = [{
      manual_info = {
        az_id    = yandex_vpc_subnet.interconnect.zone
        prefixes = yandex_vpc_subnet.interconnect.v4_cidr_blocks
      }
    }]
  }]

  cic_private_connection_info = [{
    cic_private_connection_id = var.cic_private_connection_id
  }]

  // Disable deletion protection before destroying the routing instance.
  deletion_protection = true
}

// Auxiliary resource for the routing instance.
resource "yandex_vpc_network" "interconnect" {
  name = "my-interconnect-network"
}

resource "yandex_vpc_subnet" "interconnect" {
  name           = "my-interconnect-subnet"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.interconnect.id
  v4_cidr_blocks = ["10.10.0.0/24"]
}
```

## Arguments & Attributes Reference

- `cic_private_connection_info` [Block]. List of the info about privateConnections which are attached to routingInstance.
  - `cic_private_connection_id` (**Required**)(String). ID of the cicPrivateConnection that is attached to the routingInstance.
- `created_at` (*Read-Only*) (String). Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.
- `deletion_protection` (Bool). package: yandex.cloud.cloudrouter.v1
filename: yandex/cloud/cloudrouter/v1/routing_instance.proto

- `description` (String). Description of the routingInstance. 0-256 characters long.
- `folder_id` (String). ID of the folder that the routingInstance belongs to.
- `id` (*Read-Only*) (String). ID of the RoutingInstance resource to return.
 To get the routingInstance ID use a [RoutingInstanceService.List] request.
- `labels` (Map Of String). Resource labels, `key:value` pairs.
 No more than 64 per resource.
 The maximum string length in characters for each value is 63.
 Each value must match the regular expression `[-_0-9a-z]*`.
 The string length in characters for each key must be 1-63.
 Each key must match the regular expression `[a-z][-_0-9a-z]*`.
- `name` (String). Name of the routingInstance.
 The name must be unique within the folder.
 Value must match the regular expression `\|[a-zA-Z]([-_a-zA-Z0-9]{0,61}[a-zA-Z0-9])?`.
- `region_id` (*Read-Only*) (String). ID of the region that the routingInstance belongs to.
- `routing_instance_id` (*Read-Only*) (String). ID of the RoutingInstance resource to return.
 To get the routingInstance ID use a [RoutingInstanceService.List] request.
- `status` (*Read-Only*) (String). Status of the routingInstance.
- `timeouts` [Block]. 
  - `create` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
  - `delete` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Setting a timeout for a Delete operation is only applicable if changes are saved into state before the destroy operation occurs.
  - `read` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Read operations occur during any refresh or planning operation when refresh is enabled.
  - `update` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
- `vpc_info` [Block]. List of the info about vpcNetworks which are attached to routingInstance.
  - `az_infos` [Block]. List of the az-related info about vpcNetworks which are attached to routingInstance
    - `manual_info` [Block]. VpcInfo which is set by user
      - `az_id` (**Required**)(String). ID of the AZ
      - `prefixes` (Set Of String). List of prefixes to announce
  - `vpc_network_id` (**Required**)(String). ID of the vpcNetwork that is attached to the routingInstance.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](../../cli/quickstart.md).

```shell
# terraform import yandex_cloudrouter_routing_instance.<resource Name> <resource Id>
terraform import yandex_cloudrouter_routing_instance.example routing-instance-id
```