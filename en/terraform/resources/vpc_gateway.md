---
subcategory: Virtual Private Cloud
---

# yandex_vpc_gateway (Resource)

Manages a gateway within the Yandex Cloud. For more information, see [the official documentation](https://yandex.cloud/docs/vpc/concepts/gateways).

* How-to Guides
  * [Cloud Networking](https://yandex.cloud/docs/vpc/).

## Example usage

```terraform
//
// Create a new VPC NAT Gateway.
//
resource "yandex_vpc_gateway" "my_gw" {
  name = "foobar"
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
- `shared_egress_gateway` [Block]. Shared egress gateway configuration. Currently empty.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_vpc_gateway.<resource Name> <resource Id>
terraform import yandex_vpc_gateway.my_gw ...
```
