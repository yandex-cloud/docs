---
title: Получить информацию о таблице маршрутизации в {{ vpc-full-name }}
---

# Получить информацию о таблице маршрутизации

{% list tabs %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [таблица маршрутизации](../concepts/routing.md).
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.vpc.switch_route-tables }}**.
  1. Выберите нужную таблицу маршрутизации.
  1. На странице **{{ ui-key.yacloud.common.overview }}** отобразится подробная информация о таблице маршрутизации.

- CLI {#cli}

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды [CLI](../../cli/) для получения информации о [таблице маршрутизации](../concepts/routing.md):

     ```bash
     yc vpc route-table get --help
     ```

  1. Получите информацию о таблице маршрутизации, указав ее имя или идентификатор:

     ```bash
     yc vpc route-table get <имя_таблицы_маршрутизации>
     ```

     Результат:

     ```text
     id: enpmgov0n4ah********
     folder_id: b1go3el0d8fs********
     created_at: "2023-09-20T13:56:58Z"
     name: my-routing
     network_id: enpols3n07b8********
     static_routes:
       - destination_prefix: 0.0.0.0/0
         gateway_id: enpkq1ujbgrs********
     ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы получить информацию о [таблице маршрутизации](../concepts/routing.md) с помощью {{ TF }}:

  1. Добавьте в конфигурационный файл {{ TF }} блоки `data` и `output`:

     ```hcl
     data "yandex_vpc_route_table" "my-rt" {
       route_table_id = "<идентификатор_таблицы_маршрутизации>"
     }

     output "route-table" {
       value = data.yandex_vpc_route_table.my-rt.static_route
     }
     ```

     Где:
     * `data "yandex_vpc_route_table"` — описание таблицы маршрутизации в качестве источника данных:
       * `route_table_id` — идентификатор таблицы маршрутизации.
     * `output "route-table"` — выходная переменная, которая содержит информацию о статических маршрутах таблицы маршрутизации:
       * `value` — возвращаемое значение.

     Вместо `static_route` вы можете выбрать любой другой параметр для получения информации. Более подробно о параметрах источника данных `yandex_vpc_route_table` см. в [документации провайдера]({{ tf-provider-datasources-link }}/vpc_route_table).

  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} создаст все требуемые ресурсы и отобразит значения выходных переменных в терминале. Чтобы проверить результат, выполните команду:

     ```bash
     terraform output
     ```

     Результат:

     ```text
     route-table = toset([
       {
         "destination_prefix" = "0.0.0.0/0"
         "gateway_id" = "enpkq1ujbgrs********"
         "next_hop_address" = ""
       },
     ])
     ```

- API {#api}

  Чтобы получить подробную информацию о [таблице маршрутизации](../concepts/routing.md), воспользуйтесь методом REST API [get](../api-ref/RouteTable/get.md) для ресурса [RouteTable](../api-ref/RouteTable/index.md), или вызовом gRPC API [RouteTableService/Get](../api-ref/grpc/RouteTable/get.md).

{% endlist %}