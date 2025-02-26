---
title: Начало работы с {{ yandex-cloud }} SDK
description: Познакомьтесь с возможностями {{ yandex-cloud }} SDK
sourcePath: ru/sdk/sdk/quickstart.md
---

# Как начать работать с {{ yandex-cloud }} SDK

[{{ yandex-cloud }} SDK](./overview.md) — это комплект средств разработки для взаимодействия с облачной инфраструктурой.

Рассмотрим некоторые возможности SDK на примере пошагового создания [виртуальной машины](../../compute/concepts/vm.md) {{ compute-full-name }}.

Чтобы начать работать с {{ yandex-cloud }} SDK:
1. [Подготовьте облако к работе](#before-begin).
    1. [Создайте сервисный аккаунт](#create-sa).
    1. [Подготовьте {{ yandex-cloud }} CLI](#prepare-cli).
    1. [Получите исходные данные](#get-source-data).
1. [Настройте окружение](#prepare-project).
1. [Создайте файл конфигурации](#create-config).
1. [Подготовьте код скрипта](#prepare-code).
1. [Создайте ВМ с помощью скрипта](#run-code).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

Также см. [Примеры использования SDK](#examples).

## Подготовьте облако к работе {#before-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки ВМ, созданной с помощью SDK, входят:
* плата за вычислительные ресурсы ВМ (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md#prices-instance-resources));
* плата за диски ВМ (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md#prices-storage));
* плата за использование динамического внешнего IP-адреса (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md#prices-public-ip)).

### Создайте сервисный аккаунт {#create-sa}

1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт.
1. [Назначьте](../../organization/operations/add-role.md) сервисному аккаунту [роли](../../iam/concepts/access-control/roles.md) в зависимости от сервисов, которыми вы хотите управлять с помощью {{ yandex-cloud }} SDK.

    В данном руководстве для создания ВМ вам понадобится роль [compute.admin](../../compute/security/index.md#compute-admin). 
    
    Если вы будете использовать **SDK для .NET**, также назначьте сервисному аккаунту роль [iam.serviceAccounts.admin](../../iam/security/index.md#iam-serviceAccounts-admin). Эта роль понадобится для получения [авторизованного ключа](../../iam/concepts/authorization/key.md).

### Подготовьте {{ yandex-cloud }} CLI {#prepare-cli}

1. [Установите](../../cli/operations/install-cli.md) {{ yandex-cloud }} CLI.
1. [Аутентифицируйтесь](../../cli/operations/authentication/service-account) в {{ yandex-cloud }} CLI от имени сервисного аккаунта.

    С помощью {{ yandex-cloud }} CLI будут получены данные для аутентификации в {{ yandex-cloud }}:
    * для Node.js, Go, Python, Java — [IAM-токен](../../iam/concepts/authorization/iam-token.md).
    * для .NET — [авторизованный ключ](../../iam/concepts/authorization/key.md).

### Получите исходные данные {#get-source-data}

1. [Получите](../../resource-manager/operations/folder/get-id.md) идентификатор каталога, внутри которого вы будете взаимодействовать с сервисами с помощью {{ yandex-cloud }} SDK.
1. [Подберите](../../compute/operations/images-with-pre-installed-software/get-list.md) подходящий образ для ВМ. Сохраните идентификатор [семейства образов](../../compute/concepts/image.md#family), например `ubuntu-2204-lts`.
1. [Создайте](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) пару SSH-ключей, чтобы использовать их для [подключения к ВМ](../../compute/operations/vm-connect/ssh.md). 

## Подготовьте рабочую директорию {#prepare-project}

{% list tabs group=instructions %}

- Node.js {#nodejs}

    1. В терминале проверьте версию Node.js с помощью команды: 

        ```bash
        node -v
        ```

        {{ yandex-cloud }} SDK поддерживает версию Node.js 12 и выше. Если Node.js не установлен или нужна более новая версия, выберите подходящий вариант установки на [сайте Node.js](https://nodejs.org/en/download/package-manager).
    1. Склонируйте [репозиторий с примерами {{ yandex-cloud }} SDK для Node.js](https://github.com/yandex-cloud-examples/yc-sdk-quickstart-node-js.git):

        ```bash
        git clone https://github.com/yandex-cloud-examples/yc-sdk-quickstart-node-js.git
        ```

    1. {% include [change-directory](../../_includes/sdk/compute/create-instance/change-directory.md) %}

        ```bash
        cd yc-sdk-quickstart-node-js && npm i
        ```

- Go {#go}

    1. В терминале проверьте версию Go с помощью команды: 

        ```bash
        go version
        ```

        Если Go не установлен, выберите подходящий вариант установки на [сайте Go](https://go.dev/doc/install).
    1. Склонируйте [репозиторий с примерами {{ yandex-cloud }} SDK для Go](https://github.com/yandex-cloud-examples/yc-sdk-quickstart-go.git):

        ```bash
        git clone https://github.com/yandex-cloud-examples/yc-sdk-quickstart-go.git
        ```

    1. {% include [change-directory](../../_includes/sdk/compute/create-instance/change-directory.md) %}

        ```bash
        cd yc-sdk-quickstart-go && go tidy
        ```
    
- Python {#python}

    1. В терминале проверьте версию Python с помощью команды для Linux и MacOS: 

        ```bash
        python3 --version
        ```

        или для Windows:

        ```bash
        python --version
        ```
        
        Если Python не установлен, выберите подходящий вариант установки на [сайте Python](https://www.python.org/downloads).
    1. Склонируйте [репозиторий с примерами {{ yandex-cloud }} SDK для Python](https://github.com/yandex-cloud-examples/yc-sdk-quickstart-python.git):

        ```bash
        git clone https://github.com/yandex-cloud-examples/yc-sdk-quickstart-python.git
        ```

    1. {% include [change-directory](../../_includes/sdk/compute/create-instance/change-directory.md) %}

        ```bash
        cd yc-sdk-quickstart-python && pip install yandexcloud
        ```

- Java {#java}

    1. В терминале проверьте версию Java с помощью команды: 

        ```bash
        java --version
        ```

        Если Java не установлен, выберите подходящий вариант установки на [сайте Oracle](https://www.oracle.com/java/technologies/downloads/).
    1. Дополнительно [установите Apache Maven](https://maven.apache.org/install.html) для сборки проекта.
    1. Склонируйте [репозиторий с примерами {{ yandex-cloud }} SDK для Java](https://github.com/yandex-cloud-examples/yc-sdk-quickstart-java.git):

        ```bash
        git clone https://github.com/yandex-cloud-examples/yc-sdk-quickstart-java.git
        ```

    1. Перейдите в склонированный репозиторий:

        ```bash
        cd yc-sdk-quickstart-java
        ```

- .NET {#dotnet}

    1. В терминале проверьте версию .NET с помощью команды: 

        ```bash
        dotnet -version
        ```

        Если .NET не установлен, выберите подходящий вариант установки на [сайте Microsoft](https://dotnet.microsoft.com/en-us/download). Рекомендуем установить версию 9.0 так как она используется в данной инструкции. Если вы установите другую версию .NET, укажите ее в файле `YC-test`.
    1. Склонируйте [репозиторий с примерами {{ yandex-cloud }} SDK для .NET](https://github.com/yandex-cloud-examples/yc-sdk-quickstart-dotnet.git):

        ```bash
        git clone https://github.com/yandex-cloud-examples/yc-sdk-quickstart-dotnet.git
        ```

    1. В склонированном репозитории перейдите в директорию `yc-sdk-quickstart-dotnet`:

        ```bash
        cd yc-sdk-quickstart-dotnet
        ```

{% endlist %}

## Настройте файл конфигурации {#create-config}

{% list tabs group=instructions %}

- Node.js {#nodejs}

    {% include [open-and-set-config](../../_includes/sdk/compute/create-instance/open-and-set-config.md) %}

    {% include [instance-json-config](../../_includes/sdk/compute/basic-instance-config-json.md) %}

- Go {#go}

    {% include [open-and-set-config](../../_includes/sdk/compute/create-instance/open-and-set-config.md) %}

    {% include [instance-json-config](../../_includes/sdk/compute/basic-instance-config-json.md) %}

- Python {#python}

    {% include [open-and-set-config](../../_includes/sdk/compute/create-instance/open-and-set-config.md) %}

    {% include [instance-json-config](../../_includes/sdk/compute/basic-instance-config-json.md) %}

- Java {#java}

    Откройте файл `config.json` в директории `src/main/resources/config`. В нем уже установлена базовая конфигурация ВМ и вам необходимо указать `folder_id` и `subnet_id`. Но вы можете установить собственные параметры и для других полей:

    {% include [instance-json-config](../../_includes/sdk/compute/basic-instance-config-json.md) %}

- .NET {#dotnet}

    {% include [open-and-set-config](../../_includes/sdk/compute/create-instance/open-and-set-config.md) %}

    {% include [instance-json-config](../../_includes/sdk/compute/basic-instance-config-json.md) %}

{% endlist %}

## Создайте ВМ с помощью скрипта {#run-code}

Проект уже настроен для создания ВМ с помощью консольных команд. С помощью комментариев в коде вы можете детальнее узнать из каких шагов состоит процесс создания ВМ.

{% list tabs group=instructions %}

- Node.js {#nodejs}

    Запустите файл `index.js` командой:

    ```bash
    IAM_TOKEN=$(yc iam create-token) \
    SSH_PUBLIC_KEY_PATH=./key.pub \
    node index.js   
    ```

    {% include [running-process-description](../../_includes/sdk/compute/create-instance/run-code-part.md) %}

- Go {#go}

    Запустите файл `main.go` командой:

    ```bash
    IAM_TOKEN=$(yc iam create-token) \
    SSH_PUBLIC_KEY_PATH=./key.pub \
    go run main.go
    ```

    {% include [running-process-description](../../_includes/sdk/compute/create-instance/run-code-part.md) %}

- Python {#python}

    Запустите файл `script.py` командой:

    ```bash
    IAM_TOKEN=$(yc iam create-token) \
    SSH_PUBLIC_KEY_PATH=./key.pub \
    python script.py
    ```

    {% include [running-process-description](../../_includes/sdk/compute/create-instance/env-vars-descr.md) %}

    {% include [env-reload-warning](../../_includes/sdk/compute/create-instance/env-reload-warning.md) %}

    Работа скрипта разделена на несколько этапов:

    * **Запуск скрипта для создания ВМ**. Если скрипт не нашел ошибок в формате переданных данных, вы увидите следующее сообщение:
    
      ```text
      INFO:yandexcloud._channels:Using endpoints from configuration, IAM iam.api.cloud.yandex.net:443, compute compute.api.cloud.yandex.net:443
      INFO:yandexcloud._channels:Using endpoints from configuration, IAM iam.api.cloud.yandex.net:443, compute compute.api.cloud.yandex.net:443
      INFO:root:Creating initiated
      ```

    * **Передача данных на сервер для валидации**. Если все данные были указаны корректно, вы увидите следующее сообщение:

      ```text
      INFO:root:Running Yandex.Cloud operation. ID: fv45g3nfq0bn********. Description: Create instance. Created at: 2024-12-19 15:52:59. Created by: ajeutahec4**********. Meta: instance_id: "fv4bi87d50**********".
      INFO:yandexcloud._channels:Using endpoints from configuration, IAM iam.api.cloud.yandex.net:443, operation operation.api.cloud.yandex.net:443
      ```
    
    * **Результат операции**. После создания ВМ вы получите информацию о ней:

      ```text
      INFO:root:Done Yandex.Cloud operation. ID: fv45g3nfq0bn********. Response: id: "fv42jgaq946dm8ibkjl6"
      folder_id: "b1g5hnqtug**********"
      created_at {
          seconds: 1734614895
      }
      name: "computer"
      zone_id: "ru-central1-d"
      platform_id: "standard-v3"
      resources {
          memory: 2147483648
          cores: 2
          core_fraction: 100
      }
      status: RUNNING
      metadata_options {
          gce_http_endpoint: ENABLED
          aws_v1_http_endpoint: ENABLED
          gce_http_token: ENABLED
          aws_v1_http_token: DISABLED
      }
      boot_disk {
          mode: READ_WRITE
          device_name: "fv4sd8kkspslntd0dpvn"
          auto_delete: true
          disk_id: "fv4sd8kkspslntd0dpvn"
      }
      network_interfaces {
          index: "0"
          mac_address: "d0:0d:29:c1:5a:49"
          subnet_id: "fl8b5ou7m8sihjbftcfk"
          primary_v4_address {
              address: "192.168.0.3"
              one_to_one_nat {
              address: "51.250.34.207"
              ip_version: IPV4
              }
          }
      }
      serial_port_settings {
          ssh_authorization: OS_LOGIN
      }
      gpu_settings {}
      fqdn: "fv42jgaq946dm8ibkjl6.auto.internal"
      scheduling_policy {}
      network_settings {
          type: STANDARD
      }
      placement_policy {}
      hardware_generation {
          legacy_features {
              pci_topology: PCI_TOPOLOGY_V1
          }
      }.
      WARNING: All log messages before absl::InitializeLog() is called are written to STDERR
      E0000 00:00:1734614936.026768 4332467 init.cc:229] grpc_wait_for_shutdown_with_timeout() timed out.
      ```

- Java {#java}

    1. Соберите проект командой:

        ```bash
        mvn clean package
        ```
    
    1. В корневой директории проекта запустите программу командой:

        ```bash
        IAM_TOKEN=$(yc iam create-token) \
        SSH_PUBLIC_KEY_PATH=key.pub \
        java -jar target/java-sdk-examples-2.6.4-jar-with-dependencies.jar  
        ```

        {% include [running-process-description](../../_includes/sdk/compute/create-instance/run-code-part.md) %}

- .NET {#dotnet}

    В корневой директории проекта запустите программу командой:

    ```bash
    yc iam key create \
      --output key.json \
      --service-account-name <имя_сервисного_аккаунта> && \
    AUTH_KEY=$(<key.json) && \
    rm key.json && \
    SSH_PUBLIC_KEY_PATH=~/key.pub \
    dotnet run
    ```

    Данная команда состоит из следующих частей:
    * `yc iam key create` — команда получения [авторизованного ключа](../../iam/concepts/authorization/key.md) в которой:
        * `--output` — путь к файлу для записи авторизованного ключа в формате JSON.
        * `--service-account-name` — имя сервисного аккаунта, для которого создается ключ.
    * `AUTH_KEY=$(<key.json)` — чтение файла с авторизованным ключом и размещение содержимого ключа в переменной `AUTH_KEY`.
    * `rm key.json` — удаление файла с авторизованным ключом. Вы можете пропустить эту часть команды, если планируете повторно использовать авторизованный ключ.
    * `SSH_PUBLIC_KEY_PATH=~/key.pub` — установка пути к файлу с публичным SSH-ключом в переменную окружения `SSH_PUBLIC_KEY_PATH`.
    * `dotnet run` — запуск скрипта.

    {% include [env-reload-warning](../../_includes/sdk/compute/create-instance/env-reload-warning.md) %}
    
    {% include [first-output](../../_includes/sdk/compute/create-instance/first-output.md) %}

    {% include [what-is-op-id](../../_includes/sdk/compute/operation-id.md) %}
    
    {% include [info-by-op-id](../../_includes/sdk/compute/get-info-by-op-id.md) %}

{% endlist %}

{% include [check-by-label](../../_includes/sdk/compute/check-by-label.md) %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы, [удалите](../../compute/operations/vm-control/vm-delete.md) ВМ из {{ compute-name }}.
 
# Примеры работы с SDK {#examples}

* [Node.js](https://github.com/yandex-cloud/nodejs-sdk/tree/master/examples)
* [Go](https://github.com/yandex-cloud/go-sdk/tree/master/examples)
* [Python](https://github.com/yandex-cloud/python-sdk/tree/master/examples)
* [Java](https://github.com/yandex-cloud/java-sdk/tree/master/java-sdk-examples)
* [.NET](https://github.com/yandex-cloud/dotnet-sdk/tree/master/Example)

## См. также {#see-also}

[{#T}](../../compute/operations/vm-connect/ssh.md)