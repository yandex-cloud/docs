---
subcategory: Virtual Private Cloud
sourcePath: en/terraform/tf-ref/yandex-cloud/resources/vpc_private_endpoint.md
---

# yandex_vpc_private_endpoint (Resource)

Manages a VPC Private Endpoint within the Yandex Cloud. For more information, see [the official documentation](https://yandex.cloud/docs/vpc/concepts/private-endpoint).

* How-to Guides
  * [Cloud Networking](https://yandex.cloud/docs/vpc/)

## Example usage

```terraform
//
// Create a new VPC Private Endpoint.
//
resource "yandex_vpc_private_endpoint" "my_pe" {
  name        = "object-storage-private-endpoint"
  description = "description for private endpoint"

  labels = {
    my-label = "my-label-value"
  }

  network_id = yandex_vpc_network.lab-net.id

  object_storage {}

  dns_options {
    private_dns_records_enabled = true
  }

  endpoint_address {
    subnet_id = yandex_vpc_subnet.lab-subnet-a.id
  }
}

// Auxiliary resources
resource "yandex_vpc_network" "lab-net" {
  name = "lab-network"
}

resource "yandex_vpc_subnet" "lab-subnet-a" {
  v4_cidr_blocks = ["10.2.0.0/16"]
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.lab-net.id
}
```

## Arguments & Attributes Reference

- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `description` (String). The resource description.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `id` (String). 
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `name` (String). The resource name.
- `network_id` (**Required**)(String). ID of the network which private endpoint belongs to.
- `status` (*Read-Only*) (String). Status of the private endpoint.
- `dns_options` [Block]. Private endpoint DNS options block.
  - `private_dns_records_enabled` (Bool). If enabled - additional service DNS will be created.
- `endpoint_address` [Block]. Private endpoint address specification block.

    {% note warning %}

    Only one of `address_id` or `subnet_id` + `address` arguments can be specified.

    {% endnote %}
  - `address` (String). Specifies IP address within `subnet_id`.
  - `address_id` (String). ID of the address.
  - `subnet_id` (String). Subnet of the IP address.
- `object_storage` [Block]. Private endpoint for Object Storage.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_vpc_private_endpoint.<resource Name> <resource Id>
terraform import yandex_vpc_private_endpoint.my_pe ...
```
