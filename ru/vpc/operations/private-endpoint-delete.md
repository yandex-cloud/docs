---
title: Как удалить сервисное подключение в {{ vpc-full-name }}
description: Следуя данной инструкции, вы сможете удалить сервисное подключение (Private Endpoint) в {{ vpc-name }}.
---

# Удалить сервисное подключение

{% include [vpc-pe-preview](../../_includes/vpc/pe-preview.md) %}



{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  1. Посмотрите описание команды CLI для удаления [сервисного подключения](../concepts/private-endpoint.md) (Private Endpoint):

      ```bash
      yc vpc private-endpoint delete --help
      ```

  1. Получите список всех сервисных подключений:

     ```bash
     yc vpc private-endpoint list
     ```

     Результат:
     
     ```text
     +----------------------+-------------+--------------------------------+
     |          ID          |    NAME     |          DESCRIPTION           |
     +----------------------+-------------+--------------------------------+
     | enpd7rq************* | s3-vpc-link | Private Endpoint to the Object |
     |                      |             | Storage                        |
     +----------------------+-------------+--------------------------------+
     ``` 

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужного сервисного подключения.
  1. Удалите сервисное подключение:

     ```bash
     yc vpc private-endpoint delete <идентификатор_подключения>
     ```


- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы удалить [сервисное подключение](../concepts/private-endpoint.md), созданное с помощью {{ TF }}:
  1. Откройте файл конфигураций {{ TF }} и удалите фрагмент с описанием ресурса `yandex_vpc_private_endpoint`:

     ```hcl
     resource "yandex_vpc_private_endpoint" "vpc-endpoint" {
       name        = "<имя_сервисного_подключения>"
       description = "<описание_сервисного_подключения>"
       network_id  = "<идентификатор_облачной_сети>"
       
       # Сервисное подключение к Object Storage
       object_storage {}

       # Создание дополнительных ресурсных DNS-записей 
       dns_options {
         private_dns_records_enabled = <true_или_false>
       }

       endpoint_address {
         subnet_id = "<идентификатор_подсети>"
       }
     }
     ```

  {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  Проверить изменения можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

  ```bash
  yc vpc private-endpoint list
  ```

- API {#api}

  Чтобы удалить [сервисное подключение](../concepts/private-endpoint.md), воспользуйтесь методом REST API [delete](../privatelink/api-ref/PrivateEndpoint/delete.md) для ресурса [PrivateEndpoint](../privatelink/api-ref/PrivateEndpoint/index.md) или вызовом gRPC API [PrivateEndpointService/Delete](../privatelink/api-ref/grpc/PrivateEndpoint/delete.md).



{% endlist %}
