[Документация Yandex Cloud](../../index.md) > [Yandex Compute Cloud](../index.md) > [Практические руководства](index.md) > Container Optimized Image > Создать ВМ с Container Optimized Image и дополнительным томом для Docker-контейнера

# Создание ВМ с Container Optimized Image и дополнительным томом для Docker-контейнера

В этой инструкции вы создадите [виртуальную машину](../concepts/vm.md) из образа [Container Optimized Image](../../cos/concepts/index.md), в которой будет [Docker-контейнер](https://yandex.cloud/ru/blog/posts/2022/03/docker-containers) с запущенным MongoDB и подключенным дополнительным [томом](../../container-registry/concepts/docker-volume.md) объемом 10 ГБ.

## Перед началом работы {#before-you-begin}

Если нужный Docker-образ загружен в Yandex Container Registry, создайте [сервисный аккаунт](../../iam/operations/sa/create.md) с ролью [container-registry.images.puller](../../container-registry/security/index.md#choosing-roles) на используемый [реестр](../../container-registry/concepts/registry.md). От его имени ВМ на базе Container Optimized Image будет скачивать из реестра Docker-образ.

## Создайте ВМ на базе образа Container Optimized Image и дополнительным томом для Docker-контейнера {#create-vm}

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для создания ВМ:

     ```bash
     yc compute instance create-with-container --help
     ```

  1. Подготовьте [спецификацию Docker Compose](../../cos/concepts/coi-specifications.md#compose-spec). Сохраните следующие данные в файл `docker-compose.yaml`:

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
       --zone ru-central1-a \
       --create-boot-disk size=30 \
       --create-disk name=data-disk,size=10,device-name=coi-data \
       --network-interface subnet-name=<имя_подсети>,nat-ip-version=ipv4 \
       --ssh-key <путь_к_открытой_части_SSH-ключа> \
       --service-account-name <имя_сервисного_аккаунта> \
       --docker-compose-file docker-compose.yaml
     ```

     Где:
     * `--name` — имя ВМ.
     * `--zone` — [зона доступности](../../overview/concepts/geo-scope.md).
     * `--create-boot-disk` — параметры [диска](../concepts/disk.md) ВМ.

        Чтобы узнать минимальный размер загрузочного диска, необходимый для установки образа, выполните команду:
        * `yc compute image get-latest-from-family container-optimized-image --folder-id standard-images` — если устанавливаете образ Container Optimized Image;
        * `yc compute image get-latest-from-family container-optimized-image-gpu --folder-id standard-images` — если устанавливаете образ Container Optimized Image GPU.
        
        Минимальный размер загрузочного диска указан в параметре `min_disk_size`.

     * `--network-interface` — параметры [сети](../../vpc/concepts/network.md#network):
       * `subnet-name` — имя [подсети](../../vpc/concepts/network.md#subnet), в которой будет размещена ВМ.
       * `nat-ip-version` — способ назначения [публичного IPv4-адреса](../../vpc/concepts/ips.md).
     * `--ssh-key` — путь к файлу с [открытым ключом](../operations/vm-connect/ssh.md#creating-ssh-keys).
     * `--service-account-name` — имя сервисного аккаунта, созданного [ранее](#before-you-begin).
     * `--docker-compose-file` — YAML-файл со спецификацией контейнера.

     После создания ВМ появится в списке ВМ в разделе **Compute Cloud** в [консоли управления](https://console.yandex.cloud).
  1. Проверьте результат.
     1. [Подключитесь к ВМ по SSH](../operations/vm-connect/ssh.md).
     1. Получите идентификатор запущенного Docker-контейнера:

        ```bash
        sudo docker ps -a
        ```

        Результат:

        ```text
        CONTAINER ID  IMAGE         COMMAND                 CREATED        STATUS        PORTS      NAMES
        1f71********  mongo:latest  "docker-entrypoint.s…"  5 minutes ago  Up 5 minutes  27017/tcp  container-name
        ```

     1. Подключитесь к запущенному Docker-контейнеру:

        ```bash
        sudo docker exec -it 1f71******** bash
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

Подробнее о работе с ВМ читайте в [пошаговых инструкциях](../operations/index.md).