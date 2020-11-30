Чтобы запустить приложение и подключиться к базе:

{% list tabs %}

- Python

  1. Склонируйте репозиторий [YDB Python SDK](https://github.com/yandex-cloud/ydb-python-sdk) и установите библиотеки `ydb`, `iso8601`, `yandexcloud`:

      ```bash
      git clone https://github.com/yandex-cloud/ydb-python-sdk.git
      sudo pip3 install iso8601 ydb yandexcloud
      ```

  1. Создайте авторизованный ключ для вашего сервисного аккаунта, запишите его файл [с помощью CLI](../../iam/operations/iam-token/create-for-sa#via-cli) и установите переменную окружения `SA_KEY_FILE`:

      ```bash
      yc iam key create --service-account-name sa-name -o  ~/.ydb/sa_name.json
      export SA_KEY_FILE=~/.ydb/sa_name.json
      ```

     {% note info %}

     Для подключения к YDB Dedicated базе установите переменную окружения с сертификатом:

      ```bash
      export YDB_SSL_ROOT_CERTIFICATES_FILE=~/.ydb/CA.pem
      ```

     {% endnote %}

  1. Запустите тестовое приложение `basic_example_v1` из репозитория `ydb-python-sdk`, указав в качестве параметров запуска значения, полученные ранее:

      ```bash
      cd ./ydb-python-sdk/examples/basic_example_v1
      python3 __main__.py -e protocol://endpoint -d database
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

  1. Получите IAM-токен для необходимого сервисного аккаунта [с помощью CLI](../../iam/operations/iam-token/create-for-sa#via-cli):

      ```bash
      yc iam key create --service-account-name sa_name -o  ~/.ydb/sa_name.json
      ```

  1. Установите переменные окружения, необходимые для аутентификации приложения:

      ```bash
      export SA_SERVICE_FILE=~/.ydb/sa_name.json
      ```

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
      inspecting Database

      > describe_table_options:

      > describe table: /global/path/todatabase/series
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

  1. Получите IAM-токен для необходимого сервисного аккаунта [с помощью CLI](../../iam/operations/iam-token/create-for-sa#via-cli):

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
      export YDB_SDK_LOGLEVEL=debug
      ```

      * `SA_JSON_FILE` — локальный путь к файлу с IAM токеном.
      * `IAM_ENDPOINT` — эндпоинт IAM, установите значение `iam.api.cloud.yandex.net:443`.
      * `YDB_SDK_LOGLEVEL` — уровень логирования, установите значение `debug`.

  1. Запустите тестовое приложение `basic_example_v1`:

      ```bash
      npm run basic-v1 -- --db <база данных YDB> --endpoint <эндпойнт базы данных>
      ```

      Результат выполнения приложения:

      ```bash
      Dropping old tables...
      Describing table: series
      Column name 'series_id' has type {"optionalType":{"item":{"typeId":"UINT64"}}}
      Column name 'title' has type {"optionalType":{"item":{"typeId":"UTF8"}}}
      Column name 'series_info' has type {"optionalType":{"item":{"typeId":"UTF8"}}}
      Column name 'release_date' has type {"optionalType":{"item":{"typeId":"UINT64"}}}

      Inserting data to tables, preparing query...
      Query has been prepared, executing...

      Making a simple select...
      selectSimple result: [{"seriesId":1,"title":"IT Crowd","releaseDate":13182}]

      Making an upsert...
      Upsert completed.
      Preparing query...
      Selecting prepared query...
      Preparing query...

      Selecting prepared query...
      Select prepared query [{"title":"To Build a Better Beta","airDate":"2016-06-05","releaseDate":null}]
      Select prepared query [{"title":"Bachman's Earnings Over-Ride","airDate":"2016-06-12","releaseDate":null}]

      Running prepared query with explicit transaction control...
      Executing query with txId d2f98e91-e69cc14a-bebded66-10c7d3a5.
      TxId d2f98e91-e69cc14a-bebded66-10c7d3a5 committed.

      Preparing query...
      Selecting prepared query...
      Select prepared query [{"title":"TBD","airDate":"2020-04-05","releaseDate":null}]
      Released session ydb://session/...= on endpoint vm-xxxxx.ydb.mdb.yandexcloud.net:2135.
      ```

- Java

  1. Соберите тестовое приложение.

      ```bash
      git clone https://github.com/yandex-cloud/ydb-nodejs-sdk.git
      cd ydb-java-sdk/examples/maven-project
      mvn package
      ```

  1. Для запуска тестового приложения вне облака получите свой OAUTH-токен [по ссылке](https://oauth.yandex.ru/authorize?response_type=token&client_id=1a6990aa636648e9b2ef855fa7bec2fb),
     установите переменную окружения

      ```bash
      export OAUTH_TOKEN=<your oauth token>
      ```
      для запуска в виртуальной машине - создайте виртуальную машину с созданным ранее сервисным аккаунтом. В этом случае
      OAUTH_TOKEN не требуется, авторизация будет проходить от имени сервисного аккаунта.

  1. Запустите тестовое приложение:

      ```bash
      cd target/release
      java -jar example.jar <эндпойнт базы данных> <база данных YDB>
      ```
      Для запуска в виртуальной машине скопируйте весь каталог target/release на виртуальную машину.

{% endlist %}
