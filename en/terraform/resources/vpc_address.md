---
subcategory: Virtual Private Cloud
sourcePath: en/terraform/tf-ref/yandex-cloud/resources/vpc_address.md
---

# yandex_vpc_address (Resource)

Manages a address within the Yandex Cloud. You can only create a reserved (static) address via this resource. An ephemeral address could be obtained via implicit creation at a compute instance creation only. For more information, see [the official documentation](https://yandex.cloud/docs/vpc/concepts/address).

* How-to Guides
  * [Cloud Networking](https://yandex.cloud/docs/vpc/)
  * [VPC Addressing](https://yandex.cloud/docs/vpc/concepts/address)

## Example usage

```terraform
//
// Create a new VPC regular IPv4 Address.
//
resource "yandex_vpc_address" "addr" {
  name = "exampleAddress"

  external_ipv4_address {
    zone_id = "ru-central1-a"
  }
}
```
```terraform
//
// Create a new VPC IPv4 Address with DDoS Protection.
//
resource "yandex_vpc_address" "vpnaddr" {
  name = "vpnaddr"

  external_ipv4_address {
    zone_id                  = "ru-central1-a"
    ddos_protection_provider = "qrator"
  }
}
```

## Arguments & Attributes Reference

- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `deletion_protection` (Bool). The `true` value means that resource is protected from accidental deletion.
- `description` (String). The resource description.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `id` (String). 
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `name` (String). The resource name.
- `reserved` (*Read-Only*) (Bool). `false` means that address is ephemeral.
- `used` (*Read-Only*) (Bool). `true` if address is used.
- `dns_record` [Block]. DNS record specification of address.
  - `dns_zone_id` (**Required**)(String). DNS zone id to create record at.
  - `fqdn` (**Required**)(String). FQDN for record to address.
  - `ptr` (Bool). If PTR record is needed.
  - `ttl` (Number). TTL of DNS record.
- `external_ipv4_address` [Block]. Specification of IPv4 address.

    {% note warning %}

    Either one `address` or `zone_id` arguments can be specified.~> Either one `ddos_protection_provider` or `outgoing_smtp_capability` arguments can be specified.~> Change any argument in `external_ipv4_address` will cause an address recreate.

    {% endnote %}
  - `address` (*Read-Only*) (String). Allocated IP address.
  - `ddos_protection_provider` (String). Enable DDOS protection. Possible values are: `qrator`
  - `outgoing_smtp_capability` (String). Wanted outgoing smtp capability.
  - `zone_id` (String). The [availability zone](https://yandex.cloud/docs/overview/concepts/geo-scope) where resource is located. If it is not provided, the default provider zone will be used.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_vpc_address.<resource Name> <resource Id>
terraform import yandex_vpc_address.addr ...
```
