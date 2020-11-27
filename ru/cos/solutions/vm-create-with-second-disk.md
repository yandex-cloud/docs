# Создание ВМ с {{ coi }} и дополнительным томом для Docker-контейнера

В этой инструкции вы создадите виртуальную машину из образа [{{ coi }}](../concepts/index.md), в которой будет Docker-контейнер с запущенным MongoDB и подключенным дополнительным [томом](https://docs.docker.com/storage/volumes/) объемом 10 ГБ.

## Перед началом работы {#before-you-begin}

Если нужный Docker-образ загружен в {{ container-registry-name }}, то создайте [сервисный аккаунт](../../iam/operations/sa/create.md) с ролью [{{ roles-cr-puller }}](../../container-registry/security/index.md#choosing-roles) на используемый реестр. От его имени ВМ на базе {{ coi }} будет скачивать из реестра Docker-образ.

## Создайте ВМ на базе образа {{ coi }} и дополнительным томом для Docker-контейнера {#create-vm}

{% list tabs %}

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}
    
    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    1. Посмотрите описание команды CLI для создания ВМ:

        ```
        yc compute instance create-with-container --help
        ```

    1. Подготовьте [Docker Compose спецификацию](../concepts/index.md#compose-spec). Сохраните следующие данные в файл `docker-compose.yaml`:
        
        ```
        version: '3.4'
        services:
          app2:
            container_name: container-name
            image: "mongo:latest"
            restart: always
            volumes: 
              - /home/yc-user/coi-data:/data
              
        x-yc-disks:
          - device_name: coi-data
            fs_type: ext4
            host_path: /home/yc-user/coi-data
                      
        ```
        При создании виртуальной машины через CLI, создается пользователь по умолчанию — `yc-user`.

    1. Создайте ВМ с несколькими дисками.
                 
        ```
        yc compute instance create-with-container \
            --name coi-vm \
            --zone=ru-central1-a \
            --public-ip \
            --create-boot-disk size=10 \
            --create-disk name=data-disk,size=10,device-name=coi-data \
            --ssh-key <публичный SSH-ключ для подключения к ВМ> \
            --docker-compose-file docker-compose.yaml 
        ```
            
        Где:
        - `--name` — имя виртуальной машины.
        - `--zone` — зона доступности.
        - `--public-ip` — выделение публичного IP-адреса для ВМ.
        - `--create-boot-disk` — параметры диска виртуальной машины.
        - `--ssh-key` — содержимое файла [открытого ключа](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
        - `--docker-compose-file` — YAML-файл со спецификацией контейнера.
            
        После создания виртуальная машина появится в списке ВМ в разделе **{{ compute-name }}** в [консоли управления]({{ link-console-main }}).
            
    1. Проверьте результат.
    
        1. [Подключитесь к ВМ по SSH](../../compute/operations/vm-connect/ssh.md).
        1. Получите идентификатор запущенного Docker-контейнера:
        
            ```
            CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS               NAMES
            1f71192ded4c        mongo:latest        "docker-entrypoint.s…"   5 minutes ago       Up 5 minutes        27017/tcp           container-name


            ```
        1. Подключитесь к запущенному Docker-контейнеру:
        
            ```
            sudo docker exec -it 1f71192ded4c bash
            ```
           
        1. Посмотрите список подключенных дисков. Обратите внимание на смонтированный диск `/dev/vdb 11G 24M 9.9G 1% /data`:
        
            ```
            df -H
            Filesystem      Size  Used Avail Use% Mounted on
            overlay          11G  3.1G  7.0G  31% /
            tmpfs            68M     0   68M   0% /dev
            tmpfs           1.1G     0  1.1G   0% /sys/fs/cgroup
            /dev/vdb         11G   24M  9.9G   1% /data
            /dev/vda2        11G  3.1G  7.0G  31% /data/db
            shm              68M     0   68M   0% /dev/shm
            tmpfs           1.1G     0  1.1G   0% /proc/acpi
            tmpfs           1.1G     0  1.1G   0% /proc/scsi
            tmpfs           1.1G     0  1.1G   0% /sys/firmware

            ```
    
{% endlist %}

Подробнее о работе с ВМ читайте в [пошаговых инструкциях](../../compute/operations/index.md).