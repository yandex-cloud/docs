# Разработка на Java

В этом разделе описана работа с помощью {{ ydb-short-name }} Java SDK:

Вы узнаете как:

* инициализировать драйвер {{ ydb-short-name }};
* инициализировать клиент и сессию {{ ydb-short-name }};
* создавать таблицы с помощью CrеateTable API;
* читать данные и обрабатывать результаты их выполнения;
* записывать и изменять данные;
* использовать параметризованные запросы;
* использовать параметризованные подготовленные запросы;
* выполнять многошаговые транзакции;
* пользоваться в явном виде языком управления транзакциями;
* обрабатывать ошибки.

## Предварительные требования
Для демонстрации работы с SDK мы подготовили приложение [basic_example](https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/public/sdk/java/examples/src/main/java/com/yandex/ydb/examples/basic_example). Чтобы успешно запустить [basic_example](https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/public/sdk/java/examples/src/main/java/com/yandex/ydb/examples/basic_example) потребуется:

* база данных (подробно о создании и управлении базой данных написано в разделе ["Базы данных - создание и управление"](create_manage_database.md);
* endpoint базы данных (информация об endpoint доступна на странице Info [web-интерфейса](https://ydb.yandex-team.ru) вашей БД);
* [токен для аутентификации приложения](start_auth.md);
* [SDK](https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/public/sdk/java) (доступен в [Аркадии](https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/public/sdk/java));
* код приложения [basic_example](https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/public/sdk/java/examples).

{% note info "Аутентификация" %}

Для аутентификации в YDB тестовое приложение использует токен из переменной окружения __YDB_TOKEN__.

{% endnote %}

После запуска и выполнения basic_example в консоли отобразится следующий результат:

```bash
./run.sh -j java com.yandex.ydb.examples.basic_example.BasicExample -e ydb-ru.yandex.net:2135 -d /ru/home/yourlogin/mydb

--[ DescribeTables ]---------------------------------------
/ru/home/olegbondar/mydb1/series:
    series_id: Uint64? (PK)
    title: Utf8?
    series_info: Utf8?
    release_date: Uint64?

/ru/home/olegbondar/mydb1/seasons:
    series_id: Uint64? (PK)
    season_id: Uint64? (PK)
    title: Utf8?
    first_aired: Uint64?
    last_aired: Uint64?

/ru/home/olegbondar/mydb1/episodes:
    series_id: Uint64? (PK)
    season_id: Uint64? (PK)
    episode_id: Uint64? (PK)
    title: Utf8?
    air_date: Uint64?


--[ SelectSimple ]---------------------------------------
+-----------+------------------+--------------------+
| series_id |            title |       release_date |
+-----------+------------------+--------------------+
|   Some[1] | Some["IT Crowd"] | Some["2006-02-03"] |
+-----------+------------------+--------------------+

--[ SelectWithParams ]---------------------------------------
+------------------+------------------------+
|     season_title |           series_title |
+------------------+------------------------+
| Some["Season 3"] | Some["Silicon Valley"] |
+------------------+------------------------+
Finished preparing query: PreparedSelectTransaction

--[ PreparedSelect ]---------------------------------------
+-------------+------------+-----------+-----------+--------------------------------+
|    air_date | episode_id | season_id | series_id |                          title |
+-------------+------------+-----------+-----------+--------------------------------+
| Some[16957] |    Some[7] |   Some[3] |   Some[2] | Some["To Build a Better Beta"] |
+-------------+------------+-----------+-----------+--------------------------------+

--[ PreparedSelect ]---------------------------------------
+-------------+------------+-----------+-----------+--------------------------------------+
|    air_date | episode_id | season_id | series_id |                                title |
+-------------+------------+-----------+-----------+--------------------------------------+
| Some[16964] |    Some[8] |   Some[3] |   Some[2] | Some["Bachman's Earnings Over-Ride"] |
+-------------+------------+-----------+-----------+--------------------------------------+

--[ MultiStep ]---------------------------------------
+-----------+------------+---------------------------------+-------------+
| season_id | episode_id |                           title |    air_date |
+-----------+------------+---------------------------------+-------------+
|   Some[5] |    Some[1] |   Some["Grow Fast or Die Slow"] | Some[17615] |
|   Some[5] |    Some[2] |           Some["Reorientation"] | Some[17622] |
|   Some[5] |    Some[3] | Some["Chief Operating Officer"] | Some[17629] |
+-----------+------------+---------------------------------+-------------+

--[ PreparedSelect ]---------------------------------------
+-------------+------------+-----------+-----------+-------------+
|    air_date | episode_id | season_id | series_id |       title |
+-------------+------------+-----------+-----------+-------------+
| Some[17795] |    Some[1] |   Some[6] |   Some[2] | Some["TBD"] |
+-------------+------------+-----------+-----------+-------------+
```

Для взаимодействия с {{ ydb-short-name }} необходимо создать экземпляр драйвера, клиента и сессии:

* драйвер {{ ydb-short-name }} отвечает за взаимодействие приложения и {{ ydb-short-name }} на транспортном уровне;
* клиент {{ ydb-short-name }} работает поверх драйвера {{ ydb-short-name }} и отвечает за работу с сущностями и транзакциями;
* сессия {{ ydb-short-name }} содержит информацию о выполняемых транзакциях и подготовленных запросах и содержится в контексте клиента {{ ydb-short-name }}.

## Инициализация драйвера {#driver-init}
Драйвер отвечает за взаимодействие приложения и {{ ydb-short-name }} на транспортном уровне. Драйвер должен существовать на всем протяжении жизненного цикла работы с {{ ydb-short-name }}. Перед тем как создать клиента {{ ydb-short-name }} и установить сессию, необходимо инициализировать драйвер {{ ydb-short-name }}.  Фрагмент кода basic_example, представленный в листинге 2, демонстрирует инициализацию драйвера параметрами соединения с БД.

<small>Листинг 2</small>
```java
        RpcTransport transport = GrpcTransport.forEndpoint(args.endpoint, args.database)
            .withAuthProvider(new TokenAuthProvider(ydbToken))
            .build();

        try (TableService tableService = TableServiceBuilder.ownTransport(transport).build()) {
            String path = args.path == null ? args.database : args.path;
            try (App example = appFactory.newApp(tableService, path)) {
                example.run();
            } catch (Throwable t) {
                t.printStackTrace();
                System.exit(1);
            }
        } catch (Throwable t) {
            t.printStackTrace();
            System.exit(1);
        }
```

## Инициализация клиента и сессии {{ ydb-short-name }} {#client-session-init}
Клиент отвечает за работу с сущностями {{ ydb-short-name }}. Сессия содержит информацию о выполняемых транзакциях и подготовленных запросах.
В листинге 3 приведен фрагмент кода basic_example для создания клиента и сессии {{ ydb-short-name }}.

<small>Листинг 3</small>
```java
        tableClient = tableService.newTableClient();
        session = tableClient.createSession()
            .join()
            .expect("cannot create session");
```

## Создание таблиц с помощью CrеateTable API {#create-table-api}
Для создания таблиц можно использовать метод CreateTable.
В листинге 4 представлен фрагмент кода basic_example описания таблицы series с помощью TableDescription.newBuilder() и ее создания с помощью метода session.createTable().

<small>Листинг 4</small>
```java
    /**
     * Creates sample tables with CrateTable API.
     */
    private void createTables() {
        TableDescription seriesTable = TableDescription.newBuilder()
            .addNullableColumn("series_id", DataType.uint64())
            .addNullableColumn("title", DataType.utf8())
            .addNullableColumn("series_info", DataType.utf8())
            .addNullableColumn("release_date", DataType.uint64())
            .setPrimaryKey("series_id")
            .build();

        execute(session -> session.createTable(path + "/series", seriesTable).join());
    }
```

С помощью метода describeTable можно вывести информацию о структуре таблицы и убедиться, что она успешно создалась. Фрагмент кода basic_example в листинге 5 демонстрирует вывод информации о структуре таблицы, полученной с помощью метода session.describeTable().

<small>Листинг 5</small>
```java
    /**
     * Describes existing table.
     */
    private void describeTables() {
        System.out.println("\n--[ DescribeTables ]---------------------------------------");

        for (String tableName : new String[]{ "series", "seasons", "episodes" }) {
            String tablePath = path + '/' + tableName;
            TableDescription tableDesc = executeWithResult(session -> session.describeTable(tablePath).join());

            System.out.println(tablePath + ':');
            List<String> primaryKeys = tableDesc.getPrimaryKeys();
            for (TableColumn column : tableDesc.getColumns()) {
                boolean isPrimary = primaryKeys.contains(column.getName());
                System.out.println("    " + column.getName() + ": " + column.getType() + (isPrimary ? " (PK)" : ""));
            }
            System.out.println();
        }
    }
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

## Обработка запросов и транзакций {#query-processing}

Для выполнения YQL запросов используется метод executeDataQuery.
SDK позволяет в явном виде контролировать выполнение транзакций и настраивать необходимый режим выполнения транзакций с помощью класса TxControl.

В фрагменте кода basic_example, приведенного в листинге 7, транзакция выполняется с помощью метода ```session.executeDataQuery()```. Устанавливается режим выполнения транзакции ```TxControl txControl = TxControl.serializableRw().setCommitTx(true);``` и флаг автоматического завершения транзакции ```setCommitTx(true)```. Тело запроса описано с помощью синтаксиса YQL и как параметр передается методу ```executeDataQuery```.

<small>Листинг 7</small>
```java
    /**
     * Shows basic usage of YDB data queries and transactions.
     */
    private void selectSimple() {
        String query = String.format(
            "PRAGMA TablePathPrefix(\"%s\");\n" +
            "\n" +
            "SELECT series_id, title, DateTime::ToDate(DateTime::FromDays(release_date)) AS release_date\n" +
            "FROM series\n" +
            "WHERE series_id = 1;",
            path);

        // Begins new transaction with SerializableRW mode.
        TxControl txControl = TxControl.serializableRw().setCommitTx(true);

        // Executes data query with specified transaction control settings.
        DataQueryResult result = executeWithResult(session -> session.executeDataQuery(query, txControl).join());

        System.out.println("\n--[ SelectSimple ]---------------------------------------");
        // Index of result set corresponds to its order in YQL query.
        new TablePrinter(result.getResultSet(0)).print();
    }
```

## Обработка результатов выполнения {#results-processing}
В качестве результатов выполнения запроса возвращается result.getResultSet(0).
Фрагмент кода basic_example в листинге 8 демонстрирует вывод результатов запроса с помощью вспомогательного класса TablePrinter.

<small>Листинг 8</small>
```java
        System.out.println("\n--[ SelectSimple ]---------------------------------------");
        // Index of result set corresponds to its order in YQL query
        new TablePrinter(result.getResultSet(0)).print();
    }
```

Фрагмент кода basic_example, приведенный в листинге 8, при запуске выводит на консоль текст:

<small>Листинг 9</small>
```bash
--[ SelectSimple ]---------------------------------------
+-----------+------------------+--------------------+
| series_id |            title |       release_date |
+-----------+------------------+--------------------+
|   Some[1] | Some["IT Crowd"] | Some["2006-02-03"] |
+-----------+------------------+--------------------+
```

## Запросы на запись и изменение данных {#write-queries}

Фрагмент кода basic_example листинге 10 демонстрирует выполнение запроса на запись/изменение данных.

<small>Листинг 10</small>
```java
    /**
     * Shows basic usage of mutating operations.
     */
    private void upsertSimple() {
        String query = String.format(
            "PRAGMA TablePathPrefix(\"%s\");\n" +
            "\n" +
            "UPSERT INTO episodes (series_id, season_id, episode_id, title) VALUES\n" +
            "(2, 6, 1, \"TBD\");",
            path);

        // Begins new transaction with SerializableRW mode.
        TxControl txControl = TxControl.serializableRw().setCommitTx(true);

        // Executes data query with specified transaction control settings.
        execute(session -> session.executeDataQuery(query, txControl)
            .join()
            .toStatus());
    }
```

## Параметризованные запросы {#param-queries}

{% note warning "Использование параметров в запросах" %}

Настоятельно рекомендуется использовать только параметризованные запросы. Это позволяет БД выполнить подготовительную работу по разбору и оптимизации запроса один раз для нескольких запросов, отличающихся только значениями параметров.

{% endnote %}

Фрагмент кода в листинге 11 демонстрирует использование параметризованных запросов и класс ```Params``` для формирования параметров и передачи их методу ```executeDataQuery```.

<small>Листинг 11</small>
```java
    /**
     * Shows usage of parameters in data queries.
     */
    public void selectWithParams() {
        String query = String.format(
            "PRAGMA TablePathPrefix(\"%s\");\n" +
            "\n" +
            "DECLARE $seriesId AS Uint64;\n" +
            "DECLARE $seasonId AS Uint64;\n" +
            "\n" +
            "SELECT sa.title AS season_title, sr.title AS series_title\n" +
            "FROM seasons AS sa\n" +
            "INNER JOIN series AS sr\n" +
            "ON sa.series_id = sr.series_id\n" +
            "WHERE sa.series_id = $seriesId AND sa.season_id = $seasonId;",
            path);

        // Begins new transaction with SerializableRW mode.
        TxControl txControl = TxControl.serializableRw().setCommitTx(true);

        // Type of parameter values should be exactly the same as in DECLARE statements.
        Params params = Params.withUnknownTypes()
            .put("$seriesId", DataType.uint64(), DataValue.uint64(2))
            .put("$seasonId", DataType.uint64(), DataValue.uint64(3));

        DataQueryResult result = executeWithResult(session -> session.executeDataQuery(query, txControl, params).join());

        System.out.println("\n--[ SelectWithParams ]---------------------------------------");
        // Index of result set corresponds to its order in YQL query.
        new TablePrinter(result.getResultSet(0)).print();
    }
```

Фрагмент кода basic_example, приведенный в листинге 11, при запуске выводит на консоль текст:

<small>Листинг 12</small>
```bash
--[ SelectWithParams ]---------------------------------------
+------------------+------------------------+
|     season_title |           series_title |
+------------------+------------------------+
| Some["Season 3"] | Some["Silicon Valley"] |
+------------------+------------------------+
Finished preparing query: PreparedSelectTransaction
```

## Параметризованные подготовленные запросы

Параметризованные подготовленные запросы (prepared queries) записываются в форме шаблона, в котором определенного вида имена заменяются конкретными параметрами при каждом выполнении запроса. Использование параметризованных запросов может улучшить производительность за счет сокращения частоты выполнения компиляции и перекомпиляции запросов, отличающихся только значениями параметров.

Фрагмент кода basic_example в листинге 13 демонстрирует возможность использования параметризованных подготовленных запросов. Подготовленный запрос хранится в контексте сесии. Подготовленный запрос можно подготовить с помощью ```prepareDataQuery```.

<small>Листинг 13</small>
```java
    /**
     * Shows usage of prepared queries.
     */
    private void preparedSelect(long seriesId, long seasonId, long episodeId) {
        final String queryId = "PreparedSelectTransaction";

        // Once prepared, query data is stored in the session and identified by QueryId.
        // We keep a track of prepared queries available in current session to reuse them in
        // consecutive calls.

        PreparedQuery query = preparedQueries.get(queryId);
        if (query == null) {
            String queryText = String.format(
                "PRAGMA TablePathPrefix(\"%s\");\n" +
                "\n" +
                "DECLARE $seriesId AS Uint64;\n" +
                "DECLARE $seasonId AS Uint64;\n" +
                "DECLARE $episodeId AS Uint64;\n" +
                "\n" +
                "SELECT *\n" +
                "FROM episodes\n" +
                "WHERE series_id = $seriesId AND season_id = $seasonId AND episode_id = $episodeId;",
                path);

            // Prepares query and stores its QueryId for the current session.
            query = executeWithResult(session -> session.prepareDataQuery(queryText).join());
            System.out.println("Finished preparing query: " + queryId);

            preparedQueries.put(queryId, query);
        }

        Params params = query.newParams()
            .put("$seriesId", DataValue.uint64(seriesId))
            .put("$seasonId", DataValue.uint64(seasonId))
            .put("$episodeId", DataValue.uint64(episodeId));

        DataQueryResult result = query.execute(TxControl.serializableRw().setCommitTx(true), params)
            .join()
            .expect("prepared query failed");

        System.out.println("\n--[ PreparedSelect ]---------------------------------------");
        new TablePrinter(result.getResultSet(0)).print();
    }
```

Фрагмент кода basic_example, приведенный в листинге 13, при запуске выводит на консоль текст:

<small>Листинг 14</small>
```bash
--[ PreparedSelect ]---------------------------------------
+-------------+------------+-----------+-----------+--------------------------------------+
|    air_date | episode_id | season_id | series_id |                                title |
+-------------+------------+-----------+-----------+--------------------------------------+
| Some[16964] |    Some[8] |   Some[3] |   Some[2] | Some["Bachman's Earnings Over-Ride"] |
+-------------+------------+-----------+-----------+--------------------------------------+
```

## Многошаговые транзакции с промежуточной обработкой данных на стороне клиента {#multistep-transactions}
Фрагмент кода basic_example в листинге 15 демонстрирует возможность использования многошаговых транзакций, состоящих из нескольких запросов. Между выполнением запросов допустимо выполнение работы кода клиентского приложения.

Первый шаг — подготовка и выполнение первого запроса:

<small>Листинг 15</small>
```java
    public void multiStep() {
        final long seriesId = 2;
        final long seasonId = 5;

        final String txId;
        final Instant fromDate;
        final Instant toDate;

        {
            String query = String.format(
                "PRAGMA TablePathPrefix(\"%s\");\n" +
                "\n" +
                "DECLARE $seriesId AS Uint64;\n" +
                "DECLARE $seasonId AS Uint64;\n" +
                "\n" +
                "SELECT first_aired AS from_date FROM seasons\n" +
                "WHERE series_id = $seriesId AND season_id = $seasonId;",
                path);

            Params params = Params.withUnknownTypes()
                .put("$seriesId", DataType.uint64(), DataValue.uint64(seriesId))
                .put("$seasonId", DataType.uint64(), DataValue.uint64(seasonId));

            // Executes the first query to get the required values to the client.
            // Transaction control settings don't set CommitTx flag to keep transaction active
            // after query execution.
            TxControl txControl = TxControl.serializableRw();
            DataQueryResult result = executeWithResult(session -> session.executeDataQuery(query, txControl, params)
                .join());

            if (result.isEmpty()) {
                throw new IllegalStateException("empty result set");
            }
```

Для продолжения работы в рамках текущей транзакции необходимо получить текущий transaction id:

<small>Листинг 16</small>
```java
            ResultSetReader resultSet = result.getResultSet(0);
            resultSet.next();
            long firstAired = resultSet.getColumn(0).getUint64();

            // Performs some client logic on returned values.
            fromDate = Instant.EPOCH.plus(firstAired, ChronoUnit.DAYS);
            toDate = fromDate.plus(15, ChronoUnit.DAYS);

            // Gets active transaction id.
            txId = result.getTxId();
        }
```

Следующий шаг — создание следующего запроса, использующего результаты выполнения кода на стороне клиентского приложения:

<small>Листинг 17</small>
```java
        {
            // Constructs next query based on the results of client logic.
            String query = String.format(
                "PRAGMA TablePathPrefix(\"%s\");\n" +
                "\n" +
                "DECLARE $seriesId AS Uint64;\n" +
                "DECLARE $fromDate AS Uint64;\n" +
                "DECLARE $toDate AS Uint64;\n" +
                "\n" +
                "SELECT season_id, episode_id, title, air_date FROM episodes\n" +
                "WHERE series_id = $seriesId AND air_date >= $fromDate AND air_date <= $toDate;",
                path);

            Params params = Params.withUnknownTypes()
                .put("$seriesId", DataType.uint64(), DataValue.uint64(seriesId))
                .put("$fromDate", DataType.uint64(), DataValue.uint64(Duration.between(Instant.EPOCH, fromDate).toDays()))
                .put("$toDate", DataType.uint64(), DataValue.uint64(Duration.between(Instant.EPOCH, toDate).toDays()));

            // Executes second query.
            // Transaction control settings continues active transaction (tx) and
            // commits it at the end of second query execution.
            TxControl txControl = TxControl.id(txId).setCommitTx(true);
            DataQueryResult result = executeWithResult(session -> session.executeDataQuery(query, txControl, params)
                .join());

            System.out.println("\n--[ MultiStep ]---------------------------------------");
            // Index of result set corresponds to its order in YQL query.
            new TablePrinter(result.getResultSet(0)).print();
        }
    }
```

Фрагмент кода basic_example, приведенный в листингах 15,16,17, при запуске выводит на консоль текст:

<small>Листинг 18</small>
```bash
--[ MultiStep ]---------------------------------------
+-----------+------------+---------------------------------+-------------+
| season_id | episode_id |                           title |    air_date |
+-----------+------------+---------------------------------+-------------+
|   Some[5] |    Some[1] |   Some["Grow Fast or Die Slow"] | Some[17615] |
|   Some[5] |    Some[2] |           Some["Reorientation"] | Some[17622] |
|   Some[5] |    Some[3] | Some["Chief Operating Officer"] | Some[17629] |
+-----------+------------+---------------------------------+-------------+
```

## Явное использование вызовов TCL Begin/Commit

В большинстве случаев вместо явного использования [TCL](https://cloud.yandex.ru/docs/ydb/oss/public/develop/concepts/transactions) вызовов Begin и Commit лучше использовать параметры контроля транзакций в вызовах ExecuteDataQuery. Это позволит избежать лишних обращений к {{ ydb-short-name }} и эффективней выполнять запросы. Фрагмент кода basic_example в листинге 19 демонстрирует явное использование вызовов ```beginTransaction``` и ```transaction.commit()```

<small>Листинг 19</small>

```java
    /**
     * Shows usage of explicit Begin/Commit transaction control calls.
     * In most cases it's better to use transaction control settings in executeDataQuery calls instead of
     * avoiding additional hops to YDB cluster and allowing more efficient execution of queries.
     */
    private Status explicitTcl(Session session) {
        Result<Transaction> transactionResult = session.beginTransaction(TransactionMode.SERIALIZABLE_READ_WRITE)
            .join();
        if (!transactionResult.isSuccess()) {
            return transactionResult.toStatus();
        }

        Transaction transaction = transactionResult.expect("cannot begin transaction");
        String query = String.format(
            "PRAGMA TablePathPrefix(\"%s\");\n" +
            "DECLARE $airDate AS Date;\n" +
            "UPDATE episodes SET air_date = DateTime::ToDays($airDate) WHERE title = \"TBD\";",
            path);

        Params params = Params.withUnknownTypes()
            .put("$airDate", DataType.date(), DataValue.date(Instant.now()));

        // Executes data query.
        // Transaction control settings continues active transaction (tx).
        Result<DataQueryResult> updateResult = session.executeDataQuery(query, TxControl.id(transaction), params)
            .join();
        if (!updateResult.isSuccess()) {
            return updateResult.toStatus();
        }

        // Commits active transaction (tx).
        return transaction.commit().join();
    }
```

## Обработка ошибок {#error-handling}

Подробнее об обработке ошибок читайте в [документации](https://cloud.yandex.ru/docs/ydb/oss/public/reference/ydb-sdk/error_handling).
