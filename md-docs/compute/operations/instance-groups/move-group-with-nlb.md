# Перенести группу виртуальных машин с сетевым балансировщиком нагрузки в другую зону доступности


Чтобы перенести [группу ВМ](../../concepts/instance-groups/index.md) c [сетевым балансировщиком нагрузки](../../../network-load-balancer/concepts/index.md) [Yandex Network Load Balancer](../../../network-load-balancer/index.md):
1. [Создайте](../../../vpc/operations/subnet-create.md) [подсеть](../../../vpc/concepts/network.md#subnet) в [зоне доступности](../../../overview/concepts/geo-scope.md), в которую вы хотите перенести группу ВМ.
1. Добавьте ВМ группы в новую зону доступности:

   {% list tabs group=instructions %}
   
   - Консоль управления {#console}
   
     1. В [консоли управления](https://console.yandex.cloud) откройте [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится нужная [группа виртуальных машин](../../concepts/instance-groups/index.md).
     1. Перейдите в сервис **Compute Cloud**.
     1. На панели слева выберите ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **Группы виртуальных машин**.
     1. Выберите группу ВМ, которую хотите изменить.
     1. В правом верхнем углу нажмите ![image](../../../_assets/console-icons/pencil.svg) **Редактировать**.
     1. В блоке **Распределение** добавьте [зону доступности](../../../overview/concepts/geo-scope.md), в которую вы хотите перенести группу ВМ. 
     1. Если у вас группа ВМ с [ручным масштабированием](../../concepts/instance-groups/scale.md#fixed-scale), в блоке **Масштабирование** укажите размер группы, достаточный для размещения во всех выбранных зонах доступности.
   
        Вернуть изначальное количество ВМ можно будет после воссоздания всех ВМ группы в новой зоне доступности и удаления всех ВМ в старой.
     1. Если у вас [автоматически масштабируемая](../../concepts/instance-groups/scale.md#auto-scale) группа ВМ с ручной (`OPPORTUNISTIC`) [стратегией остановки](../../concepts/instance-groups/policies/deploy-policy.md#strategy), в поле **Останавливать машины по стратегии** измените стратегию на автоматическую (`PROACTIVE`).
   
        Вернуть ручную стратегию остановки можно будет после воссоздания всех ВМ группы в новой зоне доступности и удаления всех ВМ в старой.
     1. Нажмите **Сохранить**.
   
   - CLI {#cli}
   
     Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).
   
     По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.
   
     1. Откройте файл со [спецификацией](../../concepts/instance-groups/specification.md) [группы виртуальных машин](../../concepts/instance-groups/index.md) и измените [шаблон ВМ](../../concepts/instance-groups/instance-template.md):
        * В секции `allocation_policy` добавьте новую [зону доступности](../../../overview/concepts/geo-scope.md).
        * В секции `network_interface_specs` добавьте идентификатор [подсети](../../../vpc/concepts/network.md#subnet), созданной ранее.
        * Если у вас группа ВМ с [ручным масштабированием](../../concepts/instance-groups/scale.md#fixed-scale), в секции `scale_policy` укажите размер группы, достаточный для размещения во всех выбранных зонах доступности.
   
          Вернуть изначальное количество ВМ можно будет после воссоздания всех ВМ группы в новой зоне доступности и удаления всех ВМ в старой.
        * Если у вас [автоматически масштабируемая](../../concepts/instance-groups/scale.md#auto-scale) группа ВМ с ручной (`OPPORTUNISTIC`) [стратегией остановки](../../concepts/instance-groups/policies/deploy-policy.md#strategy), в секции `deploy_policy` измените стратегию на автоматическую (`PROACTIVE`).
   
          Вернуть ручную стратегию остановки можно будет после воссоздания всех ВМ группы в новой зоне доступности и удаления всех ВМ в старой.
     1. Посмотрите описание команды CLI для изменения группы ВМ:
   
        ```bash
        yc compute instance-group update --help
        ```
   
     1. Получите список всех групп ВМ в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию:
   
        ```bash
        yc compute instance-group list
        ```
   
        Результат:
   
        ```text
        +----------------------+---------------------------------+--------+--------+
        |          ID          |              NAME               | STATUS |  SIZE  |
        +----------------------+---------------------------------+--------+--------+
        | cl15sjqilrei******** | first-fixed-group-with-balancer | ACTIVE |      3 |
        | cl19s7dmihgm******** | test-group                      | ACTIVE |      2 |
        +----------------------+---------------------------------+--------+--------+
        ```
   
     1. Измените группу ВМ:
   
        ```bash
        yc compute instance-group update \
          --id <идентификатор_группы_ВМ> \
          --file <файл_со_спецификацией_ВМ>
        ```
   
        Где:
        * `--id` — идентификатор группы ВМ.
        * `--file` — путь к файлу со спецификацией группы ВМ.
   
        Результат:
   
        ```text
        id: cl15sjqilrei********
        ...
        allocation_policy:
        zones:
        - zone_id: <старая_зона_доступности>
        - zone_id: <новая_зона_доступности>
        ...
        ```
   
   - Terraform {#tf}
   
     Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
     1. Откройте файл конфигурации Terraform для [группы виртуальных машин](../../concepts/instance-groups/index.md) и добавьте в блоке `allocation_policy` новую [зону доступности](../../../overview/concepts/geo-scope.md), а в блоке `network_interface` идентификатор [подсети](../../../vpc/concepts/network.md#subnet), созданной ранее.
   
        ```hcl
        ...
        network_interface {
          subnet_ids = [
            "<идентификатор_подсети_в_старой_зоне_доступности>",
            "<идентификатор_подсети_в_новой_зоне_доступности>"
          ]
        }
        ...
        allocation_policy {
          zones = [
            "<старая_зона_доступности>",
            "<новая_зона_доступности>"
          ]
        }
        ...
        ```
   
        Где:
        * `zones` — зоны доступности, в которых будет размещена группа ВМ — новая и старая.
        * `subnet_ids` — идентификаторы подсетей в зонах доступности, в которых будет размещена группа ВМ.
   
        Если у вас группа ВМ с [ручным масштабированием](../../concepts/instance-groups/scale.md#fixed-scale), в секции `scale_policy` укажите размер группы, достаточный для размещения во всех выбранных зонах доступности.
   
        ```hcl
        ...
        scale_policy {
          fixed_scale {
            size = <количество_ВМ_в_группе>
          }
        }
        ...
        ```
   
        Вернуть изначальное количество ВМ можно будет после воссоздания всех ВМ группы в новой зоне доступности и удаления всех ВМ в старой.
   
        Если у вас [автоматически масштабируемая](../../concepts/instance-groups/scale.md#auto-scale) группа ВМ с ручной (`OPPORTUNISTIC`) [стратегией остановки](../../concepts/instance-groups/policies/deploy-policy.md#strategy), измените стратегию на автоматическую (`PROACTIVE`):
   
        ```hcl
        ...
        deploy_policy {
          strategy = "proactive" 
        }
        ...
        ```
   
        Вернуть ручную стратегию остановки можно будет после воссоздания всех ВМ группы в новой зоне доступности и удаления всех ВМ в старой.
   
        Более подробную информацию о параметрах ресурсов в Terraform читайте в [документации провайдера](../../../terraform/resources/compute_instance_group.md).
     1. Примените изменения:
   
        1. В терминале перейдите в директорию с конфигурационным файлом.
        1. Проверьте корректность конфигурации с помощью команды:
        
           ```bash
           terraform validate
           ```
        
           Если конфигурация является корректной, появится сообщение:
        
           ```bash
           Success! The configuration is valid.
           ```
        
        1. Выполните команду:
        
           ```bash
           terraform plan
           ```
        
           В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
        1. Примените изменения конфигурации:
        
           ```bash
           terraform apply
           ```
        
        1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.
   
        Добавится новая зона доступности для группы ВМ. Проверить изменения можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../../cli/quickstart.md):
   
        ```bash
        yc compute instance-group get <имя_группы_ВМ>
        ```
   
   - API {#api}
   
     Воспользуйтесь методом REST API [update](../../instancegroup/api-ref/InstanceGroup/update.md) для ресурса [InstanceGroup](../../instancegroup/api-ref/InstanceGroup/index.md) или вызовом gRPC API [InstanceGroupService/Update](../../instancegroup/api-ref/grpc/InstanceGroup/update.md).
   
     Если у вас группа ВМ с [ручным масштабированием](../../concepts/instance-groups/scale.md#fixed-scale), задайте размер группы, достаточный для размещения ВМ во всех выбранных зонах доступности. Вернуть изначальное количество ВМ можно будет после воссоздания всех ВМ группы в новой зоне доступности и удаления всех ВМ в старой.
   
     Если у вас [автоматически масштабируемая](../../concepts/instance-groups/scale.md#auto-scale) группа ВМ с ручной (`OPPORTUNISTIC`) [стратегией остановки](../../concepts/instance-groups/policies/deploy-policy.md#strategy), измените стратегию на автоматическую (`PROACTIVE`). Вернуть ручную стратегию остановки можно будет после воссоздания всех ВМ группы в новой зоне доступности и удаления всех ВМ в старой.
   
   {% endlist %}
   
   Дождитесь пока ВМ создадутся в новой зоне доступности и перейдут в статус `Running Actual`.

1. В зависимости от [типа балансировщика](../../../network-load-balancer/concepts/nlb-types.md), выполните следующие действия:
   * **Внешний балансировщик** (`EXTERNAL`):
     1. Дождитесь пока ресурсы целевой группы в новой зоне доступности пройдут [проверку состояния](../../../network-load-balancer/concepts/health-check.md) и перейдут в статус `HEALTHY`. Смотрите [Проверить состояние целевых ресурсов](../../../network-load-balancer/operations/check-resource-health.md).

        После этого новая зона доступности будет включена в маршрутизацию трафика через балансировщик. Этот процесс может занимать до 2 минут. Смотрите [Сходимость маршрутизации в зоне доступности](../../../network-load-balancer/concepts/specifics.md#nlb-zone-converge).
     1. Удалите ВМ группы из старой зоны доступности:

        {% list tabs group=instructions %}
        
        - Консоль управления {#console}
        
          1. В [консоли управления](https://console.yandex.cloud) откройте [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится нужная [группа виртуальных машин](../../concepts/instance-groups/index.md).
          1. Перейдите в сервис **Compute Cloud**.
          1. На панели слева выберите ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **Группы виртуальных машин**.
          1. Выберите группу ВМ, которую хотите изменить.
          1. В правом верхнем углу нажмите ![image](../../../_assets/console-icons/pencil.svg) **Редактировать**.
          1. В блоке **Распределение** отключите старую [зону доступности](../../../overview/concepts/geo-scope.md).
          1. Нажмите **Сохранить**.
        
        - CLI {#cli}
        
          1. Откройте файл со [спецификацией](../../concepts/instance-groups/specification.md) [группы виртуальных машин](../../concepts/instance-groups/index.md) и измените [шаблон ВМ](../../concepts/instance-groups/instance-template.md):
             * В секции `allocation_policy` удалите старую зону доступности.
             * В секции `network_interface_specs` удалите идентификатор [подсети](../../../vpc/concepts/network.md#subnet) в старой зоне доступности.
          1. Измените группу ВМ:
        
             ```bash
             yc compute instance-group update \
               --id <идентификатор_группы_ВМ> \
               --file <файл_со_спецификацией_ВМ>
             ```
        
             Где:
             * `--id` — идентификатор группы ВМ.
             * `--file` — путь к файлу со спецификацией группы ВМ.
        
             Результат:
        
             ```text
             id: cl15sjqilrei********
             ...
             allocation_policy:
             zones:
             - zone_id: <новая_зона_доступности>
             ...
             ```
        
        - Terraform {#tf}
        
          1. Откройте файл конфигурации Terraform для [группы виртуальных машин](../../concepts/instance-groups/index.md) и удалите в блоке `allocation_policy` старую [зону доступности](../../../overview/concepts/geo-scope.md), а в блоке `network_interface` идентификатор [подсети](../../../vpc/concepts/network.md#subnet) в старой зоне:
        
             ```hcl
             ...
             network_interface {
               subnet_ids = ["<идентификатор_подсети_в_новой_зоне_доступности>"]
             }
             ...
             allocation_policy {
               zones = ["<новая_зона_доступности>"]
             }
             ...
             ```
        
             Где:
             * `zones` — зона доступности, в которую вы хотите переместить группу ВМ. Можно указать несколько зон.
             * `subnet_ids` — идентификатор подсети в той зоне доступности, в которую вы хотите перенести группу ВМ.
        
             Более подробную информацию о параметрах ресурсов в Terraform читайте в [документации провайдера](../../../terraform/resources/compute_instance_group.md).
          1. Примените изменения:
        
             1. В терминале перейдите в директорию с конфигурационным файлом.
             1. Проверьте корректность конфигурации с помощью команды:
             
                ```bash
                terraform validate
                ```
             
                Если конфигурация является корректной, появится сообщение:
             
                ```bash
                Success! The configuration is valid.
                ```
             
             1. Выполните команду:
             
                ```bash
                terraform plan
                ```
             
                В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
             1. Примените изменения конфигурации:
             
                ```bash
                terraform apply
                ```
             
             1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.
        
             ВМ группы будут удалены в старой зоне доступности. Проверить изменения можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../../cli/quickstart.md):
        
             ```bash
             yc compute instance-group get <имя_группы_ВМ>
             ```
        
        - API {#api}
        
          Воспользуйтесь методом REST API [update](../../instancegroup/api-ref/InstanceGroup/update.md) для ресурса [InstanceGroup](../../instancegroup/api-ref/InstanceGroup/index.md) или вызовом gRPC API [InstanceGroupService/Update](../../instancegroup/api-ref/grpc/InstanceGroup/update.md).
        
        {% endlist %}

   * **Внутренний балансировщик** (`INTERNAL`):
     1. Перенесите ресурсы, которым нужен доступ к внутреннему балансировщику, в подсеть, созданную ранее.
     1. Измените [обработчик](../../../network-load-balancer/concepts/listener.md) балансировщика:

        {% list tabs group=instructions %}

        - Консоль управления {#console}

          1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится балансировщик.
          1. Перейдите в сервис **Network Load Balancer**.
          1. Нажмите на имя нужного балансировщика.
          1. В блоке **Обработчики** нажмите ![image](../../../_assets/horizontal-ellipsis.svg) и выберите **Удалить обработчик**.
          1. Справа сверху нажмите ![image](../../../_assets/plus-sign.svg) **Создать обработчик** и [создайте](../../../network-load-balancer/operations/listener-add.md) новый обработчик.

             При создании нового обработчика укажите подсеть в той зоне доступности, в которую вы хотите перенести балансировщик.
          1. Нажмите кнопку **Добавить**.

        - CLI {#cli}

          1. Посмотрите описание команды [CLI](../../../cli/index.md) для удаления обработчика:

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
             | enp2btm6uvdr******** | nlb-34aa5-db1 | ru-central1 | INTERNAL |              0 |                        |  ACTIVE  |
             | enpvg9o73hqh******** | test-balancer | ru-central1 | EXTERNAL |              0 |                        |  ACTIVE  |
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
             region_id: ru-central1
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
             region_id: ru-central1
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

        - Terraform {#tf}

          1. Откройте файл Terraform с конфигурацией балансировщика и в блоке `listener` замените значения полей `name` и `subnet_id`:

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

             Более подробную информацию о параметрах ресурсов в Terraform читайте в [документации провайдера](../../../terraform/resources/lb_network_load_balancer.md).
          1. Примените изменения:

             1. В терминале перейдите в директорию с конфигурационным файлом.
             1. Проверьте корректность конфигурации с помощью команды:
             
                ```bash
                terraform validate
                ```
             
                Если конфигурация является корректной, появится сообщение:
             
                ```bash
                Success! The configuration is valid.
                ```
             
             1. Выполните команду:
             
                ```bash
                terraform plan
                ```
             
                В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
             1. Примените изменения конфигурации:
             
                ```bash
                terraform apply
                ```
             
             1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

             Будет добавлен новый обработчик балансировщика в новой зоне доступности. Проверить создание нового обработчика можно в [консоли управления](https://console.yandex.cloud).

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

        {% list tabs group=instructions %}
        
        - Консоль управления {#console}
        
          1. В [консоли управления](https://console.yandex.cloud) откройте [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится нужная [группа виртуальных машин](../../concepts/instance-groups/index.md).
          1. Перейдите в сервис **Compute Cloud**.
          1. На панели слева выберите ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **Группы виртуальных машин**.
          1. Выберите группу ВМ, которую хотите изменить.
          1. В правом верхнем углу нажмите ![image](../../../_assets/console-icons/pencil.svg) **Редактировать**.
          1. В блоке **Распределение** отключите старую [зону доступности](../../../overview/concepts/geo-scope.md).
          1. Нажмите **Сохранить**.
        
        - CLI {#cli}
        
          1. Откройте файл со [спецификацией](../../concepts/instance-groups/specification.md) [группы виртуальных машин](../../concepts/instance-groups/index.md) и измените [шаблон ВМ](../../concepts/instance-groups/instance-template.md):
             * В секции `allocation_policy` удалите старую зону доступности.
             * В секции `network_interface_specs` удалите идентификатор [подсети](../../../vpc/concepts/network.md#subnet) в старой зоне доступности.
          1. Измените группу ВМ:
        
             ```bash
             yc compute instance-group update \
               --id <идентификатор_группы_ВМ> \
               --file <файл_со_спецификацией_ВМ>
             ```
        
             Где:
             * `--id` — идентификатор группы ВМ.
             * `--file` — путь к файлу со спецификацией группы ВМ.
        
             Результат:
        
             ```text
             id: cl15sjqilrei********
             ...
             allocation_policy:
             zones:
             - zone_id: <новая_зона_доступности>
             ...
             ```
        
        - Terraform {#tf}
        
          1. Откройте файл конфигурации Terraform для [группы виртуальных машин](../../concepts/instance-groups/index.md) и удалите в блоке `allocation_policy` старую [зону доступности](../../../overview/concepts/geo-scope.md), а в блоке `network_interface` идентификатор [подсети](../../../vpc/concepts/network.md#subnet) в старой зоне:
        
             ```hcl
             ...
             network_interface {
               subnet_ids = ["<идентификатор_подсети_в_новой_зоне_доступности>"]
             }
             ...
             allocation_policy {
               zones = ["<новая_зона_доступности>"]
             }
             ...
             ```
        
             Где:
             * `zones` — зона доступности, в которую вы хотите переместить группу ВМ. Можно указать несколько зон.
             * `subnet_ids` — идентификатор подсети в той зоне доступности, в которую вы хотите перенести группу ВМ.
        
             Более подробную информацию о параметрах ресурсов в Terraform читайте в [документации провайдера](../../../terraform/resources/compute_instance_group.md).
          1. Примените изменения:
        
             1. В терминале перейдите в директорию с конфигурационным файлом.
             1. Проверьте корректность конфигурации с помощью команды:
             
                ```bash
                terraform validate
                ```
             
                Если конфигурация является корректной, появится сообщение:
             
                ```bash
                Success! The configuration is valid.
                ```
             
             1. Выполните команду:
             
                ```bash
                terraform plan
                ```
             
                В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
             1. Примените изменения конфигурации:
             
                ```bash
                terraform apply
                ```
             
             1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.
        
             ВМ группы будут удалены в старой зоне доступности. Проверить изменения можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../../cli/quickstart.md):
        
             ```bash
             yc compute instance-group get <имя_группы_ВМ>
             ```
        
        - API {#api}
        
          Воспользуйтесь методом REST API [update](../../instancegroup/api-ref/InstanceGroup/update.md) для ресурса [InstanceGroup](../../instancegroup/api-ref/InstanceGroup/index.md) или вызовом gRPC API [InstanceGroupService/Update](../../instancegroup/api-ref/grpc/InstanceGroup/update.md).
        
        {% endlist %}

     1. Убедитесь, что в подсети в старой зоне доступности не осталось ресурсов.
     1. [Удалите](../../../vpc/operations/subnet-delete.md) подсеть в старой зоне доступности.