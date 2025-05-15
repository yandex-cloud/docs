---
title: Как получить информацию об сервисном подключении в {{ vpc-full-name }}
description: Следуя данной инструкции, вы сможете получить информацию о сервисном подключении (Private Endpoint) в {{ vpc-name }}.
---

# Получить информацию о сервисном подключении

{% include [vpc-pe-preview](../../_includes/vpc/pe-preview.md) %}



{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  1. Посмотрите описание команды CLI для получения информации о [сервисном подключении](../concepts/private-endpoint.md) (Private Endpoint):

      ```bash
      yc vpc private-endpoint get --help
      ```

  1. Получите информацию о сервисном подключении, указав его имя или идентификатор:

     ```bash
     yc vpc private-endpoint get <идентификатор_сервисного_подключения>
     ```

     Результат:
     ```text
     id: enpd7***************
     folder_id: b1g23***************
     created_at: "2024-08-31T16:23:33.859574Z"
     name: s3-vpc-link
     description: Private Endpoint to the Object Storage
     network_id: enpgi***************
     status: AVAILABLE
     address:
       subnet_id: e2l8b***************
       address: 10.128.0.10
       address_id: e2ldn***************
     dns_options: {}
     object_storage: {}
     ```

- {{ TF }}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы получить информацию о [сервисном подключении](../concepts/private-endpoint.md) с помощью {{ TF }}:

  1. Добавьте в конфигурационный файл Terraform блоки `data` и `output`:

      ```hcl
      data "yandex_vpc_private_endpoint" "my-vpc-data" {
        private_endpoint_id = "<идентификатор_сервисного_подключения>"
      }

      output "endpoint-info-network" {
        value = data.yandex_vpc_private_endpoint.my-vpc-info.network_id
      }
      ```

      Где:

      * `data "yandex_vpc_private_endpoint"` — описание сервисного подключения в качестве источника данных:
         * `resource_id` — идентификатор сервисного подключения.
      * `output "ref_description"` — выходная переменная, которая содержит идентификатор сети (`network_id`) с сервисным подключением:
         * `value` — возвращаемое значение.

     Вместо `network_id` вы можете выбрать любой другой параметр для получения информации. Более подробно о параметрах источника данных `yandex_vpc_private_endpoint` см. в [документации провайдера]({{ tf-provider-datasources-link }}/vpc_private_endpoint).

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} создаст все требуемые ресурсы и отобразит значения выходных переменных в терминале. Чтобы проверить результат, выполните команду:

      ```bash
      terraform output
      ```

      Результат:

      ```text
      endpoint-info-network = "enpt232s2lp6********"
      ```

- API {#api}

  Чтобы получить информацию о [сервисном подключении](../concepts/private-endpoint.md), воспользуйтесь методом REST API [get](../privatelink/api-ref/PrivateEndpoint/get.md) для ресурса [PrivateEndpoint](../privatelink/api-ref/PrivateEndpoint/index.md) или вызовом gRPC API [PrivateEndpointService/Get](../privatelink/api-ref/grpc/PrivateEndpoint/get.md).

{% endlist %}
