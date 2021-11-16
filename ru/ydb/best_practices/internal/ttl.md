# Удаление устаревших данных с помощью вспомогательных таблиц

В разделе приведены рекомендации по организации удаления устаревших данных и представлены примеры реализации на языках [C++](https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/public/sdk/cpp/examples/ttl) и [Python](https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/public/sdk/python/examples/ttl).

Для эффективного удаления устаревших данных потребуется создать одну или несколько вспомогательных таблиц. В приложении TTL в качестве первичного ключа во вспомогательных таблицах используются столбцы ```timestamp``` (время записи) и ```doc_id``` (идентификатор строки из основной таблицы). В качестве первого элемента первичного ключа выступает столбец ```timestamp```. Вспомогательные таблицы будут использоваться для поиска устаревших строк по времени и последующего их удаления из основной таблицы по идентификатору строки. Использование нескольких вспомогательных таблиц позволяет масштабировать нагрузку при поиске и удалении устаревших строк.

Данные в основной таблице рекомендуется равномерно распределять по предопределенному количеству шардов для эффективного использования пропускной способности системы. Подробнее читайте в разделе [Загрузка больших объемов данных](batch_upload.md).

## Использование вспомогательных таблиц {#extra-tables}

Временные метки строк из основной таблицы и их идентификаторы следует записывать во вспомогательные таблицы. В приложении TTL используются вспомогательные таблицы с названиями ```expiration_queue_%``` (```expiration_queue_0```, ```expiration_queue_1```, ```expiration_queue_2```, ```expiration_queue_3```).

Фрагмент кода приложения TTL, представленный в листинге 1, демонстрирует создание вспомогательных таблиц ```expiration_queue_%```.

<small>Листинг 1</small>

```c++
    // Multiple ExpirationQueue tables allow to scale the load.
    // Each ExpirationQueue table can be handled by a dedicated worker.
    for (ui32 i = 0; i < EXPIRATION_QUEUE_COUNT; ++i) {
        ThrowOnError(client.RetryOperationSync([path, i](TSession session) {
            auto expirationDesc = TTableBuilder()
                .AddNullableColumn("timestamp", EPrimitiveType::Uint64)
                .AddNullableColumn("doc_id", EPrimitiveType::Uint64)
                .SetPrimaryKeyColumns({"timestamp", "doc_id"})
                .Build();

            return session.CreateTable(JoinPath(path, Sprintf("expiration_queue_%" PRIu32, i)),
                std::move(expirationDesc)).GetValueSync();
        }));
    }
```

### Равномерное распределение нагрузки на вспомогательные таблицы {#load-balance}

Рекомендуется равномерно распределять строки по вспомогательным таблицам ```expiration_queue_%```. Например, случайным образом выбирая вспомогательную таблицу для каждой строки.  Фрагмент кода приложения TTL, представленный в листинге 2, демонстрирует запись данных в основную таблицу ```documents```, и в одну из вспомогательных таблиц ```expiration_queue_%```, выбранную случайным образом.

<small>Листинг 2</small>

```c++
//! Insert or replaces a document.
static TStatus AddDocumentTransaction(TSession session, const TString& path,
    const TString& url, const TString& html, ui64 timestamp)
{
    // Add an entry to a random expiration queue in order to evenly distribute the load
    ui32 queue = rand() % EXPIRATION_QUEUE_COUNT;

    auto query = Sprintf(R"(
        PRAGMA TablePathPrefix("%s");

        DECLARE $url AS Utf8;
        DECLARE $html AS Utf8;
        DECLARE $timestamp AS Uint64;

        $doc_id = Digest::CityHash($url);

        REPLACE INTO documents
            (doc_id, url, html, timestamp)
        VALUES
            ($doc_id, $url, $html, $timestamp);

        REPLACE INTO expiration_queue_%u
            (timestamp, doc_id)
        VALUES
            ($timestamp, $doc_id);
    )", path.c_str(), queue);

    auto params = session.GetParamsBuilder()
        .AddParam("$url").Utf8(url).Build()
        .AddParam("$html").Utf8(html).Build()
        .AddParam("$timestamp").Uint64(timestamp).Build()
        .Build();

    return session.ExecuteDataQuery(
        query,
        TTxControl::BeginTx(TTxSettings::SerializableRW()).CommitTx(),
        std::move(params)).GetValueSync();
}
```

## Чтение данных из основной таблицы {#read-from-table}

Фрагмент кода приложения TTL, представленный в листинге 3, демонстрирует чтение по первичному ключу из основной таблицы.

<small>Листинг 3</small>

