# Управление виртуальными машинами пула резервов ВМ

{% note warning %}

Пулы резервов ВМ тарифицируются: взимается плата за весь свободный объем зарезервированных вычислительных ресурсов ВМ, кластеров GPU и программно ускоренных сетей согласно [правилам тарификации Yandex Compute Cloud](../../pricing.md). Подробнее в разделе [Использование пулов резервов ВМ](../../pricing.md#pool).

{% endnote %}

_Функциональность пулов резервов ВМ находится на [стадии Preview](../../../overview/concepts/launch-stages.md)._

Вы можете привязывать к пулам резервов ВМ как вновь создаваемые, так и существующие виртуальные машины. Подробнее в разделе [Пулы резервов виртуальных машин в Compute Cloud](../../concepts/reserved-pools.md).

{% note info %}

К пулу резервов ВМ нельзя привязать виртуальную машину с конфигурацией ([платформа](../../concepts/vm-platforms.md), vCPU, RAM), отличной от конфигурации, которая задана в настройках пула.

{% endnote %}

## Посмотреть список ВМ, привязанных к пулу {#list-pool-instances}

Чтобы посмотреть список виртуальных машин, привязанных к пулу резервов ВМ:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится пул резервов ВМ.
  1. Перейдите в сервис **Compute Cloud**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/folder-lock.svg) **Пулы резервов ВМ**.
  1. Выберите нужный пул.
  1. На панели слева перейдите в раздел ![image](../../../_assets/console-icons/server.svg) **Виртуальные машины**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды [Yandex Cloud CLI](../../../cli/index.md) для создания ВМ:

      ```bash
      yc compute reserved-instance-pool list --help
      ```
  1. Получите список пулов резервов ВМ в каталоге по умолчанию:
     
     ```bash
     yc compute reserved-instance-pool list
     ```
     
     Результат:
     
     ```text
     +----------------------+------------+---------------+------+
     |          ID          |    NAME    |    ZONE ID    | SIZE |
     +----------------------+------------+---------------+------+
     | fv48qa9iiq19******** | test-pool1 | ru-central1-a |    1 |
     | fv42fbsrso94******** | test-pool2 | ru-central1-a |    1 |
     +----------------------+------------+---------------+------+
     ```
  1. Посмотрите список ВМ, привязанных к пулу, указав его имя или идентификатор:

      ```bash
      yc compute reserved-instance-pool list-instances <имя_или_идентификатор_пула>
      ```
      
      Результат:
      
      ```text
      +----------------------+-------------------+---------------+---------+----------------+-------------+
      |          ID          |       NAME        |    ZONE ID    | STATUS  |  EXTERNAL IP   | INTERNAL IP |
      +----------------------+-------------------+---------------+---------+----------------+-------------+
      | fv4mkphl5q09******** | my-sample-pool-vm | ru-central1-a | RUNNING | 158.160.***.** | 192.168.3.8 |
      | fv4mfp4fj6f0******** | my-second-pool-vm | ru-central1-a | RUNNING | 158.165.***.** | 192.168.3.12 |
      +----------------------+-------------------+---------------+---------+----------------+-------------+
      ```

