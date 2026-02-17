---
subcategory: Virtual Private Cloud
---

# yandex_vpc_network (Resource)

Manages a network within the Yandex Cloud. For more information, see [the official documentation](https://yandex.cloud/docs/vpc/concepts/network#network).

* How-to Guides
  * [Cloud Networking](https://yandex.cloud/docs/vpc/)
  * [VPC Addressing](https://yandex.cloud/docs/vpc/concepts/address)

## Example usage

```terraform
//
// Create a new VPC Network.
//
resource "yandex_vpc_network" "my_net" {
  name = "foobar"
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
- `subnet_ids` (*Read-Only*) (List Of String). The list of VPC subnets identifiers which resource is attached.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_vpc_network.<resource Name> <resource Id>
terraform import yandex_vpc_network.my_net ...
```
