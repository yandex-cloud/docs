# Системные таблицы

Для возможности внутренней интроспекции состояния базы данных пользователю предоставляется возможность осуществлять запросы в специальные служебные таблицы (system views). Эти таблицы доступны из корня дерева базы данных и используют системный префикс пути `.sys`.

{% if audience != "external" %}

Доступ к системным таблицам возможен через [ClickHouse over YDB](../getting_started/start_chydb.md) и через [аналитические запросы](../data_interfaces/scan_queries.md).

Для обращения к системным таблицам через ClickHouse over YDB следует использовать табличную функцию `ydbTable`, например: `ydbTable('/path/to/database', '.sys/system_view_name')`.

{% endif %}

В описаниях доступных полей далее по тексту колонка **Ключ** содержит индекс поля первичного ключа соответствующей таблицы.

{% if audience != "external" %}

{% note info %}

Поля с типами Timestamp и Interval при запросах через СlickHouse over YDB будут представлены типами Uint64 и Int64 (микросекунды) соответственно.

{% endnote %}

{% endif %}

----

## Партиции таблиц

* **partition_stats**

Системная таблица, предоставляющая детализированную информацию об отдельных партициях всех таблиц базы данных. Содержит информацию о моментальных метриках, таких как нагрузка на CPU или количество транзакций в полёте, а также кумулятивные счётчики операций различного характера над партицией (например, общее количество прочитанных строк). Предназначена в первую очередь для выявления различных неравномерностей в нагрузке на партицию таблицы или размерах данных партиции таблицы.

Структура таблицы:

| **Поле** | **Тип** | **Ключ** | **Значение** |
|---|---|---|---|
| OwnerId | Uint64 | 0 | Идентификатор скимшарда, обслуживающего таблицу
| PathId | Uint64 | 1 | Идентификатор пути в скимшарде
| PartIdx | Uint64 | 2 | Порядковый номер партиции
| DataSize | Uint64 | | Приблизительный размер партиции в байтах
| RowCount | Uint64 | | Приблизительное количество строк
| IndexSize | Uint64 | | Размер индекса партиции в таблетке
| CPUCores | Double | | Моментальное значение нагрузки на партицию (доля ядра)
| TabletId | Uint64 | | Идентификатор таблетки, обслуживающей партицию
| Path | Utf8 | | Полный путь к таблице
| NodeId | Uint32 | | Идентификатор ноды, на которой в данный момент обслуживается партиция
| StartTime | Timestamp | | Последний момент запуска таблетки, обслуживающей партицию
| AccessTime | Timestamp | | Последний момент чтения из партиции
| UpdateTime | Timestamp | | Последний момент записи в партицию
| RowReads | Uint64 | | Количество точечных чтений с момента старта таблетки партиции
| RowUpdates | Uint64 | | Количество записанных строк с момента старта
| RowDeletes | Uint64 | | Количество удалённых строк с момента старта
| RangeReads | Uint64 | | Количество чтений диапазонов строк с момента старта
| RangeReadRows | Uint64 | | Количество строк, прочитанных в диапазонах с момента старта
| InFlightTxCount | Uint64 | | Количество транзакций к партиции в моменте
| ImmediateTxCompleted | Uint64 | | Количество завершившихся одношардовых транзакций с момента старта
| CoordinatedTxCompleted | Uint64 | | Количество завершившихся координируемых транзакций с момента старта
| TxRejectedByOverload | Uint64 | | Количество транзакций, отменённых по причине слишком высокой нагрузки (с момента старта)
| TxRejectedByOutOfStorage | Uint64 | | Количество транзакций, отменённых из-за нехватки места (с момента старта)

Ограничения:

* кумулятивные поля (RowReads, RowUpdates и т.д.) хранят накопленные значения с момента последнего старта таблетки, обслуживающей партицию

Примеры:

{% if audience == "external" %}

Топ-5 самых загруженных партиций среди всех таблиц базы данных
```sql
SELECT
    Path,
    PartIdx,
    CPUCores
FROM `/path/to/database/.sys/partition_stats`
ORDER BY CPUCores DESC
LIMIT 5
```

Список таблиц базы с размерами и нагрузкой в моменте
```sql
SELECT
    Path,
    COUNT() as Partitions,
    SUM(RowCount) as Rows,
    SUM(DataSize) as Size,
    SUM(CPUCores) as CPU
FROM `/path/to/database/.sys/partition_stats`
GROUP BY Path
```

