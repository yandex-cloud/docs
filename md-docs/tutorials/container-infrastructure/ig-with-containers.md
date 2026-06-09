# Создание группы виртуальных машин с Container Optimized Image и несколькими Docker-контейнерами

Вы можете создать [группу виртуальных машин](../../compute/concepts/instance-groups/index.md) на базе [образа](../../compute/concepts/image.md) [Container Optimized Image](../../cos/concepts/index.md) с несколькими [Docker-контейнерами](https://yandex.cloud/ru/blog/posts/2022/03/docker-containers) внутри.

Для создания Docker-контейнеров будет использоваться [Docker Compose спецификация](../../cos/concepts/coi-specifications.md#compose-spec).

{% note alert %}

Создавая группы ВМ, учитывайте [лимиты](../../compute/concepts/limits.md). Чтобы не нарушить работу компонента Instance Groups, не изменяйте и не удаляйте вручную созданные им ресурсы: [целевую группу](../../network-load-balancer/concepts/target-resources.md) Network Load Balancer, ВМ и диски. Вместо этого измените или удалите группу полностью.

{% endnote %}

## Перед началом работы {#before-you-begin}

Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

## Подготовьте окружение {#prepare}

1. Создайте [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) с именем `group-coi` и назначьте ему [роль](../../iam/concepts/access-control/roles.md) `editor`:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы хотите создать сервисный аккаунт.
     1. Перейдите в сервис **Identity and Access Management**.
     1. Нажмите кнопку **Создать сервисный аккаунт**.
     1. Введите имя `group-coi`.
     1. Чтобы назначить сервисному аккаунту роль на текущий каталог, нажмите **Добавить роль** и выберите роль `editor`.
     1. Нажмите кнопку **Создать**.

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

     1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы хотите создать сеть.
     1. Перейдите в сервис **Virtual Private Cloud**.
     1. Нажмите кнопку **Создать сеть**.
     1. Задайте имя сети `yc-auto-network`.
     1. Выберите дополнительную опцию **Создать подсети**.
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
        created_at: "2023-03-13T14:57:15Z"
        name: yc-auto-network
        ```

     1. Создайте подсеть в зоне доступности `ru-central1-a`:

        ```bash
        yc vpc subnet create --network-id enpabce123hd******** --range 192.168.1.0/24 --zone ru-central1-a
        ```

        Результат:

        ```text
        id: e1lnabc23r1c********
        folder_id: b0g12ga82bcv********
        created_at: "2023-03-13T16:23:12Z"
        network_id: enpabce123hd********
        zone_id: ru-central1-a
        v4_cidr_blocks:
        - 192.168.1.0/24
        ```

   - API {#api}

     1. Создайте сеть с помощью метода [Create](../../vpc/api-ref/Network/create.md) для ресурса `Networks`.
     1. Создать подсеть в зоне доступности `ru-central1-a` с помощью метода [Create](../../vpc/api-ref/Subnet/create.md) для ресурса `Subnets`.

   {% endlist %}

## Создайте группу ВМ с Container Optimized Image и несколькими Docker-контейнерами {#create}

1. Узнайте идентификатор последней версии [публичного образа](../../compute/operations/images-with-pre-installed-software/get-list.md) Container Optimized Image.
   
   Образ Container Optimized Image в реестре [Container Registry](../../container-registry/index.md) может обновляться и меняться в соответствии с релизами. При этом образ на [виртуальной машине](../../compute/concepts/vm.md) не обновится автоматически до последней версии. Чтобы создать [группу ВМ](../../compute/concepts/instance-groups/index.md) с последней версией Container Optimized Image, необходимо самостоятельно проверить ее наличие:
   
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

1. Сохраните спецификацию группы ВМ с Container Optimized Image и несколькими Docker-контейнерами в файл `specification.yaml`:

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
       - zone_id: ru-central1-a
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

1. Убедитесь, что группа ВМ с Container Optimized Image и несколькими Docker-контейнерами создана:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы создали группу ВМ.
     1. Перейдите в сервис **Compute Cloud**.
     1. Перейдите в раздел **Группы виртуальных машин**.
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
     | fhmabcv0de12******** | cl0q12abcs4g********-fmar | 84.201.155.117                   | 10.130.0.14 | RUNNING_ACTUAL [2h35m] |                |
     | fhmab0cdqj12******** | cl0q12abcs4g********-fqeg | 84.252.131.221                   | 10.130.0.47 | RUNNING_ACTUAL [2h35m] |                |
     +----------------------+---------------------------+----------------------------------+-------------+------------------------+----------------+
     ```

   - API {#api}

     Посмотрите список созданных ВМ с помощью метода [List](../../compute/instancegroup/api-ref/InstanceGroup/list.md) для ресурса `InstanceGroup`.

   {% endlist %}

## Проверьте группу ВМ с Container Optimized Image и несколькими Docker-контейнерами {#check}

1. [Подключитесь](../../compute/operations/vm-connect/ssh.md#vm-connect) к одной из созданных ВМ по SSH:

   {% list tabs group=instructions %}

   - CLI {#cli}

     ```bash
     ssh yc-user@84.201.155.117
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