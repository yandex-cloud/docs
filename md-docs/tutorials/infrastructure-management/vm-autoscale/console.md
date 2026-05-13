# Работа с группой виртуальных машин с автоматическим масштабированием с помощью консоли управления, CLI и API


Чтобы настроить [группу ВМ с политикой автоматического масштабирования](index.md):

1. [Подготовьте облако к работе](#before-begin).
1. [Подготовьте окружение](#prepare).
1. [Создайте группу ВМ с автоматическим масштабированием и сетевым балансировщиком нагрузки](#create-vm-group).
1. [Подключите сетевой балансировщик нагрузки с целевой группой](#connect-balancer).
1. [Проверьте работу группы ВМ и сетевого балансировщика](#check-service).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md) и [привяжите](../../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../../resource-manager/concepts/resources-hierarchy.md).

1. Если у вас еще нет интерфейса командной строки Yandex Cloud, [установите его](../../../cli/quickstart.md#install).

1. Чтобы скрипты из пошагового руководства работали корректно, скачайте и установите утилиту [jq](https://stedolan.github.io/jq/download/).

1. Чтобы проверить работу автоматического масштабирования, установите утилиту [wrk](https://github.com/wg/wrk) для проведения нагрузочного тестирования.

### Необходимые платные ресурсы {#paid-resources}

В стоимость инфраструктуры входят:
* плата за постоянно запущенные [ВМ](../../../compute/concepts/vm.md) (см. [тарифы Compute Cloud](../../../compute/pricing.md));
* плата за [сетевые балансировщики](../../../network-load-balancer/concepts/index.md) и балансировку трафика (см. [тарифы Network Load Balancer](../../../network-load-balancer/pricing.md)).

## Подготовьте окружение {#prepare}

1. Создайте [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) с именем `for-autoscale`. Чтобы иметь возможность создавать, обновлять и удалять ВМ в группе, а также интегрировать группу с сетевым балансировщиком Network Load Balancer, назначьте сервисному аккаунту роли [compute.editor](../../../compute/security/index.md#compute-editor) и [load-balancer.editor](../../../network-load-balancer/security/index.md#load-balancer-editor):

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы хотите создать сервисный аккаунт.
     1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Identity and Access Management**.
     1. Нажмите кнопку **Создать сервисный аккаунт**. В открывшемся окне:
        * В поле **Имя** укажите `for-autoscale`.
        * Чтобы назначить сервисному аккаунту роль на текущий каталог, нажмите ![image](../../../_assets/console-icons/plus.svg) **Добавить роль** и выберите роли `compute.editor` и `load-balancer.editor`.
        * Нажмите кнопку **Создать**.

   - CLI {#cli}

     1. Создайте сервисный аккаунт:

        По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

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

     1. Назначьте роль `compute.editor` сервисному аккаунту:

        ```bash
        yc resource-manager folder add-access-binding <идентификатор_каталога> \
          --role compute.editor \
          --subject serviceAccount:<идентификатор_сервисного_аккаунта>
        ```

     1. Назначьте роль `load-balancer.editor` сервисному аккаунту:

        ```bash
        yc resource-manager folder add-access-binding <идентификатор_каталога> \
          --role load-balancer.editor \
          --subject serviceAccount:<идентификатор_сервисного_аккаунта>
        ```

   - API {#api}

     Воспользуйтесь методом REST API [create](../../../iam/api-ref/ServiceAccount/create.md) для ресурса [ServiceAccount](../../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/Create](../../../iam/api-ref/grpc/ServiceAccount/create.md).

   {% endlist %}

1. Создайте [сеть](../../../vpc/concepts/network.md#network) с именем `yc-auto-network` и [подсети](../../../vpc/concepts/network.md#subnet) в двух зонах доступности:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы хотите создать сеть.
     1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Virtual Private Cloud**.
     1. Нажмите кнопку **Создать сеть**.
     1. В поле **Имя** задайте имя сети `yc-auto-network`.
     1. В поле **Дополнительно** включите опцию **Создать подсети**.
     1. Нажмите кнопку **Создать сеть**.

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

     1. Создайте подсеть в зоне доступности `ru-central1-a`:

        ```bash
        yc vpc subnet create \
          --network-id enpabce123hd******** \
          --range 192.168.1.0/24 \
          --zone ru-central1-a
        ```

        Результат:

        ```text
        id: e1lnabc23r1c********
        folder_id: b0g12ga82bcv********
        created_at: "2020-11-30T16:23:12Z"
        network_id: enpabce123hd********
        zone_id: ru-central1-a
        v4_cidr_blocks:
        - 192.168.1.0/24
        ```

     1. Создайте подсеть в зоне доступности `ru-central1-b`:

        ```bash
        yc vpc subnet create \
          --network-id enpabce123hd******** \
          --range 192.168.2.0/24 \
          --zone ru-central1-b
        ```

        Результат:

        ```text
        id: b1csa2b3clid********
        folder_id: b0g12ga82bcv********
        created_at: "2020-11-30T16:25:02Z"
        network_id: enpabce123hd********
        zone_id: ru-central1-b
        v4_cidr_blocks:
        - 192.168.2.0/24
        ```

   - API {#api}

     1. Создайте сеть.

        Воспользуйтесь методом REST API [create](../../../vpc/api-ref/Network/create.md) для ресурса [Network](../../../vpc/api-ref/Network/index.md) или вызовом gRPC API [NetworkService/Create](../../../vpc/api-ref/grpc/Network/create.md).
     1. Создайте подсети в зонах доступности `ru-central1-a` и `ru-central1-b`.

        Воспользуйтесь методом REST API [create](../../../vpc/api-ref/Subnet/create.md) для ресурса [Subnet](../../../vpc/api-ref/Subnet/index.md) или вызовом gRPC API [SubnetService/Create](../../../vpc/api-ref/grpc/Subnet/create.md).

   {% endlist %}

1. Создайте [группу безопасности](../../../vpc/concepts/security-groups.md):

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. Откройте [консоль управления](https://console.yandex.cloud).
     1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Virtual Private Cloud**.
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
              * **CIDR** — правило будет применено к диапазону [IP-адресов](../../../vpc/concepts/address.md). В поле **CIDR блоки** укажите CIDR и маски подсетей, в которые или из которых будет поступать трафик. Чтобы добавить несколько CIDR, нажимайте кнопку **Добавить CIDR**.
              * **Группа безопасности** — правило будет применено к ВМ из текущей группы или из выбранной группы безопасности.
              * **Проверки состояния балансировщика** — правило, которое позволяет балансировщику проверять состояние ВМ.
           1. Нажмите кнопку **Сохранить**. Таким образом создайте все правила из таблицы.
        1. Нажмите кнопку **Сохранить**.

   {% endlist %}

## Создайте группу ВМ с автоматическим масштабированием и сетевым балансировщиком нагрузки {#create-vm-group}

1. Все ВМ группы создаются из образа [Container Optimized Image](../../../cos/concepts/index.md). Каждая ВМ содержит [Docker-контейнер](https://yandex.cloud/ru/blog/posts/2022/03/docker-containers) с веб-сервером, который эмулирует нагрузку на сервис.

   Узнайте идентификатор последней версии [публичного образа](../../../compute/operations/images-with-pre-installed-software/get-list.md) Container Optimized Image.
   
   Образ Container Optimized Image в реестре [Container Registry](../../../container-registry/index.md) может обновляться и меняться в соответствии с релизами. При этом образ на [виртуальной машине](../../../compute/concepts/vm.md) не обновится автоматически до последней версии. Чтобы создать [группу ВМ](../../../compute/concepts/instance-groups/index.md) с последней версией Container Optimized Image, необходимо самостоятельно проверить ее наличие:
   
   {% list tabs group=instructions %}
   
   - CLI {#cli}
   
     ```bash
     yc compute image get-latest-from-family container-optimized-image --folder-id standard-images
     ```
   
     Результат:
     
     ```bash
     id: <идентификатор_последней_версии_COI>
     folder_id: standard-images
     ...
     ```
   
   - Yandex Cloud Marketplace {#marketplace}
   
     1. Перейдите на страницу Cloud Marketplace и выберите образ с нужной конфигурацией:
        * [Container Optimized Image](https://yandex.cloud/ru/marketplace/products/yc/container-optimized-image).
        * [Container Optimized Image GPU](https://yandex.cloud/ru/marketplace/products/yc/container-optimized-image-gpu).
     1. В блоке **Идентификаторы продукта** скопируйте значение `image_id`.
   
   {% endlist %}

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
       - zone_id: ru-central1-a
       - zone_id: ru-central1-b
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
           - image: cr.yandex/yc/demo/web-app:v1
             securityContext:
               privileged: false
             tty: false
             stdin: false
     boot_disk_spec:
       mode: READ_WRITE
       disk_spec:
         type_id: network-hdd
         size: 30G
         image_id: fd8iv792kira******** # Идентификатор публичного образа Container Optimized Image.
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

     Воспользуйтесь методом [CreateFromYaml](../../../compute/instancegroup/api-ref/InstanceGroup/createFromYaml.md) для ресурса `InstanceGroup`.

   {% endlist %}

1. Убедитесь, что группа ВМ создана:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы создали группу ВМ.
     1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Compute Cloud**.
     1. На панели слева нажмите ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **Группы виртуальных машин**.
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

     Чтобы посмотреть список созданных групп ВМ, воспользуйтесь методом REST API [list](../../../compute/instancegroup/api-ref/InstanceGroup/list.md) для ресурса [InstanceGroup](../../../compute/instancegroup/api-ref/InstanceGroup/index.md) или вызовом gRPC API [InstanceGroupService/List](../../../compute/instancegroup/api-ref/grpc/InstanceGroup/list.md).

   {% endlist %}

## Подключите сетевой балансировщик нагрузки с целевой группой {#connect-balancer}

1. Создайте сетевой балансировщик нагрузки с именем `group-balancer` и подключите его к созданной группе ВМ:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором хотите создать балансировщик.
     1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Network Load Balancer**.
     1. Нажмите кнопку **Создать сетевой балансировщик**.
     1. Укажите имя — `group-balancer`.
     1. В поле **Публичный адрес** укажите `Автоматически`.
     1. В блоке **Обработчики** нажмите кнопку **Добавить обработчик**. В открывшемся окне укажите:
        * **Имя** — `http`.
        * **Порт** (на нем балансировщик будет принимать входящий трафик) — `80`.
        * **Целевой порт** (на него балансировщик будет направлять трафик) — `80`.
        * Нажмите кнопку **Добавить**.
     1. В блоке **Целевые группы** нажмите кнопку **Добавить целевую группу**.
     1. В поле **Целевая группа** выберите группу ВМ `auto-group-tg` и нажмите кнопку **Настроить**. В открывшемся окне укажите:
        * **Имя** — `tcp`.
        * **Тип** — `TCP`.
        * **Порт** — `80`.
        * Нажмите кнопку **Применить**.
     1. Нажмите кнопку **Создать**.

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

     1. Создайте балансировщик нагрузки с помощью метода REST API [create](../../../network-load-balancer/api-ref/NetworkLoadBalancer/create.md) для ресурса [NetworkLoadBalancer](../../../network-load-balancer/api-ref/NetworkLoadBalancer/index.md) или вызова gRPC API [NetworkLoadBalancerService/Create](../../../network-load-balancer/api-ref/grpc/NetworkLoadBalancer/create.md).
     1. Добавьте обработчик к балансировщику с помощью метода REST API [addListener](../../../network-load-balancer/api-ref/NetworkLoadBalancer/addListener.md) для ресурса `NetworkLoadBalancer` или вызова gRPC API [NetworkLoadBalancerService/AddListener](../../../network-load-balancer/api-ref/grpc/NetworkLoadBalancer/addListener.md).
     1. Подключите целевую группу к балансировщику с помощью метода REST API [attachTargetGroup](../../../network-load-balancer/api-ref/NetworkLoadBalancer/attachTargetGroup.md) для ресурса `NetworkLoadBalancer` или вызова gRPC API [NetworkLoadBalancerService/AttachTargetGroup](../../../network-load-balancer/api-ref/grpc/NetworkLoadBalancer/attachTargetGroup.md).
     1. Подключите балансировщик к группе ВМ с помощью метода REST API [addTargets](../../../network-load-balancer/api-ref/TargetGroup/addTargets.md) для ресурса [TargetGroup](../../../network-load-balancer/api-ref/TargetGroup/index.md) или вызова gRPC API [TargetGroupService/AddTargets](../../../network-load-balancer/api-ref/grpc/TargetGroup/addTargets.md).

   {% endlist %}

1. Убедитесь, что сетевой балансировщик `group-balancer` создан и привязан к группе ВМ:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы создали балансировщик.
     1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Network Load Balancer**.
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
     | b0rbabc1m2ed******** | group-balancer | ru-central1 | EXTERNAL |              1 | b0rdabckribe********   | ACTIVE |
     +----------------------+----------------+-----------------+----------+----------------+------------------------+--------+
     ```

   - API {#api}

     Воспользуйтесь методом REST API [list](../../../network-load-balancer/api-ref/NetworkLoadBalancer/list.md) для ресурса [NetworkLoadBalancer](../../../network-load-balancer/api-ref/NetworkLoadBalancer/index.md) или вызовом gRPC API [NetworkLoadBalancerService/List](../../../network-load-balancer/api-ref/grpc/NetworkLoadBalancer/list.md).

   {% endlist %}

## Проверьте работу группы ВМ и сетевого балансировщика {#check-service}

1. Создайте нагрузку на одну из ВМ.

   Для этого сохраните скрипт с именем `request.sh` в домашнюю директорию. Скрипт через балансировщик `group-balancer` отправит на одну из ВМ запрос, который будет создавать нагрузку в 100% CPU в течение 30 секунд.

   ```bash
   EXTERNAL_IP=$(yc load-balancer network-load-balancer get group-balancer --format=json | jq -r .listeners[0].address)

   curl "http://$EXTERNAL_IP/burn-cpu?time=30000&load=100"
   ```

1. Запустите скрипт:

   {% list tabs group=instructions %}

   - CLI {#cli}

     ```bash
     sh request.sh
     ```

     Результат:

     ```text
     projects/b0g12ga82bcv********/zones/ru-central1-b
     ```

   {% endlist %}

1. Посмотрите нагрузку на ВМ:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы создали группу ВМ.
     1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Compute Cloud**.
     1. На панели слева нажмите ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **Группы виртуальных машин**.
     1. Выберите группу ВМ `auto-group`.
     1. Перейдите на вкладку **Мониторинг**.

        Балансировщик направил запрос на одну из ВМ группы. В зоне доступности этой ВМ среднее потребление CPU (график **Average CPU utilization in zone**) выше, чем в других.

   {% endlist %}

### Проверьте работу автоматического масштабирования {#check-highload}

Чтобы проверить работу автоматического масштабирования группы ВМ, нужно создать повышенную нагрузку на CPU каждой ВМ. В файле `specification.yaml` в параметре `scale_policy.auto_scale.cpu_utilization_rule.utilization_target` указано значение `40` — целевой уровень нагрузки 40% CPU. Если превысить целевую нагрузку, количество ВМ в группе увеличится.
1. Создайте повышенную нагрузку на группу ВМ.

   Для этого сохраните скрипт с именем `load.sh` в домашнюю директорию. Скрипт в течение 10 минут в 12 потоков отправляет запросы к группе ВМ. При этом у каждой ВМ используется по 20% CPU на каждое ядро, обрабатывающее запрос. Группа ВМ в каждый момент времени будет загружена на 240% CPU. Скрипт специально выполняет несколько параллельных запросов по 20% CPU, а не один в 240% CPU, чтобы запросы равномерно распределялись между ВМ в группе.

   ```bash
   EXTERNAL_IP=$(yc load-balancer network-load-balancer get group-balancer --format=json | jq -r .listeners[0].address)

   wrk -H "Connection: close" -t12 -c12 -d10m "http://$EXTERNAL_IP/burn-cpu?time=5000&load=20"
   ```

1. Запустите скрипт:

   {% list tabs group=instructions %}

   - CLI {#cli}

     ```bash
     sh load.sh
     ```

     Результат:

     ```text
     Running 10m test @ http://130.193.56.111/burn-cpu?time=5000&load=20
       12 threads and 12 connections
       Thread Stats   Avg      Stdev     Max   +/- Stdev
     ...
     Requests/sec: 15.04
     Transfer/sec: 3.20KB
     ```

   {% endlist %}

1. Посмотрите нагрузку:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы создали группу ВМ `auto-group`.
     1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Compute Cloud**.
     1. На панели слева нажмите ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **Группы виртуальных машин**.
     1. Выберите группу ВМ `auto-group`.
     1. Перейдите на вкладку **Мониторинг**.
        На графике **Number of instance in zone** отображены изменения количества ВМ в каждой зоне доступности. На графике **Average CPU utilization in zone** — средняя CPU-нагрузка в каждой зоне доступности.
     1. Перейдите на вкладку **Логи**.
        На странице отображены сообщения о действиях в рамках автоматического масштабирования группы ВМ.

     Суммарная нагрузка в 240% CPU равномерно распределилась между двумя ВМ в двух зонах доступности и превысила целевой уровень нагрузки в 40% CPU. [Yandex Compute Cloud](../../../compute/index.md) создал по дополнительной ВМ в каждой зоне доступности и в группе стало четыре ВМ. Когда скрипт перестал создавать CPU-нагрузку, Compute Cloud автоматически уменьшил количество ВМ в группе до двух.

   {% endlist %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:
1. [Удалите](../../../network-load-balancer/operations/load-balancer-delete.md) сетевой балансировщик.
1. [Удалите](../../../compute/operations/instance-groups/delete.md) группу ВМ.

#### См. также {#see-also}

* [Работа с группой виртуальных машин с автоматическим масштабированием с помощью Terraform](terraform.md)