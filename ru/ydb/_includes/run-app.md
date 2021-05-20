Чтобы подключиться к базе и запустить тестовое приложение:

{% list tabs %}

- Python

  1. Склонируйте репозиторий [YDB Python SDK](https://github.com/yandex-cloud/ydb-python-sdk) и установите библиотеки `ydb`, `iso8601`, `yandexcloud`:

      ```bash
      git clone https://github.com/yandex-cloud/ydb-python-sdk.git
      sudo pip3 install iso8601 ydb yandexcloud
      ```

  1. Создайте авторизованный ключ для вашего сервисного аккаунта, запишите его в файл {% if deploy != "arc" %}[с помощью CLI](../../iam/operations/iam-token/create-for-sa#via-cli){% else %}с помощью CLI{% endif %}:

     1. Посмотрите описание команды:
        
        ```bash
        yc iam key create --help
        ```
     1. Выполните команду, указав следующие параметры:

        * `folder-id` — идентификатор каталога.
        * `service-account-name` — имя сервисного аккаунта.

        ```bash
        yc iam key create --folder-id b1geoelk7fldts6chmjq --service-account-name sa-ydb-user --output ~/.ydb/sa_name.json
        ```

  1. Установите переменную окружения `SA_KEY_FILE`:

     ```bash
     export SA_KEY_FILE=~/.ydb/sa_name.json
     ```

     {% note info %}

     Для подключения к YDB Dedicated базе установите переменную окружения с сертификатом:

      ```bash
      export YDB_SSL_ROOT_CERTIFICATES_FILE=~/.ydb/CA.pem
      ```

     {% endnote %}

  1. Запустите тестовое приложение `basic_example_v1` из репозитория `ydb-python-sdk`, указав в качестве параметров запуска значения:

      * `protocol` — наименование протокола для доступа к базе, например, `grpcs`.
      * `endpoint` — эндпоинт базы данных.
      * `database` — идентификатор базы данных.

      ```bash
      cd ./ydb-python-sdk/examples/basic_example_v1
      python3 __main__.py \
      -e grpcs://ydb.serverless.yandexcloud.net:2135 \
      -d /ru-central1/b1gia87mbaomkfvsleds/etn03o8tbtd3r07sner3
      ```

      Результат выполнения приложения:

      ```bash
      > describe table: series
      column, name: series_id , Uint64
      column, name: title , Utf8
      column, name: series_info , Utf8
      column, name: release_date , Uint64
      column, name: comment , Utf8

      > select_simple_transaction:
      series, id:  1 , title:  IT Crowd , release date:  b'2006-02-03'

      > select_prepared_transaction:
      episode title: To Build a Better Beta , air date: b'2016-06-05'

      > select_prepared_transaction:
      episode title: Bachman's Earnings Over-Ride , air date: b'2016-06-12'

      > explicit TCL call

      > select_prepared_transaction:
      episode title: TBD , air date: b'2019-05-10'
      ```

- Go

  1. Установите [YDB Go SDK](https://github.com/yandex-cloud/ydb-go-sdk):

      ```bash
      go get -u github.com/yandex-cloud/ydb-go-sdk
      go get github.com/dgrijalva/jwt-go
      ```

  1. Получите IAM-токен для необходимого сервисного аккаунта {% if deploy != "arc" %}[с помощью CLI](../../iam/operations/iam-token/create-for-sa#via-cli){% else %}с помощью CLI{% endif %}:
     
     1. Посмотрите описание команды:
        
        ```bash
        yc iam key create --help
        ```
     1. Выполните команду: 

        ```bash
        yc iam key create --service-account-name sa_name -o  ~/.ydb/sa_name.json
        ```

  1. Установите переменную окружения `SA_SERVICE_FILE`, необходимую для аутентификации приложения:

      ```bash
      export SA_SERVICE_FILE=~/.ydb/sa_name.json
      ```

      Где:

      * `SA_SERVICE_FILE` — локальный путь к файлу с IAM токеном.

  1. Скомпилируйте тестовое приложение `basic_example_v1`:

      ```bash
      go build github.com/yandex-cloud/ydb-go-sdk/example/basic_example_v1/
      ```

  1. Запустите тестовое приложение `basic_example_v1`, указав в качестве параметров запуска значения эндпоинта и идентификатора базы полученные ранее, а также путь к сохраненному SSL-сертификату:

      ```bash
      ./basic_example_v1 -endpoint endpoint -database database -root-ca ~/.ydb/CA.pem
      ```

      Результат выполнения приложения:

      ```bash
      > describe table: /ru-central1/b1gia87mbaomkfvsleds/etn0061p28k0t9rajt8d/series
      column, name: Optional<Uint64>, series_id
      column, name: Optional<Utf8>, title
      column, name: Optional<Utf8>, series_info
      column, name: Optional<Uint64>, release_date
      column, name: Optional<Utf8>, comment
  
      > select_simple_transaction: 1 IT Crowd 2006-02-03
      ```

- Node.js

  1. Установите [YDB Node.js SDK](https://github.com/yandex-cloud/ydb-nodejs-sdk):

      ```bash
      git clone https://github.com/yandex-cloud/ydb-nodejs-sdk.git
      cd ydb-nodejs-sdk/examples
      npm install
      npm run build
      ```

  1. Получите IAM-токен для необходимого сервисного аккаунта {% if deploy != "arc" %}[с помощью CLI](../../iam/operations/iam-token/create-for-sa#via-cli){% else %}с помощью CLI{% endif %}:

     1. Посмотрите описание команды:
        
        ```bash
        yc iam key create --help
        ```
     1. Выполните команду:

        ```bash
        yc iam key create --service-account-name sa_name -o  ~/.ydb/sa_name.json
        ```

     {% note info %}

     Для подключения к YDB Dedicated базе установите переменную окружения с сертификатом:

      ```bash
      export YDB_SSL_ROOT_CERTIFICATES_FILE=~/.ydb/CA.pem
      ```

     {% endnote %}
     
  1. Установите переменные окружения, необходимые для аутентификации приложения:

      ```bash
      export SA_JSON_FILE=~/.ydb/sa_name.json
      export IAM_ENDPOINT=iam.api.cloud.yandex.net:443
      export ENTRYPOINT=grpcs://<эндпоинт>
      export DB=<база данных>
      export YDB_SDK_LOGLEVEL=debug
      ```
      Где:

      * `SA_JSON_FILE` — локальный путь к файлу с IAM токеном.
      * `IAM_ENDPOINT` — эндпоинт IAM, установите значение `iam.api.cloud.yandex.net:443`.
      * `ENTRYPOINT` — эндпоинт базы данных.
      * `DB` — идентификатор базы данных YDB.
      * `YDB_SDK_LOGLEVEL` — уровень логирования, установите значение `debug`.

  1. Запустите тестовое приложение `basic_example_v1`:

      ```bash
      npm run basic-v1 -- --db <база данных YDB> --endpoint <эндпойнт базы данных>
      ```

      Результат выполнения приложения:

      ```bash
      node build/basic-example-v1/index.js $ENTRYPOINT $DB | pino-pretty
      [1603883537002] INFO  (58433 on laptop): Running basic-example script against entry-point 'grpcs://ydb.serverless.yandexcloud.net:2135' and database '/ru-central1/b1gia87mbaomkfvsleds/etn0061p28k0t9rajt8d'.
      [1603883537003] DEBUG (58433 on laptop): Protocol grpcs specified in entry-point, using SSL connection.
      [1603883537003] DEBUG (58433 on laptop): SA_JSON_FILE env var found, using IamAuthService with params from that json.
      [1603883537004] DEBUG (58433 on laptop): Driver initializing...
      [1603883537589] DEBUG (58433 on laptop): Driver is ready!
      [1603883537833] DEBUG (58433 on laptop): Acquired session ydb://session/3?node_id=12065&id=ZTM4OGQwMjktOTk5ZGRiOGQtZWRiZTFmZjMtYmRmYWY3ZTA= on endpoint ydb.serverless.yandexcloud.net:2135.
      [1603883537833] INFO  (58433 on laptop): Dropping old tables...
      [1603883538114] INFO  (58433 on laptop): Creating tables...
      [1603883538660] INFO  (58433 on laptop): Describing table: series
      [1603883538735] INFO  (58433 on laptop): Column name 'series_id' has type {"optionalType":{"item":{"typeId":"UINT64"}}}
      [1603883538735] INFO  (58433 on laptop): Column name 'title' has type {"optionalType":{"item":{"typeId":"UTF8"}}}
      [1603883538735] INFO  (58433 on laptop): Column name 'series_info' has type {"optionalType":{"item":{"typeId":"UTF8"}}}
      [1603883538735] INFO  (58433 on laptop): Column name 'release_date' has type {"optionalType":{"item":{"typeId":"UINT64"}}}
      [1603883538736] INFO  (58433 on laptop): Inserting data to tables, preparing query...
      [1603883538807] INFO  (58433 on laptop): Query has been prepared, executing...
      [1603883538915] DEBUG (58433 on laptop): Released session ydb://session/3?node_id=12065&id=ZTM4OGQwMjktOTk5ZGRiOGQtZWRiZTFmZjMtYmRmYWY3ZTA= on endpoint ydb.serverless.yandexcloud.net:2135.
      [1603883538915] DEBUG (58433 on laptop): Acquired session ydb://session/3?node_id=12065&id=ZjY5NWRlM2EtYWMyYjA5YWEtNzQ0MTVlYTMtM2Q4ZDgzOWQ= on endpoint ydb.serverless.yandexcloud.net:2135.
      [1603883538915] INFO  (58433 on laptop): Making a simple select...
      [1603883539008] INFO  (58433 on laptop): selectSimple result:
      [1603883539008] INFO  (58433 on laptop): Making an upsert...
      [1603883539057] INFO  (58433 on laptop): Upsert completed.
      [1603883539057] INFO  (58433 on laptop): Preparing query...
      [1603883539119] INFO  (58433 on laptop): Selecting prepared query...
      [1603883539168] INFO  (58433 on laptop): Select prepared query
      [1603883539244] INFO  (58433 on laptop): Select prepared query
      [1603883539244] INFO  (58433 on laptop): Running prepared query with explicit transaction control...
      [1603883539456] INFO  (58433 on laptop): Executing query with txId 5e3f1eb1-d532afbf-ead22387-53272811.
      [1603883539558] INFO  (58433 on laptop): TxId 5e3f1eb1-d532afbf-ead22387-53272811 committed.
      [1603883539558] INFO  (58433 on laptop): Preparing query...
      [1603883539602] INFO  (58433 on laptop): Selecting prepared query...
      [1603883539685] INFO  (58433 on laptop): Select prepared query
      [1603883539685] DEBUG (58433 on laptop): Released session ydb://session/3?node_id=12065&id=ZjY5NWRlM2EtYWMyYjA5YWEtNzQ0MTVlYTMtM2Q4ZDgzOWQ= on endpoint ydb.serverless.yandexcloud.net:2135.
      [1603883539685] DEBUG (58433 on laptop): Destroying driver...
      [1603883539686] DEBUG (58433 on laptop): Destroying pool...
      [1603883539754] DEBUG (58433 on laptop): Pool has been destroyed.
      [1603883539754] DEBUG (58433 on laptop): Driver has been destroyed.
      ```

- Java

  1. Соберите тестовое приложение. Для этого:

     1. Склонируйте репозиторий [YDB Java SDK](https://github.com/yandex-cloud/ydb-java-sdk):
        
        ```bash
        git clone https://github.com/yandex-cloud/ydb-java-sdk.git
        ```

     1. Перейдите в директорию с тестовым приложением `ydb-java-sdk/examples/maven_project`:
        
        ```bash
        cd ydb-java-sdk/examples/maven_project
        ```

     1. Соберите его:
        
        ```bash
        mvn package
        ```

  1. Создайте авторизованный ключ для вашего сервисного аккаунта, запишите его в файл {% if deploy != "arc" %}[с помощью CLI](../../iam/operations/iam-token/create-for-sa#via-cli){% else %}с помощью CLI{% endif %}:

     1. Посмотрите описание команды:
        
        ```bash
        yc iam key create --help
        ```
     1. Выполните команду, указав следующие параметры:

        * `folder-id` — идентификатор каталога.
        * `service-account-name` — имя сервисного аккаунта.

        ```bash
        yc iam key create --folder-id b1geoelk7fldts6chmjq --service-account-name sa-ydb-user --output ~/.ydb/sa_name.json
        ```

  1. Установите переменную окружения `SA_KEY_FILE`:

     ```bash
     export SA_KEY_FILE=~/.ydb/sa_name.json
     ```

  1. Запустите тестовое приложение:

      ```bash
      cd target/release
      java -jar example.jar <эндпойнт базы данных> <база данных YDB>
      ```

{% endlist %}