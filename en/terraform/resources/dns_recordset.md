---
subcategory: Cloud DNS
---

# yandex_dns_recordset (Resource)

Manages a DNS RecordSet within Yandex Cloud.

## Example usage

```terraform
//
// Create a new DNS Zone & two DNS Records on it.
//
resource "yandex_dns_zone" "zone1" {
  name        = "my_private_zone"
  description = "desc"

  labels = {
    label1 = "label-1-value"
  }

  zone             = "example.com."
  public           = false
  private_networks = [yandex_vpc_network.foo.id]
}

resource "yandex_dns_recordset" "rs1" {
  zone_id = yandex_dns_zone.zone1.id
  name    = "srv.example.com."
  type    = "A"
  ttl     = 200
  data    = ["10.1.0.1"]
}

resource "yandex_dns_recordset" "rs2" {
  zone_id = yandex_dns_zone.zone1.id
  name    = "srv2"
  type    = "A"
  ttl     = 200
  data    = ["10.1.0.2"]
}

// Auxiliary resource for DNS Zone
resource "yandex_vpc_network" "foo" {}
```

## Arguments & Attributes Reference

- `data` (**Required**)(Set Of String). The string data for the records in this record set.
- `id` (String). 
- `name` (**Required**)(String). The DNS name this record set will apply to.
- `ttl` (**Required**)(Number). The time-to-live of this record set (seconds).
- `type` (**Required**)(String). The DNS record set type.
- `zone_id` (**Required**)(String). The id of the zone in which this record set will reside.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_dns_recordset.<resource Name> <{zone_id}/{name}/{type}>
terraform import yandex_dns_recordset.rs1 dns9m**********tducf/srv.example.com./A
```
