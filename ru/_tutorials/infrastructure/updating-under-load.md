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

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы хотите создать сервисный аккаунт.
     1. В верхней части экрана перейдите на вкладку **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}**.
     1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
     1. В поле **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_field_name }}** укажите `for-load`.
     1. Нажмите значок ![](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** и выберите [роль](../../iam/concepts/access-control/roles.md) `editor`.
     1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

   - CLI {#cli}

     1. Создайте сервисный аккаунт:

        {% include [default-catalogue](../../_includes/default-catalogue.md) %}

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

     1. Назначьте роль сервисному аккаунту:

        ```bash
        yc resource-manager folder add-access-binding b0g12ga82bcv******** \
          --role editor \
          --subject serviceAccount:ajeab0cnib1p********
        ```

   - API {#api}

     1. Создайте сервисный аккаунт `for-load`:
         Воспользуйтесь методом REST API [create](../../iam/api-ref/ServiceAccount/create.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/Create](../../iam/api-ref/grpc/service_account_service.md#Create).
     1. Назначьте сервисному аккаунту в текущем каталоге роль `editor`:
         Воспользуйтесь методом REST API [setAccessBindings](../../resource-manager/api-ref/Folder/setAccessBindings.md) для ресурса [Folder](../../resource-manager/api-ref/Folder/index.md) или вызовом gRPC API [FolderService/SetAccessBindings](../../resource-manager/api-ref/grpc/folder_service.md#SetAccessBindings).

   {% endlist %}

1. Создайте [сеть](../../vpc/concepts/network.md#network) с именем `yc-auto-network` и [подсети](../../vpc/concepts/network.md#subnet) в двух [зонах доступности](../../overview/concepts/geo-scope.md):

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите создать сеть.
     1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
     1. Нажмите кнопку **{{ ui-key.yacloud.vpc.networks.button_create }}**.
     1. В поле **{{ ui-key.yacloud.vpc.networks.create.field_name }}** укажите `yc-auto-network`.
     1. Выберите опцию **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}**.
     1. Нажмите кнопку **{{ ui-key.yacloud.vpc.networks.button_create }}**.

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

     1. Создайте подсеть в зоне `{{ region-id }}-a`:

        ```bash
        yc vpc subnet create --network-id enpabce123hd******** --range 192.168.1.0/24 --zone {{ region-id }}-a
        ```

        Результат выполнения команды:

        ```bash
        id: e1lnabc23r1c********
        folder_id: b0g12ga82bcv********
        created_at: "2021-02-09T17:34:32.561702Z"
        network_id: enpabce123hd********
        zone_id: {{ region-id }}-a
        v4_cidr_blocks:
        - 192.168.1.0/24
        ```

     1. Создайте подсеть в зоне `{{ region-id }}-b`:

        ```bash
        yc vpc subnet create --network-id enpabce123hd******** --range 192.168.2.0/24 --zone {{ region-id }}-b
        ```

        Результат выполнения команды:

        ```bash
        id: b1csa2b3clid********
        folder_id: b0g12ga82bcv********
        created_at: "2021-02-09T17:35:32.561702Z"
        network_id: enpabce123hd********
        zone_id: {{ region-id }}-b
        v4_cidr_blocks:
        - 192.168.2.0/24
        ```

   - API {#api}

     1. Создайте сеть:
         Воспользуйтесь методом REST API [create](../../vpc/api-ref/Network/create.md) для ресурса [Network](../../vpc/api-ref/Network/index.md) или вызовом gRPC API [NetworkService/Create](../../vpc/api-ref/grpc/network_service.md#Create).
     1. Создайте подсети в зонах `{{ region-id }}-a` и `{{ region-id }}-b`:
         Воспользуйтесь методом REST API [create](../../vpc/api-ref/Subnet/create.md) для ресурса [Subnet](../../vpc/api-ref/Subnet/index.md) или вызовом gRPC API [SubnetService/Create](../../vpc/api-ref/grpc/subnet_service.md#Create).

   {% endlist %}

## Создайте группу ВМ с {{ coi }} {#create-vm-group}

1. Все ВМ группы создаются из образа [{{ coi }}](../../cos/concepts/index.md). Каждая ВМ содержит [Docker-контейнер](/blog/posts/2022/03/docker-containers) с веб-сервером, который эмулирует нагрузку на сервис.

   {% list tabs group=instructions %}

   
   - Консоль управления {#console}

     1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите создать группу ВМ.
     1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
     1. На панели слева выберите ![](../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.switch_groups }}**.
     1. Нажмите кнопку **{{ ui-key.yacloud.compute.groups.button_create }}**.
     1. В блоке **{{ ui-key.yacloud.compute.groups.create.section_base }}**:
        * В поле **{{ ui-key.yacloud.compute.groups.create.field_name }}** укажите `group-for-load`.
        * Выберите **{{ ui-key.yacloud.compute.groups.create.field_service-account }}** `for-load`.
     1. В блоке **{{ ui-key.yacloud.compute.groups.create.section_allocation }}** в поле **{{ ui-key.yacloud.compute.groups.create.field_zone }}** выберите `{{ region-id }}-a` и `{{ region-id }}-b`.
     1. В блоке **{{ ui-key.yacloud.compute.groups.create.section_instance }}** нажмите **{{ ui-key.yacloud.compute.groups.create.button_instance_empty-create }}** и в открывшемся окне:
        * В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** выберите вкладку **{{ ui-key.yacloud.compute.instances.create.image_value_coi }}**.
        * Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.image_coi_label_empty-button }}**.
        * В окне **{{ ui-key.yacloud.compute.instances.create.section_coi }}**:
          * В поле **{{ ui-key.yacloud.compute.instances.create.field_coi-name }}** укажите `nginx`.
          * В поле **{{ ui-key.yacloud.compute.instances.create.field_coi-image }}** нажмите **{{ ui-key.yacloud.component.image-field.button_custom-image }}** и введите `{{ registry }}/yc/demo/autoscaling-example-app:v1`.
          * Нажмите кнопку **{{ ui-key.yacloud.common.apply }}**.
        * В блоке **{{ ui-key.yacloud.compute.instances.create.section_disk }}**:
          * Для загрузочного диска укажите **{{ ui-key.yacloud.compute.instances.create.column_disk-size }}** `30 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
        * В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:
          * В поле **{{ ui-key.yacloud.compute.instances.create.field_instance-group-network }}** выберите `for-load`.
        * В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}**:
          * В поле **{{ ui-key.yacloud.compute.instances.create.field_service-account }}** выберите `for-load`.
          * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** укажите имя пользователя, который будет создан на ВМ.
          * В поле **{{ ui-key.yacloud.compute.instances.create.field_key }}** вставьте содержимое файла открытого ключа.
        * Нажмите кнопку **{{ ui-key.yacloud.compute.groups.create.button_edit }}**.
     1. В блоке **{{ ui-key.yacloud.compute.groups.create.section_deploy }}**:
        * В поле **{{ ui-key.yacloud.compute.groups.create.field_deploy-max-unavailable }}** введите `4`.
     1. В блоке **{{ ui-key.yacloud.compute.groups.create.section_scale }}**:
        * В поле **{{ ui-key.yacloud.compute.groups.create.field_scale-type }}** выберите `{{ ui-key.yacloud.compute.groups.create.value_scale-fixed }}`.
        * Введите **{{ ui-key.yacloud.compute.groups.create.field_scale-size }}** `6`.
     1. В блоке **{{ ui-key.yacloud.compute.groups.create.section_ylb }}**:
        * Включите опцию **{{ ui-key.yacloud.compute.groups.create.field_target-group-attached }}**.
        * В поле **{{ ui-key.yacloud.compute.groups.create.field_target-group-name }}** укажите `load-generator`.
     1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
 

   - CLI {#cli}

     1. Узнайте идентификатор последней версии [публичного образа](../../compute/operations/images-with-pre-installed-software/get-list.md) {{ coi }}.

        Образ {{ coi }} в реестре [{{ container-registry-full-name }}](../../container-registry/) может обновляться и меняться в соответствии с релизами. При этом образ на ВМ не обновится автоматически до последней версии. Чтобы создать группу ВМ с последней версией {{ coi }}, необходимо самостоятельно проверить ее наличие:

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
         id: cl0kabcquk1g********
         folder_id: b0g12ga82bcv********
         ...
         service_account_id: ajeab0cnib1p********
         status: ACTIVE
         application_load_balancer_state: {}
         ```

   - API {#api}

     1. Получите идентификатор последней версии образа `container-optimized-image` в семействе `standard-images`:
         Воспользуйтесь методом REST API [getLatestByFamily](../../compute/api-ref/Image/getLatestByFamily.md) для ресурса [Image](../../compute/api-ref/Image/index.md) или вызовом gRPC API [ImageService/GetLatestByFamily](../../compute/api-ref/grpc/image_service.md#GetLatestByFamily).
     1. Создайте группу ВМ по следующей спецификации:

         {% include [updating-under-load-yaml-spec-init](../../_includes/instance-groups/updating-under-load-yaml-spec-init.md) %}

         Воспользуйтесь методом REST API [createFromYaml](../../compute/api-ref/InstanceGroup/createFromYaml.md) для ресурса [InstanceGroup](../../compute/api-ref/InstanceGroup/index.md) или вызовом gRPC API [InstanceGroupService/CreateFromYaml](../../compute/api-ref/grpc/instance_group_service.md#CreateFromYaml).
     
   {% endlist %}
   
1. Убедитесь, что группа ВМ создана:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создали группу ВМ.
     1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
     1. На панели слева выберите ![](../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.switch_groups }}**.
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

     Чтобы посмотреть список созданных групп ВМ, воспользуйтесь методом REST API [list](../../compute/api-ref/InstanceGroup/list.md) для ресурса [InstanceGroup](../../compute/api-ref/InstanceGroup/index.md) или вызовом gRPC API [InstanceGroupService/List](../../compute/api-ref/grpc/instance_group_service.md#List).

   {% endlist %}

### Подключите сетевой балансировщик нагрузки к созданной группе виртуальных машин {#enable-balancer}

1. Создайте сетевой балансировщик нагрузки с именем `load-generator` и подключите его к созданной группе ВМ:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать балансировщик.
     1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
     1. Нажмите кнопку **{{ ui-key.yacloud.load-balancer.network-load-balancer.button_create }}**.
     1. В поле **{{ ui-key.yacloud.common.name }}** укажите `load-generator`.
     1. В поле **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_address-type }}** выберите `{{ ui-key.yacloud.common.label_auto }}`.
     1. В блоке **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.section_listeners }}** нажмите **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_add-listener }}**.
     1. В открывшемся окне:
        * В поле **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-name }}** укажите `http`.
        * В поле **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-port }}** укажите `80` — на нем балансировщик будет принимать входящий трафик.
        * В поле **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-target-port }}** укажите `80` — на него балансировщик будет направлять трафик.
        * Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.
     1. В блоке **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.section_target-groups }}** нажмите **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_add-target-group }}**.
     1. В списке **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_target-group-id }}** выберите `load-generator`.
     1. В блоке **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check }}** нажмите **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_edit-health-check }}**:
        * В открывшемся окне укажите **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-path }}** `/hello` — по этому пути балансировщик будет отправлять запросы для проверки состояния ВМ из целевой группы.
        * Нажмите кнопку **{{ ui-key.yacloud.common.apply }}**.
     1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

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

     1. Создайте балансировщик нагрузки с помощью метода REST API [create](../../network-load-balancer/api-ref/NetworkLoadBalancer/create.md) для ресурса [NetworkLoadBalancer](../../network-load-balancer/api-ref/NetworkLoadBalancer/index.md) или вызова gRPC API [NetworkLoadBalancerService/Create](../../network-load-balancer/api-ref/grpc/network_load_balancer_service.md#Create).
     1. Добавьте обработчик к балансировщику с помощью метода REST API [addListener](../../network-load-balancer/api-ref/NetworkLoadBalancer/addListener.md) для ресурса `NetworkLoadBalancer` или вызова gRPC API [NetworkLoadBalancerService/AddListener](../../network-load-balancer/api-ref/grpc/network_load_balancer_service.md#AddListener).
     1. Подключите целевую группу к балансировщику с помощью метода REST API [attachTargetGroup](../../network-load-balancer/api-ref/NetworkLoadBalancer/attachTargetGroup.md) для ресурса `NetworkLoadBalancer` или вызова gRPC API [NetworkLoadBalancerService/AttachTargetGroup](../../network-load-balancer/api-ref/grpc/network_load_balancer_service.md#AttachTargetGroup).
     1. Подключите балансировщик к группе ВМ с помощью метода REST API [addTargets](../../network-load-balancer/api-ref/TargetGroup/addTargets.md) для ресурса [TargetGroup](../../network-load-balancer/api-ref/TargetGroup/index.md) или вызова gRPC API [TargetGroupService/AddTargets](../../network-load-balancer/api-ref/grpc/target_group_service.md#AddTargets).

   {% endlist %}

1. Убедитесь, что сетевой балансировщик `load-generator` создан и привязан к группе ВМ:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создали сетевой балансировщик.
     1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
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
     | b0ruab1ccvpd******** | load-generator | {{ region-id }}     | EXTERNAL |              1 | b0r1tabcphde********   | ACTIVE |
     +----------------------+----------------+-----------------+----------+----------------+------------------------+--------+
     ```
     
     

   - API {#api}

     Воспользуйтесь методом REST API [list](../../network-load-balancer/api-ref/NetworkLoadBalancer/list.md) для ресурса [NetworkLoadBalancer](../../network-load-balancer/api-ref/NetworkLoadBalancer/index.md) или вызовом gRPC API [NetworkLoadBalancerService/List](../../network-load-balancer/api-ref/grpc/network_load_balancer_service.md#List).

   {% endlist %}

## Создайте нагрузку на ВМ {#start-load-testing}

1. Получите IP-адрес созданного балансировщика:

   {% list tabs group=instructions %}
   
   - Консоль управления {#console}
   
     1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится балансировщик.
     1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
     1. Скопируйте **{{ ui-key.yacloud.load-balancer.network-load-balancer.column_ip-address }}** балансировщика `load-generator`.
     
   - CLI {#cli}
   
     ```bash
     yc load-balancer network-load-balancer get load-generator | grep "address"
     ```
     
     Результат выполнения команды:

     ```bash
       address: 84.252.133.110
     ```
     
   - API {#api}
   
     Воспользуйтесь методом REST API [get](../../network-load-balancer/api-ref/NetworkLoadBalancer/get.md) для ресурса [NetworkLoadBalancer](../../network-load-balancer/api-ref/NetworkLoadBalancer/index.md) или вызовом gRPC API [NetworkLoadBalancerService/Get](../../network-load-balancer/api-ref/grpc/network_load_balancer_service.md#Get).
     
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

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создали группу ВМ.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![](../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.switch_groups }}**.
  1. Нажмите на имя группы ВМ `group-for-load`.
  1. Нажмите кнопку ![edit](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.compute.groups.button_action-edit }}**.
  1. В блоке **{{ ui-key.yacloud.compute.groups.create.section_instance }}** нажмите ![horizontal-ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.edit }}**.
     * В блоке **{{ ui-key.yacloud.compute.instances.create.section_disk }}** укажите новый размер диска — `35 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
     * Нажмите кнопку **{{ ui-key.yacloud.compute.groups.create.button_edit }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.
  1. В блоке **{{ ui-key.yacloud.compute.group.overview.section_instances-state }}** поэтапно отобразятся изменения размера диска для всех ВМ группы.

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

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. Удалите балансировщик нагрузки:
      1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создали балансировщик нагрузки.
      1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
      1. Справа в строке балансировщика `load-generator` нажмите ![horizontal-ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.remove }}**.
      1. В открывшемся окне нажмите **{{ ui-key.yacloud.common.remove }}**.
   1. Удалите группу ВМ:
      1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создали группу ВМ.
      1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
      1. На панели слева выберите ![](../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.switch_groups }}**.
      1. Справа в строке группы `load-generator` нажмите ![horizontal-ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.compute.groups.button_action-delete }}**.
      1. В открывшемся окне нажмите **{{ ui-key.yacloud.compute.groups.popup-confirm_button_delete }}**.
   1. Удалите сервисный аккаунт:
      1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создали сервисный аккаунт.
      1. Перейдите на вкладку **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}**.
      1. Справа в строке аккаунта `yc-auto-sa` нажмите ![horizontal-ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.iam.folder.service-accounts.button_action-delete }}**.
      1. В открывшемся окне нажмите **{{ ui-key.yacloud.iam.folder.service-accounts.popup-confirm_button_delete }}**.
   1. Удалите сеть и подсети:
      1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создали сеть и подсети.
      1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
      1. Выберите сеть `yc-auto-network`.
      1. В блоке **{{ ui-key.yacloud.vpc.network.overview.section_subnetworks }}**:
         1. Справа в строке подсети `yc-auto-subnet-1` нажмите ![horizontal-ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.delete }}**.
         1. В открывшемся окне нажмите **{{ ui-key.yacloud.common.delete }}**.
         1. Также удалите подсеть `yc-auto-subnet-2`.
      1. В правом верхнем углу нажмите **{{ ui-key.yacloud.common.delete }}**.

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

  1. Удалите балансировщик `load-generator`: воспользуйтесь методом REST API [delete](../../network-load-balancer/api-ref/NetworkLoadBalancer/delete.md) для ресурса [NetworkLoadBalancer](../../network-load-balancer/api-ref/NetworkLoadBalancer/index.md) или вызовом gRPC API [NetworkLoadBalancerService/Delete](../../network-load-balancer/api-ref/grpc/network_load_balancer_service.md#Delete).
  1. Удалите группу ВМ `load-generator`: воспользуйтесь методом REST API [delete](../../compute/api-ref/InstanceGroup/delete.md) для ресурса [InstanceGroup](../../compute/api-ref/InstanceGroup/index.md) или вызовом gRPC API [InstanceGroupService/Delete](../../compute/api-ref/grpc/instance_group_service.md#Delete).
  1. Удалите сервисный аккаунт `yc-auto-sa`: воспользуйтесь методом REST API [delete](../../iam/api-ref/ServiceAccount/delete.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/Delete](../../iam/api-ref/grpc/service_account_service.md#Delete).
  1. Удалите подсети `yc-auto-subnet-1` и `yc-auto-subnet-2`: воспользуйтесь методом REST API [delete](../../vpc/api-ref/Subnet/delete.md) для ресурса [Subnet](../../vpc/api-ref/Subnet/index.md) или вызовом gRPC API [SubnetService/Delete](../../vpc/api-ref/grpc/subnet_service.md#Delete).
  1. Удалите сеть `yc-auto-network`: воспользуйтесь методом REST API [delete](../../vpc/api-ref/Network/delete.md) для ресурса [Network](../../vpc/api-ref/Network/index.md) или вызовом gRPC API [NetworkService/Delete](../../vpc/api-ref/grpc/network_service.md#Delete).

{% endlist %}