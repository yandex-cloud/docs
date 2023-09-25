# Визуализация логов в {{ grafana-name }} с помощью плагина {{ cloud-logging-full-name }}

[Плагин {{ cloud-logging-full-name }} для {{ grafana-name }}](https://github.com/yandex-cloud/grafana-logs-plugin/tree/master) — расширение для {{ grafana-name }}, с помощью которого можно добавить [{{ cloud-logging-name }}](https://cloud.yandex.ru/services/logging) в качестве источника данных.

Чтобы визуализировать логи:
1. [Установите плагин](#install-plugin)
1. [Создайте сервисный аккаунт](#create-account)
1. [Подключите источник данных](#create-group)
1. [Создайте лог-группу](#create-group)
1. [Добавьте записи в лог-группу](#add-records)
1. [Посмотрите логи в {{ grafana-name }}](#see-logs)

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость ресурсов входит плата за запись и хранение логов в лог-группе (см. [тарифы {{ cloud-logging-full-name }}](../../logging/pricing.md)).

## Установите плагин {#install-plugin}

Чтобы установить плагин {{ cloud-logging-full-name }} для {{ grafana-name }}, воспользуйтесь [инструкцией](https://grafana.com/docs/grafana/latest/administration/plugin-management/#install-plugin-on-local-grafana).

В настоящий момент у плагина нет подписи, поэтому вам нужно явно [разрешить установку](https://grafana.com/docs/grafana/latest/administration/plugin-management/#allow-unsigned-plugins).

## Создайте сервисный аккаунт {#create-account}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать сервисный аккаунт.
    1. Перейдите на вкладку **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
    1. Введите имя сервисного аккаунта: `grafana-plugin`.
    1. Нажмите **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** и выберите роль `logging.reader`.
    1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    1. Создайте сервисный аккаунт `grafana-plugin`:

        ```bash
        yc iam service-account create --name grafana-plugin
        ```

        Результат:

        ```
        id: nfersamh4sjq********
        folder_id: b1gc1t4cb638********
        created_at: "2023-09-26T10:36:29.726397755Z"
        name: grafana-plugin
        ```

        Сохраните идентификатор сервисного аккаунта `grafana-plugin` (`id`) и каталога, в котором его создали (`folder_id`).

    1. Назначьте сервисному аккаунту роль `logging.reader` на каталог:

        ```bash
        yc resource-manager folder add-access-binding <идентификатор_каталога> \
          --role logging.reader \
          --subject serviceAccount:<идентификатор_сервисного_аккаунта>
        ```

        Результат:

        ```
        done (1s)
        ```

- {{ TF }}

    
    Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).


    1. Опишите в конфигурационном файле параметры сервисного аккаунта:

        ```hcl
        resource "yandex_iam_service_account" "grafana-plugin" {
          name        = "grafana-plugin"
          folder_id   = "<идентификатор_каталога>"
        }

        resource "yandex_resourcemanager_folder_iam_member" "reader" {
          folder_id = "<идентификатор каталога>"
          role      = "logging.reader"
          member    = "serviceAccount:${yandex_iam_service_account.grafana-plugin id}"
        }
        ```

        Где:

        * `name` — имя сервисного аккаунта. Обязательный параметр.
        * `folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md). Необязательный параметр. По умолчанию будет использовано значение, указанное в настройках провайдера.
        * `role` — назначаемая роль.

        Более подробную информацию о параметрах ресурса `yandex_iam_service_account` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/iam_service_account).

    1. Проверьте корректность конфигурационных файлов.

        1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
        1. Выполните проверку с помощью команды:

            ```bash
            terraform plan
            ```

        Если конфигурация описана верно, в терминале отобразится информация о сервисном аккаунте. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Разверните облачные ресурсы.

    1. Если в конфигурации нет ошибок, выполните команду:

        ```bash
        terraform apply
        ```

    1. Подтвердите создание сервисного аккаунта: введите в терминал слово `yes` и нажмите **Enter**.

        После этого будет создан сервисный аккаунт. Проверить появление сервисного аккаунта можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

        ```bash
        yc iam service-account list
        ```

- API

    Чтобы создать сервисный аккаунт, воспользуйтесь методом [create](../../iam/api-ref/ServiceAccount/create.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/Create](../../iam/api-ref/grpc/service_account_service.md#Create).

    Чтобы назначить сервисному аккаунту роль `logging.reader` на каталог, воспользуйтесь методом [setAccessBindings](../../iam/api-ref/ServiceAccount/setAccessBindings.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/SetAccessBindings](../../iam/api-ref/grpc/service_account_service.md#SetAccessBindings).

{% endlist %}

## Подключите источник данных {#connect-plugin}

Чтобы подключить плагин, воспользуйтесь [инструкцией](https://grafana.com/docs/grafana/latest/administration/data-source-management/#add-data-source-plugins).

В поле **API Key** укажите [авторизованный ключ](../../iam/concepts/authorization/api-key.md) для сервисного аккаунта, чтобы аутентифицироваться в {{ cloud-logging-name }} API.

## Создайте лог-группу {#create-group}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором создали сервисный аккаунт.
    1. Выберите сервис **{{ cloud-logging-name }}**.
    1. Нажмите кнопку **Создать группу**.
    1. Введите имя лог-группы: `grafana-plugin`.
    1. Укажите срок хранения записей в лог-группе.
    1. Нажмите кнопку **Создать группу**.

- CLI

    Чтобы создать лог-группу, выполните команду:

    ```
    yc logging group create \
      --name=grafana-plugin \
      --retention-period=<срок_хранения> \
    ```

    Где:
    * `--name` — имя лог-группы.
    * `--retention-period` — срок хранения записей в лог-группе.

    Результат:

    ```
    done (1s)
    id: af3flf29t8**********
    folder_id: aoek6qrs8t**********
    cloud_id: aoegtvhtp8**********
    created_at: "2023-09-26T09:56:38.970Z"
    name: grafana-plugin
    status: ACTIVE
    retention_period: 3600s
    ```

- {{ TF }}

  1. Опишите в конфигурационном файле параметры лог-группы:

     ```hcl
     provider "yandex" {
       token     = "<OAuth>"
       cloud_id  = "<идентификатор облака>"
       folder_id = "<идентификатор каталога>"
       zone      = "{{ region-id }}-a"
     }

     resource "yandex_logging_group" "grafana-plugin" {
       name      = "grafana-plugin"
       folder_id = "<идентификатор каталога>"
       retention_period = "1h"
     }
     ```

     Где:

     * `name` — имя лог-группы.

     * `folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md).

     * `retention_period` — срок хранения записей в лог-группе.

     Более подробную информацию о параметрах ресурса `yandex_logging_group` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/logging_group).

  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет. 

  1. Разверните облачные ресурсы.

  1. Если в конфигурации нет ошибок, выполните команду:

        ```
        terraform apply
        ```

  1. Подтвердите создание ресурсов: введите в терминал слово `yes` и нажмите **Enter**.

     После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

        ```
        yc logging group list
        ```

- API

  Чтобы создать лог-группу, воспользуйтесь методом REST API [create](../../logging/api-ref/LogGroup/create.md) для ресурса [LogGroup](../../logging/api-ref/LogGroup/index.md) или вызовом gRPC API [LogGroupService/Create](../../logging/api-ref/grpc/log_group_service.md#Create).

{% endlist %}

## Добавьте записи в лог-группу {#add-records}

{% list tabs %}

- CLI

    Чтобы добавить записи в лог-группу, выполните команду:

    * Linux, MacOS:
        ```
        yc logging write \
          --group-name=grafana-plugin \
          --message="My message" \
          --level=INFO
        ```
    * Windows (cmd):
        ```
        yc logging write ^
          --group-name=grafana-plugin ^
          --message="My message" ^
          --level=INFO
        ```
    * Windows (PowerShell):
        ```
        yc logging write `
          --group-name=grafana-plugin `
          --message="My message" `
          --level=INFO
        ```

        Где:

        * `--group-name` — имя лог-группы, в которую вы хотите добавить записи.
        * `--message` — сообщение.
        * `--level` — уровень логирования.

- API

  Чтобы добавить записи в лог-группу, воспользуйтесь вызовом gRPC API [LogIngestionService/Write](../../logging/api-ref/grpc/log_ingestion_service.md#Write).

{% endlist %}

## Посмотрите логи в {{ grafana-name }} {#see-logs}

Чтобы посмотреть логи в {{ grafana-name }}, воспользуйтесь [инструкцией](https://grafana.com/docs/grafana/latest/explore/).

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы, [удалите лог-группу](../../logging/operations/delete-group.md).
