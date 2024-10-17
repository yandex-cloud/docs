---
title: Как получить информацию о NAT-шлюзе в {{ vpc-full-name }}
description: Следуя данной инструкции, вы сможете получить информацию о NAT-шлюзе.
---

# Получить информацию о NAT-шлюзе

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [NAT-шлюз](../concepts/gateways.md).
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/arrows-opposite-to-dots.svg) **{{ ui-key.yacloud.vpc.switch_gateways }}**.
  1. Выберите нужный NAT-шлюз.
  1. На странице **{{ ui-key.yacloud.common.overview }}** отобразится подробная информация о NAT-шлюзе.

- CLI {#cli}

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды [CLI](../../cli/) для получения информации о [NAT-шлюзе](../concepts/gateways.md):

     ```bash
     yc vpc gateway get --help
     ```

  1. Получите информацию о NAT-шлюзе, указав его имя или идентификатор:

     ```bash
     yc vpc gateway get <имя_или_идентификатор_NAT-шлюза>
     ```

     Результат:

     ```text
     id: enpkq1v2e7p0********
     folder_id: b1go79qlt1tp********
     created_at: "2024-04-23T16:34:53Z"
     name: test-gateway
     shared_egress_gateway: {}
     ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы получить информацию о [NAT-шлюзе](../concepts/gateways.md) с помощью {{ TF }}:
  1. Добавьте в конфигурационный файл {{ TF }} блоки `data` и `output`:

     ```hcl
     data "yandex_vpc_gateway" "default" {
       gateway_id = "<идентификатор_NAT-шлюза>"
     }

     output "gateway" {
       value = data.yandex_vpc_gateway.default.created_at
     }
     ```

     Где:
     * `data "yandex_vpc_gateway"` — описание NAT-шлюза в качестве источника данных:
       * `gateway_id` — идентификатор NAT-шлюза.
     * `output "gateway"` — выходная переменная, которая содержит информацию о времени создания NAT-шлюза:
       * `value` — возвращаемое значение.

     Вместо `created_at` вы можете выбрать любой другой параметр для получения информации. Более подробно о параметрах источника данных `yandex_vpc_gateway` см. в [документации провайдера]({{ tf-provider-datasources-link }}/vpc_gateway).
  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} создаст все требуемые ресурсы и отобразит значения выходных переменных в терминале. Чтобы проверить результат, выполните команду:

     ```bash
     terraform output
     ```

     Результат:

     ```text
     gateway = "2024-04-23T16:34:53Z"
     ```

- API {#api}

  Чтобы получить подробную информацию о [NAT-шлюзе](../concepts/gateways.md), воспользуйтесь методом REST API [get](../api-ref/Gateway/get.md) для ресурса [Gateway](../api-ref/Gateway/index.md), или вызовом gRPC API [GatewayService/Get](../api-ref/grpc/Gateway/get.md) и передайте в запросе идентификатор нужного NAT-шлюзa в параметре `gatewayId`.

   {% include [get-nat-gateway](../../_includes/vpc/get-nat-gateway.md) %}

   {% include [get-catalog-id](../../_includes/get-catalog-id.md) %}

{% endlist %}