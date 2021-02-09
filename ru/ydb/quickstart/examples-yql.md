# Работа с данными

После [создания базы данных](create-db.md) выполните базовые YQL-запросы: создайте таблицу, работайте с данными таблицы и удалите её. Вы можете использовать [консоль управления]({{ link-console-main }}) или [интерфейс командной строки (YDB CLI)](examples-ydb-cli.md).

{% note tip %}

Подробнее о синтаксисе YQL читайте в [Справочнике YQL](../yql/reference/overview.md).

{% endnote %}

## Перед началом работы { #before-work }

Чтобы успешно работать с базой данных, используя YDB CLI:

1. [Установите YDB CLI](examples-ydb-cli.md#how-to-install) — консольный клиент, для работы с {{ ydb-full-name }}.
1. Узнайте эндпоинт и путь для своей базы данных, для этого:

   {% list tabs %}
   
   - Консоль управления
   
    Чтобы узнать эндпоинт и путь для своей базы данных:
    1. Перейдите в [консоль управления]({{ link-console-main }}).
    1. Выберите нужный каталог и перейдите в сервис **{{ ydb-full-name }}**.
    1. Выберите базу данных, к которой планируете выполнять запросы.
    1. В меню слева перейдите в раздел **Обзор**.
    1. Значение эндпоинта указано в строке **Эндпоинт**. 
        * Пример значения параметра для Dedicated базы: `lb.etn01lrprvnlnhv8v5kj.ydb.mdb.yandexcloud.net:2135`. 
        * Пример значения параметра для Serverless базы: `ydb.serverless.yandexcloud.net:2135`. 
            Порт для эндпоинта по умолчанию `2135`, так что указывать в запросе `:2135` не обязательно.
    1. Полный путь к базе указан в строке **База данных**.  
        Пример значения параметра: `/ru-central1/b1g4ej5ju4rf5kelpk4b/etn01lrprvnlnhv8v5kj`.
   
   - CLI
   
     
     {% include [cli-install](../../_includes/cli-install.md) %}
     
     1. Посмотрите описание команды для получения списка баз данных:
   
        ```bash
        yc ydb database list --help
        ```
     1. Чтобы получить список баз данных в каталоге по умолчанию, выполните команду:
        
        ```bash
        yc ydb database list
        ```

        В результате в колонке `ENDPOINT` будет указан `эндпоинт` и база данных.

        ```bash
        +----------------------+----------+-------------+------------------------------------------------+---------------------+---------+
        |          ID          |   NAME   | DESCRIPTION |                    ENDPOINT                    |     CREATED AT      | STATUS  |
        +----------------------+----------+-------------+------------------------------------------------+---------------------+---------+
        | etn008v5oqsj8joktlvd | ydb-test |             | grpcs://<YDB эндпоинт>/?database=<база данных> | 2020-12-09 11:46:45 | RUNNING |
        +----------------------+----------+-------------+------------------------------------------------+---------------------+---------+
        ```   
        
      1.Сохраните значения `YDB эндпоинт` и базу данных, указанных в колонке `ENDPOINT`. Они потребуются для дальнейших запросов.

   
   {% endlist %}



1. Проверьте разрешение входящего трафика через порт 2135. Убедитесь, что в назначенной [группе безопасности](../../vpc/concepts/security-groups.md) существует соответствующее правило или добавьте его.
1. Используйте один из способов аутентификации, представленных в разделе [Аутентификация в YDB CLI](examples-ydb-cli.md#authentication). 
   
    Один из самых простых способов аутентификации — сохранить значение [OAuth-токена](../../iam/concepts/authorization/oauth-token.md) в переменную окружения YC_TOKEN. Для этого выполните команду:

    ```bash
    export YC_TOKEN=<OAuth-токен>
    ```

## Создание таблицы {#create-table}

Создайте новую таблицу в базе данных с помощью конструкции [CREATE TABLE](../yql/reference/syntax/create_table.md):

{% list tabs %}

- Консоль управления

  {% include [create-schema-via-console](../_includes/create-schema-via-console.md) %}

- CLI

  1. Если у вас еще нет интерфейса командной строки YDB CLI, [установите и инициализируйте его](examples-ydb-cli.md#how-to-install).
  
  1. Посмотрите описание команды для выполнения YQL запроса:

     ```bash
     ydb scripting yql --help
     ```

  1. Для создания таблицы выполните запрос:
     
     ```bash
     ydb -e grpcs://<YDB эндпоинт> -d <база данных> \
     scripting yql -s \
     'CREATE TABLE series
     (
         series_id Uint64,
         title Utf8,
         series_info Utf8,
         release_date Uint64,
         PRIMARY KEY (series_id)
     );'
     ```

  1. Посмотрите результат, выполнив команду:

     ```bash
     ydb -e grpcs://<YDB эндпоинт> -d <база данных> \
     scheme ls -l
     ```

     Результат:

     ```bash
     ┌───────┬─────────────────┬──────┬───────────────────────────────┬──────────┬─────────────┐
     | Type  | Owner           | Size | Created                       | Modified | Name        |
     ├───────┼─────────────────┼──────┼───────────────────────────────┼──────────┼─────────────┤
     | table | ajehdq76s7o8ike | 0 b  | Wed, 09 Dec 2020 14:53:25 MSK | Unknown  | series      |
     | dir   |                 |      |                               |          | .sys        |
     └───────┴─────────────────┴──────┴───────────────────────────────┴──────────┴─────────────┘
     ```

{% endlist %}

## Добавление строк {#replace-data}

Добавьте данные в таблицу, используя конструкцию [REPLACE INTO](../yql/reference/syntax/replace_into.md):

{% list tabs %}

- Консоль управления

  {% include [replace-data-via-console](../_includes/replace-data-via-console.md) %}

- CLI
  
  1. Если у вас еще нет интерфейса командной строки YDB CLI, [установите и инициализируйте его](examples-ydb-cli.md#how-to-install).
  1. Посмотрите описание команды для выполнения YQL запроса:

     ```bash
     ydb scripting yql --help
     ```
  1. Для добавления данных в таблицу выполните команду:
     
     ```bash
     ydb -e grpcs://<YDB эндпоинт> -d <база данных> \
     scripting yql -s \
     'REPLACE INTO series (series_id, title, release_date, series_info)
     VALUES
     (
         1,
         "IT Crowd",
         CAST(Date("2006-02-03") AS Uint64),
         "The IT Crowd is a British sitcom."
     ),
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
     );'
     ```
     
     В таблицу `series` будут добавлены новые строки, чтобы увидеть результат, далее вы можете [выбрать строки](../quickstart/examples-yql.md#select-data) из таблицы.


{% endlist %}


## Замена строк {#update-data}

Измените существующие данные в таблице, использую оператор [UPDATE](../yql/reference/syntax/update.md):

{% list tabs %}

- Консоль управления

  {% include [update-data-via-console](../_includes/update-data-via-console.md) %}

- CLI
  
  1. Если у вас еще нет интерфейса командной строки YDB CLI, [установите и инициализируйте его](examples-ydb-cli.md#how-to-install).
  1. Посмотрите описание команды для выполнения YQL запроса:

     ```bash
     ydb scripting yql --help
     ```
  1. Для изменения данных в таблице `series` выполните команду:

     ```bash
     ydb -e grpcs://<YDB эндпоинт> -d <база данных> \
     scripting yql -s \
     'UPDATE series
     SET series_info="Fake series updated"
     WHERE series_id = 3;'
     ```
     
     Чтобы увидеть результат, далее вы можете [выбрать строки](../quickstart/examples-yql.md#select-data) из таблицы.

{% endlist %}


## Удаление строк {#delete-data}

Удалите данные из таблицы с помощью оператора [DELETE](../yql/reference/syntax/delete.md):

{% list tabs %}

- Консоль управления

  {% include [delete-data-via-console](../_includes/delete-data-via-console.md) %}

- CLI
  
  1. Если у вас еще нет интерфейса командной строки YDB CLI, [установите и инициализируйте его](examples-ydb-cli.md#how-to-install).
  1. Посмотрите описание команды для выполнения YQL запроса:

     ```bash
     ydb scripting yql --help
     ```
  1. Для удаления данных в таблице `series` выполните команду:

     ```bash
     ydb -e grpcs://<YDB эндпоинт> -d <база данных> \
     scripting yql -s \
     'DELETE
     FROM series
     WHERE series_id = 3;'
     ```
     
     Данная команда удалит строки, в которых колонка `series_id` = 3. Чтобы увидеть результат, далее вы можете [выбрать строки](../quickstart/examples-yql.md#select-data) из таблицы.

{% endlist %}


## Выбор строк {#select-data}

Выберите данные из таблицы с помощью оператора [SELECT](../yql/reference/syntax/select.md):

{% list tabs %}

- Консоль управления

  {% include [select-data-via-console](../_includes/select-data-via-console.md) %}

- CLI

  1. Если у вас еще нет интерфейса командной строки YDB CLI, [установите и инициализируйте его](examples-ydb-cli.md#how-to-install).
  1. Посмотрите описание команды для выполнения YQL запроса:

     ```bash
     ydb scripting yql --help
     ```
  1. Для выборки данных из таблицы `series` выполните команду:

     ```bash
     ydb -e grpcs://<YDB эндпоинт> -d <база данных> \
     scripting yql -s \
     'SELECT series_id,
     title AS series_title,
     CAST (release_date AS Date) AS release_date
     FROM series;'
     ```

     В результате отобразятся данные таблицы:

     ```bash
     ┌───────────┬──────────────────┬──────────────┐
     | series_id | series_title     | release_date |
     ├───────────┼──────────────────┼──────────────┤
     | 1         | "IT Crowd"       | "2006-02-03" |
     ├───────────┼──────────────────┼──────────────┤
     | 2         | "Silicon Valley" | "2014-04-06" |
     └───────────┴──────────────────┴──────────────┘
     ```

{% endlist %}


## Удаление таблицы {#drop-table}

Удалите таблицу с помощью конструкции [DROP TABLE](../yql/reference/syntax/drop_table.md):

{% list tabs %}

- Консоль управления

  {% include [drop-table-via-console](../_includes/drop-table-via-console.md) %}

- CLI

  1. Если у вас еще нет интерфейса командной строки YDB CLI, [установите и инициализируйте его](examples-ydb-cli.md#how-to-install).
  1. Посмотрите описание команды для выполнения YQL запроса:

     ```bash
     ydb scripting yql --help
     ```
  1. Для удаления таблицы `series` выполните команду:

     ```bash
     ydb -e grpcs://<YDB эндпоинт> -d <база данных> \
     scripting yql -s \
     'DROP TABLE series;'
     ```

     Таблица будет удалена.


{% endlist %}
