# Как начать работать с {{ ydb-short-name }}

*Сервис {{ ydb-short-name }} находится на [стадии Preview](../overview/concepts/launch-stages.md), доступ к сервису предоставляется по заявке.*

Начать работать с {{ ydb-short-name }} можно как из консоли управления Яндекс.Облаком, так и с помощью SDK:

* [Получить доступ к сервису](#before-you-begin).
* [Создать базу данных](#control-plane) в консоли управления.
* [Создать схему](#create-table), [внести](#replace-data) и [прочитать](#select-data) данные из консоли управления.
* [Запустить Python, Go или Java приложение](#run-test).

## Перед началом работы {#before-you-begin}

Доступ к сервису предоставляется по заявке. Чтобы оформить заявку:

1. Перейдите в [консоль управления](https://console.cloud.yandex.ru), нажмите кнопку **Войти** и введите логин и пароль от Яндекс.Паспорта. Если вы еще не зарегистрированы, нажмите **Зарегистрироваться** и следуйте инструкциям.

1. [На странице биллинга](https://console.cloud.yandex.ru/billing) убедитесь, что у вас подключен [платежный аккаунт](../billing/concepts/billing-account.md), и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../billing/quickstart/index.md#create_billing_account).

1. Если у вас еще нет каталога, [создайте его](../resource-manager/operations/folder/create.md).

1. Перейдите на [страницу сервиса](https://cloud.yandex.ru/services/ydb) и нажмите кнопку **Запросить доступ**.

1. Выберите облако, в котором планируете работать с сервисом, и нажмите кнопку **Отправить**. Как только заявка будет одобрена, на вашу электронную почту придет письмо с подтверждением.

1. Откройте письмо и нажмите кнопку **Начать тестирование**. Вы будете перенаправлены в [консоль Яндекс.Облака](https://console.cloud.yandex.ru/) и сможете начать работу с сервисом.

## Создать базу данных {#control-plane}

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

Чтобы создать базу данных, понадобится доступный вам каталог в Яндекс.Облаке. Если у вас уже есть каталог в Яндекс.Облаке, откройте страницу этого каталога в консоли управления. Если каталога еще нет, создайте его.

{% include [owner-warning](../_includes/iam/owner-warning.md) %}

Чтобы создать каталог:

{% include [create-folder](../_includes/create-folder.md) %}

Чтобы создать базу данных:

1. Выберите каталог, в котором нужно создать базу данных.

1. Выберите **{{ ydb-full-name }}** в списке сервисов.

    {% note alert %}

    {{ ydb-full-name }} находится на стадии закрытого Preview и появится в списке доступных ресурсов только после одобрения заявки.

    {% endnote %}

1. Нажмите кнопку **Создать базу данных**.

1. Настройте параметры базы в диалоговом окне:

    1. **Имя**. Имя базы данных регистрозависимое, должно начинаться с латинской буквы, дальше допустимы буквы латинского алфавита и цифры.

    1. **Вычислительные ресурсы**. Тип и количество [вычислительных ресурсов](concepts/databases.md#compute_units) — комбинаций CPU и оперативной памяти.

    1. **Группы хранения**. Тип и количество [групп хранения](concepts/databases.md#storage_groups) — комбинаций типов дисков и объема памяти.

1. В блоке **Сеть** добавьте сеть. Если [сети](../vpc/concepts/network.md#network) нет, создайте ее. У каждой сети должна быть как минимум одна [подсеть](../vpc/concepts/network.md#subnet).

1. Нажмите кнопку **Создать базу данных**.

1. Дождитесь запуска базы данных. В процессе создания база будет иметь статус *Provisioning*, а когда станет готова к использованию — статус сменится на *Running*.

{% endif %}

## Создать схему {#create-table}

После создания базы можно проверить выполнение YQL-запросов в консоли управления. Чтобы сделать запрос:

1. Выберите базу данных на главной странице.

1. Нажмите кнопку **SQL-запрос** в правом верхнем углу. Откроется страница **Корневая папка**. В поле **Запрос**  осуществляются запросы к базе данных.

{% if audience == "internal" %}

![Open YQL Kit](_assets/db_ui_open_yql_kit.png)

{% else if audience == "external" %}

{% endif %}

Чтобы начать работу с базой, создайте новую таблицу с помощью оператора [CREATE TABLE](yql/reference/syntax/create_table.md):

1. Добавьте в поле **Запрос** следующую инструкцию:

    ```
    CREATE TABLE series
    (
        series_id Uint64,
        title Utf8,
        series_info Utf8,
        release_date Uint64,
        PRIMARY KEY (series_id)
    );
    ```

{% if audience == "internal" %}

![New yql query](_assets/db_ui_yql_kit_panel.png)

{% endif %}

1. Нажмите кнопку **Выполнить**. Новая таблица *series* и имя владельца таблицы отобразятся в поле слева. Если навести курсор на таблицу и кликнуть на значок <svg viewBox="0 0 24 24" width="18" height="18" fill="#26a"><path id="icon.info" d="M11,9H13V7H11M12,20C7.59,20 4,16.41 4,12C4,7.59 7.59,4 12,4C16.41,4 20,7.59 20,12C20,16.41 16.41,20 12,20M12,2A10,10 0 0,0 2,12A10,10 0 0,0 12,22A10,10 0 0,0 22,12A10,10 0 0,0 12,2M11,17H13V11H11V17Z"></path></svg> справа от таблицы, в левом нижнем углу экрана отобразится схема таблицы.

    {% if audience == "internal" %}

    ![Run_сreate table](_assets/db_ui_run_create_table.png)

    {% endif %}

{% if audience == "internal" %}

![Table details](_assets/db_ui_table_details_kit.png)

{% endif %}

## Работа с данными {#replace-data}

Запишите новые данные в таблицу с помощью оператора [REPLACE](yql/reference/syntax/replace_into.md):

1. Добавьте в поле **Запрос** следующую инструкцию:

    ```
    REPLACE INTO series (series_id, title, release_date, series_info)
    VALUES
        (
            1,
            "IT Crowd",
            CAST(Date("2006-02-03") AS Uint64),
            "The IT Crowd is a British sitcom."),
        (
            2,
            "Silicon Valley",
            CAST(Date("2014-04-06") AS Uint64),
            "Silicon Valley is an American comedy television series."
        ),
        (
            3,
            "Fake series",
            CAST(Date("2018-09-11") AS Uint64),
            "Fake series for testing purposes."
        )
        ;
    ```

1. Нажмите кнопку **Выполнить**. Изменения отобразятся в левом нижнем углу экрана.

{% if audience == "internal" %}

![Table preview](_assets/db_ui_table_preview.png)

{% endif %}

### Заменить строки {#update-data}

Обновите существующие данные в таблице с помощью оператора [UPDATE](yql/reference/syntax/update.md):

1. Добавьте в поле **Запрос** следующую инструкцию:

    ```
    UPDATE series
    SET series_info="Fake series updated"
    WHERE
        series_id = 3
    ;
    ```

1. Нажмите кнопку **Выполнить**. Изменения отобразятся в левом нижнем углу экрана.

{% if audience == "internal" %}

![Update preview](_assets/db_ui_run_update.png)

{% endif %}

### Удалить строки {#delete-data}

Удалите данные из таблицы с помощью оператора [DELETE](yql/reference/syntax/delete.md):

1. Добавьте в поле **Запрос** следующую инструкцию:

    ```
    DELETE
    FROM series
    WHERE
        series_id = 3
    ;
    ```

1. Нажмите кнопку **Выполнить**. Изменения отобразятся в левом нижнем углу экрана.

{% if audience == "internal" %}

![Delete preview](_assets/db_ui_run_delete.png)

{% endif %}

## Прочитать данные {#select-data}

Прочитайте данные из таблицы с помощью оператора [SELECT](yql/reference/syntax/select.md):

1. Добавьте в поле **Запрос** следующую инструкцию:

    ```
    SELECT
        series_id,
        title AS series_title,
        DateTime::ToDate(DateTime::FromDays(release_date)) AS release_date
    FROM series;
    ```

1. Нажмите кнопку **Выполнить**. Изменения отобразятся в левом нижнем углу экрана.

{% if audience == "internal" %}

![Select from table](_assets/db_ui_run_select.png)

{% endif %}

## Удалить таблицу {#drop-table}

Удалите таблицу с помощью оператора [DROP TABLE](yql/reference/syntax/drop_table.md):

1. Добавьте в поле **Запрос** следующую инструкцию:

    ```
    DROP TABLE series;
    ```

1. Нажмите кнопку **Выполнить**. Таблица будет удалена.

## Запустить Python, Go или Java приложение {#sdk}

Чтобы запустить приложение, разработанное с помощью {{ ydb-short-name }} SDK для [Python](https://github.com/yandex-cloud/ydb-python-sdk), [Go](https://github.com/yandex-cloud/ydb-go-sdk) или [Java](https://github.com/yandex-cloud/ydb-java-sdk), получите данные для подключения к базе. Вы можете запустить тестовые приложение для знакомства с SDK.

{% note info %}

Подробный разбор кода тестовых приложений читайте в разделе [{#T}](getting_started/sdk.md).

{% endnote %}

### Подключиться к базе данных {#connect-to-db}

Чтобы подключиться к базе данных:

1. [Создайте виртуальную машину](../compute/operations/vm-create/create-linux-vm) в Яндекс.Облаке.

1. Сохраните публичный IP-адрес виртуальной машины. Для этого перейдите в свойства виртуальной машины или [воспользуйтесь интерфейсом командной строки](../compute/operations/vm-info/get-info#outside-instance).

1. Для аутентификации в базе данных [создайте сервисный аккаунт](../iam/operations/sa/create) и назначьте ему роли `viewer` и `editor`.

1. Перейдите в раздел **Сервисные аккаунты** своего каталога и выберите необходимый сервисный аккаунт в списке. Сохраните идентификатор сервисного аккаунта.

1. [Создайте авторизованные ключи доступа](../iam/operations/iam-token/create-for-sa#keys-create) к сервисному аккаунту и сохраните их.

1. Перейдите в свойства базы данных и сохраните значения эндпоинта и идентификатора базы, приведенные в поле **Эндпоинт**.

### Запустить тестовое приложение {#run-test}

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

## Что дальше {#what-is-next}

* Прочитайте [пошаговые инструкции по работе с {{ ydb-short-name }}](getting_started/index.md).
* Узнайте [рекомендации по работе с {{ ydb-short-name }}](best_practices/index.md).
* Пройдите [туториал по работе с {{ yql-short-name }}](yql/tutorial/overview.md).