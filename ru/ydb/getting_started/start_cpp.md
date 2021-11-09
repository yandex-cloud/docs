# Разработка на C++

В этом разделе описана работа с помощью YDB C++ SDK.

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
Для демонстрации работы с SDK мы подготовили приложение [basic_example](https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/public/sdk/cpp/examples/basic_example). Чтобы успешно запустить [basic_example](https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/public/sdk/cpp/examples/basic_example) потребуется:

* база данных (подробно о создании и управлении базой данных написано в разделе ["Базы данных - создание и управление"](create_manage_database.md);
* endpoint базы данных (информация об endpoint доступна на странице Info [web-интерфейса](https://ydb.yandex-team.ru) вашей БД);
* [токен для аутентификации приложения](start_auth.md);
* [SDK](https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/public/sdk/cpp) (доступен в [Аркадии](https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/public/sdk/cpp));
* код приложения [basic_example](https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/public/sdk/cpp/examples/basic_example).

{% note info "Аутентификация" %}

Для аутентификации в YDB тестовое приложение использует токен из переменной окружения __YDB_TOKEN__.

{% endnote %}

После запуска и выполнения basic_example в консоли отобразится следующий результат:

<small>Листинг 1</small>
```bash
./basic_example -e ydb-ru.yandex.net:2135 -d /ru/home/yourlogin/mydb

> Describe table: series
Column, name: series_id, type: Uint64?
Column, name: title, type: Utf8?
Column, name: series_info, type: Utf8?
Column, name: release_date, type: Uint64?

> SelectSimple:
Series, Id: 1, Title: IT Crowd, Release date: 2006-02-03

> SelectWithParams:
Season, Title: Season 3, Series title: Silicon Valley
+Finished preparing query: PreparedSelectTransaction

> PreparedSelect:
Episode 7, Title: To Build a Better Beta, Air date: Sun Jun 05, 2016

> PreparedSelect:
Episode 8, Title: Bachman's Earnings Over-Ride, Air date: Sun Jun 12, 2016

> MultiStep:
Episode 1, Season: 5, Title: Grow Fast or Die Slow, Air date: Sun Mar 25, 2018
Episode 2, Season: 5, Title: Reorientation, Air date: Sun Apr 01, 2018
Episode 3, Season: 5, Title: Chief Operating Officer, Air date: Sun Apr 08, 2018

> PreparedSelect:
Episode 1, Title: TBD, Air date: Fri Sep 21, 2018

```

Для взаимодействия с YDB необходимо создать экземпляр драйвера, клиента и сессии:

* драйвер YDB отвечает за взаимодействие приложения и YDB на транспортном уровне;
* клиент YDB работает поверх драйвера YDB и отвечает за работу с сущностями и транзакциями;
* сессия YDB содержит информацию о выполняемых транзакциях и подготовленных запросах и содержится в контексте клиента YDB.

## Инициализация драйвера
Драйвер отвечает за взаимодействие приложения и YDB на транспортном уровне. Драйвер должен существовать на всем протяжении жизненного цикла работы с YDB. Перед тем как создать клиента YDB, и, установить сессию, необходимо инициализировать драйвер YDB.  Фрагмент кода basic_example, представленный в листинге 2, демонстрирует инициализацию драйвера параметрами соединения с БД.

<small>Листинг 2</small>
```c++
    auto connectionParams = TConnectionsParams()
        .SetEndpoint(endpoint)
        .SetDatabase(database)
        .SetAuthToken(GetEnv("YDB_TOKEN"));

    TDriver driver(connectionParams);
```

## Инициализация клиента и сессии YDB
Клиент отвечает за работу с сущностями YDB. Сессия содержит информацию о выполняемых транзакциях и подготовленных запросах.
В листинге 3 приведен фрагмент кода basic_example для создания клиента.

<small>Листинг 3</small>
```c++
    TClient client(driver);
```

## Создание таблиц с помощью CrеateTable API
Для создания таблиц можно использовать метод CreateTable.
В листинге 4 представлен фрагмент кода basic_example описания таблицы series с помощью TTableBuilder и ее создания с помощью метода CreateTable.

<small>Листинг 4</small>
```c++
//! Creates sample tables with CrateTable API.
    ThrowOnError(client.RetryOperationSync([path](TSession session) {
        auto seriesDesc = TTableBuilder()
            .AddNullableColumn("series_id", EPrimitiveType::Uint64)
            .AddNullableColumn("title", EPrimitiveType::Utf8)
            .AddNullableColumn("series_info", EPrimitiveType::Utf8)
            .AddNullableColumn("release_date", EPrimitiveType::Uint64)
            .SetPrimaryKeyColumn("series_id")
            .Build();

        return session.CreateTable(JoinPath(path, "series"), std::move(seriesDesc)).GetValueSync();
    }));
```

С помощью метода DescribeTable можно вывести информацию о структуре таблицы и убедиться, что она успешно создалась. Фрагмент кода basic_example в листинге 5 демонстрирует вывод информации о структуре таблицы, полученной с помощью метода DescribeTable.

<small>Листинг 5</small>
```c++
    TMaybe<TTableDescription> desc;

    ThrowOnError(client.RetryOperationSync([path, name, &desc](TSession session) {
        auto result = session.DescribeTable(JoinPath(path, name)).GetValueSync();

        if (result.IsSuccess()) {
            desc = result.GetTableDescription();
        }

        return result;
    }));

    Cout << "> Describe table: " << name << Endl;
    for (auto& column : desc->GetColumns()) {
        Cout << "Column, name: " << column.Name << ", type: " << FormatType(column.Type) << Endl;
    }
```

Фрагмент кода basic_example, приведенный в листинге 5, при запуске выводит на консоль текст:

<small>Листинг 6</small>
```bash
> Describe table: series
Column, name: series_id, type: Uint64?
Column, name: title, type: Utf8?
Column, name: series_info, type: Utf8?
Column, name: release_date, type: Uint64?
```

{% note info "PRAGMA TablePathPrefix" %}

Добавляет указанный префикс к путям таблиц внутри БД. Работает по принципу объединения путей в файловой системе: поддерживает ссылки на родительский каталог и не требует добавления слеша справа. Например, `PRAGMA TablePathPrefix = "/ru/tutorial/home/testdb"; SELECT * FROM Episodes;`. Подробнее о PRAGMA YQL написано в [документации YQL](https://yql.yandex-team.ru/docs/ydb/syntax/pragma/).

{% endnote %}

## Обработка запросов и транзакций

Для выполнения YQL запросов используется метод ExecuteDataQuery.
SDK позволяет в явном виде контролировать выполнение транзакций и настраивать необходимый режим выполнения транзакций с помощью класса TTxControl.

В фрагменте кода basic_example, приведенного в листинге 7, транзакция начинается методом ```TTxControl::BeginTx```. С помощью ```TTxSettings``` устанавливается режим выполнения транзакции ```SerializableRW```. После завершения всех запросов транзакции она будет автоматически завершена явным указанием: ```CommitTx()```. Запрос ```query```, описанный с помощью синтаксиса YQL, передается методу ```ExecuteDataQuery``` для выполнения.

<small>Листинг 7</small>
```c++
//! Shows basic usage of YDB data queries and transactions.
static TStatus SelectSimpleTransaction(TSession session, const TString& path,
    TMaybe<TResultSet>& resultSet)
{
    auto query = Sprintf(R"(
        PRAGMA TablePathPrefix("%s");

        SELECT series_id, title, DateTime::ToDate(DateTime::FromDays(release_date)) AS release_date
        FROM series
        WHERE series_id = 1;
    )", path.c_str());

    auto txControl =
        // Begin new transaction with SerializableRW mode
        TTxControl::BeginTx(TTxSettings::SerializableRW())
        // Commit transaction at the end of the query
        .CommitTx();

    // Executes data query with specified transaction control settings.
    auto result = session.ExecuteDataQuery(query, txControl).GetValueSync();

    if (result.IsSuccess()) {
        // Index of result set corresponds to its order in YQL query
        resultSet = result.GetResultSet(0);
    }

    return result;
}
```

## Обработка результатов выполнения
Для обработки результатов выполнения запроса используется класс TResultSetParser.
Фрагмент кода basic_example в листинге 8 демонстрирует обработку результатов запроса с помощью объекта parser.

<small>Листинг 8</small>
```c++
    TResultSetParser parser(*resultSet);
    if (parser.TryNextRow()) {
        Cout << "> SelectSimple:" << Endl << "Series"
            << ", Id: " << parser.ColumnParser("series_id").GetOptionalUint64()
            << ", Title: " << parser.ColumnParser("title").GetOptionalUtf8()
            << ", Release date: " << parser.ColumnParser("release_date").GetOptionalString()
            << Endl;
    }
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
```c++
//! Shows basic usage of mutating operations.
static TStatus UpsertSimpleTransaction(TSession session, const TString& path) {
    auto query = Sprintf(R"(
        PRAGMA TablePathPrefix("%s");

        UPSERT INTO episodes (series_id, season_id, episode_id, title) VALUES
            (2, 6, 1, "TBD");
    )", path.c_str());

    return session.ExecuteDataQuery(query,
        TTxControl::BeginTx(TTxSettings::SerializableRW()).CommitTx()).GetValueSync();
}
```

## Параметризованные запросы

{% note warning "Использование параметров в запросах" %}

Настоятельно рекомендуется использовать только параметризованные запросы. Это позволяет БД выполнить подготовительную работу по разбору и оптимизации запроса один раз для нескольких запросов, отличающихся только значениями параметров.

{% endnote %}

Фрагмент кода в листинге 11 демонстрирует использование параметризованных запросов и ```GetParamsBuilder``` для формирования параметров и передачи их в ```ExecuteDataQuery```.

<small>Листинг 11</small>
```c++
//! Shows usage of parameters in data queries.
static TStatus SelectWithParamsTransaction(TSession session, const TString& path,
    ui64 seriesId, ui64 seasonId, TMaybe<TResultSet>& resultSet)
{
    auto query = Sprintf(R"(
        PRAGMA TablePathPrefix("%s");

        DECLARE $seriesId AS Uint64;
        DECLARE $seasonId AS Uint64;

        SELECT sa.title AS season_title, sr.title AS series_title
        FROM seasons AS sa
        INNER JOIN series AS sr
        ON sa.series_id = sr.series_id
        WHERE sa.series_id = $seriesId AND sa.season_id = $seasonId;
    )", path.c_str());

    // Type of parameter values should be exactly the same as in DECLARE statements.
    auto params = session.GetParamsBuilder()
        .AddParam("$seriesId")
            .Uint64(seriesId)
            .Build()
        .AddParam("$seasonId")
            .Uint64(seasonId)
            .Build()
        .Build();

    auto result = session.ExecuteDataQuery(
        query,
        TTxControl::BeginTx(TTxSettings::SerializableRW()).CommitTx(),
        std::move(params)).GetValueSync();

    if (result.IsSuccess()) {
        resultSet = result.GetResultSet(0);
    }

    return result;
}
```

Фрагмент кода basic_example, приведенный в листинге 11, при запуске выводит на консоль текст:

<small>Листинг 12</small>
```bash
> SelectWithParams:
Season, title: Season 3, series title: Silicon Valley
Finished preparing query: PreparedSelectTransaction
```

## Параметризованные подготовленные запросы

Параметризованные подготовленные запросы (prepared queries) - записываются в форме шаблона, в котором определенного вида имена заменяются конкретными параметрами при каждом выполнении запроса. Использование параметризованных запросов может улучшить производительность за счет сокращения частоты выполнения компиляции и перекомпиляции запросов, отличающихся только значениями параметров.

Фрагмент кода basic_example в листинге 13 демонстрирует возможность использования параметризованных подготовленных запросов. Подготовленный запрос хранится в контексте сесии. Проверить наличие подготовленного запроса в сессии можно с помощью метода ```GetPreparedQuery```. Если подготовленного запроса в контексте сессии еще не существует, его можно подготовить с помощью ```PrepareDataQuery```, и сохранить для использования в рамках текущей сессии с помощью ```AddPreparedQuery```.

<small>Листинг 13</small>
```c++
//! Shows usage of prepared queries.
static TStatus PreparedSelectTransaction(TSession session, const TString& path,
    ui64 seriesId, ui64 seasonId, ui64 episodeId, TMaybe<TResultSet>& resultSet)
{
    // Once prepared, query data is stored in the session and identified by QueryId.
    // Local query cache is used to keep track of queries, prepared in current session.
    auto query = Sprintf(R"(
        PRAGMA TablePathPrefix("%s");

        DECLARE $seriesId AS Uint64;
        DECLARE $seasonId AS Uint64;
        DECLARE $episodeId AS Uint64;

        SELECT *
        FROM episodes
        WHERE series_id = $seriesId AND season_id = $seasonId AND episode_id = $episodeId;
    )", path.c_str());

    // Prepare query or get result from query cache
    auto prepareResult = session.PrepareDataQuery(query).GetValueSync();
    if (!prepareResult.IsSuccess()) {
        return prepareResult;
    }

    if (!prepareResult.IsFromCache()) {
        Cerr << "+Finished preparing query: PreparedSelectTransaction" << Endl;
    }

    auto dataQuery = prepareResult.GetQuery();

    auto params = dataQuery.GetParamsBuilder()
        .AddParam("$seriesId")
            .Uint64(seriesId)
            .Build()
        .AddParam("$seasonId")
            .Uint64(seasonId)
            .Build()
        .AddParam("$episodeId")
            .Uint64(episodeId)
            .Build()
        .Build();

    auto result = dataQuery.Execute(TTxControl::BeginTx(TTxSettings::SerializableRW()).CommitTx(),
        std::move(params)).GetValueSync();

    if (result.IsSuccess()) {
        resultSet = result.GetResultSet(0);
    }

    return result;
}
```

Фрагмент кода basic_example, приведенный в листинге 13, при запуске выводит на консоль текст:

<small>Листинг 14</small>
```bash
> PreparedSelect:
Episode 7, title: To Build a Better Beta, Air date: Sun Jun 05, 2016
```

## Многошаговые транзакции с промежуточной обработкой данных на стороне клиента
Фрагмент кода basic_example в листинге 15 демонстрирует возможность использования многошаговых транзакций, состоящих из нескольких запросов. Между выполнением запросов допустимо выполнение работы кода клиентского приложения.

Первый шаг — подготовка и выполнение первого запроса:

<small>Листинг 15</small>
```c++
//! Shows usage of transactions consisting of multiple data queries with client logic between them.
static TStatus MultiStepTransaction(TSession session, const TString& path, ui64 seriesId, ui64 seasonId,
    TMaybe<TResultSet>& resultSet)
{
    auto query1 = Sprintf(R"(
        PRAGMA TablePathPrefix("%s");

        DECLARE $seriesId AS Uint64;
        DECLARE $seasonId AS Uint64;

        SELECT first_aired AS from_date FROM seasons
        WHERE series_id = $seriesId AND season_id = $seasonId;
    )", path.c_str());

    auto params1 = session.GetParamsBuilder()
        .AddParam("$seriesId")
            .Uint64(seriesId)
            .Build()
        .AddParam("$seasonId")
            .Uint64(seasonId)
            .Build()
        .Build();

    // Execute first query to get the required values to the client.
    // Transaction control settings don't set CommitTx flag to keep transaction active
    // after query execution.
    auto result = session.ExecuteDataQuery(
        query1,
        TTxControl::BeginTx(TTxSettings::SerializableRW()),
        std::move(params1)).GetValueSync();

    if (!result.IsSuccess()) {
        return result;
    }
```

Для продолжения работы в рамках текущей транзакции необходимо получить текущий transaction id:

<small>Листинг 16</small>
```c++
    // Get active transaction id
    auto tx = result.GetTransaction();

    TResultSetParser parser(result.GetResultSet(0));
    parser.TryNextRow();
    auto date = parser.ColumnParser("from_date").GetOptionalUint64();

    // Perform some client logic on returned values
    auto userFunc = [] (const TInstant fromDate) {
        return fromDate + TDuration::Days(15);
    };

    TInstant fromDate = TInstant::Days(*date);
    TInstant toDate = userFunc(fromDate);
```

Следующий шаг — создание следующего запроса, использующего результаты выполнения кода на стороне клиентского приложения:

<small>Листинг 17</small>
```c++
    // Construct next query based on the results of client logic
    auto query2 = Sprintf(R"(
        PRAGMA TablePathPrefix("%s");

        DECLARE $seriesId AS Uint64;
        DECLARE $fromDate AS Uint64;
        DECLARE $toDate AS Uint64;

        SELECT season_id, episode_id, title, air_date FROM episodes
        WHERE series_id = $seriesId AND air_date >= $fromDate AND air_date <= $toDate;
    )", path.c_str());

    auto params2 = session.GetParamsBuilder()
        .AddParam("$seriesId")
            .Uint64(seriesId)
            .Build()
        .AddParam("$fromDate")
            .Uint64(fromDate.Days())
            .Build()
        .AddParam("$toDate")
            .Uint64(toDate.Days())
            .Build()
        .Build();

    // Execute second query.
    // Transaction control settings continues active transaction (tx) and
    // commits it at the end of second query execution.
    result = session.ExecuteDataQuery(
        query2,
        TTxControl::Tx(*tx).CommitTx(),
        std::move(params2)).GetValueSync();

    if (result.IsSuccess()) {
        resultSet = result.GetResultSet(0);
    }

    return result;
}
```

Фрагмент кода basic_example, приведенный в листингах 15,16,17, при запуске выводит на консоль текст:

<small>Листинг 18</small>
```bash
> MultiStep:
Episode 1, Season: 5, title: Grow Fast or Die Slow, Air date: Sun Mar 25, 2018
Episode 2, Season: 5, title: Reorientation, Air date: Sun Apr 01, 2018
Episode 3, Season: 5, title: Chief Operating Officer, Air date: Sun Apr 08, 2018
```

## Явное использование вызовов [TCL](https://cloud.yandex.ru/docs/ydb/oss/public/develop/concepts/transaction) Begin/Commit

В большинстве случаев вместо явного использования TCL вызовов Begin и Commit лучше использовать параметры контроля транзакций в вызовах ExecuteDataQuery. Это позволит избежать лишних обращений к YDB и эффективней выполнять запросы. Фрагмент кода basic_example в листинге 19 демонстрирует явное использование вызовов ```BeginTransaction``` и ```tx.Commit()```

<small>Листинг 19</small>
```c++
// Show usage of explicit Begin/Commit transaction control calls.
// In most cases it's better to use transaction control settings in ExecuteDataQuery calls instead
// to avoid additional hops to YDB cluster and allow more efficient execution of queries.
static TStatus ExplicitTclTransaction(TSession session, const TString& path, const TInstant& airDate) {
    auto beginResult = session.BeginTransaction(TTxSettings::SerializableRW()).GetValueSync();
    if (!beginResult.IsSuccess()) {
        return beginResult;
    }

    // Get newly created transaction id
    auto tx = beginResult.GetTransaction();

    auto query = Sprintf(R"(
        PRAGMA TablePathPrefix("%s");

        DECLARE $airDate AS Date;

        UPDATE episodes SET air_date = DateTime::ToDays($airDate) WHERE title = "TBD";
    )", path.c_str());

    auto params = session.GetParamsBuilder()
        .AddParam("$airDate")
            .Date(airDate)
            .Build()
        .Build();

    // Execute data query.
    // Transaction control settings continues active transaction (tx)
    auto updateResult = session.ExecuteDataQuery(query,
        TTxControl::Tx(tx),
        std::move(params)).GetValueSync();

    if (!updateResult.IsSuccess()) {
        return updateResult;
    }

    // Commit active transaction (tx)
    return tx.Commit().GetValueSync();
}
```

## Обработка ошибок

Подробно об обработке ошибок написано в разделе ["Обработка ошибок в API"](../ydb-sdk/error_handling.md).
