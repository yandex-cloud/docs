---
title: Как создать виртуальную машину с метаданными из переменных окружения
description: Следуя данной инструкции, вы сможете использовать переменные окружения при создании виртуальной машины с пользовательским скриптом cloud-init, чтобы установить дополнительное ПО и донастроить ВМ при ее создании.
---

# Создать виртуальную машину с метаданными из переменных окружения

С помощью [{{ yandex-cloud }} CLI](../../../cli/index.yaml) вы можете создать [виртуальную машину](../../concepts/vm.md), [метаданные](../../concepts/vm-metadata.md) которой содержат значения, заданные в [переменных окружения](https://ru.wikipedia.org/wiki/Переменная_среды). Переданная в ключе `user-data` конфигурация метаданных обрабатывается запущенным на ВМ агентом [cloud-init](https://cloudinit.readthedocs.io/en/latest/).

В приведенном примере будет создана виртуальная машина под управлением ОС [Ubuntu 22.04 LTS](/marketplace/products/yc/ubuntu-22-04-lts) с предустановленным веб-сервером [Nginx](https://nginx.org/). Значения имени локального пользователя и [SSH](../../../glossary/ssh-keygen.md)-ключа при выполнении команды CLI будут переданы в метаданные виртуальной машины подстановкой из переменных `USER_NAME` и `SSH_KEY`, заданных в окружении, в котором выполняется эта команда.

Дополнительно в метаданные виртуальной машины будут переданы две переменные, заданные в секции `data` конфигурации: `var1` со значением `value1` и `var2` со значением `value2`. Эти переменные и их значения будут доступны в [каталоге](../../concepts/metadata/directories.md#dir-user) `user-data` сервиса метаданных изнутри ВМ после ее создания.

Чтобы создать виртуальную машину с метаданными из переменных окружения:

1. Задайте переменные окружения, содержащие имя локального пользователя ВМ и его SSH-ключ, которые будут подставлены в метаданные ВМ при последующем выполнении команды {{ yandex-cloud }} CLI:

    ```bash
    export USER_NAME="<имя_пользователя>"
    export SSH_KEY="<SSH-ключ>"
    ```
1. Создайте файл `metadata.yaml` и поместите в него следующую конфигурацию метаданных создаваемой ВМ:

    **metadata.yaml**

    ```yaml
    #cloud-config
    datasource:
      Ec2:
        strict_id: false
      data:
        var1: value1
        var2: value2
    ssh_pwauth: no
    users:
    - name: $USER_NAME
      sudo: 'ALL=(ALL) NOPASSWD:ALL'
      shell: /bin/bash
      ssh_authorized_keys:
      - $SSH_KEY
    write_files:
      - path: "/usr/local/etc/startup.sh"
        permissions: "755"
        content: |
          #!/bin/bash
    
          apt-get update
          apt-get install -y nginx
          service nginx start
          sed -i -- "s/ nginx/ Yandex Cloud - $$HOSTNAME/" /var/www/html/index.nginx-debian.html
        defer: true
    runcmd:
      - ["/usr/local/etc/startup.sh"]
    packages:
      - yq
    ```
1. Создайте виртуальную машину:

    {% list tabs group=instructions %}

    - CLI {#cli}

      {% include [cli-install](../../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

      ```bash
      yc compute instance create \
        --name my-vm \
        --hostname <имя_хоста> \
        --zone <зона_доступности> \
        --network-interface subnet-name=<имя_подсети>,nat-ip-version=ipv4,security-group-ids=<идентификатор_группы_безопасности> \
        --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-2204-lts \
        --metadata-from-file user-data="<путь_к_файлу_конфигурации>"
      ```

      Где:
      * `--name` — имя создаваемой ВМ. Например: `my-vm`.
      * `--hostname` — имя хоста создаваемой ВМ. Необязательный параметр. Если параметр не задан, в качестве имени хоста будет использовано значение идентификатора ВМ.
      * `--zone` — [зона доступности](../../../overview/concepts/geo-scope.md), в которой будет находиться создаваемая ВМ.
      * `--network-interface` — настройки [сетевого интерфейса](../../concepts/network.md) создаваемой ВМ:

          * `subnet-name` — имя [подсети](../../../vpc/concepts/network.md#subnet), расположенной в зоне доступности, указанной в параметре `--zone`.
          * `security-group-ids` — идентификатор [группы безопасности](../../../vpc/concepts/security-groups.md).
      * `--metadata-from-file` — ключ `user-data`, значением которого является путь к созданному ранее файлу с конфигурацией `cloud-config` в формате YAML. Например: `--metadata-from-file user-data="/home/user/metadata.yaml"`.

          {% note info %}

          Обратите внимание, что при выполнении команды CLI для переменной `HOSTNAME` значение не будет подставлено в метаданные. Вместо этого при выполнении команды CLI в конфигурацию `cloud-init` будет передано имя переменной `$HOSTNAME`, а значение имени хоста создаваемой ВМ будет подставлено вместо этой переменной позднее при создании ВМ.

          Для этого в ключе `user-data` переменная `HOSTNAME` задана с двумя символами доллара: `$$HOSTNAME`. Подробнее см. в разделе [{#T}](../../concepts/metadata/sending-metadata.md#environment-variables).

          {% endnote %}

      {% cut "Результат" %}

      ```text
      done (36s)
      id: epd8m0fqvkuu********
      folder_id: b1gt6g8ht345********
      created_at: "2025-01-01T14:24:37Z"
      name: my-vm
      zone_id: {{ region-id }}-b
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
        device_name: epd60hoo48qj********
        auto_delete: true
        disk_id: epd60hoo48qj********
      network_interfaces:
        - index: "0"
          mac_address: d0:0d:8b:01:fa:fd
          subnet_id: e2lqsms4cdl3********
          primary_v4_address:
            address: 192.168.15.14
            one_to_one_nat:
              address: 51.250.**.**
              ip_version: IPV4
          security_group_ids:
            - enpbtvidu0g0********
      serial_port_settings:
        ssh_authorization: OS_LOGIN
      gpu_settings: {}
      fqdn: my-web-server.{{ region-id }}.internal
      scheduling_policy: {}
      network_settings:
        type: STANDARD
      placement_policy: {}
      hardware_generation:
        legacy_features:
          pci_topology: PCI_TOPOLOGY_V1
      ```

      {% endcut %}

      Подробнее о команде `yc compute instance create` см. в [справочнике CLI](../../../cli/cli-ref/compute/cli-ref/instance/create.md).

    {% endlist %}

1. Сохраните [публичный IP-адрес](../../concepts/network.md#public-ip) созданной виртуальной машины в переменную `EXT_IP`:

    ```bash
    EXT_IP=$(yc compute instance get my-vm --jq '.network_interfaces[0].primary_v4_address.one_to_one_nat.address')
    ```
1. Подключитесь к ВМ по SSH:

    ```bash
    ssh $USER_NAME@$EXT_IP
    ```
1. Получите значения переданных ранее в метаданные переменных изнутри ВМ. Для этого в терминале ВМ выполните запросы:

    ```bash
    export var1=$(curl -sf -H Metadata-Flavor:Google 169.254.169.254/latest/user-data | yq .datasource.data.var1)
    export var2=$(curl -sf -H Metadata-Flavor:Google 169.254.169.254/latest/user-data | yq .datasource.data.var2)
    echo $var1 $var2
    ```

    Результат:

    ```text
    value1 value2
    ```

Другие примеры конфигурации для `user-data` см. в разделе [Примеры](./create-with-cloud-init-scripts.md#examples).

#### См. также {#see-also}

* [{#T}](../../concepts/vm-metadata.md)
* [{#T}](./create-with-lockbox-secret.md)
* [{#T}](./create-with-cloud-init-scripts.md)