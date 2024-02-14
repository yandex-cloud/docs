---
title: "Как создать статический маршрут. {{ vpc-short-name }}"
description: "Статический маршрут по умолчанию (0.0.0.0/0) действует на машины с публичными IP-адресами. Если вам требуется создать NAT-инстанс, создайте его в отдельной подсети. Чтобы создать таблицу маршрутизации и добавить в нее статические маршруты откройте раздел {{ vpc-name }} в каталоге, где требуется создать статический маршрут. Выберите сеть, в которой требуется создать таблицу маршрутизации. Нажмите Создать таблицу маршрутизации."
---

# Создать статический маршрут

{% note info %}

Статический маршрут по умолчанию (`0.0.0.0/0`) действует на машины с публичными IP-адресами. Если вам требуется [создать NAT-инстанс](../../tutorials/routing/nat-instance.md), создайте его в отдельной подсети.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы создать таблицу маршрутизации и добавить в нее [статические маршруты](../concepts/static-routes.md): 
  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, где требуется создать статический маршрут.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.vpc.network.switch_route-table }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
  1. Задайте имя таблицы маршрутизации. Требования к имени:

     {% include [name-format](../../_includes/name-format.md) %}

  1. (Опционально) Добавьте описание таблицы маршрутизации.
  1. Выберите сеть, в которой требуется создать таблицу маршрутизации.
  1. Нажмите кнопку **{{ ui-key.yacloud.vpc.route-table-form.label_add-static-route }}**.
  1. В открывшемся окне введите префикс подсети назначения в нотации CIDR.
  1. Укажите **{{ ui-key.yacloud.vpc.add-static-route.field_next-hop-address }}** — IP-адрес из [разрешенных диапазонов](../concepts/network.md#subnet).
  1. Нажмите кнопку **{{ ui-key.yacloud.vpc.add-static-route.button_add }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.vpc.route-table.create.button_create }}**.

  Чтобы использовать статические маршруты, необходимо привязать таблицу маршрутизации к подсети:

  1. На панели слева выберите ![image](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.vpc.switch_networks }}**.
  1. В строке нужной подсети нажмите кнопку ![image](../../_assets/console-icons/ellipsis.svg).
  1. В открывшемся меню выберите пункт **{{ ui-key.yacloud.vpc.subnetworks.button_action-add-route-table }}**.
  1. В открывшемся окне выберите созданную таблицу в списке.
  1. Нажмите кнопку **{{ ui-key.yacloud.vpc.subnet.add-route-table.button_add }}**.

