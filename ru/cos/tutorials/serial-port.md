---
title: "Настройка вывода информации из Docker-контейнера в серийный порт в {{ cos-full-name }}"
description: "Следуя данному руководству, вы сможете создать виртуальную машину из образа {{ coi }} и настроить перенаправление потока вывода приложения в серийный порт ВМ." 
---

# Настройка вывода информации из Docker-контейнера в серийный порт

Чтобы создать [виртуальную машину](../../compute/concepts/vm.md) из [образа](../../compute/concepts/image.md) [{{ coi }}](../concepts/index.md) и настроить перенаправление потока вывода приложения в [серийный порт](../../compute/operations/serial-console/index.md#configuration) ВМ:
1. [Подготовьте облако к работе](#before-you-begin).
1. [Подготовьте спецификацию ВМ](#prepare-specification-vm).
1. [Подготовьте спецификацию Docker-контейнера](#prepare-specification-docker).
1. [Получите идентификатор образа для создания ВМ](#get-id).
1. [Создайте ВМ](#create-vm).
1. [Проверьте результат](#check-result).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

Если нужный [Docker-образ](../../container-registry/concepts/docker-image.md) загружен в [{{ container-registry-name }}](../../container-registry/), создайте [сервисный аккаунт](../../iam/operations/sa/create.md) с ролью [{{ roles-cr-puller }}](../../container-registry/security/index.md#choosing-roles) на используемый [реестр](../../container-registry/concepts/registry.md). От его имени ВМ на базе {{ coi }} будет скачивать из реестра Docker-образ.

{% include [cli-install](../../_includes/cli-install.md) %}

{% include [default-catalogue](../../_includes/default-catalogue.md) %}

Если у вас еще нет [сети](../../vpc/operations/network-create.md) или [подсети](../../vpc/operations/subnet-create.md), создайте их.

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входит:
* Плата за постоянно запущенную ВМ (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md)).
* Плата за использование динамического или статического [внешнего IP-адреса](../../vpc/concepts/address.md#public-addresses) (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md)).

## Подготовьте спецификацию ВМ {#prepare-specification-vm}

{% list tabs group=instructions %}

- CLI {#cli}

  Чтобы подготовить спецификацию ВМ, создайте файл `cloud-config-ports.yaml` и заполните его следующими данными:

  ```yaml
  #cloud-config
  runcmd:
    - [ sudo, chmod, 666, /dev/ttyS1]
  users:
    - name: <имя_пользователя>
      groups: sudo
      shell: /bin/bash
      sudo: 'ALL=(ALL) NOPASSWD:ALL'
      ssh-authorized-keys:
        - <публичный_SSH-ключ_для_подключения_к_ВМ>
  ```

  В конфигурации файла задайте имя пользователя и укажите публичную часть [SSH-ключа](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) для подключения к ВМ. Пару ключей для подключения по SSH необходимо [создать](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) самостоятельно.

{% endlist %}

## Подготовьте спецификацию Docker-контейнера {#prepare-specification-docker}

{% list tabs group=instructions %}

- CLI {#cli}

  Чтобы подготовить спецификацию [Docker-контейнера](/blog/posts/2022/03/docker-containers), создайте файл `container-spec-ports.yaml` и заполните его следующими данными:

  ```yaml
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

  1. Создайте ВМ с несколькими [дисками](../../compute/concepts/disk.md).
     1. Получите идентификатор образа для создания ВМ:

        {% list tabs group=programming_language %}

        - Bash {#bash}

          ```bash
          IMAGE_ID=$(yc compute image get-latest-from-family container-optimized-image --folder-id standard-images --format=json | jq -r .id)
          ```

        - PowerShell {#powershell}

          ```shell script
          > $IMAGE_ID=(yc compute image get-latest-from-family container-optimized-image --folder-id standard-images --format=json | ConvertFrom-Json).id
          ```

        {% endlist %}

     1. Создайте ВМ:

        ```bash
        yc compute instance create \
          --name coi-vm-with-sp \
          --zone {{ region-id }}-a \
          --network-interface subnet-name=<имя_подсети>,nat-ip-version=ipv4 \
          --metadata-from-file user-data=cloud-config-ports.yaml,docker-container-declaration=container-spec-ports.yaml \
          --create-boot-disk image-id=$IMAGE_ID
        ```

        Где:
        * `--name` — имя ВМ.
        * `--zone` — [зона доступности](../../overview/concepts/geo-scope.md).
        * `--network-interface` — сетевые настройки ВМ.
        * `--metadata-from-file` — YAML-файлы [метаданных](../../compute/concepts/vm-metadata.md) для создания ВМ.
        * `--create-boot-disk` — идентификатор образа для создания загрузочного диска.

        После создания ВМ появится в списке ВМ в разделе **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}** в [консоли управления]({{ link-console-main }}).
     1. Проверьте результат.
        1. В [консоли управления]({{ link-console-main }}) перейдите на страницу [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
        1. Нажмите на имя нужной ВМ `coi-vm-with-sp`.
        1. В блоке **{{ ui-key.yacloud.compute.instance.switch_service-console }}** выберите порт `COM2`. Через несколько минут на экран начнет выводиться `Hello world!`.

{% endlist %}

## Получите идентификатор образа для создания ВМ {#get-id}

Чтобы получить идентификатор последнего образа для создания ВМ, выполните:

{% list tabs group=operating_system %}

- Linux (Bash) {#linux}

  ```bash
  IMAGE_ID=$(yc compute image get-latest-from-family container-optimized-image \
    --folder-id standard-images \
    --format=json | jq -r .id)
  ```

- Windows (PowerShell) {#windows}

  ```shell script
  $IMAGE_ID=(yc compute image get-latest-from-family container-optimized-image `
    --folder-id standard-images `
    --format=json | ConvertFrom-Json).id
  ```

{% endlist %}

## Создайте ВМ {#create-vm}

{% list tabs group=instructions %}

- CLI {#cli}

  Задайте имя [подсети](../../vpc/operations/subnet-create.md), в которой будет создаваться ВМ, и выполните:

  ```bash
  yc compute instance create \
    --name coi-vm-with-sp \
    --zone {{ region-id }}-c \
    --network-interface subnet-name=<имя_подсети>,nat-ip-version=ipv4 \
    --metadata-from-file user-data=cloud-config-ports.yaml,docker-container-declaration=container-spec-ports.yaml \
    --create-boot-disk image-id=$IMAGE_ID
  ```

  Где:
  * `--name` — имя ВМ.
  * `--zone` — зона доступности.
  * `--network-interface` — сетевые настройки ВМ.
  * `--metadata-from-file` — YAML-файлы метаданных для создания ВМ.
  * `--create-boot-disk` — идентификатор образа для создания загрузочного диска.

{% endlist %}

После создания ВМ появится в списке ВМ в разделе **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}** в [консоли управления]({{ link-console-main }}).

## Проверьте результат {#check-result}

Чтобы проверить результат настройки вывода информации из Docker-контейнера в серийный порт:
1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
1. Нажмите на имя нужной ВМ `coi-vm-with-sp`.
1. В блоке **{{ ui-key.yacloud.compute.instance.switch_service-console }}** выберите порт `COM2`. Через несколько минут на экран начнет выводиться `Hello world!`.

Подробнее о работе с ВМ читайте в [пошаговых инструкциях](../../compute/operations/index.md).

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:
1. [Удалите ВМ](../../compute/operations/vm-control/vm-delete.md).
1. Если вы зарезервировали для ВМ публичный статический IP-адрес, [удалите его](../../vpc/operations/address-delete.md).