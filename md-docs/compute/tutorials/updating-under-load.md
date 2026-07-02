[Документация Yandex Cloud](../../index.md) > [Yandex Compute Cloud](../index.md) > [Практические руководства](index.md) > Обновление группы ВМ под нагрузкой

# Обновление группы виртуальных машин под нагрузкой


С помощью этого пошагового руководства вы настроите [группу ВМ](../concepts/instance-groups/index.md) и проверите ее работу при обновлении конфигурации. Для этого:
1. [Подготовьте облако к работе](#before-you-begin).
1. [Подготовьте окружение](#create-environment).
1. [Создайте группу ВМ с Container Optimized Image](#create-vm-group).
1. [Создайте нагрузку на ВМ](#start-load-testing).
1. [Обновите группу ВМ под нагрузкой](#update-spec).
1. [Остановите нагрузку и получите результаты](#end-load-testing).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

1. Если у вас еще нет интерфейса командной строки Yandex Cloud, [установите его](../../cli/quickstart.md#install).

1. Чтобы скрипты из пошагового руководства работали корректно, скачайте и установите утилиту [jq](https://stedolan.github.io/jq/download/).

1. Чтобы проверить работу автоматического масштабирования, установите утилиту [wrk](https://github.com/wg/wrk) для проведения нагрузочного тестирования.

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки группы ВМ Yandex Cloud входит плата за:
* [Диски](../concepts/disk.md) и постоянно запущенные [ВМ](../concepts/vm.md) – [тарифы Yandex Compute Cloud](../pricing.md).
* Использование динамического или статического [публичного IP-адреса](../../vpc/concepts/address.md) – [тарифы Yandex Virtual Private Cloud](../../vpc/pricing.md).

## Подготовьте окружение {#create-environment}

1. Создайте [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) с именем `for-load`. Чтобы иметь возможность создавать, обновлять и удалять ВМ в группе, а также интегрировать группу с сетевым балансировщиком Network Load Balancer, назначьте сервисному аккаунту роли [compute.editor](../security/index.md#compute-editor) и [load-balancer.editor](../../network-load-balancer/security/index.md#load-balancer-editor):

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы хотите создать сервисный аккаунт.
     1. Перейдите в сервис **Identity and Access Management**.
     1. Нажмите кнопку **Создать сервисный аккаунт**.
     1. В поле **Имя** укажите `for-load`.
     1. Нажмите значок ![](../../_assets/console-icons/plus.svg) **Добавить роль**. Чтобы иметь возможность создавать, обновлять и удалять ВМ в группе, а также интегрировать группу с сетевым балансировщиком Network Load Balancer, назначьте сервисному аккаунту роли [compute.editor](../security/index.md#compute-editor) и [load-balancer.editor](../../network-load-balancer/security/index.md#load-balancer-editor).
     1. Нажмите кнопку **Создать**.

   - CLI {#cli}

     1. Создайте сервисный аккаунт:

        По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

        ```bash
        yc iam service-account create --name for-load
        ```

        Результат выполнения команды:

        ```bash
        id: ajeab0cnib1p********
        folder_id: b0g12ga82bcv********
        created_at: "2021-02-09T17:31:32.561702Z"
        name: for-load
        ```

     1. Назначьте роль сервисному аккаунту роль compute.editor:

        ```bash
        yc resource-manager folder add-access-binding <идентификатор_каталога> \
          --role compute.editor \
          --subject serviceAccount:<идентификатор_сервисного_аккаунта>
        ```

      1. Назначьте роль сервисному аккаунту роль load-balancer.editor:

          ```bash
          yc resource-manager folder add-access-binding <идентификатор_каталога> \
            --role load-balancer.editor \
            --subject serviceAccount:<идентификатор_сервисного_аккаунта>
          ```

   - API {#api}

     1. Создайте сервисный аккаунт `for-load`:
         Воспользуйтесь методом REST API [create](../../iam/api-ref/ServiceAccount/create.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/Create](../../iam/api-ref/grpc/ServiceAccount/create.md).
     1. Чтобы иметь возможность создавать, обновлять и удалять ВМ в группе, а также интегрировать группу с сетевым балансировщиком Network Load Balancer, назначьте сервисному аккаунту роли [compute.editor](../security/index.md#compute-editor) и [load-balancer.editor](../../network-load-balancer/security/index.md#load-balancer-editor):
         Воспользуйтесь методом REST API [setAccessBindings](../../resource-manager/api-ref/Folder/setAccessBindings.md) для ресурса [Folder](../../resource-manager/api-ref/Folder/index.md) или вызовом gRPC API [FolderService/SetAccessBindings](../../resource-manager/api-ref/grpc/Folder/setAccessBindings.md).

   {% endlist %}

1. Создайте [сеть](../../vpc/concepts/network.md#network) с именем `yc-auto-network` и [подсети](../../vpc/concepts/network.md#subnet) в двух [зонах доступности](../../overview/concepts/geo-scope.md):

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы хотите создать сеть.
     1. Перейдите в сервис **Virtual Private Cloud**.
     1. Нажмите кнопку **Создать сеть**.
     1. В поле **Имя** укажите `yc-auto-network`.
     1. Выберите опцию **Создать подсети**.
     1. Нажмите кнопку **Создать сеть**.

   - CLI {#cli}

     1. Создайте сеть:

        ```bash
        yc vpc network create --name yc-auto-network
        ```

        Результат выполнения команды:

        ```bash
        id: enpabce123hd********
        folder_id: b0g12ga82bcv********
        created_at: "2021-02-09T17:33:32.561702Z"
        name: yc-auto-network
        ```

     1. Создайте подсеть в зоне `ru-central1-d`:

        ```bash
        yc vpc subnet create --network-id enpabce123hd******** --range 192.168.1.0/24 --zone ru-central1-d
        ```

        Результат выполнения команды:

        ```bash
        id: e1lnabc23r1c********
        folder_id: b0g12ga82bcv********
        created_at: "2021-02-09T17:34:32.561702Z"
        network_id: enpabce123hd********
        zone_id: ru-central1-d
        v4_cidr_blocks:
        - 192.168.1.0/24
        ```

     1. Создайте подсеть в зоне `ru-central1-b`:

        ```bash
        yc vpc subnet create --network-id enpabce123hd******** --range 192.168.2.0/24 --zone ru-central1-b
        ```

        Результат выполнения команды:

        ```bash
        id: b1csa2b3clid********
        folder_id: b0g12ga82bcv********
        created_at: "2021-02-09T17:35:32.561702Z"
        network_id: enpabce123hd********
        zone_id: ru-central1-b
        v4_cidr_blocks:
        - 192.168.2.0/24
        ```

   - API {#api}

     1. Создайте сеть:
         Воспользуйтесь методом REST API [create](../../vpc/api-ref/Network/create.md) для ресурса [Network](../../vpc/api-ref/Network/index.md) или вызовом gRPC API [NetworkService/Create](../../vpc/api-ref/grpc/Network/create.md).
     1. Создайте подсети в зонах `ru-central1-d` и `ru-central1-b`:
         Воспользуйтесь методом REST API [create](../../vpc/api-ref/Subnet/create.md) для ресурса [Subnet](../../vpc/api-ref/Subnet/index.md) или вызовом gRPC API [SubnetService/Create](../../vpc/api-ref/grpc/Subnet/create.md).

   {% endlist %}

## Создайте группу ВМ с Container Optimized Image {#create-vm-group}

1. Все ВМ группы создаются из образа [Container Optimized Image](../../cos/concepts/index.md). Каждая ВМ содержит [Docker-контейнер](https://yandex.cloud/ru/blog/posts/2022/03/docker-containers) с веб-сервером, который эмулирует нагрузку на сервис.

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы хотите создать группу ВМ.
     1. Перейдите в сервис **Compute Cloud**.
     1. На панели слева выберите ![](../../_assets/console-icons/layers-3-diagonal.svg) **Группы виртуальных машин**.
     1. Нажмите кнопку **Создать группу виртуальных машин**.
     1. В блоке **Базовые параметры**:
        * В поле **Имя** укажите `group-for-load`.
        * Выберите **Сервисный аккаунт** `for-load`.
     1. В блоке **Распределение** в поле **Зона доступности** выберите `ru-central1-d` и `ru-central1-b`.
     1. В блоке **Шаблон виртуальной машины** нажмите **Задать** и в открывшемся окне:
        * В блоке **Образ загрузочного диска** выберите вкладку **Container Solution**.
        * Нажмите кнопку **Настроить**.
        * В окне **Настройка Docker-контейнера**:
          * В поле **Имя** укажите `nginx`.
          * В поле **Docker-образ** нажмите **Укажите ссылку** и введите `cr.yandex/yc/demo/autoscaling-example-app:v1`.
          * Нажмите кнопку **Применить**.
        * В блоке **Диски и файловые хранилища**:
          * Для загрузочного диска укажите **Размер** `30 ГБ`.
        * В блоке **Сетевые настройки**:
          * В поле **Сеть** выберите `for-load`.
        * В блоке **Доступ**:
          * В поле **Сервисный аккаунт** выберите `for-load`.
          * В поле **Логин** укажите имя пользователя, который будет создан на ВМ.
          * В поле **SSH-ключ** вставьте содержимое файла открытого ключа.
        * Нажмите кнопку **Сохранить**.
     1. В блоке **В процессе создания и обновления разрешено**:
        * В поле **Уменьшать относительно целевого значения** введите `4`.
     1. В блоке **Масштабирование**:
        * В поле **Тип** выберите `Фиксированный`.
        * Введите **Размер** `6`.
     1. В блоке **Интеграция с Network Load Balancer**:
        * Включите опцию **Создать целевую группу**.
        * В поле **Имя целевой группы** укажите `load-generator`.
     1. Нажмите кнопку **Создать**.

   - CLI {#cli}

     1. Узнайте идентификатор последней версии [публичного образа](../operations/images-with-pre-installed-software/get-list.md) Container Optimized Image.

        Образ Container Optimized Image в реестре [Yandex Container Registry](../../container-registry/index.md) может обновляться и меняться в соответствии с релизами. При этом образ на ВМ не обновится автоматически до последней версии. Чтобы создать группу ВМ с последней версией Container Optimized Image, необходимо самостоятельно проверить ее наличие:

        ```bash
        yc compute image get-latest-from-family container-optimized-image --folder-id standard-images
        ```

        Результат выполнения команды:
  
        ```bash
        id: fd8iv792kira********
        folder_id: standard-images
        created_at: "2021-01-29T13:30:22Z"
        ...
        status: READY
        os:
          type: LINUX
        ```

     1. Сохраните спецификацию группы ВМ с сетевым балансировщиком нагрузки в файл `specification.yaml`:

        ```yaml
        name: group-for-load # Имя группы ВМ, уникальное в рамках каталога.
        service_account_id: ajeab0cnib1p******** # Идентификатор сервисного аккаунта.
        allocation_policy: # Политика распределения ВМ в группе.
           zones:
             - zone_id: ru-central1-d
             - zone_id: ru-central1-b
        instance_template:
          service_account_id: ajeab0cnib1p******** # Идентификатор сервисного аккаунта для доступа к приватным Docker-образам.
          platform_id: standard-v1 # Идентификатор платформы.
          resources_spec:
            memory: 2G # Количество памяти (RAM).
            cores: 2 # Количество ядер процессора (vCPU).
          boot_disk_spec:
            mode: READ_WRITE # Режим доступа к диску: чтение и запись.
            disk_spec:
              image_id: <идентификатор_последней_версии_COI>
            type_id: network-ssd # Тип диска.
            size: 30G # Размер диска.
          network_interface_specs:
           - network_id: enplhg4nncc7******** # Идентификатор сети.
             subnet_ids:
               - e1lnabc23r1c******** # Идентификатор подсети.
               - b1csa2b3clid********
             primary_v4_address_spec: {
               one_to_one_nat_spec: {
                 ip_version: IPV4 # Спецификация версии интернет-протокола IPv4 для публичного доступа к ВМ.
               }
             }         
          metadata: # Значения, которые будут переданы в метаданные ВМ.
            docker-container-declaration: |- # Ключ в метаданных ВМ, при котором используется Docker Container спецификация.
              spec:
                containers:
                  - image: cr.yandex/yc/demo/autoscaling-example-app:v1
                    name: nginx
                    securityContext:
                      privileged: false
                    restartPolicy: Always
                    tty: false
                    stdin: false
            ssh-keys: | # Параметр для передачи SSH-ключа на ВМ.
              yc-user:ssh-ed25519 ABC...d01 user@desktop.ru # Имя пользователя для подключения к ВМ.
        deploy_policy: # Политика развертывания ВМ в группе.
          max_unavailable: 4
        scale_policy: # Политика масштабирования ВМ в группе.
          fixed_scale:
            size: 6
        load_balancer_spec: # Сетевой балансировщик нагрузки.
          target_group_spec:
            name: load-generator
        ```

        {% note info %}

        Передать [SSH-ключ](../../glossary/ssh-keygen.md) в [метаданных ВМ](../concepts/vm-metadata.md) можно с помощью параметра `ssh-keys` или в ключе с пользовательскими метаданными `user-data`. В этом руководстве используется первый вариант.

        {% endnote %}

     1. Создайте группу ВМ с именем `group-for-load` с помощью спецификации `specification.yaml`:

         ```bash
         yc compute instance-group create --file=specification.yaml
         ```

         Результат выполнения команды:

         ```bash
         done (2m18s)
         id: cl0kabcquk1g********
         folder_id: b0g12ga82bcv********
         ...
         service_account_id: ajeab0cnib1p********
         status: ACTIVE
         application_load_balancer_state: {}
         ```

   - API {#api}

     1. Получите идентификатор последней версии образа `container-optimized-image` в семействе `standard-images`:
         Воспользуйтесь методом REST API [getLatestByFamily](../api-ref/Image/getLatestByFamily.md) для ресурса [Image](../api-ref/Image/index.md) или вызовом gRPC API [ImageService/GetLatestByFamily](../api-ref/grpc/Image/getLatestByFamily.md).
     1. Создайте группу ВМ по следующей спецификации:

         ```yaml
         name: group-for-load # Имя группы ВМ, уникальное в рамках каталога.
         service_account_id: ajeab0cnib1p******** # Идентификатор сервисного аккаунта.
         allocation_policy: # Политика распределения ВМ в группе.
            zones:
              - zone_id: ru-central1-d
              - zone_id: ru-central1-b
         instance_template:
           service_account_id: ajeab0cnib1p******** # Идентификатор сервисного аккаунта для доступа к приватным Docker-образам.
           platform_id: standard-v1 # Идентификатор платформы.
           resources_spec:
             memory: 2G # Количество памяти (RAM).
             cores: 2 # Количество ядер процессора (vCPU).
           boot_disk_spec:
             mode: READ_WRITE # Режим доступа к диску: чтение и запись.
             disk_spec:
               image_id: <идентификатор_последней_версии_COI>
             type_id: network-ssd # Тип диска.
             size: 30G # Размер диска.
           network_interface_specs:
            - network_id: enplhg4nncc7******** # Идентификатор сети.
              subnet_ids:
                - e1lnabc23r1c******** # Идентификатор подсети.
                - b1csa2b3clid********
              primary_v4_address_spec: {
                one_to_one_nat_spec: {
                  ip_version: IPV4 # Спецификация версии интернет-протокола IPv4 для публичного доступа к ВМ.
                }
              }         
           metadata: # Значения, которые будут переданы в метаданные ВМ.
             docker-container-declaration: |- # Ключ в метаданных ВМ, при котором используется Docker Container спецификация.
               spec:
                 containers:
                   - image: cr.yandex/yc/demo/autoscaling-example-app:v1
                     name: nginx
                     securityContext:
                       privileged: false
                     restartPolicy: Always
                     tty: false
                     stdin: false
             ssh-keys: | # Параметр для передачи SSH-ключа на ВМ.
               yc-user:ssh-ed25519 ABC...d01 user@desktop.ru # Имя пользователя для подключения к ВМ.
         deploy_policy: # Политика развертывания ВМ в группе.
           max_unavailable: 4
         scale_policy: # Политика масштабирования ВМ в группе.
           fixed_scale:
             size: 6
         load_balancer_spec: # Сетевой балансировщик нагрузки.
           target_group_spec:
             name: load-generator
         ```

         Воспользуйтесь методом REST API [createFromYaml](../instancegroup/api-ref/InstanceGroup/createFromYaml.md) для ресурса [InstanceGroup](../instancegroup/api-ref/InstanceGroup/index.md) или вызовом gRPC API [InstanceGroupService/CreateFromYaml](../instancegroup/api-ref/grpc/InstanceGroup/createFromYaml.md).
     
   {% endlist %}
   
1. Убедитесь, что группа ВМ создана:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы создали группу ВМ.
     1. Перейдите в сервис **Compute Cloud**.
     1. На панели слева выберите ![](../../_assets/console-icons/layers-3-diagonal.svg) **Группы виртуальных машин**.
     1. Нажмите на имя группы ВМ `group-for-load`.

   - CLI {#cli}

     ```bash
     yc compute instance-group list-instances group-for-load
     ```

     Результат выполнения команды:

     ```bash
     +----------------------+---------------------------+-----------------+-------------+----------------------+----------------+
     |     INSTANCE ID      |           NAME            |   EXTERNAL IP   | INTERNAL IP |        STATUS        | STATUS MESSAGE |
     +----------------------+---------------------------+-----------------+-------------+----------------------+----------------+
     ...
     | fhmab0cfsfd1******** | cl0kabcquk1g********-oxig | 178.154.226.108 | 10.130.0.8  | RUNNING_ACTUAL [49m] |                |
     | epdabchpdef0******** | cl0kabcquk1g********-aqyg | 130.193.40.55   | 10.129.0.20 | RUNNING_ACTUAL [43m] |                |
     +----------------------+---------------------------+-----------------+-------------+----------------------+----------------+
     ```

   - API {#api}

     Чтобы посмотреть список созданных групп ВМ, воспользуйтесь методом REST API [list](../instancegroup/api-ref/InstanceGroup/list.md) для ресурса [InstanceGroup](../instancegroup/api-ref/InstanceGroup/index.md) или вызовом gRPC API [InstanceGroupService/List](../instancegroup/api-ref/grpc/InstanceGroup/list.md).

   {% endlist %}

### Подключите сетевой балансировщик нагрузки к созданной группе виртуальных машин {#enable-balancer}

1. Создайте сетевой балансировщик нагрузки с именем `load-generator` и подключите его к созданной группе ВМ:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором хотите создать балансировщик.
     1. Перейдите в сервис **Network Load Balancer**.
     1. Нажмите кнопку **Создать сетевой балансировщик**.
     1. В поле **Имя** укажите `load-generator`.
     1. В поле **Публичный адрес** выберите `Автоматически`.
     1. В блоке **Обработчики** нажмите **Добавить обработчик**.
     1. В открывшемся окне:
        * В поле **Имя** укажите `http`.
        * В поле **Порт** укажите `80` — на нем балансировщик будет принимать входящий трафик.
        * В поле **Целевой порт** укажите `80` — на него балансировщик будет направлять трафик.
        * Нажмите кнопку **Добавить**.
     1. В блоке **Целевые группы** нажмите **Добавить целевую группу**.
     1. В списке **Целевая группа** выберите `load-generator`.
     1. В блоке **Проверка состояния** нажмите **Настроить**:
        * В открывшемся окне укажите **Путь** `/hello` — по этому пути балансировщик будет отправлять запросы для проверки состояния ВМ из целевой группы.
        * Нажмите кнопку **Применить**.
     1. Нажмите кнопку **Создать**.

   - CLI {#cli}

     1. Получите идентификатор целевой группы `load-generator`:
     
        ```bash
        yc load-balancer target-group get load-generator | grep "^id"
        ```
        
        Результат выполнения команды:
        
        ```bash
        id: enpsa475ej51********
        ```
        
     1. Создайте балансировщик:
     
        ```bash
        yc load-balancer network-load-balancer create \
          --name load-generator \
          --listener external-ip-version=ipv4,name=http,port=80,protocol=tcp,target-port=80 \
          --target-group healthcheck-http-port=80,healthcheck-http-path=/hello,target-group-id=<идентификатор_целевой_группы>
        ```

        Результат выполнения команды:

        ```bash
        done (14s)
        id: b0ruab1ccvpd********
        folder_id: b1csa2b3clid********
        ...
            healthy_threshold: "2"
            http_options:
              port: "80"
              path: /hello
        ```

   - API {#api}

     1. Создайте балансировщик нагрузки с помощью метода REST API [create](../../network-load-balancer/api-ref/NetworkLoadBalancer/create.md) для ресурса [NetworkLoadBalancer](../../network-load-balancer/api-ref/NetworkLoadBalancer/index.md) или вызова gRPC API [NetworkLoadBalancerService/Create](../../network-load-balancer/api-ref/grpc/NetworkLoadBalancer/create.md).
     1. Добавьте обработчик к балансировщику с помощью метода REST API [addListener](../../network-load-balancer/api-ref/NetworkLoadBalancer/addListener.md) для ресурса `NetworkLoadBalancer` или вызова gRPC API [NetworkLoadBalancerService/AddListener](../../network-load-balancer/api-ref/grpc/NetworkLoadBalancer/addListener.md).
     1. Подключите целевую группу к балансировщику с помощью метода REST API [attachTargetGroup](../../network-load-balancer/api-ref/NetworkLoadBalancer/attachTargetGroup.md) для ресурса `NetworkLoadBalancer` или вызова gRPC API [NetworkLoadBalancerService/AttachTargetGroup](../../network-load-balancer/api-ref/grpc/NetworkLoadBalancer/attachTargetGroup.md).
     1. Подключите балансировщик к группе ВМ с помощью метода REST API [addTargets](../../network-load-balancer/api-ref/TargetGroup/addTargets.md) для ресурса [TargetGroup](../../network-load-balancer/api-ref/TargetGroup/index.md) или вызова gRPC API [TargetGroupService/AddTargets](../../network-load-balancer/api-ref/grpc/TargetGroup/addTargets.md).

   {% endlist %}

1. Убедитесь, что сетевой балансировщик `load-generator` создан и привязан к группе ВМ:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы создали сетевой балансировщик.
     1. Перейдите в сервис **Network Load Balancer**.
     1. Нажмите на имя сетевого балансировщика `load-generator`.

   - CLI {#cli}

     ```bash
     yc load-balancer network-load-balancer list
     ```

     Результат выполнения команды:

     ```bash
     +----------------------+----------------+-----------------+----------+----------------+------------------------+--------+
     |          ID          |      NAME      |    REGION ID    |   TYPE   | LISTENER COUNT | ATTACHED TARGET GROUPS | STATUS |
     +----------------------+----------------+-----------------+----------+----------------+------------------------+--------+
     | b0ruab1ccvpd******** | load-generator | ru-central1     | EXTERNAL |              1 | b0r1tabcphde********   | ACTIVE |
     +----------------------+----------------+-----------------+----------+----------------+------------------------+--------+
     ```

   - API {#api}

     Воспользуйтесь методом REST API [list](../../network-load-balancer/api-ref/NetworkLoadBalancer/list.md) для ресурса [NetworkLoadBalancer](../../network-load-balancer/api-ref/NetworkLoadBalancer/index.md) или вызовом gRPC API [NetworkLoadBalancerService/List](../../network-load-balancer/api-ref/grpc/NetworkLoadBalancer/list.md).

   {% endlist %}

## Создайте нагрузку на ВМ {#start-load-testing}

1. Получите IP-адрес созданного балансировщика:

   {% list tabs group=instructions %}
   
   - Консоль управления {#console}
   
     1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится балансировщик.
     1. Перейдите в сервис **Network Load Balancer**.
     1. Скопируйте **IP-адрес** балансировщика `load-generator`.
     
   - CLI {#cli}
   
     ```bash
     yc load-balancer network-load-balancer get load-generator | grep "address"
     ```
     
     Результат выполнения команды:

     ```bash
       address: 84.252.133.110
     ```
     
   - API {#api}
   
     Воспользуйтесь методом REST API [get](../../network-load-balancer/api-ref/NetworkLoadBalancer/get.md) для ресурса [NetworkLoadBalancer](../../network-load-balancer/api-ref/NetworkLoadBalancer/index.md) или вызовом gRPC API [NetworkLoadBalancerService/Get](../../network-load-balancer/api-ref/grpc/NetworkLoadBalancer/get.md).
     
   {% endlist %}
     
1. Выполните команду для создания нагрузки:

   ```bash
   wrk -t20 -c20 -d20m --timeout 20s http://<IP-адрес_балансировщика>/sleep
   ```

   Команда запустит утилиту `wrk`, которая будет отправлять запросы в 20 потоков по 20 подключений к сетевому балансировщику в течение 20 минут. Таймаут запроса 20 секунд. Полученную нагрузку балансировщик распределит между ВМ из группы.

   После запуска `wrk` на экране появится сообщение о начале тестирования:

   ```bash
   Running 20m test @ http://84.252.133.110/sleep
     20 threads and 20 connections
   ```
   
   Переходите к следующему шагу, не дожидаясь окончания выполнения команды.

## Обновите группу ВМ под нагрузкой {#update-spec}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы создали группу ВМ.
  1. Перейдите в сервис **Compute Cloud**.
  1. На панели слева выберите ![](../../_assets/console-icons/layers-3-diagonal.svg) **Группы виртуальных машин**.
  1. Нажмите на имя группы ВМ `group-for-load`.
  1. Нажмите кнопку ![edit](../../_assets/console-icons/pencil.svg) **Редактировать**.
  1. В блоке **Шаблон виртуальной машины** нажмите ![horizontal-ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите **Редактировать**.
     * В блоке **Диски и файловые хранилища** укажите новый размер диска — `35 ГБ`.
     * Нажмите кнопку **Сохранить**.
  1. Нажмите кнопку **Сохранить**.
  1. В блоке **Виртуальные машины** поэтапно отобразятся изменения размера диска для всех ВМ группы.

- CLI {#cli}

   1. В спецификации `specification.yaml` укажите новый размер диска — 35 ГБ — и сохраните файл:
   
      ```yaml
      ...
      size: 35G
      ...
      ```
   
   1. Обновите группу ВМ:

      ```bash
      yc compute instance-group update --name=group-for-load --file=specification.yaml
      ```

      Результат выполнения команды:

      ```bash
      done (9m24s)
      id: cl10kktrjcn8********
      folder_id: b1g7gvsi89m3********
      ...
         name: load-generator
      service_account_id: ajehbk07uus3********
      status: ACTIVE
      ```
      
- API {#api}

  1. В спецификации укажите новый размер диска — 35 ГБ:
     
     ```yaml
     ...
     size: 35G
     ...
     ```
  
  1. Чтобы обновить группу ВМ `load-generator` по новой спецификации, воспользуйтесь методом REST API [updateFromYaml](../instancegroup/api-ref/InstanceGroup/updateFromYaml.md) для ресурса [InstanceGroup](../instancegroup/api-ref/InstanceGroup/index.md) или вызовом gRPC API [InstanceGroupService/UpdateFromYaml](../instancegroup/api-ref/grpc/InstanceGroup/updateFromYaml.md).

{% endlist %}

## Остановите нагрузку и получите результаты {#end-load-testing}

Остановите работу `wrk`, нажав сочетание клавиш **Ctrl** + **C**.

Результат выполнения команды:

```bash
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency    10.00s     1.70ms  10.01s    68.21%
    Req/Sec     0.00      0.00     0.00    100.00%
  1148 requests in 17.47m, 211.89KB read
Requests/sec:      1.09
Transfer/sec:     206.94B
```

Если в результате нет строки об ошибках, например `Socket errors`, все запросы были обработаны.

## Как удалить созданные ресурсы {#clear-out}

Чтобы удалить созданные ресурсы:

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. Удалите балансировщик нагрузки:
      1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы создали балансировщик нагрузки.
      1. Перейдите в сервис **Network Load Balancer**.
      1. Справа в строке балансировщика `load-generator` нажмите ![horizontal-ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите **Удалить**.
      1. В открывшемся окне нажмите **Удалить**.
   1. Удалите группу ВМ:
      1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы создали группу ВМ.
      1. Перейдите в сервис **Compute Cloud**.
      1. На панели слева выберите ![](../../_assets/console-icons/layers-3-diagonal.svg) **Группы виртуальных машин**.
      1. Справа в строке группы `load-generator` нажмите ![horizontal-ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите **Удалить**.
      1. В открывшемся окне нажмите **Удалить**.
   1. Удалите сервисный аккаунт:
      1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы создали сервисный аккаунт.
      1. Перейдите в сервис **Identity and Access Management**.
      1. На панели слева выберите ![FaceRobot](../../_assets/console-icons/face-robot.svg) **Сервисные аккаунты**.
      1. В открывшемся списке в строке с сервисным аккаунтом `yc-auto-sa` нажмите ![horizontal-ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите **Удалить**.
      1. В открывшемся окне нажмите **Удалить**.
   1. Удалите сеть и подсети:
      1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы создали сеть и подсети.
      1. Перейдите в сервис **Virtual Private Cloud**.
      1. Выберите сеть `yc-auto-network`.
      1. В блоке **Подсети**:
         1. Справа в строке подсети `yc-auto-subnet-1` нажмите ![horizontal-ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите **Удалить**.
         1. В открывшемся окне нажмите **Удалить**.
         1. Также удалите подсеть `yc-auto-subnet-2`.
      1. В правом верхнем углу нажмите **Удалить**.

- CLI {#cli}

   Выполните последовательно команды:

   ```bash
   yc load-balancer network-load-balancer delete load-generator
   yc compute instance-group delete load-generator
   yc iam service-account delete yc-auto-sa
   yc vpc subnet delete yc-auto-subnet-1
   yc vpc subnet delete yc-auto-subnet-2
   yc vpc network delete yc-auto-network
   ```
  
- API {#api}

  1. Удалите балансировщик `load-generator`: воспользуйтесь методом REST API [delete](../../network-load-balancer/api-ref/NetworkLoadBalancer/delete.md) для ресурса [NetworkLoadBalancer](../../network-load-balancer/api-ref/NetworkLoadBalancer/index.md) или вызовом gRPC API [NetworkLoadBalancerService/Delete](../../network-load-balancer/api-ref/grpc/NetworkLoadBalancer/delete.md).
  1. Удалите группу ВМ `load-generator`: воспользуйтесь методом REST API [delete](../instancegroup/api-ref/InstanceGroup/delete.md) для ресурса [InstanceGroup](../instancegroup/api-ref/InstanceGroup/index.md) или вызовом gRPC API [InstanceGroupService/Delete](../instancegroup/api-ref/grpc/InstanceGroup/delete.md).
  1. Удалите сервисный аккаунт `yc-auto-sa`: воспользуйтесь методом REST API [delete](../../iam/api-ref/ServiceAccount/delete.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/Delete](../../iam/api-ref/grpc/ServiceAccount/delete.md).
  1. Удалите подсети `yc-auto-subnet-1` и `yc-auto-subnet-2`: воспользуйтесь методом REST API [delete](../../vpc/api-ref/Subnet/delete.md) для ресурса [Subnet](../../vpc/api-ref/Subnet/index.md) или вызовом gRPC API [SubnetService/Delete](../../vpc/api-ref/grpc/Subnet/delete.md).
  1. Удалите сеть `yc-auto-network`: воспользуйтесь методом REST API [delete](../../vpc/api-ref/Network/delete.md) для ресурса [Network](../../vpc/api-ref/Network/index.md) или вызовом gRPC API [NetworkService/Delete](../../vpc/api-ref/grpc/Network/delete.md).

{% endlist %}