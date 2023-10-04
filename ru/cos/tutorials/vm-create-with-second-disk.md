# Создание ВМ с {{ coi }} и дополнительным томом для Docker-контейнера

В этой инструкции вы создадите [виртуальную машину](../../compute/concepts/vm.md) из образа [{{ coi }}](../concepts/index.md), в которой будет [Docker-контейнер](/blog/posts/2022/03/docker-containers) с запущенным MongoDB и подключенным дополнительным [томом](../../container-registry/concepts/docker-volume.md) объемом 10 ГБ.

## Перед началом работы {#before-you-begin}

Если нужный Docker-образ загружен в {{ container-registry-full-name }}, создайте [сервисный аккаунт](../../iam/operations/sa/create.md) с ролью [{{ roles-cr-puller }}](../../container-registry/security/index.md#choosing-roles) на используемый [реестр](../../container-registry/concepts/registry.md). От его имени ВМ на базе {{ coi }} будет скачивать из реестра Docker-образ.

## Создайте ВМ на базе образа {{ coi }} и дополнительным томом для Docker-контейнера {#create-vm}

{% list tabs %}

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания ВМ:

     ```bash
     yc compute instance create-with-container --help
     ```

  1. Подготовьте [спецификацию Docker Compose](../concepts/coi-specifications.md#compose-spec). Сохраните следующие данные в файл `docker-compose.yaml`:

     ```yaml
     version: '3.4'
     services:
       app2:
         container_name: container-name
         image: "mongo:latest"
         ports:
           - "27017:27017"
         restart: always
         volumes:
           - /home/yc-user/coi-data:/data
     x-yc-disks:
       - device_name: coi-data
         fs_type: ext4
         host_path: /home/yc-user/coi-data
     ```

     При создании ВМ через CLI, создается пользователь по умолчанию — `yc-user`.
  1. Создайте ВМ с несколькими дисками:

     ```bash
     yc compute instance create-with-container \
       --name coi-vm \
       --zone {{ region-id }}-a \
       --create-boot-disk size=30 \
       --create-disk name=data-disk,size=10,device-name=coi-data \
       --network-interface subnet-name=<имя подсети>,nat-ip-version=ipv4 \
       --ssh-key <путь к открытой части SSH-ключа> \
       --docker-compose-file docker-compose.yaml
     ```

     Где:
     * `--name` — имя ВМ.
     * `--zone` — [зона доступности](../../overview/concepts/geo-scope.md).
     * `--create-boot-disk` — параметры [диска](../../compute/concepts/disk.md) ВМ. Размер диска должен быть не менее 30 ГБ.
     * `--network-interface` — параметры [сети](../../vpc/concepts/network.md#network):
       * `subnet-name` — имя [подсети](../../vpc/concepts/network.md#subnet), в которой будет размещена ВМ.
       * `nat-ip-version` — способ назначения [публичного IPv4-адреса](../../vpc/concepts/ips.md).
     * `--ssh-key` — путь к файлу с [открытым ключом](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
     * `--docker-compose-file` — YAML-файл со спецификацией контейнера.

     После создания ВМ появится в списке ВМ в разделе **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}** в [консоли управления]({{ link-console-main }}).
  1. Проверьте результат.
     1. [Подключитесь к ВМ по SSH](../../compute/operations/vm-connect/ssh.md).
     1. Получите идентификатор запущенного Docker-контейнера:

        ```bash
        sudo docker ps -a
        ```

        Результат:

        ```text
        CONTAINER ID  IMAGE         COMMAND                 CREATED        STATUS        PORTS      NAMES
        1f71192ded4c  mongo:latest  "docker-entrypoint.s…"  5 minutes ago  Up 5 minutes  27017/tcp  container-name
        ```

     1. Подключитесь к запущенному Docker-контейнеру:

        ```bash
        sudo docker exec -it 1f71192ded4c bash
        ```

     1. Посмотрите список подключенных дисков. Обратите внимание на смонтированный диск `/dev/vdb 11G 24M 9.9G 1% /data`:

        ```bash
        df -H
        ```

        Результат:

        ```text
        Filesystem  Size  Used  Avail  Use%  Mounted on
        overlay     32G   4.0G    27G   14%  /
        tmpfs       68M      0    68M    0%  /dev
        ...
        tmpfs       1.1G     0   1.1G    0%  /proc/acpi
        tmpfs       1.1G     0   1.1G    0%  /proc/scsi
        tmpfs       1.1G     0   1.1G    0%  /sys/firmware
        ```

{% endlist %}

Подробнее о работе с ВМ читайте в [пошаговых инструкциях](../../compute/operations/index.md).