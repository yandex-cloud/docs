# Настройка вывода информации из Docker-контейнера в серийный порт

Чтобы создать [виртуальную машину](../../compute/concepts/vm.md) из [образа](../../compute/concepts/image.md) [Container Optimized Image](../concepts/index.md) и настроить перенаправление потока вывода приложения в [серийный порт](../../compute/concepts/serial-console.md) ВМ:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Подготовьте спецификацию ВМ](#prepare-specification-vm).
1. [Подготовьте спецификацию Docker-контейнера](#prepare-specification-docker).
1. [Получите идентификатор образа для создания ВМ](#get-id).
1. [Создайте ВМ](#create-vm).
1. [Проверьте результат](#check-result).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

Если нужный [Docker-образ](../../container-registry/concepts/docker-image.md) загружен в [Container Registry](../../container-registry/index.md), создайте [сервисный аккаунт](../../iam/operations/sa/create.md) с ролью [container-registry.images.puller](../../container-registry/security/index.md#choosing-roles) на используемый [реестр](../../container-registry/concepts/registry.md). От его имени ВМ на базе Container Optimized Image будет скачивать из реестра Docker-образ.

Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

Если у вас еще нет [сети](../../vpc/operations/network-create.md) или [подсети](../../vpc/operations/subnet-create.md), создайте их.

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входит:
* Плата за постоянно запущенную ВМ (см. [тарифы Yandex Compute Cloud](../../compute/pricing.md)).
* Плата за использование динамического или статического [внешнего IP-адреса](../../vpc/concepts/address.md#public-addresses) (см. [тарифы Yandex Virtual Private Cloud](../../vpc/pricing.md)).

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
    ssh_authorized_keys:
    - <публичный_SSH-ключ_для_подключения_к_ВМ>
  ```

  В конфигурации файла задайте имя пользователя и укажите публичную часть [SSH-ключа](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) для подключения к ВМ. Пару ключей для подключения по SSH необходимо [создать](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) самостоятельно.

{% endlist %}

## Подготовьте спецификацию Docker-контейнера {#prepare-specification-docker}

{% list tabs group=instructions %}

- CLI {#cli}

  Чтобы подготовить спецификацию [Docker-контейнера](https://yandex.cloud/ru/blog/posts/2022/03/docker-containers), создайте файл `container-spec-ports.yaml` и заполните его следующими данными:

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
          --zone ru-central1-a \
          --network-interface subnet-name=<имя_подсети>,nat-ip-version=ipv4 \
          --metadata-from-file user-data=cloud-config-ports.yaml,docker-container-declaration=container-spec-ports.yaml \
          --create-boot-disk image-id=$IMAGE_ID \
          --service-account-name <имя_сервисного_аккаунта>
        ```

        Где:
        * `--name` — имя ВМ.
        * `--zone` — [зона доступности](../../overview/concepts/geo-scope.md).
        * `--network-interface` — сетевые настройки ВМ.
        * `--metadata-from-file` — YAML-файлы [метаданных](../../compute/concepts/vm-metadata.md) для создания ВМ.

            {% note info %}
            
            Команды [`yc compute instance create`](../../cli/cli-ref/compute/cli-ref/instance/create.md) | [`create-with-container`](../../cli/cli-ref/compute/cli-ref/instance/create-with-container.md) | [`update`](../../cli/cli-ref/compute/cli-ref/instance/update.md) | [`add-metadata`](../../cli/cli-ref/compute/cli-ref/instance/add-metadata.md) поддерживают подстановку в метаданные ВМ значений переменных окружения. Эти значения, заданные в ключе `user-data` в формате `$<имя_переменной>`, в момент выполнения команды Yandex Cloud CLI будут подставлены в метаданные ВМ из переменных окружения среды, в которой выполняется команда. 
            
            Чтобы изменить такое поведение, не подставлять значение переменной из среды выполнения команды CLI и передать в метаданные ВМ имя переменной в формате `$<имя_переменной>`, используйте синтаксис с двумя символами доллара. Например: `$$<имя_переменной>`.
            
            Подробнее см. в разделе [Особенности передачи переменных окружения в метаданных через CLI](../../compute/concepts/metadata/sending-metadata.md#environment-variables).
            
            {% endnote %}
        * `--create-boot-disk` — идентификатор образа для создания загрузочного диска.
        * `--service-account-name` — имя сервисного аккаунта, созданного [ранее](#before-you-begin).

        После создания ВМ появится в списке ВМ в разделе **Compute Cloud** в [консоли управления](https://console.yandex.cloud).
     1. Проверьте результат.
        1. В [консоли управления](https://console.yandex.cloud) перейдите на страницу [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder).
        1. Перейдите в сервис **Compute Cloud**.
        1. Нажмите на имя нужной ВМ `coi-vm-with-sp`.
        1. В блоке **Последовательный порт** выберите порт `COM2`. Через несколько минут на экран начнет выводиться `Hello world!`.

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
    --zone ru-central1-d \
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

После создания ВМ появится в списке ВМ в разделе **Compute Cloud** в [консоли управления](https://console.yandex.cloud).

## Проверьте результат {#check-result}

Чтобы проверить результат настройки вывода информации из Docker-контейнера в серийный порт:
1. В [консоли управления](https://console.yandex.cloud) перейдите на страницу каталога.
1. Перейдите в сервис **Compute Cloud**.
1. Нажмите на имя нужной ВМ `coi-vm-with-sp`.
1. В блоке **Последовательный порт** выберите порт `COM2`. Через несколько минут на экран начнет выводиться `Hello world!`.

Подробнее о работе с ВМ читайте в [пошаговых инструкциях](../../compute/operations/index.md).

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:
1. [Удалите ВМ](../../compute/operations/vm-control/vm-delete.md).
1. Если вы зарезервировали для ВМ публичный статический IP-адрес, [удалите его](../../vpc/operations/address-delete.md).