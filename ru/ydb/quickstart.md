# Как начать работать с {{ ydb-short-name }}

*Сервис {{ ydb-short-name }} находится на [стадии Preview](../overview/concepts/launch-stages.md), доступ к сервису предоставляется по заявке.*

Создайте базу данных {{ ydb-short-name }} в консоли управления {{ yandex-cloud }} и ознакомьтесть с правилами написания YQL-запросов. Также вы можете запустить тестовое приложение для знакомства с работой {{ ydb-short-name }} SDK для [Python](https://github.com/yandex-cloud/ydb-python-sdk), [Go](https://github.com/yandex-cloud/ydb-go-sdk) или [Java](https://github.com/yandex-cloud/ydb-java-sdk).

## Перед началом работы {#before-you-begin}

Доступ к сервису предоставляется по заявке. Чтобы оформить заявку:
1. Войдите в [консоль управления](https://console.cloud.yandex.ru). Если вы еще не зарегистрированы, перейдите в консоль управления и следуйте инструкциям.
1. [На странице биллинга](https://console.cloud.yandex.ru/billing) убедитесь, что у вас подключен [платежный аккаунт](../billing/concepts/billing-account.md), и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../billing/quickstart/index.md#create_billing_account).
1. Если у вас еще нет каталога, [создайте его](../resource-manager/operations/folder/create.md).
1. Перейдите на [страницу сервиса {{ ydb-short-name }}](https://cloud.yandex.ru/services/ydb) и нажмите кнопку **Запросить доступ**.
1. Выберите облако, в котором планируете работать с сервисом, и нажмите кнопку **Отправить**. Как только заявка будет одобрена, на вашу электронную почту придет письмо с подтверждением.
1. Откройте письмо и нажмите кнопку **Начать тестирование**. Вы будете перенаправлены в [консоль {{ yandex-cloud }}](https://console.cloud.yandex.ru/) и сможете начать работу с сервисом.

## Создайте базу данных {#control-plane}

{% if audience == "internal" %}

1. Чтобы создать базу данных, перейдите в [консоль управления](https://ydb.yandex-team.ru).

    {% include [iam](../_includes/iam/owner-warning.md) %}

1. Нажмите кнопку **Create database**.

    ![Create database](_assets/db_ui_create_database_button.png)

1. В поле **Cluster** выберите кластер *ydb-ru*.

    Остальные поля будут заполнены автоматически, в том числе будет автоматически выбран аккаунт *home*, создана директория с вашим именем пользователя и база данных с именем *mydb*.

    Пример создания новой базы данных:

    ![Create new database](_assets/db_ui_create_home_database.png)

1. Нажмите кнопку **Create**.

    Появится страница с сообщением об успешном создании базы данных.

    ![New database entrance](_assets/db_ui_entrance_home_database.png)

{% else if audience == "external" %}

{% include [create-db-via-console](../_includes/ydb/create-db-via-console.md) %}

{% endif %}

## Создайте таблицу {#create-table}

Чтобы начать работать с базой, создайте новую таблицу с помощью оператора [CREATE TABLE](yql/reference/syntax/create_table.md).

{% include [create-schema-via-console](../_includes/ydb/create-schema-via-console.md) %}

## Запишите данные в таблицу {#replace-data}

Запишите новые данные в таблицу с помощью оператора [REPLACE](yql/reference/syntax/replace_into.md).

{% include [replace-data-via-console](../_includes/ydb/replace-data-via-console.md) %}

{% if audience == "internal" %}

![Table preview](_assets/db_ui_table_preview.png)

{% endif %}

## Замените строки в таблице {#update-data}

Обновите существующие данные в таблице с помощью оператора [UPDATE](yql/reference/syntax/update.md).

{% include [update-data-via-console](../_includes/ydb/update-data-via-console.md) %}

{% if audience == "internal" %}

![Update preview](_assets/db_ui_run_update.png)

{% endif %}

## Удалите строки из таблицы {#delete-data}

Удалите данные из таблицы с помощью оператора [DELETE](yql/reference/syntax/delete.md).

{% include [delete-data-via-console](../_includes/ydb/delete-data-via-console.md) %}

{% if audience == "internal" %}

![Delete preview](_assets/db_ui_run_delete.png)

{% endif %}

## Прочитайте данные {#select-data}

Прочитайте данные из таблицы с помощью оператора [SELECT](yql/reference/syntax/select.md).

{% include [select-data-via-console](../_includes/ydb/select-data-via-console.md) %}

{% if audience == "internal" %}

![Select from table](_assets/db_ui_run_select.png)

{% endif %}

## Удалите таблицу {#drop-table}

Удалите таблицу с помощью оператора [DROP TABLE](yql/reference/syntax/drop_table.md).

{% include [drop-table-via-console](../_includes/ydb/drop-table-via-console.md) %}

## Запустите тестовое приложение {#sdk}

Подключитесь к базе данных и запустите тестовые приложения для знакомства с работой {{ ydb-short-name }} SDK для [Python](https://github.com/yandex-cloud/ydb-python-sdk), [Go](https://github.com/yandex-cloud/ydb-go-sdk) или [Java](https://github.com/yandex-cloud/ydb-java-sdk).

Подробный разбор кода тестовых приложений читайте в разделе [{#T}](sdk/index.md).

### Подключитесь к базе данных {#connect-to-db}

Чтобы подключиться к базе данных:

1. [Создайте виртуальную машину](../compute/operations/vm-create/create-linux-vm) в {{ yandex-cloud }}.

1. Сохраните публичный IP-адрес виртуальной машины. Для этого перейдите в свойства виртуальной машины или [воспользуйтесь интерфейсом командной строки](../compute/operations/vm-info/get-info#outside-instance).

1. Для аутентификации в базе данных [создайте сервисный аккаунт](../iam/operations/sa/create) и назначьте ему роли `viewer` и `editor`.

1. Перейдите в раздел **Сервисные аккаунты** своего каталога и выберите необходимый сервисный аккаунт в списке. Сохраните идентификатор сервисного аккаунта.

1. [Создайте авторизованные ключи доступа](../iam/operations/iam-token/create-for-sa#keys-create) к сервисному аккаунту и сохраните их.

1. Перейдите в свойства базы данных и сохраните значения эндпоинта и идентификатора базы, приведенные в поле **Эндпоинт**.

### Запустите тестовое приложение {#run-test}

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
  
      * SA_ENDPOINT — эндпоинт IAM, установите значение `iam.api.cloud.yandex.net:443`
      * SA_PRIVATE_KEY_FILE — путь к файлу с закрытым ключом
      * SA_ID — идентификатор сервисного аккаунта
      * SA_ACCESS_KEY_ID — идентификатор открытого авторизованного ключа
  
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
  
      * SA_ENDPOINT — эндпоинт IAM, установите значение `iam.api.cloud.yandex.net:443`
      * SA_PRIVATE_KEY_FILE — локальный путь к файлу с закрытым авторизованным ключом
      * SA_ID — идентификатор сервисного аккаунта
      * SA_ACCESS_KEY_ID — идентификатор открытого авторизованного ключа
  
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

  1. Установите [JDK 11](https://www.oracle.com/technetwork/java/javase/downloads/5066655), например:
  
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
