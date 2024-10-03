---
title: Как получить информацию о подсети в {{ vpc-full-name }}
---

# Получить информацию о подсети

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [подсеть](../concepts/network.md#subnet).
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.vpc.network.overview.section_subnetworks }}**.
  1. Выберите нужную подсеть.
  1. На странице **{{ ui-key.yacloud.common.overview }}** отобразится подробная информация о подсети.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для получения информации о [подсети](../concepts/network.md#subnet):

      ```bash
      yc vpc subnet get --help
      ```

  1. Получите информацию о подсети, указав ее имя или идентификатор:

      ```bash
      yc vpc subnet get <имя_подсети>
      ```

      Результат:

      ```text
      id: 5ubne7r188b7********
      folder_id: f01derqpemb4********
      created_at: "2023-10-25T14:59:49Z"
      name: my-network-{{ region-id }}-a
      description: Auto-created default subnet for zone {{ region-id }}-a in my-network
      network_id: ne7w0rkfj75j********
      zone_id: {{ region-id }}-a
      v4_cidr_blocks:
        - 10.130.0.0/24
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы получить информацию о [подсети](../concepts/network.md#subnet) с помощью {{ TF }}:

  1. Добавьте в конфигурационный файл {{ TF }} блоки `data` и `output`:

     ```hcl
     data "yandex_vpc_subnet" "my_subnet" {
       subnet_id = "<идентификатор_подсети>"
     }

     output "subnet" {
       value = data.yandex_vpc_subnet.my_subnet.zone
     }
     ```

     Где:
     * `data "yandex_vpc_subnet"` — описание подсети в качестве источника данных:
       * `subnet_id` — идентификатор подсети.
     * `output "subnet"` — выходная переменная, которая содержит название зоны доступности подсети:
       * `value` — возвращаемое значение.

     Вместо `zone` вы можете выбрать любой другой параметр для получения информации. Более подробно о параметрах источника данных `yandex_vpc_subnet` см. в [документации провайдера]({{ tf-provider-datasources-link }}/datasource_vpc_subnet).
  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} создаст все требуемые ресурсы и отобразит значения выходных переменных в терминале. Чтобы проверить результат, выполните команду:

     ```bash
     terraform output
     ```

     Результат:

     ```text
     subnet = "ru-central1-a"
     ```

- API {#api}

  Чтобы получить подробную информацию о [подсети](../concepts/network.md#subnet), воспользуйтесь методом REST API [get](../api-ref/Subnet/get) для ресурса [Subnet](../api-ref/Subnet/index.md), или вызовом gRPC API [SubnetService/Get](../api-ref/grpc/subnet_service.md#Get).

{% endlist %}

#### См. также {#see-also}

* [{#T}](network-get-info.md)
