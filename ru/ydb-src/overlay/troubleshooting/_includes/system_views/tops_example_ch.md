
  Топ запросов по времени выполнения за последнюю минуту, когда случались запросы

  ```sql
  SELECT
      IntervalEnd,
      Rank,
      QueryText,
      Duration
  FROM ydbTable('cluster', '/cluster/path/to/database', '.sys/top_queries_by_duration_one_minute')
  WHERE IntervalEnd = (
      SELECT
          MAX(IntervalEnd)
      FROM ydbTable('cluster', '/cluster/path/to/database', '.sys/top_queries_by_duration_one_minute')
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
  FROM ydbTable('cluster', '/cluster/path/to/database', '.sys/top_queries_by_read_bytes_one_minute')
  WHERE Rank = 1
  ```