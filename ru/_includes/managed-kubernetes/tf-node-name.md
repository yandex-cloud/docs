1. Создайте [внутреннюю](../../dns/operations/zone-create-private.md) или [публичную](../../dns/operations/zone-create-public.md) зону DNS.
1. Добавьте блок `instance_template.network_interface.ipv4_dns_records`:

   ```hcl
   resource "yandex_kubernetes_node_group" "<имя группы узлов>" {
     ...
     instance_template {
       network_interface {
         ipv4_dns_records {
           fqdn        = "<FQDN записи DNS>"
           dns_zone_id = "<идентификатор зоны DNS>"
           ttl         = "<TTL записи DNS, в секундах>"
           ptr         = "<создание PTR записи: true или false>"
         }
       }
     }
   }
   ```

   В FQDN записи DNS можно использовать шаблон с переменными:
   * `{instance_group.id}` — идентификатор группы ВМ.
   * `{instance.index}` — уникальный номер ВМ в группе. Возможные значения: от 1 до N, где N — количество ВМ в группе.
   * `{instance.index_in_zone}` — номер ВМ в зоне. Уникален в рамках зоны для конкретной группы ВМ.
   * `{instance.short_id}` — идентификатор ВМ, уникальный в рамках группы. Состоит из четырех букв.
   * `{instance.zone_id}`— идентификатор зоны.