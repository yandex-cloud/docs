---
title: Управлять виртуальными машинами в пуле зарезервированных ВМ
description: Из статьи вы узнаете, как создавать виртуальные машины {{ compute-full-name }} в пуле зарезервированных ВМ, а также как привязывать существующие ВМ к таким пулам и отвязывать их.
---

# Управление виртуальными машинами пула зарезервированных ВМ

{% include [reserved-pools-pricing-warning](../../../_includes/compute/reserved-pools-pricing-warning.md) %}

{% include [reserved-pools-preview-notice](../../../_includes/compute/reserved-pools-preview-notice.md) %}

Вы можете привязывать к пулам зарезервированных ВМ как вновь создаваемые, так и существующие виртуальные машины. Подробнее см. в разделе [{#T}](../../concepts/reserved-pools.md).


## Создать новую ВМ с привязкой к пулу зарезервированных ВМ {#attach-new-vm}

Чтобы создать новую виртуальную машину в пуле зарезервированных ВМ:

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды [{{ yandex-cloud }} CLI](../../../cli/index.yaml) для создания ВМ:

      ```bash
      yc compute instance create --help
      ```
  1. {% include [list-reserved-pools-cli](../../../_includes/compute/list-reserved-pools-cli.md) %}
  1. Создайте виртуальную машину в пуле зарезервированных ВМ:

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

          {% include [name-format](../../../_includes/name-format.md) %}

      * `--zone` — идентификатор [зоны доступности](../../../overview/concepts/geo-scope.md) создаваемой ВМ. Зона доступности ВМ должна совпадать с зоной доступности пула.
      * `--reserved-instance-pool-id` — идентификатор [пула](../../concepts/reserved-pools.md), в котором создается виртуальная машина.

          Вместо идентификатора вы можете передать имя пула в параметре `--reserved-instance-pool-name`.
      * `--network-interface` — настройки [сетевого интерфейса](../../concepts/network.md) ВМ:

          * `subnet-name` — имя [подсети](../../../vpc/concepts/network.md#subnet) в зоне доступности, совпадающей с зоной доступности ВМ и пула.
          * `nat-ip-version=ipv4` — [публичный IP-адрес](../../../vpc/concepts/address.md#public-addresses). Чтобы создать ВМ без публичного IP-адреса, исключите параметр.
      * `--create-boot-disk` — настройки загрузочного диска ВМ:

          * `image-id` — идентификатор образа загрузочного диска ВМ. Например: идентификатор образа [Ubuntu 24.04 LTS](/marketplace/products/yc/ubuntu-24-04-lts). 
      * `--ssh-key` — путь к файлу с [публичным SSH-ключом](../vm-connect/ssh.md#creating-ssh-keys), например: `~/.ssh/id_ed25519.pub`. Для этого ключа на ВМ будет автоматически создан пользователь `yc-user`.

          {% include [ssh-note](../../../_includes/compute/ssh-note.md) %}

      {% cut "Результат:" %}

      ```text
      done (34s)
      id: fv4fjf9qbt57********
      folder_id: b1gt6g8ht345********
      created_at: "2025-05-07T07:46:34Z"
      name: the-first-pool-vm
      zone_id: {{ region-id }}-a
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

      Подробнее о команде `yc compute instance create` читайте в [справочнике {{ yandex-cloud }} CLI](../../../cli/cli-ref/compute/cli-ref/instance/create.md).

- API {#api}

  Воспользуйтесь методом REST API [create](../../api-ref/Instance/create.md) для ресурса [Instance](../../api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/Create](../../api-ref/grpc/Instance/create.md), передав в поле `reservedInstancePoolId` (`reserved_instance_pool_id` для gRPC API) идентификатор нужного пула.

{% endlist %}

## Привязать существующую ВМ к пулу зарезервированных ВМ {#attach-existing-vm}

Чтобы привязать существующую ВМ к пулу зарезервированных ВМ:

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды [{{ yandex-cloud }} CLI](../../../cli/index.yaml) для изменения ВМ:

      ```bash
      yc compute instance update --help
      ```
  1. {% include [list-reserved-pools-cli](../../../_includes/compute/list-reserved-pools-cli.md) %}
  1. Получите список ВМ в каталоге по умолчанию:

      {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}
  1. Привяжите нужную виртуальную машину к нужному пулу зарезервированных ВМ:

      {% note info %}

      К пулу зарезервированных ВМ нельзя привязать виртуальную машину с аппаратной конфигурацией ([платформа](../../concepts/vm-platforms.md), vCPU, RAM), отличной от конфигурации, которая задана в настройках пула.

      {% endnote %}


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
      zone_id: {{ region-id }}-a
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

      Подробнее о команде `yc compute instance update` читайте в [справочнике {{ yandex-cloud }} CLI](../../../cli/cli-ref/compute/cli-ref/instance/update.md).

- API {#api}

  Воспользуйтесь методом REST API [update](../../api-ref/Instance/update.md) для ресурса [Instance](../../api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/Update](../../api-ref/grpc/Instance/update.md), передав в поле `reservedInstancePoolId` (`reserved_instance_pool_id` для gRPC API) идентификатор нужного пула.

{% endlist %}


## Отвязать ВМ от пула зарезервированных ВМ {#detach-vm}

Чтобы отвязать ВМ от пула зарезервированных ВМ:

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды [{{ yandex-cloud }} CLI](../../../cli/index.yaml) для изменения ВМ:

      ```bash
      yc compute instance update --help
      ```
  1. {% include [list-reserved-pools-cli](../../../_includes/compute/list-reserved-pools-cli.md) %}
  1. Получите список ВМ в каталоге по умолчанию:

      {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}
  1. Отвяжите нужную виртуальную машину от заданного пула зарезервированных ВМ:

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
      zone_id: {{ region-id }}-a
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

      Подробнее о команде `yc compute instance update` читайте в [справочнике {{ yandex-cloud }} CLI](../../../cli/cli-ref/compute/cli-ref/instance/update.md).

- API {#api}

  Воспользуйтесь методом REST API [update](../../api-ref/Instance/update.md) для ресурса [Instance](../../api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/Update](../../api-ref/grpc/Instance/update.md), передав в поле `reservedInstancePoolId` (`reserved_instance_pool_id` для gRPC API) пустую строку.

{% endlist %}

#### См. также {#see-also}

* [{#T}](./create-reserved-pool.md)
* [{#T}](./update-reserved-pool.md)
* [{#T}](../../concepts/reserved-pools.md)