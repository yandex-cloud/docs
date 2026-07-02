[Документация Yandex Cloud](../../index.md) > [Yandex Managed Service for ClickHouse®](../index.md) > [Пошаговые инструкции](index.md) > Кластеры > Изменение настроек ClickHouse® > На уровне запроса

# Изменение настроек ClickHouse® на уровне запроса

Вы можете задать [настройки ClickHouse® на уровне запроса](https://clickhouse.com/docs/ru/operations/settings/query-level), чтобы гибко настроить базы данных в кластере Managed Service for ClickHouse®. Указать настройки можно несколькими способами:

* С помощью [интерфейсов Yandex Cloud](#yandex-cloud-interfaces). Так можно задать только [настройки ClickHouse®, доступные в Yandex Cloud](../concepts/settings-list.md#user-level-settings).
* С помощью SQL-запросов. Так можно задать любые настройки ClickHouse® на уровне запроса. Способ, как установить настройки, зависит от их типа:

   * [Настройки пользователей](#user). В SQL-запросах `CREATE USER` и `ALTER USER` вы можете передать настройки в условии `SETTINGS`. В результате настройки применятся только к указанному пользователю.

      Чтобы воспользоваться этим способом, при [создании](cluster-create.md) или [изменении](update.md#SQL-management) кластера включите опцию **Управление пользователями через SQL**. После этого нельзя будет управлять пользователями через интерфейсы Yandex Cloud: управление пользователями через SQL невозможно выключить.

   * [Настройки на уровне профиля](#settings-profile). В ClickHouse® [профиль настроек](https://clickhouse.com/docs/ru/operations/access-rights#settings-profiles-management) содержит их значения и ограничения, а также список ролей и пользователей, к которым применяется профиль. Настройки ClickHouse® передаются в SQL-запросах `CREATE SETTINGS PROFILE` и `ALTER SETTINGS PROFILE`.

      Чтобы воспользоваться этим способом, при [создании](cluster-create.md) или [изменении](update.md#SQL-management) кластера включите опцию **Управление пользователями через SQL**.

   * [Настройки сессии](#session). Во время сессии можно передать настройки ClickHouse® с помощью SQL-запроса `SET`. Так можно задать настройки в кластере с любой конфигурацией, но они будут действовать только для текущей сессии.

      Способ подходит не для всех SQL-редакторов: в некоторых из них каждый запрос выполняется в отдельной сессии. Проверьте параметры своего SQL-редактора, прежде чем настраивать сессию.

   * [Настройки подключения](#connection). Когда вы подключаетесь к базе данных с помощью утилиты [clickhouse-client](connect/clients.md#clickhouse-client), в команде для подключения можно передать настройки ClickHouse® с помощью флагов. Так можно задать настройки в кластере с любой конфигурацией, но они будут действовать только для установленного подключения.

      Вы можете также указать настройки подключения в различных драйверах для ClickHouse® либо передать настройки в виде URL-параметров при отправке запросов HTTP API ClickHouse®. Подробнее об этих способах в [документации ClickHouse®](https://clickhouse.com/docs/ru/interfaces/overview).

## Получить список настроек ClickHouse® на уровне запроса {#get-list}

{% list tabs group=instructions %}

- SQL {#sql}

   1. [Подключитесь](connect/clients.md) к БД в кластере.
   1. Выполните запрос:

      ```sql
      SELECT name, description, value FROM system.settings;
      ```

      Результат содержит названия, описания и значения настроек ClickHouse® на уровне запроса. Результат показывает значения для текущей сессии и пользователя, установившего эту сессию.

{% endlist %}

## Задать настройки ClickHouse® через интерфейсы Yandex Cloud {#yandex-cloud-interfaces}

{% list tabs group=instructions %}

- Консоль управления {#console}

   Чтобы задать настройки ClickHouse®:

   1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится кластер.
   1. Перейдите в сервис **Managed Service for&nbsp;ClickHouse**.
   1. Нажмите на имя нужного кластера, затем перейдите в раздел **Пользователи**.
   1. В строке с именем нужного пользователя нажмите кнопку ![image](../../_assets/console-icons/ellipsis.svg) и выберите **Настроить**.
   1. В списке **Дополнительные настройки** разверните **settings** и задайте [настройки ClickHouse®](../concepts/settings-list.md#user-level-settings).
   1. Нажмите кнопку **Сохранить изменения**.

- CLI {#cli}

   Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

   По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

   Чтобы задать настройки ClickHouse®:

   1. Посмотрите полный список настроек, установленных для пользователя:

      ```bash
      yc managed-clickhouse user get <имя_пользователя> <имя_или_идентификатор_кластера>
      ```

   1. Посмотрите описание команды CLI для изменения настроек пользователя:

      ```bash
      yc managed-clickhouse user update --help
      ```

   1. Установите нужные значения параметров:

      ```bash
      yc managed-clickhouse user update <имя_пользователя> \
         --cluster-name=<имя_кластера> \
         --settings="<имя_параметра_1>=<значение_1>,<имя_параметра_2>=<значение_2>,..."
      ```


- Terraform {#tf}

   Чтобы задать настройки ClickHouse®:

   1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

      Как создать такой файл, описано в разделе [Создание кластера](cluster-create.md).

   1. В описании пользователя кластера Managed Service for ClickHouse®, в блоке `settings`, измените значения параметров:

      ```hcl
      resource "yandex_mdb_clickhouse_user" "<имя_пользователя>" {
        ...
        settings {
          <имя_параметра_1> = <значение_1>
          <имя_параметра_2> = <значение_2>
          ...
        }
      }
      ```

   1. Проверьте корректность настроек.

      1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
      1. Выполните команду:
      
         ```bash
         terraform validate
         ```
      
         Если в файлах конфигурации есть ошибки, Terraform на них укажет.

   1. Подтвердите изменение ресурсов.

      1. Выполните команду для просмотра планируемых изменений:
      
         ```bash
         terraform plan
         ```
      
         Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
      
      1. Если вас устраивают планируемые изменения, внесите их:
         1. Выполните команду:
      
            ```bash
            terraform apply
            ```
      
         1. Подтвердите изменение ресурсов.
         1. Дождитесь завершения операции.

   Подробнее в [документации провайдера Terraform](../../terraform/resources/mdb_clickhouse_user.md).


- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Воспользуйтесь методом [User.Update](../api-ref/User/update.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

        {% note warning %}
        
        Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
        
        {% endnote %}

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/clusters/<идентификатор_кластера>/users/<имя_пользователя>' \
            --data '{
                      "updateMask": "<перечень_изменяемых_настроек>",
                      "settings": { <настройки_ClickHouse®> }
                    }'
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

        * `settings` — нужные [настройки ClickHouse®](../concepts/settings-list.md#user-level-settings) с новыми значениями.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters). Имя пользователя можно запросить со [списком пользователей в кластере](cluster-users.md#list-users).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/User/update.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
       
       ```bash
       cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
       ```
       
       Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.

    1. Воспользуйтесь вызовом [UserService.Update](../api-ref/grpc/User/update.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

        {% note warning %}
        
        Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `update_mask` (в виде массива строк `paths[]`).
        
        {% cut "Формат перечисления настроек" %}
        
        ```yaml
        "update_mask": {
            "paths": [
                "<настройка_1>",
                "<настройка_2>",
                ...
                "<настройка_N>"
            ]
        }
        ```
        
        {% endcut %}
        
        {% endnote %}

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/user_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>",
                  "user_name": "<имя_пользователя>",
                  "update_mask": {
                    "paths": [
                      <перечень_изменяемых_настроек>
                    ]
                  },
                  "settings": { <настройки_ClickHouse®> }
                }' \
            mdb.api.cloud.yandex.net:443 \
            yandex.cloud.mdb.clickhouse.v1.UserService.Update
        ```

        Где:

        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

        * `settings` — нужные [настройки ClickHouse®](../concepts/settings-list.md#user-level-settings) с новыми значениями.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters). Имя пользователя можно запросить со [списком пользователей в кластере](cluster-users.md#list-users).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/User/create.md#yandex.cloud.operation.Operation).

{% endlist %}

## Задать настройки ClickHouse® в учетной записи пользователя {#user}

Передать настройки ClickHouse® можно при [добавлении нового пользователя](#add-user) или [изменении настроек](#change-user-settings) уже созданного пользователя.

### Добавить нового пользователя с настройками ClickHouse® {#add-user}

{% list tabs group=instructions %}

- SQL {#sql}

   1. [Подключитесь](connect/clients.md) к БД в кластере под учетной записью `admin`.
   1. Создайте пользователя:

      ```sql
      CREATE USER <имя_пользователя>
         IDENTIFIED WITH sha256_password BY '<пароль_пользователя>'
         SETTINGS <список_настроек_ClickHouse®>;
      ```

      {% note info %}
      
      Имя пользователя может содержать латинские буквы, цифры, дефис и подчеркивание, но должно начинаться с буквы или подчеркивания.
      
      Длина пароля от 8 до 128 символов.
      
      {% endnote %}

      В параметре `SETTINGS` помимо значения настройки можно указать ее минимальное и максимальное значение. Пример для настройки [idle_connection_timeout](https://clickhouse.com/docs/ru/operations/settings/settings#idle_connection_timeout):

      ```sql
      CREATE USER <имя_пользователя>
         IDENTIFIED WITH sha256_password BY 'password'
         SETTINGS idle_connection_timeout = 60 MIN 5 MAX 120;
      ```

      Подробнее о создании пользователей в [документации ClickHouse®](https://clickhouse.com/docs/ru/sql-reference/statements/create/user).

{% endlist %}

### Изменить настройки ClickHouse® у пользователя {#change-user-settings}

{% list tabs group=instructions %}

- SQL {#sql}

   1. [Подключитесь](connect/clients.md) к БД в кластере под учетной записью `admin`.
   1. Измените учетную запись пользователя:

      ```sql
      ALTER USER <имя_пользователя> SETTINGS <список_настроек_ClickHouse®>;
      ```

      Подробнее об изменении учетных записей в [документации ClickHouse®](https://clickhouse.com/docs/ru/sql-reference/statements/alter/user).

{% endlist %}

## Задать настройки ClickHouse® в профиле настроек {#settings-profile}

Передать настройки ClickHouse® можно при [создании](#create-settings-profile) или [изменении профиля настроек](#change-settings-profile).

### Создать профиль с настройками ClickHouse® {#create-settings-profile}

{% list tabs group=instructions %}

- SQL {#sql}

   1. [Подключитесь](connect/clients.md) к БД в кластере под учетной записью `admin`.
   1. Создайте профиль настроек:

      ```sql
      CREATE SETTINGS PROFILE <название_профиля_настроек>
         SETTINGS <список_настроек_ClickHouse®>;
      ```

      В параметре `SETTINGS` помимо значения настройки можно указать ее минимальное и максимальное значение. Пример для настройки [idle_connection_timeout](https://clickhouse.com/docs/ru/operations/settings/settings#idle_connection_timeout):

      ```sql
      CREATE SETTINGS PROFILE <название_профиля_настроек>
         SETTINGS idle_connection_timeout = 60 MIN 5 MAX 120;
      ```

      Профиль настроек можно привязать к пользователю:

      ```sql
      CREATE SETTINGS PROFILE <название_профиля_настроек>
         SETTINGS <список_настроек_ClickHouse®>
         TO <имя_пользователя>;
      ```

      Подробнее о создании профилей настроек в [документации ClickHouse®](https://clickhouse.com/docs/ru/sql-reference/statements/create/settings-profile).

{% endlist %}

### Изменить настройки ClickHouse® в профиле настроек {#change-settings-profile}

{% list tabs group=instructions %}

- SQL {#sql}

   1. [Подключитесь](connect/clients.md) к БД в кластере под учетной записью `admin`.
   1. Измените профиль настроек:

      ```sql
      ALTER SETTINGS PROFILE <название_профиля_настроек>
         SETTINGS <список_настроек_ClickHouse®>;
      ```

      В этом запросе можно задать граничные значения настроек и привязать профиль к пользователю. Подробнее об изменении профилей настроек в [документации ClickHouse®](https://clickhouse.com/docs/ru/sql-reference/statements/alter/settings-profile).

{% endlist %}

## Задать настройки ClickHouse® в сессии {#session}

{% list tabs group=instructions %}

- SQL {#sql}

   1. [Подключитесь](connect/clients.md) к БД в кластере.
   1. Выполните запрос:

      ```sql
      SET <имя_пользователя> SETTINGS <список_настроек_ClickHouse®>;
      ```

      Примененные настройки будут действовать только во время открытой сессии.

   1. Убедитесь, что настройки применились:

      ```sql
      SELECT value FROM system.settings;
      ```

      Чтобы посмотреть значение одной настройки, выполните запрос:

      ```sql
      SELECT value FROM system.settings WHERE name='<название_настройки>';
      ```

{% endlist %}

## Задать настройки ClickHouse® при подключении к БД через командную строку {#connection}

{% list tabs group=instructions %}

- SQL {#sql}

   1. [Установите зависимости](connect/clients.md#clickhouse-client), необходимые для подключения к БД.
   1. Посмотрите описание команды для подключения к БД:

      ```bash
      clickhouse-client --help
      ```

      Большинство флагов в выводе команды — это расширенные настройки ClickHouse®.

   1. Выберите флаги с нужными настройками. Для этого соотнесите названия флагов с [названиями настроек ClickHouse®](https://clickhouse.com/docs/ru/operations/settings/settings).
   1. Укажите выбранные флаги в команде на подключение к БД:

      * Подключение без SSL:

         ```bash
         clickhouse-client --host <FQDN_любого_хоста_ClickHouse®> \
                           --user <имя_пользователя> \
                           --database <имя_БД> \
                           --port 9000 \
                           --ask-password \
                           <флаги_с_настройками_ClickHouse®>
         ```

      
      * Подключение с SSL:

         ```bash
         clickhouse-client --host <FQDN_любого_хоста_ClickHouse®> \
                           --secure \
                           --user <имя_пользователя> \
                           --database <имя_БД> \
                           --port 9440 \
                           --ask-password \
                           <флаги_с_настройками_ClickHouse®>
         ```


      * Пример подключения без SSL с настройкой [idle_connection_timeout](https://clickhouse.com/docs/ru/operations/settings/settings#idle_connection_timeout):

         ```bash
         clickhouse-client --host rc1a-goh2a9tr********.mdb.yandexcloud.net \
                           --user user1 \
                           --database db1 \
                           --port 9000 \
                           --ask-password \
                           --idle_connection_timeout 60
         ```

   1. Убедитесь, что настройки применились:

      ```sql
      SELECT value FROM system.settings;
      ```

      Чтобы посмотреть значение одной настройки, выполните запрос:

      ```sql
      SELECT value FROM system.settings WHERE name='<название_настройки>';
      ```

{% endlist %}

_ClickHouse® является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._