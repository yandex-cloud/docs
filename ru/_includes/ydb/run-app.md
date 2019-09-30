Чтобы запустить приложение и подключиться к базе:

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
  
  1. Установите переменные окружения, необходимые для аутентификации приложения:
  
      ```bash
      export SA_ENDPOINT=iam.api.cloud.yandex.net:443
      export SA_PRIVATE_KEY_FILE=/home/path/to/private.key
      export SA_ID=YOUR_SA_ID
      export SA_ACCESS_KEY_ID=YOUR_ACCESS_KEY_ID
      export YDB_SSL_ROOT_CERTIFICATES_FILE=~/.ydb/CA.pem
      ```
  
      * `SA_ENDPOINT` — эндпоинт IAM, установите значение `iam.api.cloud.yandex.net:443`
      * `SA_PRIVATE_KEY_FILE` — путь к файлу с закрытым ключом
      * `SA_ID` — идентификатор сервисного аккаунта
      * `SA_ACCESS_KEY_ID` — идентификатор открытого авторизованного ключа
      * `YDB_SSL_ROOT_CERTIFICATES_FILE` — путь до файла с SSL-сертификатом
  
  1. Запустите тестовое приложение `basic_example_v1` из репозитория `ydb-python-sdk`, указав в качестве параметров запуска параметры, полученные ранее:
  
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
  
  1. Установите переменные окружения, необходимые для аутентификации приложения:
  
      ```bash
      export SA_ENDPOINT=iam.api.cloud.yandex.net:443
      export SA_PRIVATE_KEY_FILE=/home/path/to/private.key
      export SA_ID=YOUR_SA_ID
      export SA_ACCESS_KEY_ID=YOUR_ACCESS_KEY_ID
      export export YDB_SSL_ROOT_CERTIFICATES_FILE=~/.ydb/CA.pem
      ```
  
      * `SA_ENDPOINT` — эндпоинт IAM, установите значение `iam.api.cloud.yandex.net:443`
      * `SA_PRIVATE_KEY_FILE` — локальный путь к файлу с закрытым авторизованным ключом
      * `SA_ID` — идентификатор сервисного аккаунта
      * `SA_ACCESS_KEY_ID` — идентификатор открытого авторизованного ключа
      * `YDB_SSL_ROOT_CERTIFICATES_FILE` — путь до файла с SSL-сертификатом
  
  1. Скомпилируйте тестовое приложение `basic_example_v1`:
  
      ```bash
      cd $GOPATH
      go build github.com/yandex-cloud/ydb-go-sdk/example/basic_example_v1/
      ```
  
  1. Запустите тестовое приложение `basic_example_v1`, указав в качестве параметров запуска значения эндпоинта и идентификатора базы, полученные ранее:
  
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
  
  1. Скомпилируйте тестовое приложение, например, `basic_example_v1`:
  
       ```bash
       git clone https://github.com/yandex-cloud/ydb-java-sdk
       cd basic_example_v1
       ./mvnw package
       ```
       
  1. Запустите тестовое приложение `basic_example_v1`, указав параметры, полученные ранее:
  
      ```bash
      ./mvnw -q exec:java -Dexec.args="<accountId> <keyId> <private_key_file_path> <endpoint> <database> <ssl_file_path>"
      ```
      
      * `accountId` — идентификатор сервисного аккаунта
      * `keyId` — идентификатор открытого авторизованного ключа
      * `private_key_file_path` — локальный путь к файлу с закрытым авторизованным ключом
      * `endpoint` — эндпоинд базы данных
      * `database` — имя базы данных
      * `ssl_file_path` — локальный путь к файлу с SSL-сертификатом
  
{% endlist %}