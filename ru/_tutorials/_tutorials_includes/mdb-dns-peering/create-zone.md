Чтобы получить возможность разрешать [FQDN](../../../vpc/concepts/address.md#fqdn) кластера в [IP-адреса](../../../vpc/concepts/address.md) из других [облачных сетей](../../../vpc/concepts/network.md#network), нужно создать [DNS-зону](../../../dns/concepts/dns-zone.md), которая будет включать в себя необходимые облачные сети.

Создайте внутреннюю DNS-зону `vpc-peering-zone`, которая обеспечит возможность разрешения FQDN кластера из облачных сетей `vm-net` и `cluster-net`:
1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы {{ TF }} с планом инфраструктуры примера.
1. Создайте конфигурационный файл `dns.tf` с описанием DNS-зоны:

   {% cut "dns.tf" %}

   ```hcl
   resource "yandex_dns_zone" "vpc-peering-zone" {
     name             = "vpc-peering-zone"
     zone             = "{{ dns-zone }}."
     public           = false
     private_networks = [yandex_vpc_network.vm-net.id, yandex_vpc_network.cluster-net.id]
   }
   ```

   {% endcut %}

1. Проверьте корректность файлов конфигурации {{ TF }}:

   {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

1. Примените сделанные изменения:

   {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}