```c++
//! Reads document contents.
static TStatus ReadDocumentTransaction(TSession session, const TString& path,
    const TString& url, TMaybe<TResultSet>& resultSet)
{
    auto query = Sprintf(R"(
        PRAGMA TablePathPrefix("%s");

        DECLARE $url AS Utf8;

        $doc_id = Digest::CityHash($url);

        SELECT doc_id, url, html, timestamp
        FROM documents
        WHERE doc_id = $doc_id;
    )", path.c_str());

    auto params = session.GetParamsBuilder()
        .AddParam("$url").Utf8(url).Build()
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

## Удаление устаревших строк {#delete-deprecated-strings}

Рекомендуется выбирать подмножество строк из вспомогательной таблицы для последующего удаления. Фрагмент кода приложения TTL, представленный в листинге 4, демонстрирует выборку подмножества строк из вспомогательной таблицы.

<small>Листинг 4</small>

```c++
//! Reads a batch of entries from expiration queue
static TStatus ReadExpiredBatchTransaction(TSession session, const TString& path, const ui32 queue,
    const ui64 timestamp, const ui64 prevTimestamp, const ui64 prevDocId, TMaybe<TResultSet>& resultSet)
{
    auto query = Sprintf(R"(
        PRAGMA TablePathPrefix("%s");

        DECLARE $timestamp AS Uint64;
        DECLARE $prev_timestamp AS Uint64;
        DECLARE $prev_doc_id AS Uint64;
        DECLARE $prev_doc_id AS Uint64;

        $data = (
            SELECT *
            FROM expiration_queue_%u
            WHERE
                timestamp <= $timestamp
                AND
                timestamp > $prev_timestamp
            ORDER BY timestamp, doc_id
            LIMIT 100

            UNION ALL

            SELECT *
            FROM expiration_queue_%u
            WHERE
                timestamp = $prev_timestamp AND doc_id > $prev_doc_id
            ORDER BY timestamp, doc_id
            LIMIT 100
        );

        SELECT timestamp, doc_id
        FROM $data
        ORDER BY timestamp, doc_id
        LIMIT 100;
    )", path.c_str(), queue, queue);

    auto params = session.GetParamsBuilder()
        .AddParam("$timestamp").Uint64(timestamp).Build()
        .AddParam("$prev_timestamp").Uint64(prevTimestamp).Build()
        .AddParam("$prev_doc_id").Uint64(prevDocId).Build()
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

### Удаление данных из основной и вспомогательных таблиц {#delete-data}

Фрагмент кода приложения TTL, представленный в листинге 5, демонстрирует вызов метода ```DeleteDocumentWithTimestamp``` для удаления устаревших строк на основании данных, полученных из вспомогательных таблиц в листинге 4.

<small>Листинг 5</small>

```c++
void DeleteExpired(TTableClient client, const TString& path, const ui32 queue, const ui64 timestamp) {
    Cout << "> DeleteExpired from queue #" << queue << ":" << Endl;
    bool empty = false;
    ui64 lastTimestamp = 0;
    ui64 lastDocId = 0;
    while (!empty) {
        TMaybe<TResultSet> resultSet;
        ThrowOnError(client.RetryOperationSync([path, queue, timestamp, lastDocId, lastTimestamp, &resultSet] (TSession session) {
            return ReadExpiredBatchTransaction(session, path, queue, timestamp, lastTimestamp, lastDocId, resultSet);
        }));

        empty = true;
        TResultSetParser parser(*resultSet);
        while (parser.TryNextRow()) {
            empty = false;
            lastDocId  = *parser.ColumnParser("doc_id").GetOptionalUint64();
            lastTimestamp = *parser.ColumnParser("timestamp").GetOptionalUint64();
            Cout << " DocId: " << lastDocId << " Timestamp: " << lastTimestamp << Endl;

            ThrowOnError(client.RetryOperationSync([path, queue, lastDocId, lastTimestamp] (TSession session) {
                return DeleteDocumentWithTimestamp(session, path, queue, lastDocId, lastTimestamp);
            }));
        }
    }
    Cout << Endl;
}
```

Фрагмент кода приложения TTL, представленный в листинге 6, демонстрирует метод ```DeleteDocumentWithTimestamp```, в котором реализовано удаление строк из основной таблицы ```documents``` и из вспомогательных таблиц ```expiration_queue_%```.

<small>Листинг 6</small>

```c++
//! Deletes an expired document
static TStatus DeleteDocumentWithTimestamp(TSession session, const TString& path, const ui32 queue,
    const ui64 docId, const ui64 timestamp)
{
    auto query = Sprintf(R"(
        PRAGMA TablePathPrefix("%s");

        DECLARE $doc_id AS Uint64;
        DECLARE $timestamp AS Uint64;

        DELETE FROM documents
        WHERE doc_id = $doc_id AND timestamp = $timestamp;

        DELETE FROM expiration_queue_%u
        WHERE timestamp = $timestamp AND doc_id = $doc_id;
    )", path.c_str(), queue);

    auto params = session.GetParamsBuilder()
        .AddParam("$doc_id").Uint64(docId).Build()
        .AddParam("$timestamp").Uint64(timestamp).Build()
        .Build();

    auto result = session.ExecuteDataQuery(
        query,
        TTxControl::BeginTx(TTxSettings::SerializableRW()).CommitTx(),
        std::move(params)).GetValueSync();

    return result;
}
```
