---
subcategory: Virtual Private Cloud
---

# yandex_vpc_private_endpoint (DataSource)

Get information about a Yandex VPC Private Endpoint. For more information, see [Yandex Cloud VPC](https://yandex.cloud/docs/vpc/concepts/index).

This data source is used to define [VPC Private Endpoint](https://yandex.cloud/docs/vpc/concepts/private-endpoint) that can be used by other resources.

{% note warning %}

One of `private_endpoint_id` or `name` should be specified.

{% endnote %}


## Example usage

```terraform
//
// Get information about existing VPC Private Endpoint.
//
data "yandex_vpc_private_endpoint" "pe" {
  private_endpoint_id = "my-private-endpoint-id"
}
```

## Arguments & Attributes Reference

- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `description` (String). The resource description.
- `dns_options` [Block]. Private endpoint DNS options block.
  - `private_dns_records_enabled` (Bool). If enabled - additional service DNS will be created.
- `endpoint_address` [Block]. Private endpoint address specification block.

{% note warning %}

Only one of `address_id` or `subnet_id` + `address` arguments can be specified.

{% endnote %}


  - `address` (String). Specifies IP address within `subnet_id`.
  - `address_id` (String). ID of the address.
  - `subnet_id` (String). Subnet of the IP address.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `id` (String). 
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `name` (String). The resource name.
- `network_id` (**Required**)(String). ID of the network which private endpoint belongs to.
- `private_endpoint_id` (String). ID of the private endpoint.
- `status` (*Read-Only*) (String). Status of the private endpoint.
- `object_storage` [Block]. Private endpoint for Object Storage.


