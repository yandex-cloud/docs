Чтобы получить возможность разрешать FQDN кластера в IP-адреса из других облачных сетей, нужно создать DNS-зону, которая будет включать в себя необходимые облачные сети.

Создайте внутреннюю зону `vpc-peering-zone`, которая обеспечит возможность разрешения FQDN кластера из облачных сетей `vm-net` и `cluster-net`:

1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы {{ TF }} с планом инфраструктуры примера.
1. Создайте конфигурационный файл `dns.tf` с описанием зоны:

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
