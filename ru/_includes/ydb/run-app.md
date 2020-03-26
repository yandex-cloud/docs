Чтобы запустить приложение и подключиться к базе:

{% list tabs %}

- Python

  1. [Подключитесь](../../compute/operations/vm-connect/ssh.md) к виртуальной машине по SSH:
  
      ```bash
      $ ssh <имя_пользователя>@<публичный_IP-адрес_виртуальной машины>
      ```  

  1. Установите `pip3`:
  
      ```bash
      sudo apt update
      sudo apt install python3-pip
      ```
  
  1. Установите [Yandex.Cloud Python SDK](https://github.com/yandex-cloud/python-sdk):
  
      ```bash
      git clone https://github.com/yandex-cloud/python-sdk.git
      sudo pip3 install -e python-sdk/
      ```
  
  1. Установите [YDB Python SDK](https://github.com/yandex-cloud/ydb-python-sdk) и библиотеку `iso8601`:
  
      ```bash
      git clone https://github.com/yandex-cloud/ydb-python-sdk.git
      sudo pip3 install -e ydb-python-sdk/
      sudo pip3 install iso8601
      ```
  
  1. Получите IAM-токен для необходимого сервисного аккаунта [с помощью CLI](../../iam/operations/iam-token/create-for-sa#via-cli):

      ```bash
      yc iam key create --service-account-name sa_name -o  ~/.ydb/sa_name.json
      ```

  1. Установите переменные окружения, необходимые для аутентификации приложения:
  
      ```bash
      export YDB_SSL_ROOT_CERTIFICATES_FILE=~/.ydb/CA.pem
      export SA_KEY_FILE=~/.ydb/sa_name.json
      ```
  
      * `YDB_SSL_ROOT_CERTIFICATES_FILE` — путь до файла с SSL-сертификатом
      * `SA_KEY_FILE` — локальный путь к файлу с IAM токеном
  
  1. Запустите тестовое приложение `basic_example_v1` из репозитория `ydb-python-sdk`, указав в качестве параметров запуска параметры, полученные ранее:
  
      ```bash
      cd ./ydb-python-sdk/kikimr/public/sdk/python/examples/basic_example_v1
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

  1. [Подключитесь](../../compute/operations/vm-connect/ssh.md) к виртуальной машине по SSH:
  
      ```bash
      $ ssh <имя_пользователя>@<публичный_IP-адрес_виртуальной машины>
      ```  
  
  1. Установите [YDB Go SDK](https://github.com/yandex-cloud/python-sdk):
  
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
 
      * `SA_SERVICE_FILE` — локальный путь к файлу с IAM токеном
  
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
  
{% endlist %}