{% else %}

{% list tabs %}

- YQL

  Топ-5 самых загруженных партиций среди всех таблиц базы данных
  ```sql
  --!syntax_v1
  SELECT
      Path,
      PartIdx,
      CPUCores
  FROM `/path/to/database/.sys/partition_stats`
  ORDER BY CPUCores DESC
  LIMIT 5
  ```

  Список таблиц базы с размерами и нагрузкой в моменте
  ```sql
  --!syntax_v1
  SELECT
      Path,
      COUNT() as Partitions,
      SUM(RowCount) as Rows,
      SUM(DataSize) as Size,
      SUM(CPUCores) as CPU
  FROM `/path/to/database/.sys/partition_stats`
  GROUP BY Path
  ```

- ClickHouse over YDB

  Топ-5 самых загруженных партиций среди всех таблиц базы данных
  ```sql
  SELECT
      Path,
      PartIdx,
      CPUCores
  FROM ydbTable('/path/to/database', '.sys/partition_stats')
  ORDER BY CPUCores DESC
  LIMIT 5
  ```

  Список таблиц базы с размерами и нагрузкой в моменте
  ```sql
  SELECT
      Path,
      COUNT() as Partitions,
      SUM(RowCount) as Rows,
      SUM(DataSize) as Size,
      SUM(CPUCores) as CPU
  FROM ydbTable('/path/to/database', '.sys/partition_stats')
  GROUP BY Path
  ```

{% endlist %}

{% endif %}

----

## Топы запросов

* **top_queries_by_duration_one_minute**
* **top_queries_by_duration_one_hour**
* **top_queries_by_read_bytes_one_minute**
* **top_queries_by_read_bytes_one_hour**
* **top_queries_by_cpu_time_one_minute**
* **top_queries_by_cpu_time_one_hour**

Группа системных таблиц для анализа потока пользовательских запросов. Таблицы позволяют видеть ограниченную по времени историю запросов, разбитую на интервалы. В пределах одного интервала времени сохраняется топ-5 запросов по определённой характеристике. В настоящее время доступны минутные и часовые интервалы, а топ может быть построен по полному времени исполнения запроса (самые медленные), по количеству прочитанных из таблицы байт (самые широкие) и по общему затраченному процессорному времени (самые тяжёлые).

Различные запуски запроса с одним и тем же текстом дедуплицируются. Топ содержит информацию о конкретном запуске с максимальным значением соответствующей характеристики запроса в пределах одного временного интервала.

Поля, предоставляющие информацию о затраченном процессорном времени (...CPUTime), выражены в микросекундах.

Структура таблиц:

| **Поле** | **Тип** | **Ключ** | **Значение** |
|---|---|---|---|
| IntervalEnd | Timestamp | 0 | Момент закрытия минутного или часового интервала
| Rank | Uint32 | 1 | Ранг запроса в топе
| QueryText | Utf8 | | Текст запроса
| Duration | Interval | | Полное время исполнения запроса
| EndTime | Timestamp | | Момент окончания исполнения запроса
| Type | String | | Тип запроса ("data", "scan", "script")
| ReadRows | Uint64 | | Количество прочитанных строк
| ReadBytes | Uint64 | | Количество прочитанных байт
| UpdateRows | Uint64 | | Количество записанных строк
| UpdateBytes | Uint64 | | Количество записанных байт
| DeleteRows | Uint64 | | Количество удалённых строк
| Partitions | Uint64 | | Количество партиций таблиц, участвовавших в исполнении запроса
| UserSID | String | | Security ID пользователя
| ParametersSize | Uint64 | | Размер параметров запроса в байтах
| CompileDuration | Interval | | Длительность компиляции запроса
| FromQueryCache | Bool | | Использовался ли кэш подготовленных запросов
| CPUTime | Uint64 | | Общее процессорное время, использованное для исполнения запроса (микросекунды)
| ShardCount | Uint64 | | Количество шардов, участвующих в исполнении запроса
| SumShardCPUTime | Uint64 | | Общее процессорное время, затраченное в шардах
| MinShardCPUTime | Uint64 | | Минимальное процесорное время, затраченное в шардах
| MaxShardCPUTime | Uint64 | | Максимальное процессорное время, затраченное в шардах
| ComputeNodesCount | Uint64 | | Количество вычислительных нод, задействованных в исполнении запроса
| SumComputeCPUTime | Uint64 | | Общее процессорное время, затраченное в вычислительных нодах
| MinComputeCPUTime | Uint64 | | Минимальное процессорное время, затраченное в вычислительных нодах
| MaxComputeCPUTime | Uint64 | | Максимальное процессорное время, затраченное в вычислительных нодах
| CompileCPUTime | Uint64 | | Процессорное время, затраченное на компиляцию запроса
| ProcessCPUTime | Uint64 | | Процессорное время, затраченное на общую обработку запроса

