# Создание группы виртуальных машин с {{ coi }} и несколькими Docker-контейнерами

Вы можете создать [группу виртуальных машин](../../compute/concepts/instance-groups/index.md) на базе [образа](../../compute/concepts/image.md) [{{ coi }}](../../cos/concepts/index.md) с несколькими [Docker-контейнерами](/blog/posts/2022/03/docker-containers) внутри.

Для создания Docker-контейнеров будет использоваться [Docker Compose спецификация](../../cos/concepts/coi-specifications.md#compose-spec).

{% include [warning.md](warning.md) %}

## Перед началом работы {#before-you-begin}

{% include [cli-install.md](../cli-install.md) %}

{% include [default-catalogue.md](../default-catalogue.md) %}

## Подготовьте окружение {#prepare}

1. Создайте [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) с именем `group-coi` и назначьте ему [роль](../../iam/concepts/access-control/roles.md) `editor`:

   {% list tabs %}

   - Консоль управления

     1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы хотите создать сервисный аккаунт.
     1. В верхней части экрана перейдите на вкладку **Сервисные аккаунты**.
     1. Нажмите кнопку **Создать сервисный аккаунт**.
     1. Введите имя `group-coi`.
     1. Чтобы назначить сервисному аккаунту роль на текущий каталог, нажмите **Добавить роль** и выберите роль `editor`.
     1. Нажмите кнопку **Создать**.

   - CLI

     1. Создайте сервисный аккаунт:

        ```bash
        yc iam service-account create --name group-coi
        ```

        Результат:

        ```bash
        id: ajeabccde01d23efl1v5
        folder_id: b0g12ga82bcv0cdeferg
        created_at: "2023-03-13T14:32:18.900092Z"
        name: group-coi
        ```

     1. Назначьте роль сервисному аккаунту:

        ```bash
        yc resource-manager folder add-access-binding b0g12ga82bcv0cdeferg \
          --role editor \
          --subject serviceAccount:ajeabccde01d23efl1v5
        ```

   - API

     Воспользуйтесь методом [Create](../../iam/api-ref/ServiceAccount/create.md) для ресурса `ServiceAccount`.

   {% endlist %}

1. Создайте [сеть](../../vpc/concepts/network.md#network) с именем `yc-auto-network` и [подсеть](../../vpc/concepts/network.md#subnet) в одной [зоне доступности](../../overview/concepts/geo-scope.md):

   {% list tabs %}

   - Консоль управления

     1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите создать сеть.
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

        Результат:

        ```bash
        id: enpabce123hde4ft1r3t
        folder_id: b0g12ga82bcv0cdeferg
        created_at: "2023-03-13T14:57:15Z"
        name: yc-auto-network
        ```

     1. Создайте подсеть в зоне доступности `{{ region-id }}-a`:

        ```bash
        yc vpc subnet create --network-id enpabce123hde4ft1r3t --range 192.168.1.0/24 --zone {{ region-id }}-a
        ```

        Результат:

        ```bash
        id: e1lnabc23r1c9d0efoje
        folder_id: b0g12ga82bcv0cdeferg
        created_at: "2023-03-13T16:23:12Z"
        network_id: enpabce123hde4ft1r3t
        zone_id: {{ region-id }}-a
        v4_cidr_blocks:
        - 192.168.1.0/24
        ```

   - API

     1. Создайте сеть с помощью метода [Create](../../vpc/api-ref/Network/create.md) для ресурса `Networks`.
     1. Создать подсеть в зоне доступности `{{ region-id }}-a` с помощью метода [Create](../../vpc/api-ref/Subnet/create.md) для ресурса `Subnets`.

   {% endlist %}

## Создайте группу ВМ с {{ coi }} и несколькими Docker-контейнерами {#create}

1. {% include [get-latest-coi](../container-registry/get-latest-coi.md) %}

1. Сохраните спецификацию группы ВМ с {{ coi }} и несколькими Docker-контейнерами в файл `specification.yaml`:

   ```yaml
   name: group-coi-containers # Имя группы ВМ, уникальным в рамках каталога.
   service_account_id: ajeabccde01d23efl1v5 # Идентификатор сервисного аккаунта.
   instance_template:
     service_account_id: ajeabccde01d23efl1v5 # Идентификатор сервисного аккаунта для доступа к приватным Docker-образам.
     platform_id: standard-v3 # Идентификатор платформы.
     resources_spec:
       memory: 2G # Количество памяти (RAM).
       cores: 2 # Количество ядер процессора (vCPU).
     boot_disk_spec:
       mode: READ_WRITE # Режим доступа к диску: чтение и запись.
       disk_spec:
         image_id: <идентификатор последней версии COI>
         type_id: network-hdd # Тип диска.
         size: 32G # Размер диска. Должен быть не менее 30 ГБ.
     network_interface_specs:
      - network_id: enpabce123hde4ft1r3t # Идентификатор сети.
        subnet_ids:
          - e1lnabc23r1c9d0efoje # Идентификатор подсети.
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
   allocation_policy: # Политика распределения ВМ по зонам и регионам.
     zones:
       - zone_id: {{ region-id }}-a
   ```

   {% note info %}

   Передать [SSH-ключ](../../glossary/ssh-keygen.md) в [метаданных ВМ](../../compute/concepts/vm-metadata.md#keys-processed-in-public-images) можно с помощью параметра `ssh-keys` или в строке с пользовательскими метаданными `user-data`. В этом практическом руководстве используется первый вариант.

   {% endnote %}

1. Создайте группу ВМ с именем `group-coi-containers` с помощью спецификации `specification.yaml`:

   {% list tabs %}

   - CLI

     Выполните команду:

     ```bash
     yc compute instance-group create --file=specification.yaml
     ```

     Результат:

     ```bash
     done (48s)
     id: cl0q12abcd4ef8m966de
     folder_id: b0g12ga82bcv0cdeferg
     ...
       target_size: "2"
     service_account_id: ajeabccde01d23efl1v5
     status: ACTIVE
     ```

   - API

     Воспользуйтесь методом [CreateFromYaml](../../compute/api-ref/InstanceGroup/createFromYaml.md) для ресурса `InstanceGroup`.

   {% endlist %}

1. Убедитесь, что группа ВМ с {{ coi }} и несколькими Docker-контейнерами создана:

   {% list tabs %}

   - Консоль управления

     1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создали группу ВМ.
     1. Выберите сервис **{{ compute-name }}**.
     1. Перейдите в раздел **Группы виртуальных машин**.
     1. Нажмите на имя группы ВМ `group-coi-containers`.

   - CLI

     ```bash
     yc compute instance-group list-instances group-coi-containers
     ```

     Результат:

     ```bash
     +----------------------+---------------------------+----------------------------------+-------------+------------------------+----------------+
     |     INSTANCE ID      |           NAME            |            EXTERNAL IP           | INTERNAL IP |         STATUS         | STATUS MESSAGE |
     +----------------------+---------------------------+----------------------------------+-------------+------------------------+----------------+
     | fhmabcv0de123fo50d0b | cl0q12abcs4gq8m966de-fmar | {{ cos-external-ip-examples.0 }} | 10.130.0.14 | RUNNING_ACTUAL [2h35m] |                |
     | fhmab0cdqj12tcv18jou | cl0q12abcs4gq8m966de-fqeg | {{ cos-external-ip-examples.1 }} | 10.130.0.47 | RUNNING_ACTUAL [2h35m] |                |
     +----------------------+---------------------------+----------------------------------+-------------+------------------------+----------------+
     ```

   - API

     Посмотрите список созданных ВМ с помощью метода [List](../../compute/api-ref/InstanceGroup/list.md) для ресурса `InstanceGroup`.

   {% endlist %}

## Проверьте группу ВМ с {{ coi }} и несколькими Docker-контейнерами {#check}

1. [Подключитесь](../../compute/operations/vm-connect/ssh.md#vm-connect) к одной из созданных ВМ по SSH:

   {% list tabs %}

   - CLI

     ```bash
     ssh yc-user@{{ cos-external-ip-examples.0 }}
     ```

     Результат:

     ```bash
     Welcome to Ubuntu 20.04.1 LTS (GNU/Linux 5.4.0-54-generic x86_64)

      * Documentation:  https://help.ubuntu.com
      * Management:     https://landscape.canonical.com
      * Support:        https://ubuntu.com/advantage
     Last login: Mon Mar 13 15:23:28 2023 from 123.456.789.101
     ```

   {% endlist %}

1. Посмотрите список запущенных на ВМ Docker-контейнеров:

   {% list tabs %}

   - CLI

     ```bash
     sudo docker ps -a
     ```

     Результат:

     ```bash
     CONTAINER ID  IMAGE  COMMAND                 CREATED             STATUS             PORTS               NAMES
     c0a125a1765a  redis  "docker-entrypoint.s…"  About a minute ago  Up About a minute  6379/tcp            redis
     01288d7e382f  nginx  "/docker-entrypoint.…"  About a minute ago  Up About a minute  0.0.0.0:80->80/tcp  nginx
     ```

   {% endlist %}