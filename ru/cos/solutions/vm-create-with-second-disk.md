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
        $ yc compute instance create --help
        ```

    1. Подготовьте спецификацию ВМ. Задайте имя пользователя и сохраните следующие данные в файл `user-data.yaml`:
    
        ```
        #cloud-config
        fs_setup:
          - device: /dev/disk/by-id/virtio-coi-data
            filesystem: ext4
            overwrite: false
            partition: auto
        mounts:
        - - /dev/disk/by-id/virtio-coi-data
          - /home/<имя пользователя>/coi-data
          - auto
          - defaults
          - "0"
          - "0"
        users:
          - name: <имя пользователя>
            groups: sudo
            shell: /bin/bash
            sudo: ['ALL=(ALL) NOPASSWD:ALL']
            ssh-authorized-keys:
              - <публичный SSH-ключ для подключения к ВМ>
        ```
    1. Подготовьте спецификацию Docker-контейнера. Сохраните следующие данные в файл `container.yaml`:
    
        ```
        spec:
          containers:
          - image: mongo:latest
            name: container-name
            securityContext:
              privileged: false
            stdin: false
            tty: false
            volumeMounts:
              - mountPath: <путь, по которому файл или каталог монтируется в Docker-контейнер>
                name: data-volume
          restartPolicy: Always
          volumes:
            - name: data-volume
              hostPath:
                path: /home/<имя пользователя>/coi-data
        ```
    1. Создайте ВМ с несколькими дисками.
    
        1. Получите идентификатор образа для создания ВМ:
        
            {% list tabs %}
            
            - Bash
            
                ```
                $ IMAGE_ID=$(yc compute image get-latest-from-family container-optimized-image --folder-id standard-images --format=json | jq -r .id)
                ```
            - PowerShell
            
                ```
                > $IMAGE_ID=(yc compute image get-latest-from-family container-optimized-image --folder-id standard-images --format=json | ConvertFrom-Json).id
                ```

            {% endlist %}
            
        1. Создайте ВМ:
        
            ```
            yc compute instance create 
                --name coi-vm \
                --zone=ru-central1-a 
                --network-interface subnet-name=<имя подсети>,nat-ip-version=ipv4 \
                --metadata-from-file user-data=user-data.yaml,docker-container-declaration=container-spec.yaml \
                --create-boot-disk image-id=$IMAGE_ID \
                --create-disk name=data-disk,size=10,device-name=coi-data
            ```
            
            Где:
            - `--name` — имя виртуальной машины.
            - `--zone` — зона доступности.
            - `--network-interface` — сетевые настройки виртуальной машины.
            - `--metadata-from-file` — YAML-файлы метаданных для создания ВМ.
            - `--create-boot-disk` — идентификатор образа для создания загрузочного диска.
            - `--create-disk` — параметры тома, который необходимо примонтировать к Docker-контейнеру.
            
            После создания виртуальная машина появится в списке ВМ в разделе **{{ compute-name }}** в [консоли управления]({{ link-console-main }}).
            
    1. Проверьте результат.
    
        1. [Подключитесь к ВМ по SSH](../../compute/operations/vm-connect/ssh.md).
        1. Получите идентификатор запущенного Docker-контейнера:
        
            ```
            $ sudo docker ps -a
            CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS               NAMES
            7efe42b56319        mongo:latest        "docker-entrypoint.s…"   17 hours ago        Up 17 hours                             coi-container-name-1375924429
            ```
        1. Подключитесь к запущенному Docker-контейнеру:
        
            ```
            $ sudo docker exec -it 7efe42b56319  bash
            ```
           
        1. Посмотрите список подключенных дисков. Обратите внимание на смонтированный диск `/dev/vdb 11G 24M 9.9G 1% /home/<имя пользователя>/second-volume`:
        
            ```
            $ df -H
            Filesystem      Size  Used Avail Use% Mounted on
            overlay         3.2G  3.0G   19M 100% /
            tmpfs            68M     0   68M   0% /dev
            tmpfs           1.1G     0  1.1G   0% /sys/fs/cgroup
            /dev/vda1       3.2G  3.0G   19M 100% /data/db
            shm              68M     0   68M   0% /dev/shm
            /dev/vdb         11G   24M  9.9G   1% /home/<имя пользователя>/second-volume
            tmpfs           1.1G     0  1.1G   0% /proc/acpi
            tmpfs           1.1G     0  1.1G   0% /proc/scsi
            tmpfs           1.1G     0  1.1G   0% /sys/firmware
            ```
    
{% endlist %}

Подробнее о работе с ВМ читайте в [пошаговых инструкциях](../../compute/operations/index.md).