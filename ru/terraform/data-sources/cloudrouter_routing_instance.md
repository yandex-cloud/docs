---
subcategory: Cloud Router
---

# yandex_cloudrouter_routing_instance (DataSource)



## Example usage

```terraform
//
// Get information about a routing instance by ID.
//
data "yandex_cloudrouter_routing_instance" "example" {
  routing_instance_id = yandex_cloudrouter_routing_instance.example.id
}

output "routing_instance_status" {
  value = data.yandex_cloudrouter_routing_instance.example.status
}
```

## Arguments & Attributes Reference

- `cic_private_connection_info` [Block]. List of the info about privateConnections which are attached to routingInstance.
  - `cic_private_connection_id` (*Read-Only*) (String). ID of the cicPrivateConnection that is attached to the routingInstance.
- `created_at` (*Read-Only*) (String). Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.
- `deletion_protection` (*Read-Only*) (Bool). package: yandex.cloud.cloudrouter.v1
filename: yandex/cloud/cloudrouter/v1/routing_instance.proto

- `description` (*Read-Only*) (String). Description of the routingInstance. 0-256 characters long.
- `folder_id` (String). ID of the folder that the routingInstance belongs to.
- `id` (String). ID of the RoutingInstance resource to return.
 To get the routingInstance ID use a [RoutingInstanceService.List] request.
- `labels` (*Read-Only*) (Map Of String). Resource labels, `key:value` pairs.
 No more than 64 per resource.
 The maximum string length in characters for each value is 63.
 Each value must match the regular expression `[-_0-9a-z]*`.
 The string length in characters for each key must be 1-63.
 Each key must match the regular expression `[a-z][-_0-9a-z]*`.
- `name` (*Read-Only*) (String). Name of the routingInstance.
 The name must be unique within the folder.
 Value must match the regular expression `\|[a-zA-Z]([-_a-zA-Z0-9]{0,61}[a-zA-Z0-9])?`.
- `region_id` (*Read-Only*) (String). ID of the region that the routingInstance belongs to.
- `routing_instance_id` (String). ID of the RoutingInstance resource to return.
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
      - `az_id` (*Read-Only*) (String). ID of the AZ
      - `prefixes` (*Read-Only*) (Set Of String). List of prefixes to announce
  - `vpc_network_id` (*Read-Only*) (String). ID of the vpcNetwork that is attached to the routingInstance.


