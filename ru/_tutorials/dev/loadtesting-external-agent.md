# Запуск внешних агентов для нагрузочного тестирования


{{ load-testing-full-name }} можно использовать для нагрузочного тестирования сервисов с помощью внешних агентов. 

_Внешний агент_ — физический или виртуальный сервер с инструментом для тестирования и [генераторами нагрузки](../../load-testing/concepts/load-generator.md), который размещен вне сервиса {{ load-testing-name }}.

Запуск и просмотр результатов нагрузочного тестирования с внешнего агента идентичны работе с [агентом](../../load-testing/concepts/agent.md) {{ load-testing-name }}. Подробнее см. [{#T}](../../load-testing/quickstart.md).

Нагрузочное тестирование с внешнего агента применяется в следующих случаях:
* цель тестирования состоит из нескольких виртуальных машин, а суммарный входящий и исходящий трафик с них превышает [возможности агента {{ load-testing-name }}](../../load-testing/concepts/agent.md#benchmark);
* запросы, которые направляются в цель тестирования, требуют много вычислительных мощностей;
* агент должен размещаться в собственной инфраструктуре по правилам информационной безопасности;
* вычислительные ресурсы ВМ {{ compute-name }} ограничены.

Чтобы провести нагрузочное тестирование с внешнего агента:
1. [Подготовьте облако к работе](#before-you-begin).
1. [Подготовьте инфраструктуру](#prepare-infrastructure).
1. [Настройте окружение](#configure-environment).
1. [Установите внешний агент](#install-external-agent).
1. [Запустите внешний агент](#run-external-agent).
1. [Создайте тест](#run-test).
1. [Посмотрите результаты тестирования](#see-results).

Если подключенный внешний агент вам больше не нужен, [удалите его](#clear-out) из {{ load-testing-name }}.

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

На стадии [Preview](../../overview/concepts/launch-stages.md) использование сервиса {{ load-testing-name }} не тарифицируется.

## Подготовьте инфраструктуру {#prepare-infrastructure}

### Настройте сервисный аккаунт {#prepare-service-account}

1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт, например `sa-loadtest`, в каталоге, где будет подключен внешний агент.
1. [Назначьте](../../iam/operations/roles/grant.md) сервисному аккаунту [роли](../../load-testing/security/index.md#roles-list) `loadtesting.editor` и `loadtesting.generatorClient`.
1. [Создайте](../../iam/operations/authorized-key/create.md) авторизованные ключи для сервисного аккаунта.

    Сохраните открытый и закрытый ключи единым файлом, для этого нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.overview.action_download-keys-file }}**.

### Создайте секрет с авторизованными ключами {#create-authorized-key-secret}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, где будет подключен внешний агент.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.lockbox.button_create-secret }}**.

  1. В поле **{{ ui-key.yacloud.common.name }}** введите имя секрета, например `secret-loadtest`.
  1. В блоке **{{ ui-key.yacloud.lockbox.forms.section_version }}**:
      * в поле **{{ ui-key.yacloud.lockbox.forms.label_key }}** введите неконфиденциальный идентификатор, например `key-loadtest`;
      * в поле **{{ ui-key.yacloud.lockbox.forms.label_value }}** загрузите файл с открытым и закрытым авторизованными ключами.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

      Сохраните имя и ключ секрета.

{% endlist %}

## Настройте окружение {#configure-environment}

1. [Установите и инициализируйте](../../cli/quickstart.md#install) интерфейс командной строки {{ yandex-cloud }}.
1. [Установите](https://www.docker.com/) и запустите Docker.
1. Аутентифицируйтесь в {{ container-registry-name }} от [имени пользователя](../../container-registry/operations/authentication.md#user) или с помощью [Docker Credential Helper](../../container-registry/operations/authentication.md#cred-helper).

    Используйте эндпоинт [реестра](../../container-registry/concepts/registry.md) с [Docker-образами](../../container-registry/concepts/docker-image.md) внешних агентов: `cr.yandex/yc/`.

## Установите внешний агент {#install-external-agent}

1. Скачайте Docker-образ с внешним агентом, в терминале выполните команду:

    ```bash
    docker pull cr.yandex/yc/ya-lt-agent:latest
    ```

    Результат:

    ```bash
    latest: Pulling from yc/ya-lt-agent
    df6635ed1257: Pull complete 
    7a51fa4387ba: Pull complete 
    Digest: sha256:fad262e94a8b4021b13336ae31c738ec1e77eb6a8971528429c67d2827f1e47b
    Status: Downloaded newer image for cr.yandex/yc/ya-lt-agent:latest
    cr.yandex/yc/ya-lt-agent:latest
    ```

1. Скачайте файл с открытым и закрытым авторизованными ключами из {{ lockbox-short-name }}:

    ```bash
    yc lockbox payload get <имя_секрета> \
      --key <ключ_секрета> \
      > <имя_файла>
    ```

    Где:
    * `<имя_секрета>` — имя секрета с авторизованными ключами, например `secret-loadtest`.
    * `<ключ_секрета>` — неконфиденциальный идентификатор секрета с авторизованными ключами, например `key-loadtest`.
    * `<имя_файла>` — имя файла, в который сохраняются авторизованные ключи, например `secret-key.json`.

    {% note warning %}

    В среде Windows при выполнении команды используйте консоль командной строки **CMD**. В **Powershell** файл скачивается с некорректной кодировкой. Убедитесь, что кодировка скачанного файла — `UTF-8`.
    
    {% endnote %}
    
1. Создайте конфигурационный файл для внешнего агента, например `config.yaml`, и скопируйте в него следующие параметры:

    ```text
    client_workdir: '/var/lib/tank_agent/client'
    tankapi_host: localhost
    tankapi_port: 8083
    load_testing_host: 'loadtesting.{{ api-host }}'
    load_testing_port: '443'
    logging_host: 'ingester.logging.yandexcloud.net'
    logging_port: '443'
    object_storage_url: 'https://{{ s3-storage-host }}'
    storage_file: '/tmp/yandex-tank/storage.data'
    iam_token_service_url: 'iam.{{ api-host }}:443'
    agent_id_file: '/run/agentid'
    private_key: '/run/sa_key.json'

    agent_name: <имя_внешнего_агента>
    folder_id: <идентификатор_каталога>
    ```

    Где:
    * `agent_name` — имя внешнего агента, например `external-agent`.
    * `folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md), где будет подключен внешний агент.

## Запустите внешний агент {#run-external-agent}

1. Чтобы запустить Docker-контейнер с внешним агентом, в терминале выполните команду:

    ```bash
    docker run \
      -it \
      --mount type=bind,source=<путь_к_файлу_с_авторизованными_ключами>,target=/run/sa_key.json \
      --mount type=bind,source=<путь_к_конфигурационному_файлу>,target=/run/config.yaml \
      --env LOADTESTING_AGENT_CONFIG=/run/config.yaml \
      cr.yandex/yc/ya-lt-agent:latest
    ```

    Где:
    * `<путь_к_файлу_с_авторизованными_ключами>` — абсолютный путь к файлу с авторизованными ключами, например `/home/user/secret-key.json`.
    * `<путь_к_конфигурационному_файлу>` — абсолютный путь к конфигурационному файлу, например `/home/user/config.yaml`.

    Также конфигурацию внешнего агента можно задать с помощью переменных окружения для разных Docker-контейнеров.

    {% cut "Пример запуска внешнего агента с переменными окружения" %}

    ```bash
    docker run \
      -it \
      --mount type=bind,source=<путь_к_файлу_с_авторизованными_ключами_в_ОС_хоста>,target=/run/sa_key.json \
      --env LOADTESTING_AGENT_CONFIG=<путь_к_конфигурационному_файлу_в_контейнере> \
      --env LOADTESTING_AGENT_NAME='<имя_внешнего_агента>' \
      --env LOADTESTING_FOLDER_ID='<идентификатор_каталога>' \
      --env LOADTESTING_SA_KEY_FILE=<путь_к_файлу_с_авторизованными_ключами_в_контейнере> \
      cr.yandex/yc/ya-lt-agent:latest
    ```

    Где:
    * `LOADTESTING_AGENT_CONFIG` — (обязательный параметр) путь к конфигурационному файлу внешнего агента в контейнере.
    * `LOADTESTING_AGENT_NAME` — имя внешнего агента.
    * `LOADTESTING_FOLDER_ID` — идентификатор каталога.
    * `LOADTESTING_SA_KEY_FILE` — путь к файлу с авторизованными ключами в контейнере.

    Вместо файла с авторизованными ключами можно использовать следующие переменные окружения:
    * `LOADTESTING_SA_ID` — идентификатор сервисного аккаунта.
    * `LOADTESTING_SA_KEY_ID` — идентификатор авторизованного ключа сервисного аккаунта.
    * `LOADTESTING_SA_KEY_PAYLOAD` — значение закрытого авторизованного ключа сервисного аккаунта.

    Внешний агент авторизуется с помощью [JWT](../../iam/operations/iam-token/create-for-sa.md#via-jwt).

    {% endcut %}

    При каждом запуске Docker-контейнера внешний агент будет получать новый идентификатор в {{ load-testing-name }}. Вы можете сохранить один и тот же идентификатор между запусками, например, чтобы привязать результаты тестирования к конкретному агенту. Для этого используйте том Docker для хранения файла с идентификатором внешнего агента (параметр `agent_id_file` в конфигурационном файле агента). Данные в томе хранятся независимо от Docker-контейнера: если вы остановите или удалите контейнер, то том и данные в нем останутся.

    {% cut "Пример запуска внешнего агента с постоянным идентификатором" %}

    Создайте том Docker, например `external_agent_1_volume`:

    ```bash
    docker volume create external_agent_1_volume
    ```

    Запустите внешний агент с подключенным томом:

    ```bash
    docker run \
      -it \
      --mount source=external_agent_1_volume,target=/run \
      --mount type=bind,source=<путь_к_файлу_с_авторизованными_ключами>,target=/run/sa_key.json \
      --mount type=bind,source=<путь_к_конфигурационному_файлу>,target=/run/config.yaml \
      --env LOADTESTING_AGENT_CONFIG=/run/config.yaml \
      cr.yandex/yc/ya-lt-agent:latest
    ```

    {% endcut %}

1. Проверьте, что внешний агент доступен в {{ load-testing-name }}:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_load-testing }}**.
      1. На панели слева перейдите на вкладку ![operations](../../_assets/mdb/operations.svg) **{{ ui-key.yacloud.common.operations-key-value }}**.

      1. Убедитесь, что операция **Register an agent** успешно завершена.
      1. На панели слева перейдите на вкладку ![agents](../../_assets/load-testing/agent.svg) **{{ ui-key.yacloud.load-testing.label_agents-list }}**.
      1. Убедитесь, что внешний агент, например `external-agent`, находится в статусе `Ready for test`.

    {% endlist %}

## Создайте тест {#run-test}

[Выполните](../../load-testing/quickstart.md#run-test) нагрузочное тестирование. В поле **{{ ui-key.yacloud.load-testing.label_agents-list }}** выберите внешний агент, например `external-agent`.


## Посмотрите результаты тестирования {#see-results}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_load-testing }}**.
  1. На панели слева перейдите на вкладку ![image](../../_assets/load-testing/test.svg) **{{ ui-key.yacloud.load-testing.label_tests-list }}**.
  1. Выберите созданный ранее тест и посмотрите результаты. 

{% endlist %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы удалить внешний агент из {{ load-testing-name }}:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_load-testing }}**.
  1. На панели слева перейдите на вкладку ![agents](../../_assets/load-testing/agent.svg) **{{ ui-key.yacloud.load-testing.label_agents-list }}**.
  1. Напротив агента, который вы хотите удалить, нажмите ![options](../../_assets/options.svg) и выберите **{{ ui-key.yacloud.common.delete }}**.
  1. Подтвердите удаление.

{% endlist %}

### См. также

* [{#T}](../../load-testing/tutorials/loadtesting-multiply.md)