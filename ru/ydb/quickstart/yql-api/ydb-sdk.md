# Работа с YDB SDK

Для знакомства с работой {{ ydb-short-name }} SDK вы можете воспользоваться тестовыми приложениями на [Python](https://github.com/yandex-cloud/ydb-python-sdk), [Go](https://github.com/yandex-cloud/ydb-go-sdk), [Node.js](https://github.com/yandex-cloud/ydb-nodejs-sdk), [PHP](https://github.com/yandex-cloud/ydb-php-sdk) или [Java](https://github.com/yandex-cloud/ydb-java-sdk). Настройте подключение к базе данных, после чего установите и запустите соответствующее тестовое приложение.

{% note info %}

Подробный разбор кода тестовых приложений читайте в разделе [{#T}](../../ydb-sdk/index.md).

{% endnote %}

## Настройка подключения к базе данных {#connect-to-db}

Чтобы подключиться к базе данных:

1. Получите YDB эндпоинт и полный путь к [созданной БД](../create-db.md).

    {% cut "Как получить YDB эндпоинт и путь к БД" %}

    {% include [ydb-endpoint](../../_includes/ydb-endpoint.md) %}

    {% endcut %}

    {% note info %}

    Если ваша база данных не имеет публичного эндпоинта, [создайте](../../../compute/operations/vm-create/create-linux-vm.md) виртуальную машину для доступа к БД в {{ yandex-cloud }}.

    Дальнейшую настройку выполняйте в созданной виртуальной машине.

    {% endnote %}

1. Для аутентификации в базе данных [создайте сервисный аккаунт](../../../iam/operations/sa/create.md) и [назначьте](../../../iam/operations/sa/assign-role-for-sa.md) ему роли `viewer` и `editor`.

1. С помощью [YC CLI](../../../cli/quickstart.md#install) сохраните в файл авторизованный ключ сервисного аккаунта:

    ```bash
    yc iam key create \
      --service-account-name <имя_сервисного_аккаунта> \
      --output <имя_файла>
    ```

    * `--service-account-name` — имя созданного ранее сервисного аккаунта.
    * `--output` — имя файла, в который будет сохранен авторизованный ключ, например `sa_authorized.json`.

## Запуск тестового приложения {#run-app}

Чтобы установить и запустить тестовое приложение:

{% list tabs %}

- Python

  1. Склонируйте репозиторий [YDB Python SDK](https://github.com/yandex-cloud/ydb-python-sdk) и установите библиотеки `ydb`, `iso8601`, `yandexcloud`:

      ```bash
      git clone https://github.com/yandex-cloud/ydb-python-sdk.git
      sudo pip3 install iso8601 ydb yandexcloud
      ```

  1. Установите переменную окружения `SA_KEY_FILE` для аутентификации приложения:

      ```bash
      export SA_KEY_FILE=~/sa_authorized.json
      ```

      {% note info %}

      Чтобы подключиться к {{ ydb-short-name }} Dedicated БД, получите сертификат и сохраните путь файла сертификата в переменную окружения:

      ```bash
      wget "https://storage.yandexcloud.net/cloud-certs/CA.pem" -O ~/CA.pem
      export YDB_SSL_ROOT_CERTIFICATES_FILE=~/CA.pem
      ```

      {% endnote %}

  1. Запустите тестовое приложение `basic_example_v1`:

      ```bash
      cd ./ydb-python-sdk/examples/basic_example_v1
      python3 __main__.py \
        -e grpcs://lb.etn03umae82ti1blt4er.ydb.mdb.yandexcloud.net:2135 \
        -d /ru-central1/b1gia87mbaomkfvscrus/etn03umae82ti1blt4er
      ```

      * `-e` — эндпоинт базы данных.
      * `-d` — полный путь базы данных.

      Результат:

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
      ```

  1. Установите переменную окружения `YDB_SERVICE_ACCOUNT_KEY_FILE_CREDENTIALS` для аутентификации приложения:

      ```bash
      export YDB_SERVICE_ACCOUNT_KEY_FILE_CREDENTIALS=~/sa_authorized.json
      ```

  1. Скомпилируйте тестовое приложение `basic_example_v1`:

      ```bash
      go build github.com/yandex-cloud/ydb-go-sdk/example/basic_example_v1/
      ```

  1. Запустите тестовое приложение `basic_example_v1`:

      ```bash
      ./basic_example_v1 \
        -endpoint lb.etn03umae82ti1blt4er.ydb.mdb.yandexcloud.net:2135
        -database /ru-central1/b1gia87mbaomkfvscrus/etn03umae82ti1blt4er
      ```

      * `-endpoint` — эндпоинт базы данных.
      * `-database` — полный путь базы данных.

      Результат:

      ```bash
      > describe table: /ru-central1/b1gia87mbaomkfvscrus/etn0061p28k0t9rajt8d/series
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

  1. Установите переменную окружения `YDB_SERVICE_ACCOUNT_KEY_FILE_CREDENTIALS` для аутентификации приложения:

      ```bash
      export YDB_SERVICE_ACCOUNT_KEY_FILE_CREDENTIALS=~/sa_authorized.json
      ```

      {% note info %}

      Чтобы подключиться к {{ ydb-short-name }} Dedicated БД, получите сертификат и сохраните путь файла сертификата в переменную окружения:

      ```bash
      wget "https://storage.yandexcloud.net/cloud-certs/CA.pem" -O ~/CA.pem
      export YDB_SSL_ROOT_CERTIFICATES_FILE=~/CA.pem
      ```

      {% endnote %}

  1. Запустите тестовое приложение `basic_example_v1`:

      ```bash
      npm run basic-v1 -- \
        --db /ru-central1/b1gia87mbaomkfvscrus/etn03umae82ti1blt4er \
        --endpoint lb.etn03umae82ti1blt4er.ydb.mdb.yandexcloud.net:2135
      ```

      * `--endpoint` — эндпоинт базы данных.
      * `--db` — полный путь базы данных.

      Результат:

      ```bash
      > ydb-sdk-examples@0.0.1 basic-v1
      > node build/basic-example-v1/index.js "--db" "/ru-central1/b1gia87mbaomkfvscrus/etn03umae82ti1blt4er" "--endpoint" "lb.etn03umae82ti1blt4er.ydb.mdb.yandexcloud.net:2135"

      [1627467690996] INFO  (1106 on test): Running basic-example script against endpoint 'lb.etn03umae82ti1blt4er.ydb.mdb.yandexcloud.net:2135' and database '/ru-central1/b1gia87mbaomkfvscrus/etn03umae82ti1blt4er'.
      [1627467691512] INFO  (1106 on test): Dropping old tables...
      [1627467691612] INFO  (1106 on test): Creating tables...
      [1627467691983] INFO  (1106 on test): Describing table: series
      [1627467691993] INFO  (1106 on test): Column name 'series_id' has type {"optionalType":{"item":{"typeId":"UINT64"}}}
      [1627467691993] INFO  (1106 on test): Column name 'title' has type {"optionalType":{"item":{"typeId":"UTF8"}}}
      [1627467691993] INFO  (1106 on test): Column name 'series_info' has type {"optionalType":{"item":{"typeId":"UTF8"}}}
      [1627467691994] INFO  (1106 on test): Column name 'release_date' has type {"optionalType":{"item":{"typeId":"DATE"}}}
      [1627467691994] INFO  (1106 on test): Inserting data to tables, preparing query...
      [1627467692016] INFO  (1106 on test): Query has been prepared, executing...
      [1627467692057] INFO  (1106 on test): Making a simple select...
      [1627467692073] INFO  (1106 on test): selectSimple result: [
        {
          "seriesId": 1,
          "title": "IT Crowd",
          "releaseDate": "2006-02-03T00:00:00.000Z"
        }
      ]
      [1627467692073] INFO  (1106 on test): Making an upsert...
      [1627467692089] INFO  (1106 on test): Upsert completed.
      [1627467692090] INFO  (1106 on test): Preparing query...
      [1627467692103] INFO  (1106 on test): Selecting prepared query...
      [1627467692109] INFO  (1106 on test): Select prepared query [
        {
          "title": "To Build a Better Beta",
          "airDate": "2016-06-05T00:00:00.000Z"
        }
      ]
      [1627467692115] INFO  (1106 on test): Select prepared query [
        {
          "title": "Bachman's Earnings Over-Ride",
          "airDate": "2016-06-12T00:00:00.000Z"
        }
      ]
      [1627467692115] INFO  (1106 on test): Running prepared query with explicit transaction control...
      [1627467692134] INFO  (1106 on test): Executing query with txId c06611b3-1f45089c-3d25caa0-ba02eabd.
      [1627467692152] INFO  (1106 on test): TxId c06611b3-1f45089c-3d25caa0-ba02eabd committed.
      [1627467692152] INFO  (1106 on test): Preparing query...
      [1627467692156] INFO  (1106 on test): Selecting prepared query...
      [1627467692162] INFO  (1106 on test): Select prepared query [
        {
          "title": "TBD",
          "airDate": "2021-07-28T00:00:00.000Z"
        }
      ]
      ```

- Java

  1. Соберите тестовое приложение:

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

  1. Установите переменную окружения `SA_KEY_FILE` для аутентификации приложения:

     ```bash
     export SA_KEY_FILE=~/sa_authorized.json
     ```

  1. Запустите тестовое приложение:

      ```bash
      cd target/release
      java -jar example.jar <эндпойнт базы данных> <полный путь базы данных>
      ```

      Результат:

      ```bash
      ...
      Columns reported by describeTable: [species, name, color, price]

      Result of select query:
      species: cat
      name: Tom
      color: black
      price: 10.000000
      ```

{% endlist %}
