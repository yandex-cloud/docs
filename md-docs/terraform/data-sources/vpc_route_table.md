[Документация Yandex Cloud](../../index.md) > [Terraform в Yandex Cloud](../index.md) > Справочник Terraform > Ресурсы (англ.) > Virtual Private Cloud > Data Sources > vpc_route_table

# yandex_vpc_route_table (DataSource)

Get information about a Yandex VPC route table. For more information, see [Yandex Cloud VPC](../../vpc/concepts/index.md).

This data source is used to define [VPC Route Table](../../vpc/concepts/index.md) that can be used by other resources.

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
- `description` (*Read-Only*) (String). The resource description.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `id` (String). 
- `labels` (*Read-Only*) (Map Of String). A set of key/value label pairs which assigned to resource.
- `name` (String). The resource name.
- `network_id` (*Read-Only*) (String). ID of the network this route table belongs to.
- `route_table_id` (String). Route table ID.
- `static_route` (*Read-Only*) (Set Of Object). 
  - `destination_prefix` . 
  - `gateway_id` . 
  - `next_hop_address` .