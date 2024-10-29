---
title: Как получить информацию о зоне DNS в {{ dns-full-name }}
---

# Получить информации о зоне DNS

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [зона DNS](../concepts/dns-zone.md).
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/compass.svg) **{{ ui-key.yacloud.dns.label_zones-list }}**.
  1. Выберите нужную зону DNS.
  1. Перейдите на вкладку **{{ ui-key.yacloud.common.overview }}**
  1. На странице **{{ ui-key.yacloud.common.overview }}** отобразится подробная информация о зоне DNS.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы узнать имя или уникальный идентификатор [зоны DNS](../concepts/dns-zone.md), [получите](zone-list.md) список зон в каталоге.

  1. Посмотрите описание команды CLI для получения информации о зоне DNS:

      ```bash
      yc dns zone get --help
      ```

  1. Получите информацию о зоне DNS, указав ее имя или идентификатор:

      ```bash
      yc dns zone get <имя_зоны_DNS>
      ```

      Результат:

      ```text
      id: dns6oh57qm9n********
      folder_id: f01derqpemb4********
      created_at: "2023-11-02T08:34:58.493Z"
      name: example.com.
      zone: example-zone-name
      public_visibility: {}
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы получить информацию о [зоне DNS](../concepts/dns-zone.md) с помощью {{ TF }}:
  1. Добавьте в конфигурационный файл {{ TF }} блоки `data` и `output`:

     ```hcl
     data "yandex_dns_zone" "my_zone" {
       dns_zone_id = "<идентификатор_зоны_DNS>"
     }

     output "public" {
       value = data.yandex_dns_zone.my_zone.public
     }
     ```

     Где:
     * `data "yandex_dns_zone"` — описание зоны DNS в качестве источника данных:
       * `dns_zone_id` — идентификатор зоны DNS.
     * `output "zone"` — выходная переменная, которая содержит информацию о типе зоне DNS:
       * `value` — возвращаемое значение.

     Вместо `public` вы можете выбрать любой другой параметр для получения информации. Более подробно о параметрах источника данных `yandex_dns_zone` см. в [документации провайдера]({{ tf-provider-datasources-link }}/dns_zone).
  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} создаст все требуемые ресурсы и отобразит значения выходных переменных в терминале. Чтобы проверить результат, выполните команду:

     ```bash
     terraform output
     ```

     Результат:

     ```text
     public = false
     ```

- API {#api}

  Чтобы получить подробную информацию о [зоне DNS](../concepts/dns-zone.md), воспользуйтесь методом REST API [get](../api-ref/DnsZone/get.md) для ресурса [DnsZone](../api-ref/DnsZone/index.md), или вызовом gRPC API [DnsZoneService/Get](../api-ref/grpc/DnsZone/get.md).

{% endlist %}
