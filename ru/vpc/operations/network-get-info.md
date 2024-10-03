---
title: "Как получить информацию об облачной сети в {{ vpc-full-name }}"
description: "Следуя данной инструкции, вы сможете получить информацию об облачной сети."
---

# Получить информацию об облачной сети

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [облачная сеть](../concepts/network.md#network).
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/timestamps.svg) **{{ ui-key.yacloud.vpc.switch_list }}**.
  1. Выберите нужную облачную сеть.
  1. На странице **{{ ui-key.yacloud.common.overview }}** отобразится подробная информация о выбранной сети.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для получения информации об [облачной сети](../concepts/network.md#network):

      ```bash
      yc vpc network get --help
      ```

  1. Получите информацию о сети, указав ее имя или идентификатор:

      ```bash
      yc vpc network get <имя_сети>
      ```

      Результат:

      ```text
      id: ne7w0rkfj75j********
      folder_id: f01derqpemb4********
      created_at: "2023-10-25T14:59:46Z"
      name: my-network
      description: Auto-created network
      default_security_group_id: 5ecur17yj09k********
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы получить информацию об [облачной сети](../concepts/network.md#network) с помощью {{ TF }}:
  1. Добавьте в конфигурационный файл {{ TF }} блоки `data` и `output`:

     ```hcl
     data "yandex_vpc_network" "admin" {
       network_id = "<идентификатор_сети>"
     }

     output "network" {
       value = data.yandex_vpc_network.admin.created_at
     }
     ```

     Где:
     * `data "yandex_vpc_network"` — описание облачной сети в качестве источника данных:
       * `network_id` — идентификатор облачной сети.
     * `output "network"` — выходная переменная, которая содержит информацию о временной метке создания сети:
       * `value` — возвращаемое значение.

     Вместо `created_at` вы можете выбрать любой другой параметр для получения информации. Более подробно о параметрах источника данных `yandex_vpc_network` см. в [документации провайдера]({{ tf-provider-datasources-link }}/datasource_vpc_network).
  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} создаст все требуемые ресурсы и отобразит значения выходных переменных в терминале. Чтобы проверить результат, выполните команду:

     ```bash
     terraform output
     ```

     Результат:

     ```text
     network = "2024-04-05T06:42:00Z"
     ```

- API {#api}

  Чтобы получить подробную информацию об [облачной сети](../concepts/network.md#network), воспользуйтесь методом REST API [get](../api-ref/Network/get.md) для ресурса [Network](../api-ref/Network/index.md) или вызовом gRPC API [NetworkService/Get](../api-ref/grpc/network_service.md#Get) и передайте в запросе идентификатор нужной облачной сети в параметре `networkId`.

  {% include [get-network-id](../../_includes/vpc/get-network-id.md) %}

  {% include [get-catalog-id](../../_includes/get-catalog-id.md) %}


{% endlist %}

#### См. также {#see-also}

* [{#T}](subnet-get-info.md)