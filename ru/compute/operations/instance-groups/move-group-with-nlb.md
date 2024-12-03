---
title: Перенос группы виртуальных машин с сетевым балансировщиком в другую зону доступности
description: Из статьи вы узнаете, как можно перенести группу ВМ {{ compute-full-name }} с сетевым балансировщиком нагрузки из одной зоны доступности в другую.
---

# Перенести группу виртуальных машин с сетевым балансировщиком нагрузки в другую зону доступности


Чтобы перенести [группу ВМ](../../concepts/instance-groups/index.md) c [сетевым балансировщиком нагрузки](../../../network-load-balancer/concepts/index.md) [{{ network-load-balancer-full-name }}](../../../network-load-balancer/):
1. [Создайте](../../../vpc/operations/subnet-create.md) [подсеть](../../../vpc/concepts/network.md#subnet) в [зоне доступности](../../../overview/concepts/geo-scope.md), в которую вы хотите перенести группу ВМ.
1. Добавьте ВМ группы в новую зону доступности:

   {% include [ig-create-in-another-zone](../../../_includes/compute/ig-create-in-another-zone.md) %}

1. В зависимости от [типа балансировщика](../../../network-load-balancer/concepts/nlb-types.md), выполните следующие действия:
   * **Внешний балансировщик** (`EXTERNAL`):
     1. Дождитесь пока ресурсы целевой группы в новой зоне доступности пройдут [проверку состояния](../../../network-load-balancer/concepts/health-check.md) и перейдут в статус `HEALTHY`. См. [{#T}](../../../network-load-balancer/operations/check-resource-health.md).

        После этого новая зона доступности будет включена в маршрутизацию трафика через балансировщик. Этот процесс может занимать до 2 минут. См. [Сходимость маршрутизации в зоне доступности](../../../network-load-balancer/concepts/specifics.md#nlb-zone-converge).
     1. Удалите ВМ группы из старой зоны доступности:

        {% include [ig-delete-in-zone.md](../../../_includes/compute/ig-delete-in-zone.md) %}

   * **Внутренний балансировщик** (`INTERNAL`):
     1. Перенесите ресурсы, которым нужен доступ к внутреннему балансировщику, в подсеть, созданную ранее.
     1. Измените [обработчик](../../../network-load-balancer/concepts/listener.md) балансировщика:

        {% list tabs group=instructions %}

        - Консоль управления {#console}

          1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится балансировщик.
          1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
          1. Нажмите на имя нужного балансировщика.
          1. В блоке **{{ ui-key.yacloud.load-balancer.network-load-balancer.section_listeners }}** нажмите ![image](../../../_assets/horizontal-ellipsis.svg) и выберите **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_delete-listener }}**.
          1. Справа сверху нажмите ![image](../../../_assets/plus-sign.svg) **{{ ui-key.yacloud.load-balancer.network-load-balancer.button_add-listener }}** и [создайте](../../../network-load-balancer/operations/listener-add.md) новый обработчик.

             При создании нового обработчика укажите подсеть в той зоне доступности, в которую вы хотите перенести балансировщик.
          1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.

        - CLI {#cli}

          1. Посмотрите описание команды [CLI](../../../cli/) для удаления обработчика:

             ```bash
             yc load-balancer network-load-balancer remove-listener --help
             ```

          1. Получите список всех сетевых балансировщиков в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию:

             ```bash
             yc load-balancer network-load-balancer list
             ```

             Результат:

             ```text
             +----------------------+---------------+-----------------+----------+----------------+------------------------+----------+
             |          ID          |     NAME      |    REGION ID    |   TYPE   | LISTENER COUNT | ATTACHED TARGET GROUPS |  STATUS  |
             +----------------------+---------------+-----------------+----------+----------------+------------------------+----------+
             | enp2btm6uvdr******** | nlb-34aa5-db1 | {{ region-id }} | INTERNAL |              0 |                        |  ACTIVE  |
             | enpvg9o73hqh******** | test-balancer | {{ region-id }} | EXTERNAL |              0 |                        |  ACTIVE  |
             +----------------------+---------------+-----------------+----------+----------------+------------------------+----------+
             ```

          1. Получите имя обработчика:

             ```bash
             yc load-balancer network-load-balancer get <имя_балансировщика>
             ```

             Результат:

             ```text
             id: enp2btm6uvdr********
             folder_id: b1gmit33ngp3********
             ...
             listeners:
               - name: listener-980ee-af3
                 address: 172.17.0.36
             ```

          1. Удалите обработчик:

             ```bash
             yc load-balancer network-load-balancer remove-listener <имя_балансировщика> \
               --listener-name <имя_обработчика>
             ```

             Где `--listener-name` — имя обработчика, который нужно удалить.

             Результат:

             ```text
             done (1s)
             id: enpvg9o73hqh********
             folder_id: b1gmit33ngp3********
             created_at: "2023-08-09T13:44:57Z"
             name: nlb-34aa5-db1
             region_id: {{ region-id }}
             status: INACTIVE
             type: INTERNAL
             ```

          1. Посмотрите описание команды CLI для добавления обработчика:

             ```bash
             yc load-balancer network-load-balancer add-listener --help
             ```

          1. Добавьте обработчик:

             ```bash
             yc load-balancer network-load-balancer add-listener <имя_балансировщика> \
               --listener name=<имя_обработчика>,`
                          `port=<порт>,`
                          `target-port=<целевой_порт>,`
                          `internal-subnet-id=<идентификатор_подсети>
             ```

             Где:
             * `name` — имя обработчика.
             * `port` — порт, на котором сетевой балансировщик будет принимать входящий трафик.
             * `target-port` — целевой порт, на который балансировщик будет направлять трафик.
             * `internal-subnet-id` — идентификатор подсети в той зоне доступности, в которую вы хотите перенести балансировщик.

             Результат:

             ```text
             done (1s)
             id: enp2btm6uvdr********
             folder_id: b1gmit33ngp3********
             created_at: "2023-08-09T08:37:03Z"
             name: nlb-34aa5-db1
             region_id: {{ region-id }}
             status: ACTIVE
             type: INTERNAL
             listeners:
               - name: new-listener
                 address: 10.0.0.16
                 port: "22"
                 protocol: TCP
                 target_port: "22"
                 subnet_id: e2lgp8o00g06********
                 ip_version: IPV4
             ```

        - {{ TF }} {#tf}

          1. Откройте файл {{ TF }} с конфигурацией балансировщика и в блоке `listener` замените значения полей `name` и `subnet_id`:

             ```hcl
             listener { 
               name = "<новое_имя_обработчика>" 
               port = 80 
               target_port = 81 
               protocol = "tcp" 
               internal_address_spec { 
                 subnet_id = "<идентификатор_подсети_в_целевой_зоне_доступности>" 
                 ip_version = "ipv4" 
               } 
             }
             ```

             Где:
             * `name` — имя обработчика.
             * `port` — порт, на котором сетевой балансировщик будет принимать входящий трафик.
             * `target_port` — целевой порт, на который балансировщик будет направлять трафик. 
             * `subnet_id` — идентификатор подсети в той зоне доступности, в которую вы хотите перенести группу ВМ.

             Более подробную информацию о параметрах ресурсов в {{ TF }} см. в [документации провайдера]({{ tf-provider-resources-link }}/lb_network_load_balancer).
          1. Примените изменения:

             {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

             Будет добавлен новый обработчик балансировщика в новой зоне доступности. Проверить создание нового обработчика можно в [консоли управления]({{ link-console-main }}).

        - API {#api}

          1. Чтобы удалить обработчик сетевого балансировщика, воспользуйтесь методом REST API [removeListener](../../../network-load-balancer/api-ref/NetworkLoadBalancer/removeListener.md) для ресурса [NetworkLoadBalancer](../../../network-load-balancer/api-ref/NetworkLoadBalancer/index.md) или вызовом gRPC API [NetworkLoadBalancerService/RemoveListener](../../../network-load-balancer/api-ref/grpc/NetworkLoadBalancer/removeListener.md) и передайте в запросе:
             * Идентификатор балансировщика в параметре `networkLoadBalancerId`.
             * Имя обработчика в параметре `listenerName`.

             Идентификатор балансировщика можно получить со [списком сетевых балансировщиков в каталоге](../../../network-load-balancer/operations/load-balancer-list.md#list), имя обработчика — с [детальной информацией о сетевом балансировщике](../../../network-load-balancer/operations/load-balancer-list.md#get).
          1. Чтобы добавить обработчик сетевого балансировщика, воспользуйтесь методом API [addListener](../../../network-load-balancer/api-ref/NetworkLoadBalancer/addListener.md) для ресурса [NetworkLoadBalancer](../../../network-load-balancer/api-ref/NetworkLoadBalancer/index.md) или вызовом gRPC API [NetworkLoadBalancerService/AddListener](../../../network-load-balancer/api-ref/grpc/NetworkLoadBalancer/addListener.md) и передайте в запросе:

             ```json
             {
               "listenerSpec": {
                 "name": "<имя_обработчика>",
                 "port": "<входящий_порт>",
                 "targetPort": "<целевой_порт>",
                 "internalAddressSpec": {
                   "subnetId": "<идентификатор_подсети>"
                 }
               }
             }
             ```

             Где:
             * `name` — имя обработчика.
             * `port` — порт, на котором сетевой балансировщик будет принимать входящий трафик.
             * `targetPort` — целевой порт, на который балансировщик будет направлять трафик.
             * `subnetId` — идентификатор подсети в той зоне доступности, в которую вы хотите перенести балансировщик.

        {% endlist %}

        {% note warning %}

        [IP-адрес](../../../vpc/concepts/address.md) обработчика изменится. Укажите новый IP-адрес обработчика в настройках ресурсов, трафик с которых принимается балансировщиком.

        {% endnote %}

     1. Удалите ВМ группы из старой зоны доступности:

        {% include [ig-delete-in-zone.md](../../../_includes/compute/ig-delete-in-zone.md) %}

     1. Убедитесь, что в подсети в старой зоне доступности не осталось ресурсов.
     1. [Удалите](../../../vpc/operations/subnet-delete.md) подсеть в старой зоне доступности.