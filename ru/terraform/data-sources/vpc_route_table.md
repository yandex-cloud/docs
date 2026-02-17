---
subcategory: Virtual Private Cloud
---

# yandex_vpc_route_table (DataSource)

Get information about a Yandex VPC route table. For more information, see [Yandex Cloud VPC](https://yandex.cloud/docs/vpc/concepts).

This data source is used to define [VPC Route Table](https://yandex.cloud/docs/vpc/concepts/) that can be used by other resources.

{% note warning %}

One of `route_table_id` or `name` should be specified.

{% endnote %}


## Example usage

```terraform
//
// Get information about existing VPC Route Table.
//
data "yandex_vpc_route_table" "my_rt" {
  route_table_id = "my-rt-id"
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
- `route_table_id` (String). Route table ID.
- `static_route` [Block]. A list of static route records for the route table.

{% note warning %}

Only one of `next_hop_address` or `gateway_id` should be specified.

{% endnote %}


  - `destination_prefix` (String). Route prefix in CIDR notation.
  - `gateway_id` (String). ID of the gateway used ad next hop.
  - `next_hop_address` (String). Address of the next hop.


