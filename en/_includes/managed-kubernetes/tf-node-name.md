1. Create a [private](../../dns/operations/zone-create-private.md) or [public](../../dns/operations/zone-create-public.md) DNS zone.
1. Add the `instance_template.network_interface.ipv4_dns_records` section:

   ```hcl
   resource "yandex_kubernetes_node_group" "<node_group_name>" {
     ...
     instance_template {
       network_interface {
         ipv4_dns_records {
           fqdn        = "<DNS_record_FQDN>"
           dns_zone_id = "<DNS_zone_ID>"
           ttl         = "<DNS_record_TTL_in_seconds>"
           ptr         = "<create_PTR_record>"
         }
       }
     }
   }
   ```

   Where `ptr` indicates if you need to create a PTR record, `true` or `false`.

   In a DNS record FQDN, you can use a template with variables:
   * `{instance_group.id}`: Instance group ID.
   * `{instance.index}`: Unique instance number in the group that can be any value from 1 to N, where N is the number of instances in the group.
   * `{instance.index_in_zone}`: Instance number in the zone. It is unique for a specific instance group within a zone.
   * `{instance.short_id}`: Instance ID that is unique within the group. It consists of four alphabetic characters.
   * `{instance.zone_id}`: Zone ID.