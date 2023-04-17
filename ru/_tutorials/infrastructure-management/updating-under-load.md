# Обновление группы виртуальных машин под нагрузкой

С помощью этого пошагового руководства вы настроите [группу ВМ](../../compute/concepts/instance-groups/index.md) и проверите ее работу при обновлении конфигурации. Для этого:
1. [Подготовьте облако к работе](#before-you-begin).
1. [Подготовьте окружение](#create-environment).
1. [Создайте группу ВМ с {{ coi }}](#create-vm-group).
1. [Создайте нагрузку на ВМ](#start-load-testing).
1. [Обновите группу ВМ под нагрузкой](#update-spec).
1. [Остановите нагрузку и получите результаты](#end-load-testing).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

{% include [before](../../_includes/compute/before-solution.md) %}


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки группы ВМ {{ yandex-cloud }} входит плата за:
* [Диски](../../compute/concepts/disk.md) и постоянно запущенные [ВМ](../../compute/concepts/vm.md) – [тарифы {{ compute-full-name }}](../../compute/pricing.md).
* Использование динамического или статического [публичного IP-адреса](../../vpc/concepts/address.md) – [тарифы {{ vpc-full-name }}](../../vpc/pricing.md).


## Подготовьте окружение {#create-environment}

1. Создайте [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) с именем `for-load` и назначьте ему роль `editor`:

   {% list tabs %}

   - Консоль управления

     1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы хотите создать сервисный аккаунт.
     1. В верхней части экрана перейдите на вкладку **Сервисные аккаунты**.
     1. Нажмите кнопку **Создать сервисный аккаунт**.
     1. Введите имя `for-load`.
     1. Чтобы назначить сервисному аккаунту [роль](../../iam/concepts/access-control/roles.md) на текущий каталог, нажмите **Добавить роль** и выберите роль `editor`.
     1. Нажмите кнопку **Создать**.

   - CLI

     1. Создайте сервисный аккаунт:

        {% include [default-catalogue](../../_includes/default-catalogue.md) %}

        ```bash
        yc iam service-account create --name for-load
        ```

        Результат выполнения команды:

        ```bash
        id: ajeab0cnib1pdefe21dm
        folder_id: b0g12ga82bcv0cdeferg
        created_at: "2021-02-09T17:31:32.561702Z"
        name: for-load
        ```

     1. Назначьте роль сервисному аккаунту:

        ```bash
        yc resource-manager folder add-access-binding b0g12ga82bcv0cdeferg \
          --role editor \
          --subject serviceAccount:ajeab0cnib1pdefe21dm
        ```

   - API

     1. Создайте сервисный аккаунт `for-load`:
         Воспользуйтесь методом REST API [create](../../iam/api-ref/ServiceAccount/create.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/Create](../../iam/api-ref/grpc/service_account_service.md#Create).
     1. Назначьте сервисному аккаунту в текущем каталоге роль `editor`:
         Воспользуйтесь методом REST API [setAccessBindings](../../resource-manager/api-ref/Folder/setAccessBindings.md) для ресурса [Folder](../../resource-manager/api-ref/Folder/index.md) или вызовом gRPC API [FolderService/SetAccessBindings](../../resource-manager/api-ref/grpc/folder_service.md#SetAccessBindings).

   {% endlist %}

1. Создайте [сеть](../../vpc/concepts/network.md#network) с именем `yc-auto-network` и [подсети](../../vpc/concepts/network.md#subnet) в двух [зонах доступности](../../overview/concepts/geo-scope.md):

   {% list tabs %}

   - Консоль управления

     1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите создать группу ВМ.
     1. Выберите сервис **{{ vpc-name }}**.
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
        created_at: "2021-02-09T17:33:32.561702Z"
        name: yc-auto-network
        ```

     1. Создайте подсеть в зоне `{{ region-id }}-a`:

        ```bash
        yc vpc subnet create --network-id enpabce123hde4ft1r3t --range 192.168.1.0/24 --zone {{ region-id }}-a
        ```

        Результат выполнения команды:

        ```bash
        id: e1lnabc23r1c9d0efoje
        folder_id: b0g12ga82bcv0cdeferg
        created_at: "2021-02-09T17:34:32.561702Z"
        network_id: enpabce123hde4ft1r3t
        zone_id: {{ region-id }}-a
        v4_cidr_blocks:
        - 192.168.1.0/24
        ```

     1. Создайте подсеть в зоне `{{ region-id }}-b`:

        ```bash
        yc vpc subnet create --network-id enpabce123hde4ft1r3t --range 192.168.2.0/24 --zone {{ region-id }}-b
        ```

        Результат выполнения команды:

        ```bash
        id: b1csa2b3clideftjb121
        folder_id: b0g12ga82bcv0cdeferg
        created_at: "2021-02-09T17:35:32.561702Z"
        network_id: enpabce123hde4ft1r3t
        zone_id: {{ region-id }}-b
        v4_cidr_blocks:
        - 192.168.2.0/24
        ```

   - API

     1. Создайте сеть:
         Воспользуйтесь методом REST API [create](../../vpc/api-ref/Network/create.md) для ресурса [Network](../../vpc/api-ref/Network/index.md) или вызовом gRPC API [NetworkService/Create](../../vpc/api-ref/grpc/network_service.md#Create).
     1. Создайте подсети в зонах `{{ region-id }}-a` и `{{ region-id }}-b`:
         Воспользуйтесь методом REST API [create](../../vpc/api-ref/Subnet/create.md) для ресурса [Subnet](../../vpc/api-ref/Subnet/index.md) или вызовом gRPC API [SubnetService/Create](../../vpc/api-ref/grpc/subnet_service.md#Create).

   {% endlist %}

## Создайте группу ВМ с {{ coi }} {#create-vm-group}

1. Все ВМ группы создаются из образа [{{ coi }}](../../cos/concepts/index.md). Каждая ВМ содержит [Docker-контейнер](/blog/posts/2022/03/docker-containers) с веб-сервером, который эмулирует нагрузку на сервис.

   {% list tabs %}

   
   - Консоль управления

     1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите создать сеть.
     1. Выберите сервис **{{ compute-name }}**.
     1. На странице **Виртуальные машины** перейдите на вкладку **Группы виртуальных машин**.
     1. Нажмите кнопку **Создать группу**.
     1. В блоке **Базовые параметры**:
        * Введите **Имя** группы `group-for-load`.
        * Выберите **Сервисный аккаунт** `for-load`.
     1. В блоке **Распределение** выберите **Зоны доступности** `{{ region-id }}-a` и `{{ region-id }}-b`.
     1. В блоке **Шаблон виртуальной машины** нажмите кнопку **Задать**:
        * В блоке **Выбор образа/загрузочного диска** выберите вкладку **Container Solution**.
        * Нажмите кнопку **Настроить**.
        * В окне **Настройка Docker-контейнера**:
          * Введите **Имя** `nginx`.
          * В поле **Docker-образ** нажмите кнопку **Укажите ссылку** и введите `{{ registry }}/yc/demo/autoscaling-example-app:v1`.
          * Нажмите кнопку **Применить**.
        * В блоке **Диски**:
          * Для загрузочного диска укажите **Размер** 30 ГБ.
        * В блоке **Сетевые настройки**:
          * Выберите **Сеть** `for-load`.
        * В блоке **Доступ**:
          * Выберите **Сервисный аккаунт** `for-load`.
          * В поле **Логин** укажите имя пользователя, который будет создан на ВМ.
          * В поле **SSH-ключ** вставьте содержимое файла открытого ключа.
        * Нажмите кнопку **Сохранить**.
     1. В блоке **В процессе создания и обновления разрешено**:
        * В поле **Уменьшать относительно целевого значения** введите `4`.
     1. В блоке **Масштабирование**:
        * Выберите **Тип** `Фиксированный`.
        * Введите **Размер** `6`.
     1. В блоке **Интеграция с Load Balancer**:
        * Включите опцию **Создайте целевую группу**.
        * Введите **Имя целевой группы** `load-generator`.
     1. Нажмите кнопку **Создать**.
 

   - CLI

     1. Узнайте идентификатор последней версии [публичного образа](../../compute/operations/images-with-pre-installed-software/get-list.md) {{ coi }}.

        Образ {{ coi }} в реестре [{{ container-registry-full-name }}](../../container-registry/) может обновляться и меняться в соответствии с релизами. При этом образ на ВМ не обновится автоматически до последней версии. Чтобы создать группу ВМ с последней версией {{ coi }}, необходимо самостоятельно проверить ее наличие:

        ```bash
        yc compute image get-latest-from-family container-optimized-image --folder-id standard-images
        ```

        Результат выполнения команды:
  
        ```bash
        id: fd8iv792kirahcnqnt0q
        folder_id: standard-images
        created_at: "2021-01-29T13:30:22Z"
        ...
        status: READY
        os:
          type: LINUX
        ```

     1. Сохраните спецификацию группы ВМ с сетевым балансировщиком нагрузки в файл `specification.yaml`:

        {% include [updating-under-load-yaml-spec-init](../../_includes/instance-groups/updating-under-load-yaml-spec-init.md) %}

        {% note info %}

        Передать [SSH-ключ](../../glossary/ssh-keygen.md) в [метаданных ВМ](../../compute/concepts/vm-metadata.md#keys-processed-in-public-images) можно с помощью параметра `ssh-keys` или в строке с пользовательскими метаданными `user-data`. В этом руководстве используется первый вариант.

        {% endnote %}

     1. Создайте группу ВМ с именем `group-for-load` с помощью спецификации `specification.yaml`:

         ```bash
         yc compute instance-group create --file=specification.yaml
         ```

         Результат выполнения команды:

         ```bash
         done (2m18s)
         id: cl0kabcquk1gomdefbkk
         folder_id: b0g12ga82bcv0cdeferg
         ...
         service_account_id: ajeab0cnib1pdefe21dm
         status: ACTIVE
         application_load_balancer_state: {}
         ```

   - API

     1. Получите идентификатор последней версии образа `container-optimized-image` в семействе `standard-images`:
         Воспользуйтесь методом REST API [getLatestByFamily](../../compute/api-ref/Image/getLatestByFamily.md) для ресурса [Image](../../compute/api-ref/Image/index.md) или вызовом gRPC API [ImageService/GetLatestByFamily](../../compute/api-ref/grpc/image_service.md#GetLatestByFamily).
     1. Создайте группу ВМ по следующей спецификации:

         {% include [updating-under-load-yaml-spec-init](../../_includes/instance-groups/updating-under-load-yaml-spec-init.md) %}

         Воспользуйтесь методом REST API [createFromYaml](../../compute/api-ref/InstanceGroup/createFromYaml.md) для ресурса [InstanceGroup](../../compute/api-ref/InstanceGroup/index.md) или вызовом gRPC API [InstanceGroupService/CreateFromYaml](../../compute/api-ref/grpc/instance_group_service.md#CreateFromYaml).
     
   {% endlist %}
   
1. Убедитесь, что группа ВМ создана:

   {% list tabs %}

   - Консоль управления

     1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создали группу ВМ.
     1. Выберите сервис **{{ compute-name }}**.
     1. Перейдите в раздел **Группы виртуальных машин**.
     1. Нажмите на имя группы ВМ `group-for-load`.

   - CLI

     ```bash
     yc compute instance-group list-instances group-for-load
     ```

     Результат выполнения команды:

     ```bash
     +----------------------+---------------------------+-----------------+-------------+----------------------+----------------+
     |     INSTANCE ID      |           NAME            |   EXTERNAL IP   | INTERNAL IP |        STATUS        | STATUS MESSAGE |
     +----------------------+---------------------------+-----------------+-------------+----------------------+----------------+
     ...
     | fhmab0cfsfd125efpvn1 | cl0kabcquk1gomdefbkk-oxig | 178.154.226.108 | 10.130.0.8  | RUNNING_ACTUAL [49m] |                |
     | epdabchpdef0f1e21j14 | cl0kabcquk1gomdefbkk-aqyg | 130.193.40.55   | 10.129.0.20 | RUNNING_ACTUAL [43m] |                |
     +----------------------+---------------------------+-----------------+-------------+----------------------+----------------+
     ```

   - API

     Чтобы посмотреть список созданных групп ВМ, воспользуйтесь методом REST API [list](../../compute/api-ref/InstanceGroup/list.md) для ресурса [InstanceGroup](../../compute/api-ref/InstanceGroup/index.md) или вызовом gRPC API [InstanceGroupService/List](../../compute/api-ref/grpc/instance_group_service.md#List).

   {% endlist %}

### Подключите сетевой балансировщик нагрузки к созданной группе виртуальных машин {#enable-balancer}

1. Создайте сетевой балансировщик нагрузки с именем `load-generator` и подключите его к созданной группе ВМ:

   {% list tabs %}

   - Консоль управления

     1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать балансировщик.
     1. В списке сервисов выберите **{{ network-load-balancer-name }}**.
     1. Нажмите кнопку **Создать сетевой балансировщик**.
     1. Задайте **Имя** `load-generator`.
     1. В поле **Публичный адрес** выберите значение **Автоматически**.
     1. В блоке **Обработчики** нажмите кнопку **Добавить обработчик**:
        * В открывшемся окне введите **Имя обработчика** `http`.
        * В поле **Порт** укажите `80` — на нем балансировщик будет принимать входящий трафик.
        * В поле **Целевой порт** укажите `80` — на него балансировщик будет направлять трафик.
        * Нажмите кнопку **Добавить**.
     1. В блоке **Целевые группы** нажмите кнопку **Добавить целевую группу**.
     1. В выпадающем списке **Целевая группа** выберите `load-generator`.
     1. В блоке целевой группы нажмите кнопку **Настроить**:
        * В открывшемся окне укажите **Путь** `/hello` — по этому пути балансировщик будет отправлять запросы для проверки состояния ВМ из целевой группы.
        * Нажмите кнопку **Применить**.
     1. Нажмите кнопку **Создать**.

   - CLI

     1. Получите идентификатор целевой группы `load-generator`:
     
        ```bash
        yc load-balancer target-group get load-generator | grep "^id"
        ```
        
        Результат выполнения команды:
        
        ```bash
        id: enpsa475ej51enuam897
        ```
        
     1. Создайте балансировщик:
     
        ```bash
        yc load-balancer network-load-balancer create \
          --name load-generator \
          --listener external-ip-version=ipv4,name=http,port=80,protocol=tcp,target-port=80 \
          --target-group healthcheck-http-port=80,healthcheck-http-path=/hello,target-group-id=<ID целевой группы>
        ```

        Результат выполнения команды:

        ```bash
        done (14s)
        id: b0ruab1ccvpd26efgii4
        folder_id: b1csa2b3clideftjb121
        ...
            healthy_threshold: "2"
            http_options:
              port: "80"
              path: /hello
        ```

   - API

     1. Создайте балансировщик нагрузки с помощью метода REST API [create](../../network-load-balancer/api-ref/NetworkLoadBalancer/create.md) для ресурса [NetworkLoadBalancer](../../network-load-balancer/api-ref/NetworkLoadBalancer/index.md) или вызова gRPC API [NetworkLoadBalancerService/Create](../../network-load-balancer/api-ref/grpc/network_load_balancer_service.md#Create).
     1. Добавьте обработчик к балансировщику с помощью метода REST API [addListener](../../network-load-balancer/api-ref/NetworkLoadBalancer/addListener.md) для ресурса `NetworkLoadBalancer` или вызова gRPC API [NetworkLoadBalancerService/AddListener](../../network-load-balancer/api-ref/grpc/network_load_balancer_service.md#AddListener).
     1. Подключите целевую группу к балансировщику с помощью метода REST API [attachTargetGroup](../../network-load-balancer/api-ref/NetworkLoadBalancer/attachTargetGroup.md) для ресурса `NetworkLoadBalancer` или вызова gRPC API [NetworkLoadBalancerService/AttachTargetGroup](../../network-load-balancer/api-ref/grpc/network_load_balancer_service.md#AttachTargetGroup).
     1. Подключите балансировщик к группе ВМ с помощью метода REST API [addTargets](../../network-load-balancer/api-ref/TargetGroup/addTargets.md) для ресурса [TargetGroup](../../network-load-balancer/api-ref/TargetGroup/index.md) или вызова gRPC API [TargetGroupService/AddTargets](../../network-load-balancer/api-ref/grpc/target_group_service.md#AddTargets).

   {% endlist %}

1. Убедитесь, что сетевой балансировщик `load-generator` создан и привязан к группе ВМ:

   {% list tabs %}

   - Консоль управления

     1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создали сетевой балансировщик.
     1. Выберите сервис **{{ network-load-balancer-name }}**.
     1. Нажмите на имя сетевого балансировщика `load-generator`.

   - CLI

     ```bash
     yc load-balancer network-load-balancer list
     ```

     Результат выполнения команды:
     
     
     ```bash
     +----------------------+----------------+-----------------+----------+----------------+------------------------+--------+
     |          ID          |      NAME      |    REGION ID    |   TYPE   | LISTENER COUNT | ATTACHED TARGET GROUPS | STATUS |
     +----------------------+----------------+-----------------+----------+----------------+------------------------+--------+
     | b0ruab1ccvpd26efgii4 | load-generator | {{ region-id }} | EXTERNAL |              1 | b0r1tabcphde28fj1dd3   | ACTIVE |
     +----------------------+----------------+-----------------+----------+----------------+------------------------+--------+
     ```
     
     

   - API

     Воспользуйтесь методом REST API [list](../../network-load-balancer/api-ref/NetworkLoadBalancer/list.md) для ресурса [NetworkLoadBalancer](../../network-load-balancer/api-ref/NetworkLoadBalancer/index.md) или вызовом gRPC API [NetworkLoadBalancerService/List](../../network-load-balancer/api-ref/grpc/network_load_balancer_service.md#List).

   {% endlist %}

## Создайте нагрузку на ВМ {#start-load-testing}

1. Получите IP-адрес созданного балансировщика:

   {% list tabs %}
   
   - Консоль управления
   
     1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать балансировщик.
     1. В списке сервисов выберите **{{ network-load-balancer-name }}**.
     1. Скопируйте **IP-адрес** балансировщика.
     
   - CLI
   
     ```bash
     yc load-balancer network-load-balancer get load-generator | grep "address"
     ```
     
     Результат выполнения команды:

     ```bash
       address: 84.252.133.110
     ```
     
   - API
   
     Воспользуйтесь методом REST API [get](../../network-load-balancer/api-ref/NetworkLoadBalancer/get.md) для ресурса [NetworkLoadBalancer](../../network-load-balancer/api-ref/NetworkLoadBalancer/index.md) или вызовом gRPC API [NetworkLoadBalancerService/Get](../../network-load-balancer/api-ref/grpc/network_load_balancer_service.md#Get).
     
   {% endlist %}
     
1. Выполните команду для создания нагрузки:

   ```bash
   wrk -t20 -c20 -d20m --timeout 20s http://<IP-адрес балансировщика>/sleep
   ```

   Команда запустит утилиту `wrk`, которая будет отправлять запросы в 20 потоков по 20 подключений к сетевому балансировщику в течение 20 минут. Таймаут запроса 20 секунд. Полученную нагрузку балансировщик распределит между ВМ из группы.

   После запуска `wrk` на экране появится сообщение о начале тестирования:

   ```bash
   Running 20m test @ http://84.252.133.110/sleep
     20 threads and 20 connections
   ```
   
   Переходите к следующему шагу, не дожидаясь окончания выполнения команды.

## Обновите группу ВМ под нагрузкой {#update-spec}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создали группу ВМ.
  1. Выберите сервис **{{ compute-name }}**.
  1. Перейдите в раздел **Группы виртуальных машин**.
  1. Нажмите на имя группы ВМ `group-for-load`.
  1. На странице группы нажмите кнопку ![pencil](../../_assets/pencil.svg) **Изменить**.
  1. В блоке **Шаблон виртуальной машины** нажмите кнопку ![horizontal-ellipsis](../../_assets/horizontal-ellipsis.svg) и выберите **Изменить**.
     * В блоке **Диски** укажите новый размер диска — 35 ГБ.
     * Нажмите кнопку **Сохранить**.
  1. Нажмите кнопку **Сохранить изменения**.
  1. В блоке **Состояния виртуальных машин** поэтапно отобразятся изменения размера диска для всех ВМ группы.

- CLI

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
      id: cl10kktrjcn8polprdav
      folder_id: b1g7gvsi89m34qmcm3ke
      ...
         name: load-generator
      service_account_id: ajehbk07uus3s73pcq13
      status: ACTIVE
      ```
      
- API

  1. В спецификации укажите новый размер диска — 35 ГБ:
     
     ```yaml
     ...
     size: 35G
     ...
     ```
  
  1. Чтобы обновить группу ВМ `load-generator` по новой спецификации, воспользуйтесь методом REST API [updateFromYaml](../../compute/api-ref/InstanceGroup/updateFromYaml.md) для ресурса [InstanceGroup](../../compute/api-ref/InstanceGroup/index.md) или вызовом gRPC API [InstanceGroupService/UpdateFromYaml](../../compute/api-ref/grpc/instance_group_service.md#UpdateFromYaml).

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

{% list tabs %}

- Консоль управления

   1. Удалите балансировщик нагрузки:
      1. Перейдите в корень каталога.
      1. В списке сервисов выберите **{{ network-load-balancer-name }}**.
      1. Справа в строке балансировщика `load-generator` нажмите кнопку ![horizontal-ellipsis](../../_assets/horizontal-ellipsis.svg) и выберите **Удалить**.
      1. В открывшемся окне нажмите кнопку **Удалить**.
   1. Удалите группу ВМ:
      1. Перейдите в корень каталога.
      1. В списке сервисов выберите **{{ compute-name }}**.
      1. Перейдите на вкладку **Группы виртуальных машин**.
      1. Справа в строке группы `load-generator` нажмите кнопку ![horizontal-ellipsis](../../_assets/horizontal-ellipsis.svg) и выберите **Удалить**.
      1. В открывшемся окне нажмите кнопку **Удалить**.
   1. Удалите сервисный аккаунт:
      1. Перейдите в корень каталога.
      1. Перейдите на вкладку **Сервисные аккаунты**.
      1. Справа в строке аккаунта `yc-auto-sa` нажмите кнопку ![horizontal-ellipsis](../../_assets/horizontal-ellipsis.svg) и выберите **Удалить**.
      1. В открывшемся окне нажмите кнопку **Удалить**.
   1. Удалите сеть и подсети:
      1. Перейдите в корень каталога.
      1. В списке сервисов выберите **{{ vpc-name }}**.
      1. Выберите сеть `yc-auto-network`.
      1. В блоке **Подсети**:
         1. Справа в строке подсети `yc-auto-subnet-1` нажмите кнопку ![horizontal-ellipsis](../../_assets/horizontal-ellipsis.svg) и выберите **Удалить**.
         1. В открывшемся окне нажмите кнопку **Удалить**.
         1. Также удалите подсеть `yc-auto-subnet-2`.
      1. В правом верхнем углу нажмите кнопку **Удалить**.

- CLI

   Выполните последовательно команды:

   ```bash
   yc load-balancer network-load-balancer delete load-generator
   yc compute instance-group delete load-generator
   yc iam service-account delete yc-auto-sa
   yc vpc subnet delete yc-auto-subnet-1
   yc vpc subnet delete yc-auto-subnet-2
   yc vpc network delete yc-auto-network
   ```
  
- API

  1. Удалите балансировщик `load-generator`: воспользуйтесь методом REST API [delete](../../network-load-balancer/api-ref/NetworkLoadBalancer/delete.md) для ресурса [NetworkLoadBalancer](../../network-load-balancer/api-ref/NetworkLoadBalancer/index.md) или вызовом gRPC API [NetworkLoadBalancerService/Delete](../../network-load-balancer/api-ref/grpc/network_load_balancer_service.md#Delete).
  1. Удалите группу ВМ `load-generator`: воспользуйтесь методом REST API [delete](../../compute/api-ref/InstanceGroup/delete.md) для ресурса [InstanceGroup](../../compute/api-ref/InstanceGroup/index.md) или вызовом gRPC API [InstanceGroupService/Delete](../../compute/api-ref/grpc/instance_group_service.md#Delete).
  1. Удалите сервисный аккаунт `yc-auto-sa`: воспользуйтесь методом REST API [delete](../../iam/api-ref/ServiceAccount/delete.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/Delete](../../iam/api-ref/grpc/service_account_service.md#Delete).
  1. Удалите подсети `yc-auto-subnet-1` и `yc-auto-subnet-2`: воспользуйтесь методом REST API [delete](../../vpc/api-ref/Subnet/delete.md) для ресурса [Subnet](../../vpc/api-ref/Subnet/index.md) или вызовом gRPC API [SubnetService/Delete](../../vpc/api-ref/grpc/subnet_service.md#Delete).
  1. Удалите сеть `yc-auto-network`: воспользуйтесь методом REST API [delete](../../vpc/api-ref/Network/delete.md) для ресурса [Network](../../vpc/api-ref/Network/index.md) или вызовом gRPC API [NetworkService/Delete](../../vpc/api-ref/grpc/network_service.md#Delete).

{% endlist %}