- API {#api}

  Воспользуйтесь методом REST API [ListInstances](../../api-ref/ReservedInstancePool/listInstances.md) для ресурса [ReservedInstancePool](../../api-ref/ReservedInstancePool/index.md) или вызовом gRPC API [ReservedInstancePoolService/ListInstances](../../api-ref/grpc/ReservedInstancePool/listInstances.md), передав в поле `reservedInstancePoolId` (`reserved_instance_pool_id` для gRPC API) идентификатор нужного пула.

{% endlist %}

## Создать новую ВМ с привязкой к пулу {#attach-new-vm}

Чтобы создать новую виртуальную машину в пуле резервов ВМ:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится пул резервов ВМ.
  1. Перейдите в сервис **Compute Cloud**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/folder-lock.svg) **Пулы резервов ВМ**.
  1. В строке с нужным пулом нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../_assets/console-icons/plug-connection.svg) **Создать ВМ**.
  1. Настройте параметры создаваемой ВМ. Подробнее см. [Создание виртуальной машины](../index.md#vm-create).
  1. Нажмите кнопку **Создать ВМ**.
  
  ВМ появится в списке. При создании ВМ назначаются [IP-адрес](../../../vpc/concepts/address.md) и [имя хоста](../../../vpc/concepts/address.md#fqdn) (FQDN).

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды [Yandex Cloud CLI](../../../cli/index.md) для создания ВМ:

      ```bash
      yc compute instance create --help
      ```
  1. Получите список пулов резервов ВМ в каталоге по умолчанию:
     
     ```bash
     yc compute reserved-instance-pool list
     ```
     
     Результат:
     
     ```text
     +----------------------+------------+---------------+------+
     |          ID          |    NAME    |    ZONE ID    | SIZE |
     +----------------------+------------+---------------+------+
     | fv48qa9iiq19******** | test-pool1 | ru-central1-a |    1 |
     | fv42fbsrso94******** | test-pool2 | ru-central1-a |    1 |
     +----------------------+------------+---------------+------+
     ```
  1. Создайте виртуальную машину в пуле резервов ВМ:

      ```bash
      yc compute instance create \
        --name <имя_ВМ> \
        --zone <идентификатор_зоны_доступности> \
        --reserved-instance-pool-id <идентификатор_пула> \
        --network-interface subnet-name=<имя_подсети>,nat-ip-version=ipv4 \
        --create-boot-disk image-folder-id=standard-images,image-id=<идентификатор_образа> \
        --ssh-key <путь_к_SSH-ключу>
      ```

      Где:
      * `--name` — имя создаваемой ВМ. Требования к имени:

          * длина — от 3 до 63 символов;
          * может содержать строчные буквы латинского алфавита, цифры и дефисы;
          * первый символ — буква, последний — не дефис.

      * `--zone` — идентификатор [зоны доступности](../../../overview/concepts/geo-scope.md) создаваемой ВМ. Зона доступности ВМ должна совпадать с зоной доступности пула.
      * `--reserved-instance-pool-id` — идентификатор [пула](../../concepts/reserved-pools.md), в котором создается виртуальная машина.

          Вместо идентификатора вы можете передать имя пула в параметре `--reserved-instance-pool-name`.
      * `--network-interface` — настройки [сетевого интерфейса](../../concepts/network.md) ВМ:

          * `subnet-name` — имя [подсети](../../../vpc/concepts/network.md#subnet) в зоне доступности, совпадающей с зоной доступности ВМ и пула.
          * `nat-ip-version=ipv4` — [публичный IP-адрес](../../../vpc/concepts/address.md#public-addresses). Чтобы создать ВМ без публичного IP-адреса, исключите параметр.
      * `--create-boot-disk` — настройки загрузочного диска ВМ:

          * `image-id` — идентификатор образа загрузочного диска ВМ. Например: идентификатор образа [Ubuntu 24.04 LTS](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-24-04-lts). 
      * `--ssh-key` — путь к файлу с [публичным SSH-ключом](../vm-connect/ssh.md#creating-ssh-keys), например: `~/.ssh/id_ed25519.pub`. Для этого ключа на ВМ будет автоматически создан пользователь `yc-user`.

          При создании ВМ из публичного образа [Yandex Cloud Marketplace](https://yandex.cloud/ru/marketplace) обязательно передавайте в ВМ SSH-ключ, поскольку доступ по протоколу SSH с использованием логина и пароля для таких образов по умолчанию отключен.

      {% cut "Результат:" %}

      ```text
      done (34s)
      id: fv4fjf9qbt57********
      folder_id: b1gt6g8ht345********
      created_at: "2025-05-07T07:46:34Z"
      name: the-first-pool-vm
      zone_id: ru-central1-a
      platform_id: standard-v2
      resources:
        memory: "2147483648"
        cores: "2"
        core_fraction: "100"
      status: RUNNING
      metadata_options:
        gce_http_endpoint: ENABLED
        aws_v1_http_endpoint: ENABLED
        gce_http_token: ENABLED
        aws_v1_http_token: DISABLED
      boot_disk:
        mode: READ_WRITE
        device_name: fv4v5k7u3g3n********
        auto_delete: true
        disk_id: fv4v5k7u3g3n********
      network_interfaces:
        - index: "0"
          mac_address: d0:0d:f9:bd:3a:5f
          subnet_id: fl8dmq91iruu********
          primary_v4_address:
            address: 192.168.7.7
            one_to_one_nat:
              address: 158.160.***.**
              ip_version: IPV4
      serial_port_settings:
        ssh_authorization: OS_LOGIN
      gpu_settings: {}
      fqdn: fv4fjf9qbt57********.auto.internal
      scheduling_policy: {}
      network_settings:
        type: STANDARD
      placement_policy: {}
      hardware_generation:
        legacy_features:
          pci_topology: PCI_TOPOLOGY_V1
      reserved_instance_pool_id: fv4k96kv52t7********
      ```

      {% endcut %}

  1. [Убедитесь](#list-pool-instances), что виртуальная машина была привязана к пулу.

  Подробнее о команде `yc compute instance create` читайте в [справочнике Yandex Cloud CLI](../../../cli/cli-ref/compute/cli-ref/instance/create.md).

- API {#api}

  Воспользуйтесь методом REST API [create](../../api-ref/Instance/create.md) для ресурса [Instance](../../api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/Create](../../api-ref/grpc/Instance/create.md), передав в поле `reservedInstancePoolId` (`reserved_instance_pool_id` для gRPC API) идентификатор нужного пула.

{% endlist %}

## Привязать существующую ВМ к пулу {#attach-existing-vm}

Чтобы привязать существующую ВМ к пулу резервов ВМ:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится пул резервов ВМ.
  1. Перейдите в сервис **Compute Cloud**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/server.svg) **Виртуальные машины**.
  1. В строке с нужной ВМ нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../_assets/console-icons/plug-connection.svg) **Привязать к пулу резервов ВМ**.
  1. В открывшемся окне выберите нужный пул резервов ВМ из списка или создайте новый.
  1. Нажмите кнопку **Привязать**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды [Yandex Cloud CLI](../../../cli/index.md) для изменения ВМ:

      ```bash
      yc compute instance update --help
      ```
  1. Получите список пулов резервов ВМ в каталоге по умолчанию:
     
     ```bash
     yc compute reserved-instance-pool list
     ```
     
     Результат:
     
     ```text
     +----------------------+------------+---------------+------+
     |          ID          |    NAME    |    ZONE ID    | SIZE |
     +----------------------+------------+---------------+------+
     | fv48qa9iiq19******** | test-pool1 | ru-central1-a |    1 |
     | fv42fbsrso94******** | test-pool2 | ru-central1-a |    1 |
     +----------------------+------------+---------------+------+
     ```
  1. Получите список ВМ в каталоге по умолчанию:

      ```bash
      yc compute instance list
      ```
      
      Результат:
      ```text
      +----------------------+-----------------+---------------+---------+----------------------+
      |          ID          |       NAME      |    ZONE ID    | STATUS  |     DESCRIPTION      |
      +----------------------+-----------------+---------------+---------+----------------------+
      | fhm0b28lgfp4******** | first-instance  | ru-central1-a | RUNNING | my first vm via CLI  |
      | fhm9gk85nj7g******** | second-instance | ru-central1-a | RUNNING | my second vm via CLI |
      +----------------------+-----------------+---------------+---------+----------------------+
      ```
  1. Привяжите нужную виртуальную машину к нужному пулу резервов ВМ:

      ```bash
      yc compute instance update \
        --id <идентификатор_ВМ> \
        --reserved-instance-pool-id <идентификатор_пула>
      ```

      Где:
      * `--id` — идентификатор привязываемой ВМ.

          Вместо идентификатора вы можете указать имя ВМ в параметре `--name`.
      * `--reserved-instance-pool-id` — идентификатор [пула](../../concepts/reserved-pools.md), к которому привязывается виртуальная машина.

          Вместо идентификатора вы можете передать имя пула в параметре `--reserved-instance-pool-name`.

      {% cut "Результат:" %}

      ```text
      done (2s)
      id: fhm0b28lgfp4********
      folder_id: b1gt6g8ht345********
      created_at: "2025-05-07T09:46:04Z"
      name: first-instance
      zone_id: ru-central1-a
      platform_id: standard-v2
      resources:
        memory: "2147483648"
        cores: "2"
        core_fraction: "100"
      status: RUNNING
      metadata_options:
        gce_http_endpoint: ENABLED
        aws_v1_http_endpoint: ENABLED
        gce_http_token: ENABLED
        aws_v1_http_token: DISABLED
      boot_disk:
        mode: READ_WRITE
        device_name: fv45psom2l6o********
        auto_delete: true
        disk_id: fv45psom2l6o********
      network_interfaces:
        - index: "0"
          mac_address: d0:0d:cb:b5:9e:bf
          subnet_id: fl8dmq91iruu********
          primary_v4_address:
            address: 192.168.7.5
            one_to_one_nat:
              address: 158.160.***.**
              ip_version: IPV4
      serial_port_settings:
        ssh_authorization: OS_LOGIN
      gpu_settings: {}
      fqdn: fv4cndcunukt********.auto.internal
      scheduling_policy: {}
      network_settings:
        type: STANDARD
      placement_policy: {}
      hardware_generation:
        legacy_features:
          pci_topology: PCI_TOPOLOGY_V1
      reserved_instance_pool_id: fv48qa9iiq19********
      ```

      {% endcut %}

  1. [Убедитесь](#list-pool-instances), что виртуальная машина была привязана к пулу.

  Подробнее о команде `yc compute instance update` читайте в [справочнике Yandex Cloud CLI](../../../cli/cli-ref/compute/cli-ref/instance/update.md).

- API {#api}

  Воспользуйтесь методом REST API [update](../../api-ref/Instance/update.md) для ресурса [Instance](../../api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/Update](../../api-ref/grpc/Instance/update.md), передав в поле `reservedInstancePoolId` (`reserved_instance_pool_id` для gRPC API) идентификатор нужного пула.

{% endlist %}


## Отвязать ВМ от пула {#detach-vm}

Чтобы отвязать ВМ от пула резервов ВМ:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится пул резервов ВМ.
  1. Перейдите в сервис **Compute Cloud**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/server.svg) **Виртуальные машины**.
  1. В строке с нужной ВМ нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../_assets/console-icons/plug-connection.svg) **Отвязать от пула резервов ВМ**.
  1. В открывшемся окне нажмите кнопку **Отвязать**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды [Yandex Cloud CLI](../../../cli/index.md) для изменения ВМ:

      ```bash
      yc compute instance update --help
      ```
  1. Получите список пулов резервов ВМ в каталоге по умолчанию:
     
     ```bash
     yc compute reserved-instance-pool list
     ```
     
     Результат:
     
     ```text
     +----------------------+------------+---------------+------+
     |          ID          |    NAME    |    ZONE ID    | SIZE |
     +----------------------+------------+---------------+------+
     | fv48qa9iiq19******** | test-pool1 | ru-central1-a |    1 |
     | fv42fbsrso94******** | test-pool2 | ru-central1-a |    1 |
     +----------------------+------------+---------------+------+
     ```
  1. Получите список ВМ в нужном пуле, указав его имя или идентификатор:

      ```bash
      yc compute reserved-instance-pool list-instances <имя_или_идентификатор_пула>
      ```
      
      Результат:
      
      ```text
      +----------------------+-------------------+---------------+---------+----------------+-------------+
      |          ID          |       NAME        |    ZONE ID    | STATUS  |  EXTERNAL IP   | INTERNAL IP |
      +----------------------+-------------------+---------------+---------+----------------+-------------+
      | fv4mkphl5q09******** | my-sample-pool-vm | ru-central1-a | RUNNING | 158.160.***.** | 192.168.3.8 |
      | fv4mfp4fj6f0******** | my-second-pool-vm | ru-central1-a | RUNNING | 158.165.***.** | 192.168.3.12 |
      +----------------------+-------------------+---------------+---------+----------------+-------------+
      ```
  1. Отвяжите нужную виртуальную машину от заданного пула резервов ВМ:

      ```bash
      yc compute instance update \
        --id <идентификатор_ВМ> \
        --reserved-instance-pool-id ""
      ```

      Где:
      * `--id` — идентификатор отвязываемой ВМ.

          Вместо идентификатора вы можете указать имя ВМ в параметре `--name`.

      {% cut "Результат:" %}

      ```text
      done (5s)
      id: fv4fjf9qbt57********
      folder_id: b1gt6g8ht345********
      created_at: "2025-05-07T07:46:34Z"
      name: first-instance
      zone_id: ru-central1-a
      platform_id: standard-v2
      resources:
        memory: "2147483648"
        cores: "2"
        core_fraction: "100"
      status: RUNNING
      metadata_options:
        gce_http_endpoint: ENABLED
        aws_v1_http_endpoint: ENABLED
        gce_http_token: ENABLED
        aws_v1_http_token: DISABLED
      boot_disk:
        mode: READ_WRITE
        device_name: fv4v5k7u3g3n********
        auto_delete: true
        disk_id: fv4v5k7u3g3n********
      network_interfaces:
        - index: "0"
          mac_address: d0:0d:f9:bd:3a:5f
          subnet_id: fl8dmq91iruu********
          primary_v4_address:
            address: 192.168.7.7
            one_to_one_nat:
              address: 158.160.***.**
              ip_version: IPV4
      serial_port_settings:
        ssh_authorization: OS_LOGIN
      gpu_settings: {}
      fqdn: fv4fjf9qbt57********.auto.internal
      scheduling_policy: {}
      network_settings:
        type: STANDARD
      placement_policy: {}
      hardware_generation:
        legacy_features:
          pci_topology: PCI_TOPOLOGY_V1
      ```

      {% endcut %}

  1. [Убедитесь](#list-pool-instances), что виртуальная машина была отвязана от пула.

  Подробнее о команде `yc compute instance update` читайте в [справочнике Yandex Cloud CLI](../../../cli/cli-ref/compute/cli-ref/instance/update.md).

- API {#api}

  Воспользуйтесь методом REST API [update](../../api-ref/Instance/update.md) для ресурса [Instance](../../api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/Update](../../api-ref/grpc/Instance/update.md), передав в поле `reservedInstancePoolId` (`reserved_instance_pool_id` для gRPC API) пустую строку.

{% endlist %}

#### См. также {#see-also}

* [Создание пула резервов виртуальных машин](create-reserved-pool.md)
* [Изменение пула резервов виртуальных машин](update-reserved-pool.md)
* [Пулы резервов виртуальных машин в Compute Cloud](../../concepts/reserved-pools.md)