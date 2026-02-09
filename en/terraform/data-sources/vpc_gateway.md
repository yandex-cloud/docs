---
subcategory: Virtual Private Cloud
sourcePath: en/terraform/tf-ref/yandex-cloud/data-sources/vpc_gateway.md
---

# yandex_vpc_gateway (DataSource)

Get information about a Yandex VPC gateway. For more information, see [Yandex Cloud VPC](https://yandex.cloud/docs/vpc/concepts).

This data source is used to define [VPC Gateways](https://yandex.cloud/docs/vpc/concepts/gateways) that can be used by other resources.

{% note warning %}

One of `gateway_id` or `name` should be specified.

{% endnote %}


## Example usage

```terraform
//
// Get information about existing VPC NAT Gateway.
//
data "yandex_vpc_gateway" "default" {
  gateway_id = "my-gateway-id"
}
```

## Arguments & Attributes Reference

- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `description` (String). The resource description.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `gateway_id` (String). ID of the VPC Gateway.
- `id` (String). 
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `name` (String). The resource name.
- `shared_egress_gateway` [Block]. Shared egress gateway configuration. Currently empty.


