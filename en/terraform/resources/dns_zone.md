---
subcategory: Cloud DNS
---

# yandex_dns_zone (Resource)

Manages a DNS Zone.

## Example usage

```terraform
//
// Create a new DNS Zone.
//
resource "yandex_dns_zone" "zone1" {
  name        = "my-private-zone"
  description = "desc"

  labels = {
    label1 = "label-1-value"
  }

  zone             = "example.com."
  public           = false
  private_networks = [yandex_vpc_network.foo.id]

  deletion_protection = true
}

resource "yandex_dns_recordset" "rs1" {
  zone_id = yandex_dns_zone.zone1.id
  name    = "srv.example.com."
  type    = "A"
  ttl     = 200
  data    = ["10.1.0.1"]
}

// Auxiliary resource for DNS Zone
resource "yandex_vpc_network" "foo" {}
```

## Arguments & Attributes Reference

- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `deletion_protection` (Bool). The `true` value means that resource is protected from accidental deletion.
- `description` (String). The resource description.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `id` (String). 
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `name` (String). The resource name.
- `private_networks` (Set Of String). For privately visible zones, the set of Virtual Private Cloud resources that the zone is visible from.
- `public` (Bool). The zone's visibility: public zones are exposed to the Internet, while private zones are visible only to Virtual Private Cloud resources.
- `zone` (**Required**)(String). The DNS name of this zone, e.g. `example.com.`. Must ends with dot.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_dns_zone.<resource Name> <resource Id>
terraform import yandex_dns_zone.zone1 dns9m**********tducf
```