- CLI {#cli}

  Чтобы создать таблицу маршрутизации и добавить в нее [статические маршруты](../concepts/static-routes.md): 
  1. Посмотрите описание команды CLI для создания таблиц маршрутизации:

     ```
     yc vpc route-table create --help
     ```

  1. Получите идентификаторы облачных сетей в вашем облаке:

     ```
     yc vpc network list
     ```

     Результат:
     ```
     +----------------------+-----------------+
     |          ID          |      NAME       |
     +----------------------+-----------------+
     | enp34hbpj8dq******** | yc-auto-subnet  |
     | enp846vf5fus******** | routes-test     |
     +----------------------+-----------------+
     ```

  1. Создайте таблицу маршрутизации в одной из сетей:

     ```bash
     yc vpc route-table create \
       --name=test-route-table \
       --network-id=enp846vf5fus******** \
       --route destination=0.0.0.0/0,next-hop=192.168.1.5
     ```

     Где:

     * `--name` — имя таблицы маршрутизации.
     * `--network-id` — идентификатор сети, в которой будет создана таблица.
     * `--route` — настройки маршрута, включают два параметра:
        * `destination` — префикс подсети назначения в нотации CIDR.
        * `next-hop` — внутренний IP-адрес [виртуальной машины](../../glossary/vm.md) из [разрешенных диапазонов](../concepts/network.md#subnet), через которую будет направляться трафик.

     Результат:
     ```
     ...done
     id: enpsi6b08q2v********
     folder_id: b1gqs1teo2q2********
     created_at: "2019-06-24T09:57:54Z"
     name: test-route-table
     network_id: enp846vf5fus********
     static_routes:
     - destination_prefix: 0.0.0.0/0
       next_hop_address: 192.168.1.5
     ```

  Чтобы использовать статические маршруты, необходимо привязать таблицу маршрутизации к подсети:

  1. Получите список подсетей в вашем облаке:

     ```
     yc vpc subnet list
     ```

     Результат:
     ```
     +----------------------+------------------+----------------------+----------------+---------------+------------------+
     |          ID          |       NAME       |      NETWORK ID      | ROUTE TABLE ID |     ZONE      |      RANGE       |
     +----------------------+------------------+----------------------+----------------+---------------+------------------+
     | b0cf2b0u7nhl******** | subnet-1         | enp846vf5fus******** |                | {{ region-id }}-a | [192.168.0.0/24] |
     | e2llnffvbakq******** | subnet-2         | enp846vf5fus******** |                | {{ region-id }}-b | [192.168.1.0/24] |
     +----------------------+------------------+----------------------+----------------+---------------+------------------+
     ```

  1. Привяжите таблицу маршрутизации к одной из подсетей:

     ```
     yc vpc subnet update b0cf2b0u7nhl******** --route-table-id enp1sdveovdp********
     ```

     Результат:
     ```
     ..done
     id: b0cf2b0u7nhl********
     folder_id: b1gqs1teo2q2********
     created_at: "2019-03-12T13:27:22Z"
     name: subnet-1
     network_id: enp846vf5fus********
     zone_id: {{ region-id }}-a
     v4_cidr_blocks:
     - 192.168.0.0/24
     route_table_id: enp1sdveovdp********
     ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы создать таблицу маршрутизации и добавить в нее [статические маршруты](../concepts/static-routes.md):

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

     * `name` — имя таблицы маршрутизации. Формат имени:

          {% include [name-format](../../_includes/name-format.md) %}

     * `network_id` — идентификатор сети, в которой будет создана таблица.
     * `static_route` — описание статического маршрута:
        * `destination_prefix` — префикс подсети назначения в нотации CIDR.
        * `next_hop_address` — внутренний IP-адрес виртуальной машины из [разрешенных диапазонов](../concepts/network.md#subnet), через которую будет направляться трафик.

     Пример структуры конфигурационного файла:

     ```hcl
     resource "yandex_vpc_route_table" "lab-rt-a" {
	   name       = "<имя_таблицы_маршрутизации>"
       network_id = "<идентификатор_сети>"
       static_route {
         destination_prefix = "10.2.0.0/16"
         next_hop_address   = "172.16.10.10"
       }
     }
     ```

     Чтобы добавить, изменить или удалить таблицу маршрутизации, используйте ресурс `yandex_vpc_route_table` с указанием на сеть в поле `netword id` (например, `network_id = "${yandex_vpc_network.lab-net.id}"`).

     Более подробную информацию о параметрах ресурса `yandex_vpc_route_table` в {{ TF }} см. в [документации провайдера]({{ tf-provider-resources-link }}/vpc_route_table).

  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет. 

  1. Разверните облачные ресурсы.

     1. Если в конфигурации нет ошибок, выполните команду:

        ```
        terraform apply
        ```

     1. Подтвердите создание ресурсов: введите в терминал слово `yes` и нажмите **Enter**.

        После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

        ```
        yc vpc route-table list
        ```

- API {#api}

  Чтобы создать таблицу маршрутизации и добавить в нее [статические маршруты](../concepts/static-routes.md), воспользуйтесь методом REST API [create](../api-ref/RouteTable/create.md) для ресурса [RouteTable](../api-ref/RouteTable/index.md) или вызовом gRPC API [RouteTableService/Create](../api-ref/grpc/route_table_service.md#Create) и передайте в запросе:

  * Идентификатор каталога, в котором будет размещена таблица маршрутизации, в параметре `folderId`.
  * Имя таблицы маршрутизации в параметре `name`. Формат имени:

     {% include [name-format](../../_includes/name-format.md) %}
  * Идентификатор сети, в которой будет размещена таблица маршрутизации, в параметре `networkId`.
  * Префикс подсети назначения в нотации CIDR в параметре `staticRoutes[].destinationPrefix`.
  * Внутренний IP-адрес виртуальной машины, через которую будет направляться трафик, в параметре `staticRoutes[].nextHopAddress`. IP-адрес должен входить в [разрешенный диапазон](../concepts/network.md#subnet).

  Чтобы использовать статические маршруты, необходимо привязать таблицу маршрутизации к подсети. Воспользуйтесь методом REST API [update](../api-ref/Subnet/update.md) для ресурса [Subnet](../api-ref/Subnet/index.md) или вызовом gRPC API [SubnetService/Update](../api-ref/grpc/subnet_service.md#Update) и передайте в запросе:

  * Идентификатор подсети в параметре `subnetId`.

    {% include [get-subnet-id](../../_includes/vpc/get-subnet-id.md) %}

    {% include [get-catalog-id](../../_includes/get-catalog-id.md) %}

  * Идентификатор таблицы маршрутизации в параметре `routeTableId`.
  * Имя параметра `routeTableId` в параметре `updateMask`.

  {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}
