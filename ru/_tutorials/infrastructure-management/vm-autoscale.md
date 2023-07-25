# Работа с группой виртуальных машин с автоматическим масштабированием

В этом руководстве вы развернете [группу ВМ с политикой автоматического масштабирования](../../compute/concepts/instance-groups/scale.md#auto-scale) при превышении допустимой нагрузки.

ВМ будут развернуты в двух зонах доступности, а нагрузка на них будет регулироваться с помощью [сетевого балансировщика нагрузки](../../network-load-balancer/concepts/index.md) {{ network-load-balancer-name }}.

Чтобы создать группу ВМ:

1. [Подготовьте облако к работе](#before-begin).
1. [Подготовьте окружение](#prepare).
1. [Создайте группу ВМ с автоматическим масштабированием и сетевым балансировщиком нагрузки](#create-vm-group).
1. [Подключите сетевой балансировщик нагрузки с целевой группой](#connect-balancer).
1. [Проверьте работу группы ВМ и сетевого балансировщика](#check-service).
1. [Проверьте работу автоматического масштабирования](#check-highload).

Если созданные ресурсы вам больше не нужны, [удалите их](#delete-infrastructure).


Также инфраструктуру для масштабирования группы ВМ можно развернуть через {{ TF }} с помощью [готового файла конфигурации](#terraform).


## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

{% include [before](../../_includes/compute/before-solution.md) %}

## Подготовьте окружение {#prepare}

1. Создайте [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) с именем `for-autoscale` и назначьте ему роль `editor`:

   {% list tabs %}

   - Консоль управления

     1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите создать сервисный аккаунт.
     1. В верхней части экрана перейдите на вкладку **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}**.
     1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
     1. В открывшемся окне:
         * В поле **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_field_name }}** укажите `for-autoscale`.
         * Чтобы назначить сервисному аккаунту [роль](../../iam/concepts/access-control/roles.md) на текущий каталог, нажмите ![image](../../_assets/plus-sign.svg)  **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** и выберите роль `editor`.
         * Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

   - CLI

     1. Создайте сервисный аккаунт:

        {% include [default-catalogue](../../_includes/default-catalogue.md) %}

        ```bash
        yc iam service-account create --name for-autoscale
        ```

        Результат выполнения команды:

        ```bash
        id: ajelabcde12f33nol1v5
        folder_id: b0g12ga82bcv0cdeferg
        created_at: "2020-11-30T14:32:18.900092Z"
        name: for-autoscale
        ```

     1. Назначьте роль сервисному аккаунту:

        ```bash
        yc resource-manager folder add-access-binding b1g23ga82bcv0cdeferg \
          --role editor \
          --subject serviceAccount:ajelabcde12f33nol1v5
        ```

    
    - {{ TF }}

      См. раздел [Как создать инфраструктуру с помощью {{ TF }}](#terraform).


   - API

     Воспользуйтесь методом REST API [create](../../iam/api-ref/ServiceAccount/create.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/Create](../../iam/api-ref/grpc/service_account_service.md#Create).

   {% endlist %}

1. Создайте [сеть](../../vpc/concepts/network.md#network) с именем `yc-auto-network` и [подсети](../../vpc/concepts/network.md#subnet) в двух [зонах доступности](../../overview/concepts/geo-scope.md):

   {% list tabs %}

   - Консоль управления

     1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите создать сеть.
     1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
     1. Нажмите кнопку **{{ ui-key.yacloud.vpc.networks.button_create }}**.
     1. В поле **{{ ui-key.yacloud.vpc.networks.create.field_name }}** задайте имя сети `yc-auto-network`.
     1. В поле **{{ ui-key.yacloud.vpc.networks.create.field_advanced }}** включите опцию **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}**.
     1. Нажмите кнопку **{{ ui-key.yacloud.vpc.networks.create.button_create }}**.

   - CLI

     1. Создайте сеть:

        ```bash
        yc vpc network create --name yc-auto-network
        ```

        Результат выполнения команды:

        ```bash
        id: enpabce123hde4ft1r3t
        folder_id: b0g12ga82bcv0cdeferg
        created_at: "2020-11-30T14:57:15Z"
        name: yc-auto-network
        ```

     1. Создайте подсеть в зоне `{{ region-id }}-a`:

        ```bash
        yc vpc subnet create \
          --network-id enpabce123hde4ft1r3t \
          --range 192.168.1.0/24 \
          --zone {{ region-id }}-a
        ```

        Результат выполнения команды:

        ```bash
        id: e1lnabc23r1c9d0efoje
        folder_id: b0g12ga82bcv0cdeferg
        created_at: "2020-11-30T16:23:12Z"
        network_id: enpabce123hde4ft1r3t
        zone_id: {{ region-id }}-a
        v4_cidr_blocks:
        - 192.168.1.0/24
        ```

     1. Создайте подсеть в зоне `{{ region-id }}-b`:

        ```bash
        yc vpc subnet create \
          --network-id enpabce123hde4ft1r3t \
          --range 192.168.2.0/24 \
          --zone {{ region-id }}-b
        ```

        Результат выполнения команды:

        ```bash
        id: b1csa2b3clideftjb121
        folder_id: b0g12ga82bcv0cdeferg
        created_at: "2020-11-30T16:25:02Z"
        network_id: enpabce123hde4ft1r3t
        zone_id: {{ region-id }}-b
        v4_cidr_blocks:
        - 192.168.2.0/24
        ```

    
    - {{ TF }}

      См. раздел [Как создать инфраструктуру с помощью {{ TF }}](#terraform).


   - API

     1. Создайте сеть:
         Воспользуйтесь методом REST API [create](../../vpc/api-ref/Network/create.md) для ресурса [Network](../../vpc/api-ref/Network/index.md) или вызовом gRPC API [NetworkService/Create](../../vpc/api-ref/grpc/network_service.md#Create).
     1. Создайте подсети в зонах `{{ region-id }}-a` и `{{ region-id }}-b`:
         Воспользуйтесь методом REST API [create](../../vpc/api-ref/Subnet/create.md) для ресурса [Subnet](../../vpc/api-ref/Subnet/index.md) или вызовом gRPC API [SubnetService/Create](../../vpc/api-ref/grpc/subnet_service.md#Create).

   {% endlist %}

1. Создайте группу безопасности:

    {% note info %}

    {% include [security-groups-note](../../_includes/vpc/security-groups-note-services.md) %}

    {% endnote %}

    {% list tabs %}

    - Консоль управления 

      1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ vpc-name }}**.
      1. Откройте вкладку **Группы безопасности**.
      1. Создайте группу безопасности для балансировщика:
        
        1. Нажмите кнопку **Создать группу**.
        1. Укажите **Имя** группы: `sg-autoscale`.
        1. Выберите **Сеть** `yc-auto-network`.
        1. В блоке **Правила** создайте правила по инструкции под таблицей:
          
            | Направление<br/>трафика | Описание | Диапазон<br/>портов | Протокол | Тип источника /<br/>назначения | Источник /<br/>назначение |
            | --- | --- | --- | --- | --- | --- |
            | Исходящий | any | Весь | Любой | CIDR | 0.0.0.0/0 |
            | Входящий | ext-http | 80 | TCP | CIDR | 0.0.0.0/0 |
            | Входящий | healthchecks | 80 | TCP | Проверки состояния балансировщика | — |

            1. Выберите вкладку **Исходящий трафик** или **Входящий трафик**.
            1. Нажмите кнопку **Добавить правило**.
            1. В открывшемся окне в поле **Диапазон портов** укажите один порт или диапазон портов, куда или откуда будет поступать трафик.
            1. В поле **Протокол** укажите нужный протокол или оставьте **Любой**, чтобы разрешить передачу трафика по всем протоколам.
            1. В поле **Назначение** или **Источник** выберите назначение правила:
          
              * **CIDR** — правило будет применено к диапазону IP-адресов. В поле **CIDR блоки** укажите CIDR и маски подсетей, в которые или из которых будет поступать трафик. Чтобы добавить несколько CIDR, нажимайте кнопку **Добавить CIDR**.
              * **Группа безопасности** — правило будет применено к ВМ из текущей группы или из выбранной группы безопасности.
              * **Проверки состояния балансировщика** — правило, которое позволяет балансировщику проверять состояние ВМ.  

            1. Нажмите кнопку **Сохранить**. Таким образом создайте все правила из таблицы.

        1. Нажмите кнопку **Сохранить**.

    
    - {{ TF }}

      См. раздел [Как создать инфраструктуру с помощью {{ TF }}](#terraform).


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
       cooldown_duration: 60s
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
         image_id: fd8iv792kirahcnqnt0q # Идентификатор публичного образа Container Optimized Image.
     network_interface_specs:
       - network_id: <идентификатор_облачной_сети>
         primary_v4_address_spec: { one_to_one_nat_spec: { ip_version: IPV4 }}
   ```

1. Замените в файле `specification.yaml` значения в угловых скобках на реальные, на основе выполнения предыдущих шагов.
1. Создайте группу ВМ с именем `auto-group` с помощью спецификации `specification.yaml`:

   {% list tabs %}

   - CLI

     Выполните команду:

     ```bash
     yc compute instance-group create --file=specification.yaml
     ```

     Результат выполнения команды:

     ```bash
     done (2m45s)
     id: cl0hmabc1nd2hdefgb7k
     folder_id: b0g12ga82bcv0cdeferg
     ...
       target_group_id: enpoi5jhfps37opefgus
     ...
         name: auto-group-tg
     service_account_id: ajelabcde12f33nol1v5
     status: ACTIVE
     ```

    
    - {{ TF }}

      См. раздел [Как создать инфраструктуру с помощью {{ TF }}](#terraform).


   - API

     Воспользуйтесь методом [CreateFromYaml](../../compute/api-ref/InstanceGroup/createFromYaml.md) для ресурса `InstanceGroup`.

   {% endlist %}

1. Убедитесь, что группа ВМ создана:

   {% list tabs %}

   - Консоль управления

     1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создали группу ВМ.
     1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
     1. На панели слева нажмите ![image](../../_assets/compute/vm-group-pic.svg) **{{ ui-key.yacloud.compute.switch_groups }}**.
     1. Выберите группу ВМ `auto-group`.

   - CLI

     ```bash
     yc compute instance-group list-instances auto-group
     ```

     Результат выполнения команды:

     ```bash
     +----------------------+---------------------------+----------------+--------------+------------------------+----------------+
     |     INSTANCE ID      |           NAME            |  EXTERNAL IP   | INTERNAL IP  |         STATUS         | STATUS MESSAGE |
     +----------------------+---------------------------+----------------+--------------+------------------------+----------------+
     | epdab0c1ji2ad4ef8l1s | cl0habce1nd2hqstgd7e-fned | 84.201.163.202 | 192.168.1.34 | RUNNING_ACTUAL [4m26s] |                |
     | ef0uabc1s2fbde6f5tlu | cl0habce1nd2hqstga7b-craq | 130.193.56.102 | 192.168.2.19 | RUNNING_ACTUAL [4m14s] |                |
     +----------------------+---------------------------+----------------+--------------+------------------------+----------------+
     ```

    
    - {{ TF }}

      См. раздел [Как создать инфраструктуру с помощью {{ TF }}](#terraform).


   - API

     Чтобы посмотреть список созданных групп ВМ, воспользуйтесь методом REST API [list](../../compute/api-ref/InstanceGroup/list.md) для ресурса [InstanceGroup](../../compute/api-ref/InstanceGroup/index.md) или вызовом gRPC API [InstanceGroupService/List](../../compute/api-ref/grpc/instance_group_service.md#List).

   {% endlist %}

## Подключите сетевой балансировщик нагрузки с целевой группой {#connect-balancer}

1. Создайте сетевой балансировщик нагрузки с именем `group-balancer` и подключите его к созданной группе ВМ:

   {% list tabs %}

   - Консоль управления

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
        * **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-protocol }}** — `{{ ui-key.yacloud.ylb.health-check.label_tcp }}`.
        * **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-port }}** — `80`.
        * Нажмите кнопку **{{ ui-key.yacloud.common.apply }}**.
     1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

   - CLI

     ```bash
     yc load-balancer network-load-balancer create \
       --listener external-ip-version=ipv4,name=http,port=80,protocol=tcp,target-port=80 \
       --name group-balancer \
       --target-group healthcheck-name=tcp,healthcheck-tcp-port=80,target-group-id=enpoi5jhfps37opefgus
     ```

     Результат выполнения команды:

     ```bash
     done (16s)
     id: b0rbabc1m2edfu2ss579
     folder_id: b0g12ga82bcv0cdeferg
     ...
         healthy_threshold: "2"
         tcp_options:
           port: "80"
     ```

    
    - {{ TF }}

      См. раздел [Как создать инфраструктуру с помощью {{ TF }}](#terraform).


   - API

     1. Создайте балансировщик нагрузки с помощью метода REST API [create](../../network-load-balancer/api-ref/NetworkLoadBalancer/create.md) для ресурса [NetworkLoadBalancer](../../network-load-balancer/api-ref/NetworkLoadBalancer/index.md) или вызова gRPC API [NetworkLoadBalancerService/Create](../../network-load-balancer/api-ref/grpc/network_load_balancer_service.md#Create).
     1. Добавьте обработчик к балансировщику с помощью метода REST API [addListener](../../network-load-balancer/api-ref/NetworkLoadBalancer/addListener.md) для ресурса `NetworkLoadBalancer` или вызова gRPC API [NetworkLoadBalancerService/AddListener](../../network-load-balancer/api-ref/grpc/network_load_balancer_service.md#AddListener).
     1. Подключите целевую группу к балансировщику с помощью метода REST API [attachTargetGroup](../../network-load-balancer/api-ref/NetworkLoadBalancer/attachTargetGroup.md) для ресурса `NetworkLoadBalancer` или вызова gRPC API [NetworkLoadBalancerService/AttachTargetGroup](../../network-load-balancer/api-ref/grpc/network_load_balancer_service.md#AttachTargetGroup).
     1. Подключите балансировщик к группе ВМ с помощью метода REST API [addTargets](../../network-load-balancer/api-ref/TargetGroup/addTargets.md) для ресурса [TargetGroup](../../network-load-balancer/api-ref/TargetGroup/index.md) или вызова gRPC API [TargetGroupService/AddTargets](../../network-load-balancer/api-ref/grpc/target_group_service.md#AddTargets).

   {% endlist %}

1. Убедитесь, что сетевой балансировщик `group-balancer` создан и привязан к группе ВМ:

   {% list tabs %}

   - Консоль управления

     1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создали балансировщик.
     1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
     1. Выберите балансировщик `group-balancer`.

   - CLI

     ```bash
     yc load-balancer network-load-balancer list
     ```

     Результат выполнения команды:
     
     
     ```bash
     +----------------------+----------------+-------------+----------+----------------+------------------------+--------+
     |          ID          |      NAME      |  REGION ID  |   TYPE   | LISTENER COUNT | ATTACHED TARGET GROUPS | STATUS |
     +----------------------+----------------+-------------+----------+----------------+------------------------+--------+
     | b0rbabc1m2edfu2ss579 | group-balancer | {{ region-id }} | EXTERNAL |              1 | b0rdabckribed1fbv2l1   | ACTIVE |
     +----------------------+----------------+-------------+----------+----------------+------------------------+--------+
     ```
     
     

    
    - {{ TF }}

      См. раздел [Как создать инфраструктуру с помощью {{ TF }}](#terraform).


   - API

     Воспользуйтесь методом REST API [list](../../network-load-balancer/api-ref/NetworkLoadBalancer/list.md) для ресурса [NetworkLoadBalancer](../../network-load-balancer/api-ref/NetworkLoadBalancer/index.md) или вызовом gRPC API [NetworkLoadBalancerService/List](../../network-load-balancer/api-ref/grpc/network_load_balancer_service.md#List).

   {% endlist %}

## Проверьте работу группы ВМ и сетевого балансировщика {#check-service}

1. Создайте нагрузку на одну из ВМ.

   Для этого сохраните скрипт с именем `request.sh` в домашнюю директорию. Скрипт через балансировщик `group-balancer` отправит на одну из ВМ запрос, который будет создавать нагрузку в 100% CPU в течение 30 секунд.

   ```bash
   EXTERNAL_IP=$(yc load-balancer network-load-balancer get group-balancer --format=json | jq -r .listeners[0].address)

   curl "http://$EXTERNAL_IP/burn-cpu?time=30000&load=100"
   ```

1. Запустите скрипт:

   {% list tabs %}

   - CLI

     ```bash
     sh request.sh
     ```

     Результат выполнения команды:

     ```bash
     projects/b0g12ga82bcv0cdeferg/zones/{{ region-id }}-b
     ```

   {% endlist %}

1. Посмотрите нагрузку на ВМ:

   {% list tabs %}

   - Консоль управления

     1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создали группу ВМ.
     1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
     1. На панели слева нажмите ![image](../../_assets/compute/vm-group-pic.svg) **{{ ui-key.yacloud.compute.switch_groups }}**.
     1. Выберите группу ВМ `auto-group`.
     1. Перейдите на вкладку **{{ ui-key.yacloud.compute.group.switch_monitoring }}**.
        Балансировщик направил запрос на одну из ВМ группы. В зоне доступности этой ВМ среднее потребление CPU (график **Average CPU utilization in zone**) выше, чем в других.

   {% endlist %}

### Проверьте работу автоматического масштабирования {#check-highload}

Чтобы проверить работу автоматического масштабирования группы ВМ, нужно создать повышенную нагрузку на CPU каждой ВМ. В файле `specification.yaml` в параметре `scale_policy.auto_scale.cpu_utilization_rule.utilization_target` указано значение `40` — целевой уровень нагрузки 40% CPU. Если превысить целевую нагрузку, {{ ig-name }} увеличит количество ВМ в группе.

1. Создайте повышенную нагрузку на группу ВМ.

   Для этого сохраните скрипт с именем `load.sh` в домашнюю директорию. Скрипт в течение 10 минут в 12 потоков отправляет запросы к группе ВМ. При этом у каждой ВМ используется по 20% CPU на каждое ядро, обрабатывающее запрос. Группа ВМ в каждый момент времени будет загружена на 240% CPU. Скрипт специально выполняет несколько параллельных запросов по 20% CPU, а не один в 240% CPU, чтобы запросы равномерно распределялись между ВМ в группе.

   ```bash
   EXTERNAL_IP=$(yc load-balancer network-load-balancer get group-balancer --format=json | jq -r .listeners[0].address)

   wrk -H "Connection: close" -t12 -c12 -d10m "http://$EXTERNAL_IP/burn-cpu?time=5000&load=20"
   ```

1. Запустите скрипт:

   {% list tabs %}

   - CLI

     ```bash
     sh load.sh
     ```

     Результат выполнения команды:

     ```bash
     Running 10m test @ http://130.193.56.111/burn-cpu?time=5000&load=20
       12 threads and 12 connections
       Thread Stats   Avg      Stdev     Max   +/- Stdev
     ...
     Requests/sec: 15.04
     Transfer/sec: 3.20KB
     ```

   {% endlist %}

1. Посмотрите нагрузку:

   {% list tabs %}

   - Консоль управления

     1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создали группу ВМ `auto-group`.
     1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
     1. На панели слева нажмите ![image](../../_assets/compute/vm-group-pic.svg) **{{ ui-key.yacloud.compute.switch_groups }}**.
     1. Выберите группу ВМ `auto-group`.
     1. Перейдите на вкладку **{{ ui-key.yacloud.compute.group.switch_monitoring }}**.
        На графике **Number of instance in zone** отображены изменения количества ВМ в каждой зоне доступности. На графике **Average CPU utilization in zone** — средняя CPU-нагрузка в каждой зоне доступности.
     1. Перейдите на вкладку **{{ ui-key.yacloud.compute.group.switch_logs }}**.
        На странице отображены сообщения о действиях в рамках автоматического масштабирования группы ВМ.

     Суммарная нагрузка в 240% CPU равномерно распределилась между двумя ВМ в двух зонах доступности и превысила целевой уровень нагрузки в 40% CPU. {{ ig-name }} создал по дополнительной ВМ в каждой зоне доступности и в группе стало четыре ВМ. Когда скрипт перестал создавать CPU-нагрузку, {{ ig-name }} автоматически уменьшил количество ВМ в группе до двух.

   {% endlist %}

## Удалите инфраструктуру {#delete-infrastructure}

1. Удалите сетевой балансировщик нагрузки:

   {% list tabs %}

   - Консоль управления

     1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создали балансировщик `group-balancer`.
     1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
     1. В строке балансировщика `group-balancer` нажмите значок ![image](../../_assets/options.svg) и выберите **{{ ui-key.yacloud.common.delete }}**.
     1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.common.delete }}**.

   - CLI

     ```bash
     yc load-balancer network-load-balancer delete group-balancer
     ```

     Результат выполнения команды:

     ```bash
     done (15s)
     ```

   - API

     Воспользуйтесь методом REST API [delete](../../network-load-balancer/api-ref/NetworkLoadBalancer/delete.md) для ресурса [NetworkLoadBalancer](../../network-load-balancer/api-ref/NetworkLoadBalancer/index.md) или вызовом gRPC API [NetworkLoadBalancerService/Delete](../../network-load-balancer/api-ref/grpc/network_load_balancer_service.md#Delete).

   {% endlist %}

1. Удалите группу ВМ:

   {% list tabs %}

   - Консоль управления

     1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создали группу ВМ `auto-group`.
     1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
     1. На панели слева нажмите ![image](../../_assets/compute/vm-group-pic.svg) **{{ ui-key.yacloud.compute.switch_groups }}**.
     1. В строке группы ВМ `auto-group` нажмите значок ![image](../../_assets/options.svg) и выберите **{{ ui-key.yacloud.compute.groups.button_action-delete }}**.
     1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.compute.groups.popup-confirm_button_delete }}**.

   - CLI

     ```bash
     yc compute instance-group delete auto-group
     ```

     Результат выполнения команды:

     ```bash
     done (1m20s)
     ```

   - API

     Воспользуйтесь методом REST API [delete](../../compute/api-ref/InstanceGroup/delete.md) для ресурса [InstanceGroup](../../compute/api-ref/InstanceGroup/index.md) или вызовом gRPC API [InstanceGroupService/Delete](../../compute/api-ref/grpc/instance_group_service.md#Delete).

   {% endlist %}

1. Удалите подсети:

   {% list tabs %}

   - Консоль управления

     1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создали подсети.
     1. Откройте раздел **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
     1. Выберите сеть, в которой находятся нужные подсети.
     1. В строке нужной подсети нажмите значок ![image](../../_assets/options.svg) и выберите **{{ ui-key.yacloud.common.delete }}**.
     1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.common.delete }}**.
     1. Повторите три предыдущих шага, чтобы удалить остальные подсети.

   - CLI

     1. Удалите подсеть в зоне `{{ region-id }}-a`:

        ```bash
        yc vpc subnet delete e1lnabc23r1c9d0efoje
        ```

        Результат выполнения команды:

        ```bash
        done (1s)
        id: e1lnabc23r1c9d0efoje
        folder_id: b0g12ga82bcv0cdeferg
        created_at: "2020-11-30T16:23:12Z"
        network_id: enpabce123hde4ft1r3t
        zone_id: {{ region-id }}-a
        v4_cidr_blocks:
        - 192.168.1.0/24
        ```

     1. Удалите подсеть в зоне `{{ region-id }}-b`:

        ```bash
        yc vpc subnet delete b1csa2b3clideftjb121
        ```

        Результат выполнения команды:

        ```bash
        done (1s)
        id: b1csa2b3clideftjb121
        folder_id: b0g12ga82bcv0cdeferg
        created_at: "2020-11-30T16:25:02Z"
        network_id: enpabce123hde4ft1r3t
        zone_id: {{ region-id }}-b
        v4_cidr_blocks:
        - 192.168.2.0/24
        ```

   - API

     Воспользуйтесь методом REST API [delete](../../vpc/api-ref/Subnet/delete.md) для ресурса [Subnet](../../vpc/api-ref/Subnet/index.md) или вызовом gRPC API [SubnetService/Delete](../../vpc/api-ref/grpc/subnet_service.md#Delete).

   {% endlist %}

1. Удалите сеть:

   {% list tabs %}

   - Консоль управления

     1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создали сеть.
     1. Откройте раздел **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
     1. В строке нужной сети нажмите значок ![image](../../_assets/options.svg) и выберите **{{ ui-key.yacloud.common.delete }}**.
     1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.common.delete }}**.

   - CLI

     ```bash
     yc vpc network delete yc-auto-network
     ```

     Результат выполнения команды:

     ```bash
     id: enpabce123hde4ft1r3t
     folder_id: b0g12ga82bcv0cdeferg
     created_at: "2020-11-30T14:57:15Z"
     name: yc-auto-network
     ```

   - API

     Воспользуйтесь методом REST API [delete](../../vpc/api-ref/Network/delete.md) для ресурса [Network](../../vpc/api-ref/Network/index.md) или вызовом gRPC API [NetworkService/Delete](../../vpc/api-ref/grpc/network_service.md#Delete).

   {% endlist %}

1. Удалите сервисный аккаунт:

   {% list tabs %}

   - Консоль управления

     1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, которому принадлежит сервисный аккаунт.
     1. В верхней части экрана перейдите на вкладку **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}**.
     1. В строке нужного сервисного аккаунта нажмите значок ![image](../../_assets/options.svg)  и выберите **{{ ui-key.yacloud.iam.folder.service-accounts.button_action-delete }}**.
     1. Подтвердите удаление.

   - CLI

     ```bash
     yc iam service-account delete for-autoscale
     ```

     Результат выполнения команды:

     ```bash
     done (2s)
     ```

   - API

     Воспользуйтесь методом REST API [delete](../../iam/api-ref/ServiceAccount/delete.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/Delete](../../iam/api-ref/grpc/service_account_service.md#Delete).

   {% endlist %}


## Как создать инфраструктуру с помощью {{ TF }} {#terraform}

{% include [terraform-definition](../terraform-definition.md) %}

Чтобы настроить масштабирование группы ВМ с помощью {{ TF }}:

1. [Установите {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform) и укажите источник для установки провайдера {{ yandex-cloud }} (раздел [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).

1. Подготовьте файлы с описанием инфраструктуры:
   
    {% list tabs %}
   
    - Готовый архив

      1. Склонируйте репозиторий с конфигурационными файлами:
        
          ```bash
          git clone https://github.com/yandex-cloud-examples/yc-terraform-vm-autoscale.git
          ```

      1. Перейдите в директорию с репозиторием. В ней должны появиться файлы:
          * `vm-autoscale.tf` — конфигурация создаваемой инфраструктуры;
          * `declaration.yaml` — описание Docker-контейнера с веб-сервером, который будет запущен на ВМ для имитации нагрузки на сервис;
          * `config.tpl` — описание параметров пользователя ВМ;
          * `vm-autoscale.auto.tfvars` — пользовательские данные.

          {% include [sg-note-tf](../../_includes/vpc/sg-note-tf.md) %}

    - Создание вручную

      1. Создайте папку для конфигурационных файлов.

      1. Создайте в папке:

          1. Конфигурационный файл `vm-autoscale.tf`:

              {% include [sg-note-tf](../../_includes/vpc/sg-note-tf.md) %}

              {% cut "vm-autoscale.tf" %}

              {% include [vm-autoscale-tf-config](../../_includes/instance-groups/vm-autoscale-tf-config.md) %}

              {% endcut %}

          1. Файл `declaration.yaml` с описанием Docker-контейнера с веб-сервером, который будет запущен на ВМ для имитации нагрузки на сервис:

              {% cut "declaration.yaml" %}

              ```yaml
              spec:
              containers:
              - image: cr.yandex/yc/demo/web-app:v1
                securityContext:
                  privileged: false
                tty: false
                stdin: false
              ```

              {% endcut %}

          1. Файл `config.tpl` с параметрами пользователя ВМ:

              {% cut "config.tpl" %}
           
              ```yaml
              users:
                - name: "${VM_USER}"
                  groups: sudo
                  shell: /bin/bash
                  sudo: ['ALL=(ALL) NOPASSWD:ALL']
                  ssh_authorized_keys:
                    - "${SSH_KEY}"
              ```

              {% endcut %}

          1. Файл с пользовательскими данными `vm-autoscale.auto.tfvars`:

              {% cut "vm-autoscale.auto.tfvars" %}
             
              ```hcl
              folder_id = "<идентификатор_каталога>"
              vm_user   = "<имя_пользователя_ВМ>"
              ssh_key   = "<содержимое_публичного_SSH-ключа>"
              ```

              {% endcut %}

    {% endlist %}

    Более подробную информацию о параметрах используемых ресурсов в {{ TF }} см. в документации провайдера:

    * [yandex_iam_service_account]({{ tf-provider-link }}Resources/iam_service_account)
    * [yandex_resourcemanager_folder_iam_member]({{ tf-provider-link }}Resources/resourcemanager_folder_iam_member)
    * [yandex_vpc_network]({{ tf-provider-link }}Resources/vpc_network)
    * [yandex_vpc_subnet]({{ tf-provider-link }}Resources/vpc_subnet)
    * [yandex_vpc_security_group]({{ tf-provider-link }}Resources/vpc_security_group)
    * [yandex_compute_instance_group]({{ tf-provider-link }}Resources/compute_instance_group)
    * [yandex_lb_network_load_balancer]({{ tf-provider-link }}Resources/lb_network_load_balancer)

1. В файле `vm-autoscale.auto.tfvars` задайте пользовательские параметры:
    * `folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md).
    * `vm_user` — имя пользователя ВМ.
    * `ssh_key` — содержимое файла с открытым SSH-ключом для аутентификации пользователя на ВМ. Подробнее см. [{#T}](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).

1. Создайте ресурсы:

    {% include [terraform-validate-plan-apply](../terraform-validate-plan-apply.md) %}

1. [Проверьте работу группы ВМ и сетевого балансировщика](#check-service).

1. [Проверьте работу автоматического масштабирования](#check-highload).