Ограничения:

* текст запроса ограничен 4 килобайтами;
* таблицы с поминутными интервалами содержат историю за последние 6 часов;
* таблицы c почасовыми интервалами содержат историю за последние 2 недели

Примеры:

{% if audience == "external" %}

Топ запросов по времени выполнения за последнюю минуту, когда случались запросы

```sql
SELECT
    IntervalEnd,
    Rank,
    QueryText,
    Duration
FROM `/path/to/database/.sys/top_queries_by_duration_one_minute`
WHERE IntervalEnd = (
    SELECT
        MAX(IntervalEnd)
    FROM `/path/to/database/.sys/top_queries_by_duration_one_minute`
)
```

Запросы, прочитавшие больше всего байт, в разбивке по минутам

```sql
SELECT
    IntervalEnd,
    QueryText,
    ReadBytes,
    ReadRows,
    Partitions
FROM `/path/to/database/.sys/top_queries_by_read_bytes_one_minute`
WHERE Rank = 1
```

{% else %}

{% list tabs %}

- YQL

  Топ запросов по времени выполнения за последнюю минуту, когда случались запросы

  ```sql
  --!syntax_v1
  SELECT
      IntervalEnd,
      Rank,
      QueryText,
      Duration
  FROM `/path/to/database/.sys/top_queries_by_duration_one_minute`
  WHERE IntervalEnd = (
      SELECT
          MAX(IntervalEnd)
      FROM `/path/to/database/.sys/top_queries_by_duration_one_minute`
  )
  ```

  Запросы, прочитавшие больше всего байт, в разбивке по минутам

  ```sql
  --!syntax_v1
  SELECT
      IntervalEnd,
      QueryText,
      ReadBytes,
      ReadRows,
      Partitions
  FROM `/path/to/database/.sys/top_queries_by_read_bytes_one_minute`
  WHERE Rank = 1
  ```

- ClickHouse over YDB

  Топ запросов по времени выполнения за последнюю минуту, когда случались запросы

  ```sql
  SELECT
      IntervalEnd,
      Rank,
      QueryText,
      Duration
  FROM ydbTable('/path/to/database', '.sys/top_queries_by_duration_one_minute')
  WHERE IntervalEnd = (
      SELECT
          MAX(IntervalEnd)
      FROM ydbTable('/path/to/database', '.sys/top_queries_by_duration_one_minute')
  )
  ```

  Запросы, прочитавшие больше всего байт, в разбивке по минутам

  ```sql
  SELECT
      IntervalEnd,
      QueryText,
      ReadBytes,
      ReadRows,
      Partitions
  FROM ydbTable('/path/to/database', '.sys/top_queries_by_read_bytes_one_minute')
  WHERE Rank = 1
  ```

{% endlist %}

{% endif %}

----

## Подробная информация о запросах

* **query_metrics_one_minute**

Подробная информация о запросах, разбитая по минутным интервалам. Каждая строка таблицы содержит информацию о множестве случившихся за интервал запросов с одинаковым текстом. Поля таблицы предоставляют минимальное, максимальное и суммарное значение по каждой отслеживаемой характеристике звпроса. В пределах интервала запросы отсортированы по убыванию суммарного потраченного процессорного времени.

Структура таблицы:

