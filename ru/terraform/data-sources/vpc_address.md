---
subcategory: Virtual Private Cloud
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
- `deletion_protection` (*Read-Only*) (Bool). The `true` value means that resource is protected from accidental deletion.
- `description` (*Read-Only*) (String). The resource description.
- `dns_record` (*Read-Only*) (List Of Object). DNS record specifications.
  - `dns_zone_id` . 
  - `fqdn` . 
  - `ptr` . 
  - `ttl` . 
- `external_ipv4_address` (*Read-Only*) (List Of Object). External IPv4 address specification.
  - `address` . 
  - `ddos_protection_provider` . 
  - `outgoing_smtp_capability` . 
  - `zone_id` . 
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `id` (String). 
- `internal_ipv4_address` (*Read-Only*) (List Of Object). Internal IPv4 address specification.
  - `address` . 
  - `subnet_id` . 
- `labels` (*Read-Only*) (Map Of String). A set of key/value label pairs which assigned to resource.
- `name` (String). The resource name.
- `reserved` (*Read-Only*) (Bool). `false` means that address is ephemeral.
- `used` (*Read-Only*) (Bool). `true` if address is used.


