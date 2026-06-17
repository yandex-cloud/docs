# Загрузка данных из Яндекс Директ в витрину Yandex Managed Service for ClickHouse® с использованием Yandex Cloud Functions, Yandex Object Storage и Yandex Data Transfer

# Загрузка данных из Яндекс Директ в витрину Yandex Managed Service for ClickHouse® с использованием Yandex Cloud Functions, Yandex Object Storage и Yandex Data Transfer


Вы можете перенести данные из Яндекс Директ в Managed Service for ClickHouse® с использованием сервисов Cloud Functions, Object Storage и Data Transfer. Для этого:

1. [Перенесите данные из Яндекс Директ в Object Storage с использованием Cloud Functions](#direct-objstorage).
1. [Перенесите данные из Object Storage в Managed Service for ClickHouse® с использованием Data Transfer](#objstorage-mch).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

* Бакет Object Storage: использование хранилища и выполнение операций с данными ([тарифы Object Storage](../../storage/pricing.md)).
* Сервис Cloud Functions: количество вызовов функции, время простоя подготовленных экземпляров и выделенные для выполнения функции вычислительные ресурсы ([тарифы Yandex Cloud Functions](../../functions/pricing.md)).
* Сервис Yandex Lockbox: количество хранимых версий секрета и запросы к ним ([тарифы Yandex Lockbox](../../lockbox/pricing.md)).
* Кластер Managed Service for ClickHouse®: выделенные хостам вычислительные ресурсы, объем хранилища и резервных копий ([тарифы Managed Service for ClickHouse®](../../managed-clickhouse/pricing.md)).
* Публичные IP-адреса, если для хостов кластера включен публичный доступ ([тарифы Virtual Private Cloud](../../vpc/pricing.md)).


## Перед началом работы {#before-you-begin}

1. Подготовьте тестовые данные для выгрузки из Яндекс Директ:

    1. [Зарегистрируйте тестовое приложение в сервисе Яндекс.OAuth](https://yandex.ru/dev/direct/doc/dg/concepts/register.html#oauth).

        В качестве платформы выберите **Веб-сервисы**, а в поле **Redirect URI** вставьте URL для отладки: `https://oauth.yandex.ru/verification_code`.

    1. [Получите отладочный токен](https://yandex.ru/dev/id/doc/ru/tokens/debug-token) для приложения.
    1. [Создайте заявку](https://yandex.ru/dev/direct/doc/dg/concepts/register.html#request) на тестовый доступ приложения к Яндекс Директ и дождитесь ее одобрения.
    1. [Включите песочницу](https://yandex.ru/dev/direct/doc/dg/concepts/sandbox-init.html) в Яндекс Директ с ролью **Клиент**.
    1. (Опционально) Убедитесь, что все настроено верно, отправив запрос к API песочницы от имени приложения:

        {% cut "Пример запроса" %}

        ```bash
        curl \
          --header 'Authorization: Bearer <отладочный_токен>' \
          --header 'Accept-Language: en' \
          --data '
              {
                "method":"get",
                "params": {
                  "SelectionCriteria": {},
                  "FieldNames": [
                    "Id",
                    "Name"
                  ]
                }
              }' \
          "https://api-sandbox.direct.yandex.com/json/v5/campaigns" | jq
        ```

        {% endcut %}

        {% cut "Пример ответа" %}

        ```json
        {
          "result": {
            "Campaigns": [
              {
                  "Id": 463476,
                  "Name": "Test API Sandbox campaign 1"
              },
              {
                  "Id": 463477,
                  "Name": "Test API Sandbox campaign 2"
              },
              {
                  "Id": 463478,
                  "Name": "Test API Sandbox campaign 3"
              }
            ]
          }
        }
        ```

        {% endcut %}

1. Подготовьте инфраструктуру Yandex Cloud:

    {% list tabs group=resources %}

    - Вручную {#manual}

        1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) с именем `storage-lockbox-sa` и назначьте ему роли `storage.uploader` и `lockbox.payloadViewer`.
        1. [Создайте статический ключ доступа](../../iam/operations/authentication/manage-access-keys.md#create-access-key) для сервисного аккаунта `storage-lockbox-sa`.
        1. [Создайте секрет в Yandex Lockbox](../../lockbox/operations/secret-create.md) с тремя парами `ключ:значение`:

            * `access_key:<открытый_ключ>`;
            * `secret_key:<закрытый_ключ>`;
            * `app_token:<отладочный_токен_приложения>`.

        1. В Object Storage [создайте бакет](../../storage/operations/buckets/create.md).
        1. [Создайте кластер Managed Service for ClickHouse®](../../managed-clickhouse/operations/cluster-create.md) любой подходящей конфигурации с хостами в публичном доступе.

            {% note info %}
            
            Публичный доступ к хостам кластера нужен, если вы планируете подключаться к кластеру через интернет. Этот вариант подключения более простой, и его рекомендуется использовать для прохождения руководства. К хостам без публичного доступа тоже можно подключиться, но только с виртуальных машин Yandex Cloud, расположенных в той же облачной сети, что и кластер.
            
            {% endnote %}

        1. Если вы используете группы безопасности в кластере Managed Service for ClickHouse®, убедитесь, что они [настроены правильно](../../managed-clickhouse/operations/connect/index.md#configuring-security-groups) и допускают подключение к нему.

    - Terraform {#tf}

        1. Если у вас еще нет Terraform, [установите его](../infrastructure-management/terraform-quickstart.md#install-terraform).
        1. [Получите данные для аутентификации](../infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
        1. [Настройте и инициализируйте провайдер](../infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
        1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

        1. Скачайте в ту же рабочую директорию файл конфигурации [ya-direct-to-mch.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-direct-to-clickhouse/blob/main/ya-direct-to-mch.tf).

            В этом файле описаны:

            * [сеть](../../vpc/concepts/network.md#network);
            * [подсеть](../../vpc/concepts/network.md#subnet);
            * [группа безопасности](../../vpc/concepts/security-groups.md) и правила, необходимые для подключения к кластеру Managed Service for ClickHouse®;
            * сервисный аккаунт с ролями `storage.uploader` и `lockbox.payloadViewer`.
            * статический ключ для сервисного аккаунта;
            * секрет Yandex Lockbox;
            * бакет Object Storage;
            * бессерверная функция Cloud Functions;
            * кластер-приемник Managed Service for ClickHouse®;
            * эндпоинт для приемника Managed Service for ClickHouse®;
            * трансфер.

        1. Укажите в файле `ya-direct-to-mch.tf` переменные:

            * `folder_id` — идентификатор облачного каталога, такой же как в настройках провайдера.
            * `app_token` — отладочный токен приложения.
            * `bucket_name` — имя бакета Object Storage. Имя должно быть уникальным в сервисе.
            * `ch_password` — пароль пользователя-администратора кластера Managed Service for ClickHouse®.

        1. Проверьте корректность файлов конфигурации Terraform с помощью команды:

            ```bash
            terraform validate
            ```

            Если в файлах конфигурации есть ошибки, Terraform на них укажет.

        1. Создайте необходимую инфраструктуру:

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

            В указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления](https://console.yandex.cloud).

    {% endlist %}

## Перенесите данные из Яндекс Директ в Object Storage с использованием Cloud Functions {#direct-objstorage}

1. [Скачайте архив](https://github.com/yandex-cloud-examples/yc-data-transfer-direct-to-clickhouse/blob/main/example-py.zip) `example-py.zip` с кодом функции на Python.

    Функция запрашивает идентификаторы и имена рекламных кампаний из песочницы, используя токен приложения, затем конвертирует эти данные в формат Parquet и помещает в бакет Object Storage.

    Функция принимает на вход:

    * ключ сервисного аккаунта;
    * токен приложения;
    * имя бакета.

    {% note tip %}

    Вы можете использовать эту функцию для получения данных из реальных рекламных кампаний или выполнения запросов от имени рекламного агентства. Для этого распакуйте архив и раскомментируйте необходимые параметры в файле `example.py`. Подробности см. в комментариях к коду.

    {% endnote %}

1. Создайте и настройте [функцию в сервисе Cloud Functions](../../functions/concepts/function.md):

    {% list tabs group=resources %}

    - Вручную {#manual}

        1. [Создайте функцию](../../functions/operations/function/function-create.md).
        1. В открывшемся редакторе выберите среду выполнения **Python** и нажмите **Продолжить**.
        1. Укажите необходимые настройки:

            * **ZIP-архив** — `ZIP-архив`.
            * **Файл** — выберите скачанный ранее архив `example-py.zip`.
            * **Точка входа** — `example.foo`.
            * **Сервисный аккаунт** — выберите из списка `storage-lockbox-sa`.
            * **Переменные окружения** — передайте имя бакета в формате `ключ=значение`:

                * Ключ — `BUCKET`.
                * Значение — имя созданного ранее бакета (без префикса `s3://`).

            * **Секреты Lockbox** — укажите путь к трем ранее созданным секретам Yandex Lockbox в переменных окружения:

                * `AWS_ACCESS_KEY_ID` — `access_key`;
                * `AWS_SECRET_ACCESS_KEY` — `secret_key`;
                * `TOKEN` — `app_token`.

            Остальные настройки можно оставить по умолчанию.

        1. Нажмите **Сохранить изменения** и дождитесь завершения сборки.

    - Terraform {#tf}

        1. Укажите в файле `ya-direct-to-mch.tf` переменные:

            * `path_to_zip_cf` — путь к скачанному ZIP-архиву с кодом функции;
            * `create_function` — значение `1` для создания функции.

        1. Проверьте корректность файлов конфигурации Terraform с помощью команды:

            ```bash
            terraform validate
            ```

            Если в файлах конфигурации есть ошибки, Terraform на них укажет.

        1. Создайте необходимую инфраструктуру:

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

    {% endlist %}

1. Откройте созданную функцию в консоли управления и выберите **Тестирование** на панели слева.
1. Нажмите **Запустить тест** и дождитесь выполнения функции.

В бакете появится файл в формате Parquet.

## Перенесите данные из Object Storage в Managed Service for ClickHouse® с использованием Data Transfer {#objstorage-mch}

1. [Создайте эндпоинт для источника](../../data-transfer/operations/endpoint/index.md#create) со следующими параметрами:

    * **Тип базы данных** — `Yandex Object Storage`.
    * **Бакет** — имя бакета в Object Storage.
    * **Сервисный аккаунт** – выберите из списка [созданный ранее](#before-you-begin) сервисный аккаунт.
    * **Эндпоинт** — `https://storage.yandexcloud.net`.
    * **Регион** — `ru-central1`.
    * **Формат данных** — `Parquet`.
    * **Схема** — `{"Id": "int64", "Name": "string"}`.
    * **Таблица** — имя Parquet-файла в бакете, например: `ac05e4fe818e463f88a8a299d290734d.snappy.parquet`.
    * **Схема результирующей таблицы** — выберите `Вручную` и укажите имена полей и тип данных:

        * `Id`: `Int64`;
        * `Name` : `String`.

    Остальные параметры оставьте по умолчанию.

1. Создайте эндпоинт для приемника и трансфер:

    {% list tabs group=resources %}

    - Вручную {#manual}

        1. [Создайте эндпоинт для приемника](../../data-transfer/operations/endpoint/index.md#create) Managed Service for ClickHouse®, указав параметры созданного ранее кластера.

        1. [Создайте трансфер](../../data-transfer/operations/transfer.md#create), использующий созданные эндпоинты.

    - Terraform {#tf}

        1. Укажите в файле `ya-direct-to-mch.tf` переменные:

            * `source_endpoint_id` — идентификатор эндпоинта-источника;
            * `transfer_enabled` — значение `1` для создания трансфера.

        1. Проверьте корректность файлов конфигурации Terraform с помощью команды:

            ```bash
            terraform validate
            ```

            Если в файлах конфигурации есть ошибки, Terraform на них укажет.

        1. Создайте необходимую инфраструктуру:

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

    {% endlist %}

1. Активируйте трансфер и дождитесь его перехода в статус **Завершен**.

1. Убедитесь, что в базу данных Managed Service for ClickHouse® перенесены данные из источника Object Storage:

    1. [Подключитесь к кластеру](../../managed-clickhouse/operations/connect/clients.md#clickhouse-client) с помощью `clickhouse-client`.

    1. Выполните запрос:

        ```sql
        SELECT * FROM ac05e4fe818e463f88a8a299d290734d_snappy_parquet;
        ```

        Где `ac05e4fe818e463f88a8a299d290734d` — имя Parquet-файла.

        {% cut "Пример ответа" %}

        ```sql
        ┌─────Id─┬─Name────────────────────────┬─__file_name─────────────────────────────────────┬─__row_index─┐
        │ 463476 │ Test API Sandbox campaign 1 │ ac05e4fe818e463f88a8a299d290734d.snappy.parquet │           1 │
        │ 463477 │ Test API Sandbox campaign 2 │ ac05e4fe818e463f88a8a299d290734d.snappy.parquet │           2 │
        │ 463478 │ Test API Sandbox campaign 3 │ ac05e4fe818e463f88a8a299d290734d.snappy.parquet │           3 │
        └────────┴─────────────────────────────┴─────────────────────────────────────────────────┴─────────────┘
        ```

        {% endcut %}

## Удалите созданные ресурсы {#clear-out}

Чтобы снизить потребление ресурсов, которые вам не нужны, удалите их:

1. [Удалите трансфер](../../data-transfer/operations/transfer.md#delete).
1. [Удалите эндпоинт](../../data-transfer/operations/endpoint/index.md#delete) для источника.
1. [Удалите объекты](../../storage/operations/objects/delete.md) из бакета.
1. Остальные ресурсы удалите в зависимости от способа их создания:

   {% list tabs group=resources %}

   - Вручную {#manual}

       1. [Удалите эндпоинт](../../data-transfer/operations/endpoint/index.md#delete) для приемника.
       1. [Удалите кластер Managed Service for ClickHouse®](../../managed-clickhouse/operations/cluster-delete.md).
       1. [Удалите бакет Object Storage](../../storage/operations/buckets/delete.md).
       1. [Удалите функцию](../../functions/operations/function/function-delete.md).
       1. [Удалите секрет в Yandex Lockbox](../../lockbox/operations/secret-delete.md).
       1. [Удалите сервисный аккаунт](../../iam/operations/sa/delete.md).

   - Terraform {#tf}

       1. В терминале перейдите в директорию с планом инфраструктуры.
       
           {% note warning %}
       
           Убедитесь, что в директории нет Terraform-манифестов с ресурсами, которые вы хотите сохранить. Terraform удаляет все ресурсы, которые были созданы с помощью манифестов в текущей директории.
       
           {% endnote %}
       
       1. Удалите ресурсы:
       
           1. Выполните команду:
       
               ```bash
               terraform destroy
               ```
       
           1. Подтвердите удаление ресурсов и дождитесь завершения операции.
       
           Все ресурсы, которые были описаны в Terraform-манифестах, будут удалены.

   {% endlist %}

_ClickHouse® является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._