[Документация Yandex Cloud](../../index.md) > [Terraform в Yandex Cloud](../index.md) > Справочник Terraform > Ресурсы (англ.) > Virtual Private Cloud > Data Sources > vpc_network

# yandex_vpc_network (DataSource)

Get information about a Yandex VPC network. For more information, see [Yandex Cloud VPC](../../vpc/concepts/index.md).

This data source is used to define [VPC Networks](../../vpc/concepts/network.md) that can be used by other resources.

{% note warning %}

One of `network_id` or `name` should be specified.

{% endnote %}


## Example usage

```terraform
//
// Get information about existing VPC Network.
//
data "yandex_vpc_network" "admin" {
  network_id = "my-network-id"
}
```

## Arguments & Attributes Reference

- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `default_security_group_id` (*Read-Only*) (String). ID of default Security Group of this network.
- `description` (String). The resource description.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `id` (String). 
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `name` (String). The resource name.
- `network_id` (String). ID of the network.
- `subnet_ids` (*Read-Only*) (List Of String). The list of VPC subnets identifiers which resource is attached.