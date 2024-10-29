1. [Подготовьте облако к работе](#before-begin).
1. [Подготовьте окружение](#prepare).
1. [Создайте группу ВМ с автоматическим масштабированием и сетевым балансировщиком нагрузки](#create-vm-group).
1. [Подключите сетевой балансировщик нагрузки с целевой группой](#connect-balancer).
1. [Проверьте работу группы ВМ и сетевого балансировщика](#check-service).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

{% include [before](../../_includes/compute/before-solution.md) %}

### Необходимые платные ресурсы {#paid-resources}

{% include [paid-resources](../_tutorials_includes/vm-autoscale/paid-resources.md) %}

## Подготовьте окружение {#prepare}

1. Создайте [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) с именем `for-autoscale` и назначьте ему [роль](../../iam/concepts/access-control/roles.md) `editor`:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы хотите создать сервисный аккаунт.
     1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
     1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**. В открывшемся окне:
        * В поле **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_field_name }}** укажите `for-autoscale`.
        * Чтобы назначить сервисному аккаунту роль на текущий каталог, нажмите ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** и выберите роль `editor`.
        * Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

   - CLI {#cli}

     1. Создайте сервисный аккаунт:

        {% include [default-catalogue](../../_includes/default-catalogue.md) %}

        ```bash
        yc iam service-account create --name for-autoscale
        ```

        Результат:

        ```text
        id: ajelabcde12f********
        folder_id: b0g12ga82bcv********
        created_at: "2020-11-30T14:32:18.900092Z"
        name: for-autoscale
        ```

     1. Назначьте роль сервисному аккаунту:

        ```bash
        yc resource-manager folder add-access-binding b1g23ga82bcv******** \
          --role editor \
          --subject serviceAccount:ajelabcde12f********
        ```

   - API {#api}

     Воспользуйтесь методом REST API [create](../../iam/api-ref/ServiceAccount/create.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/Create](../../iam/api-ref/grpc/ServiceAccount/create.md).

   {% endlist %}

1. Создайте [сеть](../../vpc/concepts/network.md#network) с именем `yc-auto-network` и [подсети](../../vpc/concepts/network.md#subnet) в двух зонах доступности:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите создать сеть.
     1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
     1. Нажмите кнопку **{{ ui-key.yacloud.vpc.networks.button_create }}**.
     1. В поле **{{ ui-key.yacloud.vpc.networks.create.field_name }}** задайте имя сети `yc-auto-network`.
     1. В поле **{{ ui-key.yacloud.vpc.networks.create.field_advanced }}** включите опцию **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}**.
     1. Нажмите кнопку **{{ ui-key.yacloud.vpc.networks.create.button_create }}**.

   - CLI {#cli}

     1. Создайте сеть:

        ```bash
        yc vpc network create --name yc-auto-network
        ```

        Результат:

        ```text
        id: enpabce123hd********
        folder_id: b0g12ga82bcv********
        created_at: "2020-11-30T14:57:15Z"
        name: yc-auto-network
        ```

     1. Создайте подсеть в зоне доступности `{{ region-id }}-a`:

        ```bash
        yc vpc subnet create \
          --network-id enpabce123hd******** \
          --range 192.168.1.0/24 \
          --zone {{ region-id }}-a
        ```

        Результат:

        ```text
        id: e1lnabc23r1c********
        folder_id: b0g12ga82bcv********
        created_at: "2020-11-30T16:23:12Z"
        network_id: enpabce123hd********
        zone_id: {{ region-id }}-a
        v4_cidr_blocks:
        - 192.168.1.0/24
        ```

     1. Создайте подсеть в зоне доступности `{{ region-id }}-b`:

        ```bash
        yc vpc subnet create \
          --network-id enpabce123hd******** \
          --range 192.168.2.0/24 \
          --zone {{ region-id }}-b
        ```

        Результат:

        ```text
        id: b1csa2b3clid********
        folder_id: b0g12ga82bcv********
        created_at: "2020-11-30T16:25:02Z"
        network_id: enpabce123hd********
        zone_id: {{ region-id }}-b
        v4_cidr_blocks:
        - 192.168.2.0/24
        ```

   - API {#api}

     1. Создайте сеть.

        Воспользуйтесь методом REST API [create](../../vpc/api-ref/Network/create.md) для ресурса [Network](../../vpc/api-ref/Network/index.md) или вызовом gRPC API [NetworkService/Create](../../vpc/api-ref/grpc/Network/create.md).
     1. Создайте подсети в зонах доступности `{{ region-id }}-a` и `{{ region-id }}-b`.

        Воспользуйтесь методом REST API [create](../../vpc/api-ref/Subnet/create.md) для ресурса [Subnet](../../vpc/api-ref/Subnet/index.md) или вызовом gRPC API [SubnetService/Create](../../vpc/api-ref/grpc/Subnet/create.md).

   {% endlist %}

1. Создайте [группу безопасности](../../vpc/concepts/security-groups.md):

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ vpc-name }}**.
     1. Откройте вкладку **Группы безопасности**.
     1. Создайте группу безопасности для балансировщика:
        1. Нажмите кнопку **Создать группу**.
        1. Укажите **Имя** группы: `sg-autoscale`.
        1. Выберите **Сеть** `yc-auto-network`.
        1. В блоке **Правила** создайте правила по инструкции под таблицей:

           Направление<br>трафика | Описание | Диапазон<br>портов | Протокол | Тип источника /<br>назначения | Источник /<br>назначение
           --- | --- | --- | --- | --- | ---
           Исходящий | any | Весь | Любой | CIDR | 0.0.0.0/0
           Входящий | ext-http | 80 | TCP | CIDR | 0.0.0.0/0
           Входящий | healthchecks | 80 | TCP | Проверки состояния балансировщика | —

           1. Выберите вкладку **Исходящий трафик** или **Входящий трафик**.
           1. Нажмите кнопку **Добавить правило**.
           1. В открывшемся окне в поле **Диапазон портов** укажите один порт или диапазон портов, куда или откуда будет поступать трафик.
           1. В поле **Протокол** укажите нужный протокол или оставьте **Любой**, чтобы разрешить передачу трафика по всем протоколам.
           1. В поле **Назначение** или **Источник** выберите назначение правила:
              * **CIDR** — правило будет применено к диапазону [IP-адресов](../../vpc/concepts/address.md). В поле **CIDR блоки** укажите CIDR и маски подсетей, в которые или из которых будет поступать трафик. Чтобы добавить несколько CIDR, нажимайте кнопку **Добавить CIDR**.
              * **Группа безопасности** — правило будет применено к ВМ из текущей группы или из выбранной группы безопасности.
              * **Проверки состояния балансировщика** — правило, которое позволяет балансировщику проверять состояние ВМ.
           1. Нажмите кнопку **Сохранить**. Таким образом создайте все правила из таблицы.
        1. Нажмите кнопку **Сохранить**.

   {% endlist %}

## Создайте группу ВМ с автоматическим масштабированием и сетевым балансировщиком нагрузки {#create-vm-group}

1. Все ВМ группы создаются из образа [{{ coi }}](../../cos/concepts/index.md). Каждая ВМ содержит [Docker-контейнер](/blog/posts/2022/03/docker-containers) с веб-сервером, который эмулирует нагрузку на сервис.

   {% include [get-latest-coi](../../_includes/container-registry/get-latest-coi.md) %}

1. Сохраните спецификацию группы ВМ с сетевым балансировщиком нагрузки в файл `specification.yaml`:

   ```yaml
   name: auto-group
   service_account_id: <идентификатор_сервисного_аккаунта>
   scale_policy:
     auto_scale:
       min_zone_size: 1
       max_size: 6
       measurement_duration: 60s
       warmup_duration: 120s
       stabilization_duration: 60s
       initial_size: 2
       cpu_utilization_rule:
         utilization_target: 40
   deploy_policy:
     max_unavailable: 1
   allocation_policy:
     zones:
       - zone_id: {{ region-id }}-a
       - zone_id: {{ region-id }}-b
   load_balancer_spec:
     target_group_spec:
       name: auto-group-tg
   instance_template:
     service_account_id: <идентификатор_сервисного_аккаунта>
     platform_id: standard-v3
     resources_spec:
       memory: 2G
       cores: 2
       core_fraction: 100
     metadata:
       docker-container-declaration: |-
         spec:
           containers:
           - image: {{ registry }}/yc/demo/web-app:v1
             securityContext:
               privileged: false
             tty: false
             stdin: false
     boot_disk_spec:
       mode: READ_WRITE
       disk_spec:
         type_id: network-hdd
         size: 30G
         image_id: fd8iv792kira******** # Идентификатор публичного образа {{ coi }}.
     network_interface_specs:
       - network_id: <идентификатор_облачной_сети>
         primary_v4_address_spec: { one_to_one_nat_spec: { ip_version: IPV4 }}
   ```

1. Замените в файле `specification.yaml` значения в угловых скобках на реальные, на основе выполнения предыдущих шагов.
1. Создайте группу ВМ с именем `auto-group` с помощью спецификации `specification.yaml`:

   {% list tabs group=instructions %}

   - CLI {#cli}

     Выполните команду:

     ```bash
     yc compute instance-group create --file=specification.yaml
     ```

     Результат:

     ```text
     done (2m45s)
     id: cl0hmabc1nd2********
     folder_id: b0g12ga82bcv********
     ...
       target_group_id: enpoi5jhfps3********
     ...
         name: auto-group-tg
     service_account_id: ajelabcde12f********
     status: ACTIVE
     ```

   - API {#api}

     Воспользуйтесь методом [CreateFromYaml](../../compute/instancegroup/api-ref/InstanceGroup/createFromYaml.md) для ресурса `InstanceGroup`.

   {% endlist %}

1. Убедитесь, что группа ВМ создана:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создали группу ВМ.
     1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
     1. На панели слева нажмите ![image](../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.switch_groups }}**.
     1. Выберите группу ВМ `auto-group`.

   - CLI {#cli}

     ```bash
     yc compute instance-group list-instances auto-group
     ```

     Результат:

     ```text
     +----------------------+---------------------------+----------------+--------------+------------------------+----------------+
     |     INSTANCE ID      |           NAME            |  EXTERNAL IP   | INTERNAL IP  |         STATUS         | STATUS MESSAGE |
     +----------------------+---------------------------+----------------+--------------+------------------------+----------------+
     | epdab0c1ji2a******** | cl0habce1nd2********-fned | 84.201.163.202 | 192.168.1.34 | RUNNING_ACTUAL [4m26s] |                |
     | ef0uabc1s2fb******** | cl0habce1nd2********-craq | 130.193.56.102 | 192.168.2.19 | RUNNING_ACTUAL [4m14s] |                |
     +----------------------+---------------------------+----------------+--------------+------------------------+----------------+
     ```

   - API {#api}

     Чтобы посмотреть список созданных групп ВМ, воспользуйтесь методом REST API [list](../../compute/instancegroup/api-ref/InstanceGroup/list.md) для ресурса [InstanceGroup](../../compute/instancegroup/api-ref/InstanceGroup/index.md) или вызовом gRPC API [InstanceGroupService/List](../../compute/instancegroup/api-ref/grpc/InstanceGroup/list.md).

   {% endlist %}

## Подключите сетевой балансировщик нагрузки с целевой группой {#connect-balancer}

1. Создайте сетевой балансировщик нагрузки с именем `group-balancer` и подключите его к созданной группе ВМ:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать балансировщик.
     1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
     1. Нажмите кнопку **{{ ui-key.yacloud.load-balancer.network-load-balancer.button_create }}**.
     1. Укажите имя — `group-balancer`.
     1. В поле **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_address-type }}** укажите `{{ ui-key.yacloud.common.label_auto }}`.
     1. В блоке **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.section_listeners }}** нажмите кнопку **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_add-listener }}**. В открывшемся окне укажите:
        * **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-name }}** — `http`.
        * **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-port }}** (на нем балансировщик будет принимать входящий трафик) — `80`.
        * **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-target-port }}** (на него балансировщик будет направлять трафик) — `80`.
        * Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.
     1. В блоке **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.section_target-groups }}** нажмите кнопку **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_add-target-group }}**.
     1. В поле **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_target-group-id }}** выберите группу ВМ `auto-group-tg` и нажмите кнопку **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_edit-health-check }}**. В открывшемся окне укажите:
        * **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-name }}** — `tcp`.
        * **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
        * **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-port }}** — `80`.
        * Нажмите кнопку **{{ ui-key.yacloud.common.apply }}**.
     1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

   - CLI {#cli}

     ```bash
     yc load-balancer network-load-balancer create \
       --listener external-ip-version=ipv4,name=http,port=80,protocol=tcp,target-port=80 \
       --name group-balancer \
       --target-group healthcheck-name=tcp,healthcheck-tcp-port=80,target-group-id=enpoi5jhfps3********
     ```

     Результат:

     ```text
     done (16s)
     id: b0rbabc1m2ed********
     folder_id: b0g12ga82bcv********
     ...
         healthy_threshold: "2"
         tcp_options:
           port: "80"
     ```

   - API {#api}

     1. Создайте балансировщик нагрузки с помощью метода REST API [create](../../network-load-balancer/api-ref/NetworkLoadBalancer/create.md) для ресурса [NetworkLoadBalancer](../../network-load-balancer/api-ref/NetworkLoadBalancer/index.md) или вызова gRPC API [NetworkLoadBalancerService/Create](../../network-load-balancer/api-ref/grpc/NetworkLoadBalancer/create.md).
     1. Добавьте обработчик к балансировщику с помощью метода REST API [addListener](../../network-load-balancer/api-ref/NetworkLoadBalancer/addListener.md) для ресурса `NetworkLoadBalancer` или вызова gRPC API [NetworkLoadBalancerService/AddListener](../../network-load-balancer/api-ref/grpc/NetworkLoadBalancer/addListener.md).
     1. Подключите целевую группу к балансировщику с помощью метода REST API [attachTargetGroup](../../network-load-balancer/api-ref/NetworkLoadBalancer/attachTargetGroup.md) для ресурса `NetworkLoadBalancer` или вызова gRPC API [NetworkLoadBalancerService/AttachTargetGroup](../../network-load-balancer/api-ref/grpc/NetworkLoadBalancer/attachTargetGroup.md).
     1. Подключите балансировщик к группе ВМ с помощью метода REST API [addTargets](../../network-load-balancer/api-ref/TargetGroup/addTargets.md) для ресурса [TargetGroup](../../network-load-balancer/api-ref/TargetGroup/index.md) или вызова gRPC API [TargetGroupService/AddTargets](../../network-load-balancer/api-ref/grpc/TargetGroup/addTargets.md).

   {% endlist %}

1. Убедитесь, что сетевой балансировщик `group-balancer` создан и привязан к группе ВМ:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создали балансировщик.
     1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
     1. Выберите балансировщик `group-balancer`.

   - CLI {#cli}

     ```bash
     yc load-balancer network-load-balancer list
     ```

     Результат:

     ```text
     +----------------------+----------------+-----------------+----------+----------------+------------------------+--------+
     |          ID          |      NAME      |    REGION ID    |   TYPE   | LISTENER COUNT | ATTACHED TARGET GROUPS | STATUS |
     +----------------------+----------------+-----------------+----------+----------------+------------------------+--------+
     | b0rbabc1m2ed******** | group-balancer | {{ region-id }} | EXTERNAL |              1 | b0rdabckribe********   | ACTIVE |
     +----------------------+----------------+-----------------+----------+----------------+------------------------+--------+
     ```

   - API {#api}

     Воспользуйтесь методом REST API [list](../../network-load-balancer/api-ref/NetworkLoadBalancer/list.md) для ресурса [NetworkLoadBalancer](../../network-load-balancer/api-ref/NetworkLoadBalancer/index.md) или вызовом gRPC API [NetworkLoadBalancerService/List](../../network-load-balancer/api-ref/grpc/NetworkLoadBalancer/list.md).

   {% endlist %}

## Проверьте работу группы ВМ и сетевого балансировщика {#check-service}

{% include [check-service](../_tutorials_includes/vm-autoscale/check-service.md) %}

### Проверьте работу автоматического масштабирования {#check-highload}

{% include [check-highload](../_tutorials_includes/vm-autoscale/check-highload.md) %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:
1. [Удалите](../../network-load-balancer/operations/load-balancer-delete.md) сетевой балансировщик.
1. [Удалите](../../compute/operations/instance-groups/delete.md) группу ВМ.
