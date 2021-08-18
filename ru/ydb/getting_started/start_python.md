# Разработка на Python

В этом разделе описана работа с помощью YDB Python SDK.

Вы узнаете как:

* инициализировать драйвер YDB;
* инициализировать клиент и сессию YDB;
* создавать таблицы с помощью CrеateTable API;
* читать данные и обрабатывать результаты их выполнения;
* записывать и изменять данные;
* использовать параметризованные запросы;
* использовать параметризованные подготовленные запросы;
* выполнять многошаговые транзакции;
* пользоваться в явном виде языком управления транзакциями;
* обрабатывать ошибки.

## Предварительные требования
Для демонстрации работы с SDK мы подготовили приложение [basic_example](https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/public/sdk/python/examples/basic_example_v1). Чтобы успешно запустить [basic_example](https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/public/sdk/python/examples/basic_example_v1) потребуется:

* база данных (подробно о создании и управлении базой данных написано в разделе ["Базы данных - создание и управление"](create_manage_database.md);
* endpoint базы данных (информация об endpoint доступна на странице Info [web-интерфейса](https://ydb.yandex-team.ru) вашей БД);
* [токен для аутентификации приложения](start_auth.md);
* SDK (доступен в [Аркадии](https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/public/sdk/python), или в [pypi](https://pypi.yandex-team.ru/dashboard/repositories/default/packages/ydb/));
* код приложения [basic_example](https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/public/sdk/python/examples/basic_example_v1).

{% note info "Аутентификация" %}

Для аутентификации в YDB тестовое приложение использует токен из переменной окружения __YDB_TOKEN__.

{% endnote %}

После запуска и выполнения basic_example в консоли отобразится следующий результат:

<small>Листинг 1</small>
```bash
./basic_example -e ydb-ru.yandex.net:2135 -d /ru/home/yourlogin/mydb

> describe table: series
('column, name:', 'series_id', ',', 'type_id: UINT64')
('column, name:', 'title', ',', 'type_id: UTF8')
('column, name:', 'series_info', ',', 'type_id: UTF8')
('column, name:', 'release_date', ',', 'type_id: UINT64')

> select_simple_transaction:
('series, id: ', 1L, ', title: ', u'IT Crowd', ', release date: ', '2006-02-03')

> select_prepared_transaction:
('episode title:', u'To Build a Better Beta', ', air date:', '2016-06-05')

> select_prepared_transaction:
('episode title:', u"Bachman's Earnings Over-Ride", ', air date:', '2016-06-12')

> explicit TCL call

> select_prepared_transaction:
('episode title:', u'TBD', ', air date:', '2018-09-11')
```

Для взаимодействия с YDB необходимо создать экземпляр драйвера, клиента и сессии:

* драйвер YDB отвечает за взаимодействие приложения и YDB на транспортном уровне;
* клиент YDB работает поверх драйвера YDB и отвечает за работу с сущностями и транзакциями;
* сессия YDB содержит информацию о выполняемых транзакциях и подготовленных запросах и содержится в контексте клиента YDB.

## Инициализация драйвера
Драйвер отвечает за взаимодействие приложения и YDB на транспортном уровне. Драйвер должен существовать на всем протяжении жизненного цикла работы с YDB. Перед тем как создать клиента YDB, и, установить сессию, необходимо инициализировать драйвер YDB.  Фрагмент кода basic_example, представленный в листинге 2, демонстрирует инициализацию драйвера параметрами соединения с БД.

<small>Листинг 2</small>
```python
    connection_params = ydb.DriverConfig(endpoint, database=database, auth_token=auth_token)
    try:
        driver = ydb.Driver(connection_params)
        driver.wait(timeout=5)
    except TimeoutError:
        raise RuntimeError("Connect failed to YDB")
```

## Инициализация клиента и сессии YDB
Клиент отвечает за работу с сущностями YDB. Сессия содержит информацию о выполняемых транзакциях и подготовленных запросах.
В листинге 3 приведен фрагмент кода basic_example для создания сессии.

<small>Листинг 3</small>
```python
    session = driver.table_client.session().create()
```

## Создание таблиц с помощью CrеateTable API
Для создания таблиц можно использовать метод create_table.
В листинге 4 представлен фрагмент кода basic_example описания таблицы series с помощью create_table.

<small>Листинг 4</small>
```python
    # Creating Series table
    session.create_table(
        os.path.join(path, 'series'),
        ydb.TableDescription()
        .with_column(ydb.Column('series_id', ydb.OptionalType(ydb.DataType.Uint64)))
        .with_column(ydb.Column('title', ydb.OptionalType(ydb.DataType.Utf8)))
        .with_column(ydb.Column('series_info', ydb.OptionalType(ydb.DataType.Utf8)))
        .with_column(ydb.Column('release_date', ydb.OptionalType(ydb.DataType.Uint64)))
        .with_primary_key('series_id')
    )
```

С помощью метода DescribeTable можно вывести информацию о структуре таблицы и убедиться, что она успешно создалась. Фрагмент кода basic_example в листинге 5 демонстрирует вывод информации о структуре таблицы, полученной с помощью метода describe_table.

<small>Листинг 5</small>
```python
    result = session.describe_table(os.path.join(path, name))
    print("\n> describe table: series")
    for column in result.columns:
        print("column, name:", column.name, ",", str(column.type.optional_type.item).strip())
```

Фрагмент кода basic_example, приведенный в листинге 5, при запуске выводит на консоль текст:

<small>Листинг 6</small>
```bash
> describe table: series
('column, name:', 'series_id', ',', 'type_id: UINT64')
('column, name:', 'title', ',', 'type_id: UTF8')
('column, name:', 'series_info', ',', 'type_id: UTF8')
('column, name:', 'release_date', ',', 'type_id: UINT64')
```

{% note info "PRAGMA TablePathPrefix" %}

Добавляет указанный префикс к путям таблиц внутри БД. Работает по принципу объединения путей в файловой системе: поддерживает ссылки на родительский каталог и не требует добавления слеша справа. Например, `PRAGMA TablePathPrefix = "/ru/tutorial/home/testdb"; SELECT * FROM Episodes;`. Подробнее о PRAGMA YQL написано в [документации YQL](https://yql.yandex-team.ru/docs/ydb/syntax/pragma/).

{% endnote %}

## Обработка запросов и транзакций

Для выполнения YQL запросов используется метод session.transaction().execute()
SDK позволяет в явном виде контролировать выполнение транзакций и настраивать необходимый режим выполнения транзакций с помощью класса TTxControl.

В фрагменте кода basic_example, приведенного в листинге 7, транзакция выполняется с помощью метода ```transaction().execute()```. Устанавливается режим выполнения транзакции ```ydb.SerializableReadWrite()```. После завершения всех запросов транзакции она будет автоматически завершена с помощью явного указания флага: ```commit_tx=True```. Тело запроса описано с помощью синтаксиса YQL и как параметр передается методу ```execute```.

<small>Листинг 7</small>
```python
def select_simple(session, path):
    # new transaction in serializable read write mode
    # if query successfully completed you will get result sets.
    # otherwise exception will be raised
    result_sets = session.transaction(ydb.SerializableReadWrite()).execute(
        """
        PRAGMA TablePathPrefix("{}");
        SELECT series_id, title, DateTime::ToDate(DateTime::FromDays(release_date)) AS release_date
        FROM series
        WHERE series_id = 1;
        """.format(path),
        commit_tx=True,
    )
    print("\n> select_simple_transaction:")
    for row in result_sets[0].rows:
        print("series, id: ", row.series_id, ", title: ", row.title, ", release date: ", row.release_date)

    return result_sets[0]
```

## Обработка результатов выполнения
В качестве результатов выполнения запроса возвращается result_set.
Фрагмент кода basic_example в листинге 8 демонстрирует вывод результатов запроса.

<small>Листинг 8</small>
```python
    for row in result_sets[0].rows:
        print("series, id: ", row.series_id, ", title: ", row.title, ", release date: ", row.release_date)
```

Фрагмент кода basic_example, приведенный в листинге 8, при запуске выводит на консоль текст:

<small>Листинг 9</small>
```bash
> SelectSimple:
series, Id: 1, title: IT Crowd, Release date: 2006-02-03
```

## Запросы на запись и изменение данных

Фрагмент кода basic_example листинге 10 демонстрирует выполнение запроса на запись/изменение данных.

<small>Листинг 10</small>
```python
def upsert_simple(session, path):
    session.transaction().execute(
        """
        PRAGMA TablePathPrefix("{}");
        UPSERT INTO episodes (series_id, season_id, episode_id, title) VALUES
            (2, 6, 1, "TBD");
        """.format(path),
        commit_tx=True,
    )
```

## Параметризованные подготовленные запросы

Параметризованные подготовленные запросы (prepared queries) - записываются в форме шаблона, в котором определенного вида имена заменяются конкретными параметрами при каждом выполнении запроса. Использование параметризованных запросов может улучшить производительность за счет сокращения частоты выполнения компиляции и перекомпиляции запросов, отличающихся только значениями параметров.

Фрагмент кода basic_example в листинге 12 демонстрирует возможность использования параметризованных подготовленных запросов. Подготовленный запрос хранится в контексте сесии.

<small>Листинг 12</small>
```python
def select_prepared(session, path, series_id, season_id, episode_id):
    query = """
    PRAGMA TablePathPrefix("{}");

    DECLARE $seriesId AS Uint64;
    DECLARE $seasonId AS Uint64;
    DECLARE $episodeId AS Uint64;

    SELECT title, DateTime::ToDate(DateTime::FromDays(air_date)) as air_date
    FROM episodes
    WHERE series_id = $seriesId AND season_id = $seasonId AND episode_id = $episodeId;
    """.format(path)

    prepared_query = session.prepare(query)
    result_sets = session.transaction(ydb.SerializableReadWrite()).execute(
        prepared_query, {
            '$seriesId': series_id,
            '$seasonId': season_id,
            '$episodeId': episode_id,
        },
        commit_tx=True
    )
    print("\n> select_prepared_transaction:")
    for row in result_sets[0].rows:
        print("episode title:", row.title, ", air date:", row.air_date)

    return result_sets[0]
```

Фрагмент кода basic_example, приведенный в листинге 12, при запуске выводит на консоль текст:

<small>Листинг 13</small>
```bash
> select_prepared_transaction:
('episode title:', u'To Build a Better Beta', ', air date:', '2016-06-05')
```

## Явное использование вызовов [TCL](../concepts/transactions.md) Begin/Commit

В большинстве случаев вместо явного использования TCL вызовов Begin и Commit лучше использовать параметры контроля транзакций в вызовах execute. Это позволит избежать лишних обращений к YDB и эффективней выполнять запросы. Фрагмент кода basic_example в листинге 14 демонстрирует явное использование вызовов ```transaction().begin()``` и ```tx.Commit()```

<small>Листинг 14</small>
```python
# Show usage of explicit Begin/Commit transaction control calls.
# In most cases it's better to use transaction control settings in session.transaction
# calls instead to avoid additional hops to YDB cluster and allow more efficient
# execution of queries.
def explicit_tcl(session, path, series_id, season_id, episode_id):
    query = """
    PRAGMA TablePathPrefix("{}");

    DECLARE $seriesId AS Uint64;
    DECLARE $seasonId AS Uint64;
    DECLARE $episodeId AS Uint64;

    UPDATE episodes
    SET air_date = DateTime::ToDays(DateTime::TimestampFromString("2018-09-11T15:15:59.373006Z"))
    WHERE series_id = $seriesId AND season_id = $seasonId AND episode_id = $episodeId;
    """.format(path)
    prepared_query = session.prepare(query)

    # Get newly created transaction id
    tx = session.transaction(ydb.SerializableReadWrite()).begin()

    # Execute data query.
    # Transaction control settings continues active transaction (tx)
    tx.execute(
        prepared_query, {
            '$seriesId': series_id,
            '$seasonId': season_id,
            '$episodeId': episode_id
        }
    )

    print("\n> explicit TCL call")

    # Commit active transaction(tx)
    tx.commit()
```

## Обработка ошибок

Подробно об обработке ошибок написано в разделе ["Обработка ошибок в API"](../ydb-sdk/error_handling.md)
