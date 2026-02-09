---
subcategory: Virtual Private Cloud
sourcePath: en/terraform/tf-ref/yandex-cloud/data-sources/vpc_address.md
---

# yandex_vpc_address (DataSource)

Get information about a Yandex VPC address. For more information, see [the official documentation](https://yandex.cloud/docs/vpc/concepts/address).

This data source is used to define [VPC Address](https://yandex.cloud/docs/vpc/concepts/address) that can be used by other resources.

{% note warning %}

One of `address_id` or `name` should be specified.

{% endnote %}


## Example usage

```terraform
//
// Get information about existing VPC IPv4 Address.
//
data "yandex_vpc_address" "addr" {
  address_id = "my-address-id"
}
```

## Arguments & Attributes Reference

- `address_id` (String). ID of the address.
- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `deletion_protection` (Bool). The `true` value means that resource is protected from accidental deletion.
- `description` (String). The resource description.
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
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `id` (String). 
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `name` (String). The resource name.
- `reserved` (*Read-Only*) (Bool). `false` means that address is ephemeral.
- `used` (*Read-Only*) (Bool). `true` if address is used.


