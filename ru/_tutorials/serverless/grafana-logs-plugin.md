# Визуализация логов в {{ grafana-name }} с помощью плагина {{ cloud-logging-full-name }}


[Плагин {{ cloud-logging-full-name }} для {{ grafana-name }}](https://github.com/yandex-cloud/grafana-logs-plugin/tree/master) — расширение для {{ grafana-name }}, с помощью которого можно добавить [{{ cloud-logging-name }}](https://yandex.cloud/ru/services/logging) в качестве источника данных.

Чтобы визуализировать логи:

1. [Установите плагин](#install-plugin).
1. [Создайте сервисный аккаунт](#create-account).
1. [Создайте авторизованный ключ для сервисного аккаунта](#create-key).
1. [Создайте лог-группу](#create-group).
1. [Добавьте записи в лог-группу](#add-records).
1. [Подключите источник данных в {{ grafana-name }}](#connect-plugin).
1. [Посмотрите логи в {{ grafana-name }}](#see-logs).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость ресурсов входит плата за запись и хранение логов в лог-группе (см. [тарифы {{ cloud-logging-full-name }}](../../logging/pricing.md)).

## Установите плагин {#install-plugin}

1. [Скачайте](https://github.com/yandex-cloud/grafana-logs-plugin/releases) архив с последней версией плагина.
1. Распакуйте архив в папку с плагинами. Расположение папки с плагинами указывается в [конфигурации {{ grafana-name }}](https://grafana.com/docs/grafana/latest/setup-grafana/configure-grafana/).

   ```bash
   unzip <путь_к_архиву> -d <путь_к_папке_с_плагинами>
   ```

   {% note info %}

   Если вы используете macOS, после распаковки плагина вручную запустите файл `/opt/homebrew/var/lib/grafana/plugins/yandexcloud-logging-datasource/yc-logs-plugin_darwin_arm64` и в системных настройках [разрешите запуск приложений от сторонних разработчиков](https://support.apple.com/ru-ru/HT202491#openanyway).

   {% endnote %}

1. Разрешите загрузку плагина без подписи. Для этого в конфигурационном файле {{ grafana-name }} укажите название плагина в параметре `allow_loading_unsigned_plugins`:

   ```text
   allow_loading_unsigned_plugins = yandexcloud-logging-datasource
   ```

   Подробнее о загрузке плагинов без подписи см. в [документации {{ grafana-name }}](https://grafana.com/docs/grafana/latest/administration/plugin-management/#allow-unsigned-plugins).

1. Перезапустите сервер {{ grafana-name }}:

   {% list tabs group=operating_system %}

   - Linux {#linux}

     ```bash
     sudo systemctl restart grafana-server
     ```

   - Windows {#windows}

     1. Нажмите сочетание клавиш **Win+R**.
     1. В открывшемся окне введите `services.msc` и нажмите кнопку **ОК**.
     1. Нажмите правой кнопкой мыши строку со службой `Grafana` и выберите **Перезапустить**.

   - macOS {#macos}

     ```bash
     brew services restart grafana
     ```

   {% endlist %}  

## Создайте сервисный аккаунт {#create-account}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать сервисный аккаунт.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. Введите имя сервисного аккаунта: `grafana-plugin`.
  1. Нажмите **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** и выберите роль `logging.reader`.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Создайте сервисный аккаунт `grafana-plugin`:

     ```bash
     yc iam service-account create --name grafana-plugin
     ```

     Результат:

     ```text
     id: nfersamh4s**********
     folder_id: b1gc1t4cb6**********
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

     ```text
     done (1s)
     ```

- {{ TF }} {#tf}


  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).


  1. Опишите в конфигурационном файле параметры сервисного аккаунта:

     ```hcl
     resource "yandex_iam_service_account" "grafana-plugin" {
       name        = "grafana-plugin"
       folder_id   = "<идентификатор_каталога>"
     }

     resource "yandex_resourcemanager_folder_iam_member" "reader" {
       folder_id = "<идентификатор_каталога>"
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

- API {#api}

  Чтобы создать сервисный аккаунт, воспользуйтесь методом [create](../../iam/api-ref/ServiceAccount/create.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/Create](../../iam/api-ref/grpc/ServiceAccount/create.md).

  Чтобы назначить сервисному аккаунту роль `logging.reader` на каталог, воспользуйтесь методом [setAccessBindings](../../iam/api-ref/ServiceAccount/setAccessBindings.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/SetAccessBindings](../../iam/api-ref/grpc/ServiceAccount/setAccessBindings.md).

{% endlist %}

## Создайте авторизованный ключ для сервисного аккаунта {#create-key}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит сервисный аккаунт.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. На панели слева выберите ![FaceRobot](../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}**.
  1. В открывшемся списке выберите сервисный аккаунт `grafana-plugin`.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** на верхней панели.
  1. Выберите пункт **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_key }}**.
  1. Выберите алгоритм шифрования.
  1. Задайте описание ключа, чтобы потом было проще найти его в консоли управления.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.overview.action_download-keys-file }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_close }}**.

- CLI {#cli}

  Создайте авторизованные ключи для сервисного аккаунта `grafana-plugin`:

  ```bash
  yc iam key create --service-account-name grafana-plugin -o authorized_key.json
  ```

  В случае успеха в файл `authorized_key.json` будет записан закрытый ключ (`privateKey`) и идентификатор открытого ключа (`id`).

  Пример файла с ключом:

  ```json
  {
     "id": "lfkoe35hsk**********",
     "service_account_id": "ajepg0mjt0**********",
     "created_at": "2023-10-10T10:04:56Z",
     "key_algorithm": "RSA_2048",
     "public_key": "-----BEGIN PUBLIC KEY-----\n...\n-----END PUBLIC KEY-----\n",
     "private_key": "-----BEGIN PRIVATE KEY-----\n...\n-----END PRIVATE KEY-----\n"
  }
  ```

- {{ TF }} {#tf}

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

     * `service_account_id` — [идентификатор](../../iam/operations/sa/get-id.md) сервисного аккаунта. Обязательный параметр.
     * `description` — описание ключа. Необязательный параметр.
     * `key_algorithm` — алгоритм генерации ключа. Необязательный параметр. По умолчанию используется алгоритм `RSA_2048`. Допустимые значения параметра см. в [документации API](../../iam/api-ref/Key/index.md).

     Пример структуры конфигурационного файла:

     ```hcl
     resource "yandex_iam_service_account_key" "sa-auth-key" {
       service_account_id = "<идентификатор_сервисного_аккаунта>"
       description        = "<описание_ключа>"
       key_algorithm      = "<алгоритм_генерации_ключа>"
     }
     ```

     Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/iam_service_account_key).

  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```bash
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Разверните облачные ресурсы.

     1. Если в конфигурации нет ошибок, выполните команду:

        ```bash
        terraform apply
        ```

     1. Подтвердите создание ресурсов: введите в терминал слово `yes` и нажмите **Enter**.

        После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}), а также с помощью команды CLI:

        ```bash
        yc iam key list --service-account-id <идентификатор_сервисного_аккаунта>
        ```

- API {#api}

  Чтобы создать ключ доступа, воспользуйтесь методом REST API [create](../../iam/api-ref/Key/create.md) для ресурса [Key](../../iam/api-ref/Key/index.md) или вызовом gRPC API [KeyService/Create](../../iam/api-ref/grpc/Key/create.md).

  Пример запроса с помощью cURL для метода REST API `create`:

  ```bash
  curl --request POST \
    --header 'Content-Type: application/json' \
    --header "Authorization: Bearer <IAM-токен>" \
    --data '{"serviceAccountId": "<идентификатор_сервисного_аккаунта>"}' \
    https://iam.{{ api-host }}/iam/v1/keys
  ```

  Где:

  * `<IAM-токен>` — IAM-токен пользователя, у которого есть права на создание ключей для указанного сервисного аккаунта.
  * `<идентификатор_сервисного_аккаунта>` — идентификатор сервисного аккаунта, для которого создаются ключи.

  В случае успеха в ответе сервера будет указан закрытый ключ (`privateKey`) и идентификатор открытого ключа (`id`). Сохраните эти данные. Получить значение ключа снова будет невозможно.

  Пример ответа сервера:

  ```json
  {
      "key": {
          "createdAt": "2023-10-10T10:55:00+00:00",
          "description": "",
          "id": "lfkoe35hsk**********",
          "keyAlgorithm": "RSA_2048",
          "publicKey": "-----BEGIN PUBLIC KEY-----\n...\n-----END PUBLIC KEY-----\n",
          "serviceAccountId": "ajepg0mjt0**********"
      },
      "privateKey": "-----BEGIN PRIVATE KEY-----\n...\n-----END PRIVATE KEY-----\n"
  }
  ```

{% endlist %}

## Создайте лог-группу {#create-group}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором создали сервисный аккаунт `grafana-plugin`.
  1. Выберите сервис **{{ cloud-logging-name }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.logging.button_create-group }}**.
  1. Введите имя лог-группы: `grafana-plugin`.
  1. Укажите срок хранения записей в лог-группе.
  1. Нажмите кнопку **{{ ui-key.yacloud.logging.button_create-group }}**.

- CLI {#cli}

  Чтобы создать лог-группу, выполните команду:

  ```bash
  yc logging group create \
    --name=grafana-plugin \
    --retention-period=<срок_хранения> \
  ```

  Где:

  * `--name` — имя лог-группы.
  * `--retention-period` — срок хранения записей в лог-группе.

  Результат:

  ```text
  done (1s)
  id: af3flf29t8**********
  folder_id: aoek6qrs8t**********
  cloud_id: aoegtvhtp8**********
  created_at: "2023-09-26T09:56:38.970Z"
  name: grafana-plugin
  status: ACTIVE
  retention_period: 3600s
  ```

- {{ TF }} {#tf}

  1. Опишите в конфигурационном файле параметры лог-группы:

     ```hcl
     provider "yandex" {
       token     = "<OAuth-токен>"
       cloud_id  = "<идентификатор_облака>"
       folder_id = "<идентификатор_каталога>"
       zone      = "{{ region-id }}-a"
     }

     resource "yandex_logging_group" "grafana-plugin" {
       name             = "grafana-plugin"
       folder_id        = "<идентификатор_каталога>"
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

        ```bash
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Разверните облачные ресурсы.

  1. Если в конфигурации нет ошибок, выполните команду:

     ```bash
     terraform apply
     ```

  1. Подтвердите создание ресурсов: введите в терминал слово `yes` и нажмите **Enter**.

     После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

     ```bash
     yc logging group list
     ```

- API {#api}

  Чтобы создать лог-группу, воспользуйтесь методом REST API [create](../../logging/api-ref/LogGroup/create.md) для ресурса [LogGroup](../../logging/api-ref/LogGroup/index.md) или вызовом gRPC API [LogGroupService/Create](../../logging/api-ref/grpc/LogGroup/create.md).

{% endlist %}

## Добавьте записи в лог-группу {#add-records}

{% list tabs group=instructions %}

- CLI {#cli}

  Чтобы добавить записи в лог-группу, выполните команду:

  * Linux, macOS:

    ```bash
    yc logging write \
      --group-name=grafana-plugin \
      --message="My message" \
      --level=INFO
    ```

  * Windows (cmd):

    ```bash
    yc logging write ^
      --group-name=grafana-plugin ^
      --message="My message" ^
      --level=INFO
    ```

  * Windows (PowerShell):

    ```bash
    yc logging write `
      --group-name=grafana-plugin `
      --message="My message" `
      --level=INFO
    ```

    Где:

    * `--group-name` — имя лог-группы, в которую вы хотите добавить записи.
    * `--message` — сообщение.
    * `--level` — уровень логирования.

   {% note info %}

   Флаги `--group-name` и `--message` можно опустить и указать только значения параметров. Например: `grafana-plugin "My message"`.

   {% endnote %}

- API {#api}

  Чтобы добавить записи в лог-группу, воспользуйтесь вызовом gRPC API [LogIngestionService/Write](../../logging/api-ref/grpc/LogIngestion/write.md).

{% endlist %}

## Подключите источник данных в {{ grafana-name }} {#connect-plugin}

1. В браузере перейдите по адресу `http://localhost:3000/`.

   {% note info %}

   По умолчанию {{ grafana-name }} использует порт 3000, если в конфигурационном файле вы не [указали другой](https://grafana.com/docs/grafana/latest/setup-grafana/configure-grafana/#http_port).

   {% endnote %}

1. На панели слева выберите **Connections** → **Add new connection**.
1. В списке источников выберите **{{ cloud-logging-full-name }}**.
1. Нажмите кнопку **Add new data source**.
1. В блоке **Secret config**, в поле **API Key**, вставьте содержимое файла с [авторизованными ключами](#create-key) `authorized_key.json`.
1. В блоке **SDK config**, в поле **Folder ID**, укажите идентификатор каталога, в котором находится лог-группа `grafana-plugin`.
1. Нажмите кнопку **Save & test**.

## Посмотрите логи в {{ grafana-name }} {#see-logs}

1. В интерфейсе {{ grafana-name }} на панели слева выберите **Explore**.
1. В левом верхнем углу выберите из выпадающего списка источник данных **{{ cloud-logging-full-name }}**.
1. В редакторе запросов для источника:

   1. В поле **Group** выберите идентификатор лог-группы `grafana-plugin`.
   1. В поле **Filter query** введите запрос на [языке фильтрующих выражений](../../logging/concepts/filter.md).
   1. В правом верхнем углу нажмите кнопку **Run query**.

      В блоке **Logs volume** отобразится гистограмма с записями из лог-группы.

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы, [удалите лог-группу](../../logging/operations/delete-group.md).
