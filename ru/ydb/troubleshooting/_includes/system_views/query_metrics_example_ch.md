---
sourcePath: overlay/troubleshooting/_includes/system_views/query_metrics_example_ch.md
---

  Топ-10 запросов за последние 6 часов по общему количеству записанных строк в минутном интервале

  ```sql
  SELECT
      SumUpdateRows,
      Count,
      QueryText,
      IntervalEnd
  FROM ydbTable('cluster', '/cluster/path/to/database', '.sys/query_metrics_one_minute')
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
  FROM ydbTable('cluster', '/cluster/path/to/database', '.sys/query_metrics_one_minute')
  WHERE SumReadBytes > 0
  ORDER BY IntervalEnd DESC, SumReadBytes DESC
  LIMIT 100
  ```