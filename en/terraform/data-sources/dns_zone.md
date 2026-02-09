---
subcategory: Cloud DNS
sourcePath: en/terraform/tf-ref/yandex-cloud/data-sources/dns_zone.md
---

# yandex_dns_zone (DataSource)

Get information about a DNS Zone.

{% note warning %}

One of `dns_zone_id` or `name` should be specified.

{% endnote %}


## Example usage

```terraform
//
// Get information about existing DNS Zone.
//
data "yandex_dns_zone" "foo" {
  dns_zone_id = yandex_dns_zone.zone1.id
}

output "zone" {
  value = data.yandex_dns_zone.foo.zone
}
```

## Arguments & Attributes Reference

- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `deletion_protection` (Bool). The `true` value means that resource is protected from accidental deletion.
- `description` (String). The resource description.
- `dns_zone_id` (String). The ID of the DNS Zone.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `id` (String). 
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `name` (String). The resource name.
- `private_networks` (Set Of String). For privately visible zones, the set of Virtual Private Cloud resources that the zone is visible from.
- `public` (Bool). The zone's visibility: public zones are exposed to the Internet, while private zones are visible only to Virtual Private Cloud resources.
- `zone` (**Required**)(String). The DNS name of this zone, e.g. `example.com.`. Must ends with dot.


