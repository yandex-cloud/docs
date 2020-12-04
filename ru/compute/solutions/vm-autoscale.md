# Работа с группой виртуальных машин с автоматическим масштабированием

Чтобы создать [группу виртуальных машин с автоматическим масштабированием](../concepts/instance-groups/scale.md#auto-scale) и [сетевым балансировщиком нагрузки](../../load-balancer/concepts/index.md), необходимо выполнить следующие действия.

## Перед началом работы {#before-you-begin}

1. Если у вас еще нет интерфейса командной строки {{ yandex-cloud }}, [установите его](../../cli/quickstart.md#install).

1. Чтобы скрипты из пошагового руководства работали корректно, скачайте и установите утилиту [jq](https://stedolan.github.io/jq/download/).

1. Чтобы проверить работу автоматического масштабирования, установите утилиту [wrk](https://github.com/wg/wrk) для проведения нагрузочного тестирования.

## Подготовьте окружение {#prepare}

1. Создайте [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) с именем `for-autoscale` и назначьте ему роль `editor`:

   {% list tabs %}

   - Консоль управления

     1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите создать сервисный аккаунт.
     1. Выберите вкладку **Сервисные аккаунты**.
     1. Нажмите кнопку **Создать сервисный аккаунт**.
     1. Введите имя `for-autoscale`.
     1. Чтобы назначить сервисному аккаунту [роль](../../iam/concepts/access-control/roles.md) на текущий каталог, нажмите **Добавить роль** и выберите роль `editor`.
     1. Нажмите кнопку **Создать**.

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

   - API

     Воспользуйтесь методом [Сreate](../../iam/api-ref/ServiceAccount/create.md) для ресурса `ServiceAccount`.

   {% endlist %}

1. Создайте [сеть](../../vpc/concepts/network.md#network) с именем `yc-auto-network` и [подсети](../../vpc/concepts/network.md#subnet) в двух [зонах доступности](../../overview/concepts/geo-scope.md):

   {% list tabs %}

   - Консоль управления

     1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите создать сеть.
     1. Выберите сервис **Virtual Private Cloud**.
     1. Нажмите кнопку **Создать сеть**.
     1. Задайте имя сети `yc-auto-network`.
     1. Выберите дополнительную опцию **Создать подсети**.
     1. Нажмите кнопку **Создать сеть**.

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

     1. Создайте подсеть в зоне `ru-central1-b`:

        ```bash
        yc vpc subnet create --network-id enpabce123hde4ft1r3t --range 192.168.1.0/24 --zone ru-central1-b
        ```

        Результат выполнения команды:

        ```bash
        id: e1lnabc23r1c9d0efoje
        folder_id: b0g12ga82bcv0cdeferg
        created_at: "2020-11-30T16:23:12Z"
        network_id: enpabce123hde4ft1r3t
        zone_id: ru-central1-b
        v4_cidr_blocks:
        - 192.168.1.0/24
        ```

     1. Создайте подсеть в зоне `ru-central1-c`:

        ```bash
        yc vpc subnet create --network-id enpabce123hde4ft1r3t --range 192.168.2.0/24 --zone ru-central1-c
        ```

        Результат выполнения команды:

        ```bash
        id: b1csa2b3clideftjb121
        folder_id: b0g12ga82bcv0cdeferg
        created_at: "2020-11-30T16:25:02Z"
        network_id: enpabce123hde4ft1r3t
        zone_id: ru-central1-c
        v4_cidr_blocks:
        - 192.168.2.0/24
        ```

   - API

     1. Создайте сеть с помощью метода [Create](../../vpc/api-ref/Network/create.md) для ресурса `Networks`.

     1. Создать подсети в зонах `ru-central1-b` и `ru-central1-c` с помощью метода [Сreate](../../vpc/api-ref/Subnet/create.md) для ресурса `Subnets`.

   {% endlist %}

## Создайте группу ВМ с автоматическим масштабированием и балансировщиком нагрузки {#create-vm-group}

1. Сохраните спецификацию группы ВМ с сетевым балансировщиком нагрузки в файл `specification.yaml`:

   ```yaml
   name: auto-group
   service_account_id: ajelabcde12f33nol1v5
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
       - zone_id: ru-central1-b
       - zone_id: ru-central1-c
   load_balancer_spec:
     target_group_spec:
       name: auto-group-tg
   instance_template:
     service_account_id: ajelabcde12f33nol1v5
     platform_id: standard-v1
     resources_spec:
       memory: 2G
       cores: 2
       core_fraction: 100
     metadata:
       docker-container-declaration: |-
         spec:
           containers:
           - image: cr.yandex/yc/demo/web-app:v1
             securityContext:
               privileged: false
             tty: false
             stdin: false
     boot_disk_spec:
       mode: READ_WRITE
       disk_spec:
         type_id: network-hdd
         size: 10G
         image_id: fd81a49qficqvt0dthu8
     network_interface_specs:
       - network_id: enpabce123hde4ft1r3t
         primary_v4_address_spec: { one_to_one_nat_spec: { ip_version: IPV4 }}
   ```

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
         name: auto-group-tg
     service_account_id: ajelabcde12f33nol1v5
     status: ACTIVE
     ```

     Все ВМ группы создаются из образа [{{ coi }}](../../cos/concepts/index.md). Каждая ВМ содержит Docker-контейнер с веб-сервером, который эмулирует нагрузку на сервис.

   - API

     Воспользуйтесь методом [СreateFromYaml](../api-ref/InstanceGroup/createFromYaml.md) для ресурса `InstanceGroup`.

   {% endlist %}

1. Убедитесь, что группа ВМ создана:

   {% list tabs %}

   - Консоль управления

     1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создали группу ВМ.
     1. Выберите сервис **Compute Cloud**.
     1. Перейдите в раздел **Группы виртуальных машин**.
     1. Нажмите на имя группы ВМ `auto-group`.

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

   - API

     Посмотрите список созданных групп ВМ с помощью метода [List](../api-ref/InstanceGroup/list.md) для ресурса `InstanceGroup`.

   {% endlist %}

## Подключите балансировщик нагрузки с целевой группой {#connect-balancer}

1. Создайте балансировщик нагрузки с именем `group-balancer` и подключите его к созданной группе ВМ:

   {% list tabs %}

   - Консоль управления

     1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать балансировщик.
     1. Выберите сервис **Load Balancer**.
     1. Нажмите кнопку **Создать балансировщик**.
     1. Задайте **Имя** `group-balancer`.
     1. В поле **Публичный адрес** выберите значение **Автоматически**.
     1. В блоке **Обработчики** нажмите кнопку **Добавить обработчик**:
        * В открывшемся окне введите **Имя обработчика** `http`.
        * В поле **Порт** укажите `80`, на нем балансировщик будет принимать входящий трафик.
        * В поле **Целевой порт** укажите `80`, на него балансировщик будет направлять трафик.
        * Нажмите кнопку **Добавить**.
     1. В блоке **Целевые группы** нажмите кнопку **Добавить целевую группу**.
     1. В поле **Целевая группа** выберите группу ВМ `auto-group` и нажмите кнопку **Настроить**:
        * В открывшемся окне **Настройка проверки состояния** введите **Имя** `tcp`.
        * Выберите **Тип** **TCP**.
        * В поле **Порт** укажите `80`.
        * Нажмите кнопку **Применить**.
     1. Нажмите кнопку **Создать**.

   - CLI

     ```bash
     yc load-balancer network-load-balancer create \
       --listener external-ip-version=ipv4,name=http,port=80,protocol=tcp,target-port=80 \
       --name group-balancer \
       --target-group healthcheck-name=tcp,healthcheck-tcp-port=80,target-group-id=cl0hmabc1nd2hdefgb7k
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

   - API

     1. Создайте сетевой балансировщик нагрузки с помощью метода [Create](../../load-balancer/api-ref/NetworkLoadBalancer/create.md) для ресурса `NetworkLoadBalancers`.

     1. Добавьте обработчик к балансировщику с помощью метода [AddListener](../../load-balancer/api-ref/NetworkLoadBalancer/addListener.md) для ресурса `NetworkLoadBalancers`.

     1. Подключите целевую группу к балансировщику с помощью метода [AttachTargetGroup](../../load-balancer/api-ref/NetworkLoadBalancer/attachTargetGroup.md) для ресурса `NetworkLoadBalancers`.

     1. Подключите балансировщик к группе ВМ с помощью метода [AddTargets](../../load-balancer/api-ref/TargetGroup/addTargets.md) для ресурса `TargetGroups`.

   {% endlist %}

1. Убедитесь, что балансировщик `group-balancer` создан и привязан к группе ВМ:

   {% list tabs %}

   - Консоль управления

     1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создали балансировщик.
     1. Выберите сервис **Load Balancer**.
     1. Нажмите на имя балансировщика `group-balancer`.

   - CLI

     ```bash
     yc load-balancer network-load-balancer list
     ```

     Результат выполнения команды:

     ```bash
     +----------------------+----------------+-------------+----------+----------------+------------------------+--------+
     |          ID          |      NAME      |  REGION ID  |   TYPE   | LISTENER COUNT | ATTACHED TARGET GROUPS | STATUS |
     +----------------------+----------------+-------------+----------+----------------+------------------------+--------+
     | b0rbabc1m2edfu2ss579 | group-balancer | ru-central1 | EXTERNAL |              1 | b0rdabckribed1fbv2l1   | ACTIVE |
     +----------------------+----------------+-------------+----------+----------------+------------------------+--------+
     ```

   - API

     Воспользуйтесь методом [List](../../load-balancer/api-ref/NetworkLoadBalancer/list.md) для ресурса `NetworkLoadBalancer`.

   {% endlist %}

## Проверьте работу группы ВМ и балансировщика {#check-service}

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
     projects/b0g12ga82bcv0cdeferg/zones/ru-central1-b
     ```

   {% endlist %}

1. Посмотрите нагрузку на ВМ:

   {% list tabs %}

   - Консоль управления

     1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создали группу ВМ.
     1. Выберите сервис **Сompute Cloud**.
     1. Перейдите в раздел **Группы виртуальных машин**.
     1. Нажмите на имя группы ВМ `auto-group`.
     1. Выберите вкладку **Мониторинг**.
        Балансировщик направил запрос на одну из ВМ группы. В зоне доступности этой ВМ среднее потребление CPU (график **Average CPU utilization in zone**) выше, чем в других.

   {% endlist %}

### Проверьте работу автоматического масштабирования {#check-highload}

Чтобы проверить работу автоматического масштабирования группы ВМ, нужно создать повышенную нагрузку на CPU каждой ВМ. В файле `specification.yaml` в параметре `scale_policy.auto_scale.cpu_utilization_rule.utilization_target` указано значение `40` — целевой уровень нагрузки 40% CPU. Если превысить целевую нагрузку, {{ ig-name }} увеличит количество ВМ в группе.

1. Создайте повышенную нагрузку на группу ВМ.

   Для этого сохраните скрипт с именем `load.sh` в домашнюю директорию. Скрипт в течение 10 минут в 12 потоков отправляет запросы, которые используют 20% CPU каждой ВМ. Группа ВМ в каждый момент времени будет загружена на 240% CPU. Скрипт специально выполняет несколько параллельных запросов по 20% CPU, а не один в 240% CPU, чтобы запросы равномерно распределялись между ВМ в группе.

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
     1. Выберите сервис **Сompute Cloud**.
     1. Перейдите в раздел **Группы виртуальных машин**.
     1. Нажмите на название группы ВМ `auto-group`.
     1. Выберите вкладку **Мониторинг**.
        На графике **Number of instance in zone** отображены изменения количества ВМ в каждой зоне доступности. На графике **Average CPU utilization in zone** — средняя CPU-нагрузка в каждой зоне доступности.
     1. Перейдите на вкладку **Логи**.
        На странице отображены сообщения о действиях в рамках автоматического масштабирования группы ВМ.

     Суммарная нагрузка в 240% CPU равномерно распределилась между двумя ВМ в двух зонах доступности и превысила целевой уровень нагрузки в 40% CPU. {{ ig-name }} создал по дополнительной ВМ в каждой зоне доступности и в группе стало четыре ВМ. Когда скрипт перестал создавать CPU-нагрузку, {{ ig-name }} автоматически уменьшил количество ВМ в группе до двух.

   {% endlist %}

## Удалите инфраструктуру {#delete-infrastructure}

1. Удалите балансировщик нагрузки:

   {% list tabs %}

   - Консоль управления

     1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создали балансировщик `group-balancer`.
     1. Выберите сервис **Load Balancer**.
     1. Нажмите значок ![image](../../_assets/vertical-ellipsis.svg) в строке балансировщика `group-balancer`.
     1. В открывшемся меню нажмите кнопку **Удалить**.
     1. В открывшемся окне **Удаление балансировщика** нажмите кнопку **Удалить**.

   - CLI

     ```bash
     yc load-balancer network-load-balancer delete group-balancer
     ```

     Результат выполнения команды:

     ```bash
     done (15s)
     ```

   - API

     Воспользуйтесь методом [Delete](../../load-balancer/api-ref/NetworkLoadBalancer/delete.md) для ресурса `NetworkLoadBalancer`.

   {% endlist %}

1. Удалите группу ВМ:

   {% list tabs %}

   - Консоль управления

     1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создали группу ВМ `auto-group`.
     1. Выберите сервис **Compute Cloud**.
     1. Перейдите в раздел **Группы виртуальных машин**.
     1. Нажмите значок ![image](../../_assets/vertical-ellipsis.svg) для группы ВМ `auto-group`.
     1. В открывшемся меню нажмите кнопку **Удалить**.
     1. В открывшемся окне **Удаление группы виртуальных машин** нажмите кнопку **Удалить**.

   - CLI

     ```bash
     yc compute instance-group delete auto-group
     ```

     Результат выполнения команды:

     ```bash
     done (1m20s)
     ```

   - API

     Воспользуйтесь методом [Delete](../api-ref/InstanceGroup/delete.md) для ресурса `InstanceGroup`.

   {% endlist %}