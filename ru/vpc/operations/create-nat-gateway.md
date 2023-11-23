---
title: "Как создать и настроить NAT-шлюз в {{ vpc-full-name }}"
description: "Следуя данной инструкции, вы сможете создать и настроить NAT-шлюз." 
---

# Настроить NAT-шлюз

Чтобы создать и настроить NAT-шлюз:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, где требуется создать шлюз.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. На панели слева выберите **{{ ui-key.yacloud.vpc.switch_gateways }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
  1. Задайте имя шлюза. Требования к имени:

      {% include [name-format](../../_includes/name-format.md) %}
   
  1. (Опционально) Добавьте описание шлюза.
  1. По умолчанию выбран тип шлюза `{{ ui-key.yacloud.vpc.gateways.value_gateway-type-egress-nat }}`.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.
  1. На панели слева выберите **{{ ui-key.yacloud.vpc.network.switch_route-table }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**, чтобы создать новую таблицу, или выберите одну из существующих.
  1. Нажмите кнопку **{{ ui-key.yacloud.vpc.route-table-form.label_add-static-route }}**.
  1. В открывшемся окне в поле **{{ ui-key.yacloud.vpc.add-static-route.field_next-hop-address }}** выберите `{{ ui-key.yacloud.vpc.add-static-route.value_gateway }}`.
  1. В поле **{{ ui-key.yacloud.vpc.add-static-route.value_gateway }}** выберите созданный NAT-шлюз. Префикс назначения заполнится автоматически.
  1. Нажмите кнопку **{{ ui-key.yacloud.vpc.add-static-route.button_add }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.vpc.route-table.edit.button_edit }}**. 

  Затем привяжите таблицу маршрутизации к одной из подсетей, чтобы направить трафик из нее через NAT-шлюз:

  1. На панели слева выберите ![image](../../_assets/vpc/subnets.svg) **{{ ui-key.yacloud.vpc.switch_networks }}**.
  1. В строке нужной подсети нажмите кнопку ![image](../../_assets/options.svg).
  1. В открывшемся меню выберите пункт **{{ ui-key.yacloud.vpc.subnetworks.button_action-add-route-table }}**.
  1. В открывшемся окне выберите созданную таблицу в списке.
  1. Нажмите кнопку **{{ ui-key.yacloud.vpc.subnet.add-route-table.button_add }}**.

- CLI

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  1. Посмотрите описание команды CLI для создания шлюза:

      ```bash
      yc vpc gateway create --help
      ```

  1. Создайте шлюз в каталоге по умолчанию:

     ```bash
     yc vpc gateway create \
        --name test-gateway
     ```
  1. Получите идентификатор шлюза:

     ```bash
     yc vpc gateway list
     ```

     Результат выполнения команды:

     ```text
     +----------------------+--------------+-------------+
     |          ID          |     NAME     | DESCRIPTION |
     +----------------------+--------------+-------------+
     | enpkq1v2e7p0cmr7e2s0 | test-gateway |             |
     +----------------------+--------------+-------------+
     ```

  1. Создайте таблицу маршрутизации со шлюзом в качестве next hop и префиксом назначения `0.0.0.0/0`:

     ```bash
     yc vpc route-table create \
        --name=test-route-table \
        --network-name=<имя сети, в которой создается таблица> \
        --route destination=0.0.0.0/0,`
                gateway-id=enpkq1v2e7p0cmr7e2s0
     ```

  1. Привяжите таблицу к подсети:

     ```bash
     yc vpc subnet update <имя подсети> \
        --route-table-name=test-route-table
     ```

- {{ TF }}

  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}
  
  Чтобы создать NAT-шлюз, указать его в качестве next hop в таблице [маршрутизации](../concepts/static-routes.md) и привязать таблицу к подсети используйте следующую конфигурацию:
  
  ```hcl
  data "yandex_vpc_network" "net" {
    folder_id = "<идентификатор каталога>"
    name      = "<имя облачной сети>"
  }

  resource "yandex_vpc_subnet" "subnet" {
    folder_id      = "<имя каталога, в котором находится подсеть>"
    name           = "<имя подсети>"
    v4_cidr_blocks = "10.20.30.0/24"
    zone           = {{ region-id }}-a
    network_id     = data.yandex_vpc_network.net.id
    route_table_id = yandex_vpc_route_table.rt.id
  }

  resource "yandex_vpc_gateway" "nat_gateway" {
    name = "test-gateway"
    shared_egress_gateway {}
  }

  resource "yandex_vpc_route_table" "rt" {
    name       = test-route-table
    network_id = "<идентификатор сети>"

    static_route {
      destination_prefix = "0.0.0.0/0"
      gateway_id         = yandex_vpc_gateway.nat_gateway.id
    }
  }
  ```

- API

  1. Создайте NAT-шлюз. Воспользуйтесь методом REST API [create](../api-ref/Gateway/create.md) для ресурса [Gateway](../api-ref/Gateway/index.md) или вызовом gRPC API [GatewayService/Create](../api-ref/grpc/gateway_service.md#Create) и передайте в запросе:

      * Идентификатор каталога, в котором будет размещен шлюз, в параметре `folderId`.
      * Имя шлюза в параметре `name`. Формат имени:

          {% include [name-format](../../_includes/name-format.md) %}

  1. Привяжите NAT-шлюз к новой таблице маршрутизации. Для этого воспользуйтесь методом REST API [create](../api-ref/RouteTable/create.md) для ресурса [RouteTable](../api-ref/RouteTable/index.md) или вызовом gRPC API [RouteTableService/Create](../api-ref/grpc/route_table_service.md#Create) и передайте в запросе:

      * Идентификатор каталога, в котором будет размещена таблица маршрутизации, в параметре `folderId`.
      * Имя таблицы маршрутизации в параметре `name`. Формат имени:

        {% include [name-format](../../_includes/name-format.md) %}
      * Идентификатор сети, в которой будет размещена таблица маршрутизации, в параметре `networkId`.
      * Значение `0.0.0.0/0` для префикса подсети назначения в параметре `staticRoutes[].destinationPrefix`.
      * Идентификатор NAT-шлюза в параметре `staticRoutes[].gatewayId`.

        {% include [get-nat-gateway](../../_includes/vpc/get-nat-gateway.md) %}

  1. Привяжите таблицу маршрутизации к подсети. Для этого воспользуйтесь методом REST API [update](../api-ref/Subnet/update.md) для ресурса [Subnet](../api-ref/Subnet/index.md) или вызовом gRPC API [SubnetService/Update](../api-ref/grpc/subnet_service.md#Update) и передайте в запросе:

      * Идентификатор подсети в параметре `subnetId`.

        {% include [get-subnet-id](../../_includes/vpc/get-subnet-id.md) %}

        {% include [get-catalog-id](../../_includes/get-catalog-id.md) %}

      * Идентификатор таблицы маршрутизации в параметре `routeTableId`.
      * Имя параметра `routeTableId` в параметре `updateMask`.

      {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}
