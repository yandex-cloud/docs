# Настройка вывода информации из Docker-контейнера в серийный порт

В этой инструкции вы создадите виртуальную машину из образа [{{ coi }}](../concepts/index.md) и настроите перенаправление потока вывода приложения в [серийный порт](../../compute/operations/serial-console/index.md#configuration) ВМ.

## Перед началом работы {#before-you-begin}

Если нужный Docker-образ загружен в {{ container-registry-name }}, то создайте [сервисный аккаунт](../../iam/operations/sa/create.md) с ролью [{{ roles-cr-puller }}](../../container-registry/security/index.md#choosing-roles) на используемый реестр. От его имени ВМ на базе {{ coi }} будет скачивать из реестра Docker-образ.

## Создайте ВМ с {{ coi }} и выводом серийного порта {#create-vm}

{% list tabs %}

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания ВМ на базе образа {{ coi }}:

     ```bash
     yc compute instance create-with-container --help
     ```

  1. Подготовьте спецификацию ВМ. Задайте имя пользователя, укажите публичную часть SSH-ключа для подключения к ВМ и сохраните эти данные в файл `cloud-config-ports.yaml`:

     ```
     #cloud-config
     runcmd:
       - [ sudo, chmod, 666, /dev/ttyS1]
     users:
       - name: <имя пользователя>
         groups: sudo
         shell: /bin/bash
         sudo: ['ALL=(ALL) NOPASSWD:ALL']
         ssh-authorized-keys:
           - <публичный SSH-ключ для подключения к ВМ>
     ```

  1. Подготовьте спецификацию Docker-контейнера. Сохраните следующие данные в файл `container-spec-ports.yaml`:

     ```
     spec:
       containers:
       - image: ubuntu
         name: app
         command: ["/bin/bash", "-c", "sleep 30 && echo 'Hello World!' > /dev/ttyS1"]
         securityContext:
           privileged: true
         stdin: false
         tty: false
         volumeMounts:
           - mountPath: /dev/ttyS1
             name: log-port
       restartPolicy: Always
       volumes:
         - name: log-port
           hostPath:
             path: /dev/ttyS1
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

        ```bash
        yc compute instance create \
          --name coi-vm-with-sp \
          --zone {{ region-id }}-a \
          --network-interface subnet-name=<имя подсети>,nat-ip-version=ipv4 \
          --metadata-from-file user-data=cloud-config-ports.yaml,docker-container-declaration=container-spec-ports.yaml \
          --create-boot-disk image-id=$IMAGE_ID
        ```

        Где:
        * `--name` — имя ВМ.
        * `--zone` — зона доступности.
        * `--network-interface` — сетевые настройки ВМ.
        * `--metadata-from-file` — YAML-файлы метаданных для создания ВМ.
        * `--create-boot-disk` — идентификатор образа для создания загрузочного диска.

        После создания ВМ появится в списке ВМ в разделе **{{ compute-name }}** в [консоли управления]({{ link-console-main }}).

     1. Проверьте результат.
        1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ compute-name }}**.
        1. Нажмите на имя нужной ВМ `coi-vm-with-sp`.
        1. В блоке **Серийный порт** выберите порт `COM2`. Через несколько минут на экран начнет выводиться `Hello world!`.

{% endlist %}

Подробнее о работе с ВМ читайте в [пошаговых инструкциях](../../compute/operations/index.md).