| **Поле** | **Тип** | **Ключ** | **Значение** |
|---|---|---|---|
| IntervalEnd | Timestamp | 0 | Момент закрытия минутного или часового интервала
| Rank | Uint32 | 1 | Ранг запроса в пределах интервала (по полю SumCPUTime)
| QueryText | Utf8 | | Текст запроса
| Count | Uint64 | | Количество запусков запроса
| SumDuration | Interval | | Общая длительность запросов
| MinDuration | Interval | | Минимальная длительность запроса
| MaxDuration | Interval | | Иаксимальная длительность запроса
| SumCPUTime | Uint64 | | Общее затраченное процессорное время
| MinCPUTime | Uint64 | | Минимальное затраченное процессорное время
| MaxCPUTime | Uint64 | | Максимальное затраченное процессорное время
| SumReadRows | Uint64 | | Общее количество прочитанных строк
| MinReadRows | Uint64 | | Минимальное количество прочитанных строк
| MaxReadRows | Uint64 | | Максимальное количество прочитанных строк
| SumReadBytes | Uint64 | | Общее количество прочитанных байт
| MinReadBytes | Uint64 | | Минимальное количество прочитанных байт
| MaxReadBytes | Uint64 | | Максимальное количество прочитанных байт
| SumUpdateRows | Uint64 | | Общее количество записанных строк
| MinUpdateRows | Uint64 | | Минимальное количество записанных строк
| MaxUpdateRows | Uint64 | | Максимальное количество записанных строк
| SumUpdateBytes | Uint64 | | Общее количество записанных байт
| MinUpdateBytes | Uint64 | | Минимальное количество записанных байт
| MaxUpdateBytes | Uint64 | | Максимальное количество записанных байт
| SumDeleteRows | Uint64 | | Общее количество удалённых строк
| MinDeleteRows | Uint64 | | Минимальное количество удалённых строк
| MaxDeleteRows | Uint64 | | Максимальное количество удалённых строк

Ограничения:

* текст запроса ограничен 4 килобайтами;
* таблица содержит историю за последние 6 часов;
* в пределах интервала представлена информация о не более чем 256 различных запросах;
* статистика может быть неполной, если база испытывает сильную нагрузку

Примеры:

{% if audience == "external" %}

Топ-10 запросов за последние 6 часов по общему количеству записанных строк в минутном интервале

```sql
SELECT
    SumUpdateRows,
    Count,
    QueryText,
    IntervalEnd
FROM `/path/to/database/.sys/query_metrics_one_minute`
ORDER BY SumUpdateRows DESC LIMIT 10
```

Недавние запросы, прочитавшие больше всего байт за минуту

```sql
SELECT
    IntervalEnd,
    SumReadBytes,
    MinReadBytes,
    SumReadBytes / Count as AvgReadBytes,
    MaxReadBytes,
    QueryText
FROM `/path/to/database/.sys/query_metrics_one_minute`
WHERE SumReadBytes > 0
ORDER BY IntervalEnd DESC, SumReadBytes DESC
LIMIT 100
```

{% else %}

{% list tabs %}

- YQL

  Топ-10 запросов за последние 6 часов по общему количеству записанных строк в минутном интервале

  ```sql
  --!syntax_v1
  SELECT
      SumUpdateRows,
      Count,
      QueryText,
      IntervalEnd
  FROM `/path/to/database/.sys/query_metrics_one_minute`
  ORDER BY SumUpdateRows DESC LIMIT 10
  ```

  Недавние запросы, прочитавшие больше всего байт за минуту:

  ```sql
  --!syntax_v1
  SELECT
      IntervalEnd,
      SumReadBytes,
      MinReadBytes,
      SumReadBytes / Count as AvgReadBytes,
      MaxReadBytes,
      QueryText
  FROM `/path/to/database/.sys/query_metrics_one_minute`
  WHERE SumReadBytes > 0
  ORDER BY IntervalEnd DESC, SumReadBytes DESC
  LIMIT 100
  ```

- ClickHouse over YDB

  Топ-10 запросов за последние 6 часов по общему количеству записанных строк в минутном интервале

  ```sql
  SELECT
      SumUpdateRows,
      Count,
      QueryText,
      IntervalEnd
  FROM ydbTable('/path/to/database', '.sys/query_metrics_one_minute')
  ORDER BY SumUpdateRows DESC LIMIT 10
  ```

  Недавние запросы, прочитавшие больше всего байт за минуту

  ```sql
  SELECT
      IntervalEnd,
      SumReadBytes,
      MinReadBytes,
      SumReadBytes / Count AS AvgReadBytes,
      MaxReadBytes,
      QueryText
  FROM ydbTable('/path/to/database', '.sys/query_metrics_one_minute')
  WHERE SumReadBytes > 0
  ORDER BY IntervalEnd DESC, SumReadBytes DESC
  LIMIT 100
  ```

{% endlist %}

{% endif %}

----

## Замечания

Следует иметь в виду, что обращение к системным таблицам имеет скорее аналитический характер нагрузки, и поэтому частое обращение к ним в больших базах будет существенно расходовать системные ресурсы. Нагрузка порядка 1-2 rps вполне допустима.
