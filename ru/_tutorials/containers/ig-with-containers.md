# Создание группы виртуальных машин с {{ coi }} и несколькими Docker-контейнерами

Вы можете создать [группу виртуальных машин](../../compute/concepts/instance-groups/index.md) на базе [образа](../../compute/concepts/image.md) [{{ coi }}](../../cos/concepts/index.md) с несколькими [Docker-контейнерами](/blog/posts/2022/03/docker-containers) внутри.

Для создания Docker-контейнеров будет использоваться [Docker Compose спецификация](../../cos/concepts/coi-specifications.md#compose-spec).

{% include [warning.md](../../_includes/instance-groups/warning.md) %}

## Перед началом работы {#before-you-begin}

{% include [cli-install.md](../../_includes/cli-install.md) %}

{% include [default-catalogue.md](../../_includes/default-catalogue.md) %}

## Подготовьте окружение {#prepare}

1. Создайте [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) с именем `group-coi` и назначьте ему [роль](../../iam/concepts/access-control/roles.md) `editor`:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы хотите создать сервисный аккаунт.
     1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
     1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
     1. Введите имя `group-coi`.
     1. Чтобы назначить сервисному аккаунту роль на текущий каталог, нажмите **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** и выберите роль `editor`.
     1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

   - CLI {#cli}

     1. Создайте сервисный аккаунт:

        ```bash
        yc iam service-account create --name group-coi
        ```

        Результат:

        ```text
        id: ajeabccde01d********
        folder_id: b0g12ga82bcv********
        created_at: "2023-03-13T14:32:18.900092Z"
        name: group-coi
        ```

     1. Назначьте роль сервисному аккаунту:

        ```bash
        yc resource-manager folder add-access-binding b0g12ga82bcv******** \
          --role editor \
          --subject serviceAccount:ajeabccde01d********
        ```

   - API {#api}

     Воспользуйтесь методом [Create](../../iam/api-ref/ServiceAccount/create.md) для ресурса `ServiceAccount`.

   {% endlist %}

1. Создайте [сеть](../../vpc/concepts/network.md#network) с именем `yc-auto-network` и [подсеть](../../vpc/concepts/network.md#subnet) в одной [зоне доступности](../../overview/concepts/geo-scope.md):

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите создать сеть.
     1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
     1. Нажмите кнопку **{{ ui-key.yacloud.vpc.networks.button_create }}**.
     1. Задайте имя сети `yc-auto-network`.
     1. Выберите дополнительную опцию **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}**.
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
        created_at: "2023-03-13T14:57:15Z"
        name: yc-auto-network
        ```

     1. Создайте подсеть в зоне доступности `{{ region-id }}-a`:

        ```bash
        yc vpc subnet create --network-id enpabce123hd******** --range 192.168.1.0/24 --zone {{ region-id }}-a
        ```

        Результат:

        ```text
        id: e1lnabc23r1c********
        folder_id: b0g12ga82bcv********
        created_at: "2023-03-13T16:23:12Z"
        network_id: enpabce123hd********
        zone_id: {{ region-id }}-a
        v4_cidr_blocks:
        - 192.168.1.0/24
        ```

   - API {#api}

     1. Создайте сеть с помощью метода [Create](../../vpc/api-ref/Network/create.md) для ресурса `Networks`.
     1. Создать подсеть в зоне доступности `{{ region-id }}-a` с помощью метода [Create](../../vpc/api-ref/Subnet/create.md) для ресурса `Subnets`.

   {% endlist %}

## Создайте группу ВМ с {{ coi }} и несколькими Docker-контейнерами {#create}

1. {% include [get-latest-coi](../../_includes/container-registry/get-latest-coi.md) %}

1. Сохраните спецификацию группы ВМ с {{ coi }} и несколькими Docker-контейнерами в файл `specification.yaml`:

   ```yaml
   name: group-coi-containers # Имя группы ВМ, уникальным в рамках каталога.
   service_account_id: ajeabccde01d******** # Идентификатор сервисного аккаунта.
   instance_template:
     service_account_id: ajeabccde01d******** # Идентификатор сервисного аккаунта для доступа к приватным Docker-образам.
     platform_id: standard-v3 # Идентификатор платформы.
     resources_spec:
       memory: 2G # Количество памяти (RAM).
       cores: 2 # Количество ядер процессора (vCPU).
     boot_disk_spec:
       mode: READ_WRITE # Режим доступа к диску: чтение и запись.
       disk_spec:
         image_id: <идентификатор_последней_версии_COI>
         type_id: network-hdd # Тип диска.
         size: 32G # Размер диска. Должен быть не менее 30 ГБ.
     network_interface_specs:
      - network_id: enpabce123hd******** # Идентификатор сети.
        subnet_ids:
          - e1lnabc23r1c******** # Идентификатор подсети.
        primary_v4_address_spec: {
          one_to_one_nat_spec: {
            ip_version: IPV4 # Спецификация версии интернет-протокола IPv4 для публичного доступа к ВМ.
          }
        }
     metadata: # Значения, которые будут переданы в метаданные ВМ.
      docker-compose: |- # Ключ в метаданных ВМ, при котором используется Docker Compose спецификация.
        version: '3.7'
        services:
          app1:
            container_name: nginx
            image: "nginx"
            ports:
              - "80:80"
            restart: always
          app2:
            container_name: redis
            image: "redis"
            restart: always
      ssh-keys: | # Параметр для передачи SSH-ключа на ВМ.
        yc-user:ssh-ed25519 ABC...d01 user@desktop.ru # Имя пользователя для подключения к ВМ.
   deploy_policy: # Политика развертывания ВМ в группе.
     max_unavailable: 1
     max_expansion: 0
   scale_policy: # Политика масштабирования ВМ в группе.
     fixed_scale:
       size: 2
   allocation_policy: # Политика распределения ВМ по зонам доступности.
     zones:
       - zone_id: {{ region-id }}-a
   ```

   {% note info %}

   Передать [SSH-ключ](../../glossary/ssh-keygen.md) в [метаданных ВМ](../../compute/concepts/vm-metadata.md) можно с помощью параметра `ssh-keys` или в ключе с пользовательскими метаданными `user-data`. В этом практическом руководстве используется первый вариант.

   {% endnote %}

1. Создайте группу ВМ с именем `group-coi-containers` с помощью спецификации `specification.yaml`:

   {% list tabs group=instructions %}

   - CLI {#cli}

     Выполните команду:

     ```bash
     yc compute instance-group create --file=specification.yaml
     ```

     Результат:

     ```text
     done (48s)
     id: cl0q12abcd4e********
     folder_id: b0g12ga82bcv********
     ...
       target_size: "2"
     service_account_id: ajeabccde01d********
     status: ACTIVE
     ```

   - API {#api}

     Воспользуйтесь методом [CreateFromYaml](../../compute/instancegroup/api-ref/InstanceGroup/createFromYaml.md) для ресурса `InstanceGroup`.

   {% endlist %}

1. Убедитесь, что группа ВМ с {{ coi }} и несколькими Docker-контейнерами создана:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создали группу ВМ.
     1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
     1. Перейдите в раздел **{{ ui-key.yacloud.compute.switch_groups }}**.
     1. Нажмите на имя группы ВМ `group-coi-containers`.

   - CLI {#cli}

     ```bash
     yc compute instance-group list-instances group-coi-containers
     ```

     Результат:

     ```text
     +----------------------+---------------------------+----------------------------------+-------------+------------------------+----------------+
     |     INSTANCE ID      |           NAME            |            EXTERNAL IP           | INTERNAL IP |         STATUS         | STATUS MESSAGE |
     +----------------------+---------------------------+----------------------------------+-------------+------------------------+----------------+
     | fhmabcv0de12******** | cl0q12abcs4g********-fmar | {{ external-ip-examples.0 }}                   | 10.130.0.14 | RUNNING_ACTUAL [2h35m] |                |
     | fhmab0cdqj12******** | cl0q12abcs4g********-fqeg | {{ external-ip-examples.1 }}                   | 10.130.0.47 | RUNNING_ACTUAL [2h35m] |                |
     +----------------------+---------------------------+----------------------------------+-------------+------------------------+----------------+
     ```

   - API {#api}

     Посмотрите список созданных ВМ с помощью метода [List](../../compute/instancegroup/api-ref/InstanceGroup/list.md) для ресурса `InstanceGroup`.

   {% endlist %}

## Проверьте группу ВМ с {{ coi }} и несколькими Docker-контейнерами {#check}

1. [Подключитесь](../../compute/operations/vm-connect/ssh.md#vm-connect) к одной из созданных ВМ по SSH:

   {% list tabs group=instructions %}

   - CLI {#cli}

     ```bash
     ssh yc-user@{{ external-ip-examples.0 }}
     ```

     Результат:

     ```text
     Welcome to Ubuntu 20.04.1 LTS (GNU/Linux 5.4.0-54-generic x86_64)

      * Documentation:  https://help.ubuntu.com
      * Management:     https://landscape.canonical.com
      * Support:        https://ubuntu.com/advantage
     Last login: Mon Mar 13 15:23:28 2023 from 123.456.789.101
     ```

   {% endlist %}

1. Посмотрите список запущенных на ВМ Docker-контейнеров:

   {% list tabs group=instructions %}

   - CLI {#cli}

     ```bash
     sudo docker ps -a
     ```

     Результат:

     ```text
     CONTAINER ID  IMAGE  COMMAND                 CREATED             STATUS             PORTS               NAMES
     c0a125a1765a  redis  "docker-entrypoint.s…"  About a minute ago  Up About a minute  6379/tcp            redis
     01288d7e382f  nginx  "/docker-entrypoint.…"  About a minute ago  Up About a minute  0.0.0.0:80->80/tcp  nginx
     ```

   {% endlist %}