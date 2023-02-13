1. Create an [internal](../../dns/operations/zone-create-private.md) or [public](../../dns/operations/zone-create-public.md) DNS zone.
1. Add the `instance_template.network_interface.ipv4_dns_records` section:

   ```hcl
   resource "yandex_kubernetes_node_group" "<node group name>" {
     ...
     instance_template {
       network_interface {
         ipv4_dns_records {
           fqdn        = "<DNS record's FQDN>"
           dns_zone_id = "<DNS zone ID>"
           ttl         = "<DNS record's TTL in seconds>"
           ptr         = "<create a PTR record: true or false>"
         }
       }
     }
   }
   ```

   In a DNS record's FQDN, you can use a template with variables:
   * `{instance_group.id}`: Instance group ID.
   * `{instance.index}`: Unique instance number in the instance group. Possible values: 1 to N, where N is the number of instances in the group.
   * `{instance.index_in_zone}`: Instance number in a zone. It's unique for a specific instance group within the zone.
   * `{instance.short_id}`: Instance ID that is unique within the group. Consists of four letters.
   * `{instance.zone_id}`: Zone ID.