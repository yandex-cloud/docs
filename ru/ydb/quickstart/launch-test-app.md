# Запуск тестового приложения

Подключитесь к базе данных и запустите тестовые приложения для [Python](https://github.com/yandex-cloud/ydb-python-sdk), [Go](https://github.com/yandex-cloud/ydb-go-sdk) или [Java](https://github.com/yandex-cloud/ydb-java-sdk) для знакомства с работой {{ ydb-short-name }} SDK.

Подробный разбор кода тестовых приложений читайте в разделе [{#T}](../sdk/index.md).

## Подключитесь к базе данных {#connect-to-db}

Чтобы подключиться к базе данных:

1. [Создайте виртуальную машину](../../compute/operations/vm-create/create-linux-vm) в Яндекс.Облаке.

1. Сохраните публичный IP-адрес виртуальной машины. Для этого перейдите в свойства виртуальной машины или [воспользуйтесь интерфейсом командной строки](../../compute/operations/vm-info/get-info#outside-instance).

1. Для аутентификации в базе данных [создайте сервисный аккаунт](../../iam/operations/sa/create) и назначьте ему роли `viewer` и `editor`.

1. Перейдите в раздел **Сервисные аккаунты** своего каталога и выберите необходимый сервисный аккаунт в списке. Сохраните идентификатор сервисного аккаунта.

1. [Создайте авторизованные ключи доступа](../../iam/operations/iam-token/create-for-sa#keys-create) к сервисному аккаунту и сохраните их.

1. Перейдите в свойства базы данных и сохраните значения эндпоинта и идентификатора базы, приведенные в блоке **Эндпоинт**.

## Запустите тестовое приложение {#run-test}

Чтобы запустить приложение:

{% list tabs %}

- Python
  
  1. Установите [Yandex.Cloud Python SDK](https://github.com/yandex-cloud/python-sdk):
  
      ```bash
      git clone https://github.com/yandex-cloud/python-sdk.git
      sudo pip3 install -e python-sdk/
      ```
  
  1. Установите [YDB Python SDK](https://github.com/yandex-cloud/ydb-python-sdk):
  
      ```bash
      git clone https://github.com/yandex-cloud/ydb-python-sdk.git
      sudo pip3 install -e ydb-python-sdk/
      ```
  
  1. Для аутентификации потребуются идентификатор сервисного аккаунта и открытый авторизованный ключ, созданные [ранее](#connect-to-db).
  
  1. Установите переменные окружения, необходимые для аутентификации приложения:
  
      ```bash
      export SA_ENDPOINT=iam.api.cloud.yandex.net:443
      export SA_PRIVATE_KEY_FILE=/home/path/to/private.key
      export SA_ID=YOUR_SA_ID
      export SA_ACCESS_KEY_ID=YOUR_ACCESS_KEY_ID
      ```
  
      * `SA_ENDPOINT` — эндпоинт IAM, установите значение `iam.api.cloud.yandex.net:443`
      * `SA_PRIVATE_KEY_FILE` — путь к файлу с закрытым ключом
      * `SA_ID` — идентификатор сервисного аккаунта
      * `SA_ACCESS_KEY_ID` — идентификатор открытого авторизованного ключа
  
  1. Запустите тестовое приложение `basic_example_v1` из репозитория `ydb-python-sdk`, указав в качестве параметров запуска значения эндпоинта и идентификатора базы, полученные [ранее](#connect-to-db):
  
      ```bash
      cd ./ydb-python-sdk/kikimr/public/sdk/python/examples/basic_example_v1
      python3 __main__.py -e endpoint -d database
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
  
  1. Установите [YDB Go SDK](https://github.com/yandex-cloud/python-sdk):
  
      ```bash
      export GOPATH=$HOME/go
      mkdir -p $GOPATH/src/github.com/yandex-cloud/ydb-go-sdk
      cd $GOPATH/src/github.com/yandex-cloud/ydb-go-sdk
      git clone https://github.com/yandex-cloud/ydb-go-sdk.git
      cd $GOPATH
      go get github.com/dgrijalva/jwt-go
      ```
  
  1. Для аутентификации приложения потребуются идентификатор сервисного аккаунта и открытый авторизованный ключ доступа, полученные [ранее](#connect-to-db).
  
  1. Установите переменные окружения, необходимые для аутентификации приложения:
  
      ```bash
      export SA_ENDPOINT=iam.api.cloud.yandex.net:443
      export SA_PRIVATE_KEY_FILE=/home/path/to/private.key
      export SA_ID=YOUR_SA_ID
      export SA_ACCESS_KEY_ID=YOUR_ACCESS_KEY_ID
      ```
  
      * `SA_ENDPOINT` — эндпоинт IAM, установите значение `iam.api.cloud.yandex.net:443`
      * `SA_PRIVATE_KEY_FILE` — локальный путь к файлу с закрытым авторизованным ключом
      * `SA_ID` — идентификатор сервисного аккаунта
      * `SA_ACCESS_KEY_ID` — идентификатор открытого авторизованного ключа
  
  1. Скомпилируйте тестовое приложение `basic_example_v1`:
  
      ```bash
      cd $GOPATH
      go build github.com/yandex-cloud/ydb-go-sdk/example/basic_example_v1/
      ```
  
  1. Запустите тестовое приложение `basic_example_v1`, указав в качестве параметров запуска значения эндпоинта и идентификатора базы, полученные [ранее](#connect-to-db):
  
      ```bash
      ./basic_example_v1 -endpoint endpoint -database database
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
  
- Java

  1. Установите [JDK 11](https://www.oracle.com/technetwork/java/javase/downloads/5066655):
  
      ```bash
      sudo apt-get update
      sudo apt-get install openjdk-11-jdk
      ```
  
  1. Скомпилируйте тестовое приложение, например, `ydb-test-app`:
  
       ```bash
       cd ydb-test-app
       ./mvnw package
       ```
       
  1. Запустите тестовое приложение `ydb-test-app`, указав параметры запуска, полученные [ранее](#connect-to-db):
  
      ```bash
      ./mvnw -q exec:java -Dexec.args="<accountId> <keyId> <private_key_file_path> <endpoint> <database>"
      ```
      
      * `accountId` — идентификатор сервисного аккаунта
      * `keyId` — идентификатор открытого авторизованного ключа
      * `private_key_file_path` — локальный путь к файлу с закрытым авторизованным ключом
      * `endpoint` — эндпоинд базы данных
      * `database` — имя базы данных
  
{% endlist %}