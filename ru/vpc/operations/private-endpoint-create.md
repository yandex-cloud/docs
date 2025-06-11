---
title: Как создать сервисное подключение в {{ vpc-full-name }}
description: Следуя данной инструкции, вы сможете создать сервисное подключение (Private Endpoint) в {{ vpc-name }}.
---

# Создать сервисное подключение

{% include [vpc-pe-preview](../../_includes/vpc/pe-preview.md) %}


{% include [private-endpoint-create-roles](../../_includes/vpc/private-endpoint-create-roles.md) %}

Чтобы создать [сервисное подключение](../concepts/private-endpoint.md):

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [private-endpoint-create-cli](../../_includes/vpc/private-endpoint-create-cli.md) %}

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле {{ TF }} параметры ресурсов, которые необходимо создать:

     ```hcl
     resource "yandex_vpc_private_endpoint" "my-vpc-endpoint" {
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

     Где:
     * `name` — имя сервисного подключения. Необязательный параметр.
     * `description` — описание сервисного подключения. Необязательный параметр.
     * `network_id` — имя [облачной сети](../../vpc/concepts/network.md#network), в которой будет создано сервисное подключение. Обязательный параметр.
     * `object_storage` — сервисное подключение к {{ objstorage-short-name }}. Другие типы сервисных подключений пока не доступны.
     * `dns_options` — блок с параметрами создания DNS-записей:
         * `private_dns_records_enabled` — параметр для создания дополнительных ресурсных записей в DNS для переопределения публичного FQDN сервиса, к которому создается подключение. Необязательный параметр.

             {% include [private-endpoint-create-dns](../../_includes/vpc/private-endpoint-create-dns.md) %}

     * `endpoint_address` — блок с параметрами внутреннего IP-адреса сервисного подключению:
         * `subnet_id` — идентификатор подсети, из которой будет взят IP-адрес для сервисного подключения. Если подсеть не указана, внутренний IP-адрес будет назначен случайно из диапазона одной из подсетей облачной сети. Необязательный параметр.

        {% note info %}

        Чтобы создать сервисное подключение, в вашей сети должна быть хотя бы одна подсеть.

        {% endnote %}

     Более подробную информацию о параметрах ресурса `yandex_vpc_private_endpoint` см. в [документации провайдера]({{ tf-provider-resources-link }}/vpc_private_endpoint).

  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/):

     ```bash
     yc vpc private-endpoint list
     ```

- API {#api}

  Чтобы создать [сервисное подключение](../concepts/private-endpoint.md), воспользуйтесь методом REST API [create](../privatelink/api-ref/PrivateEndpoint/create.md) для ресурса [PrivateEndpoint](../privatelink/api-ref/PrivateEndpoint/index.md) или вызовом gRPC API [PrivateEndpointService/Create](../privatelink/api-ref/grpc/PrivateEndpoint/create.md).

{% endlist %}

#### См. также {#see-also}

* [{#T}](private-endpoint-get-info.md)
* [{#T}](private-endpoint-delete.md)
