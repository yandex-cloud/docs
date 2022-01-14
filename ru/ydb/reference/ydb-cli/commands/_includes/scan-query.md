---
sourcePath: core/reference/ydb-cli/commands/_includes/scan-query.md
---
# Выполнение скан запросов

Запуск запроса через [Scan Queries](../../../../concepts/scan_query.md) посредством YDB CLI осуществляется добавлением флага `-t scan` в команду `ydb table query execute`.

Выполните запрос к данным:

```bash
ydb table query execute -t scan \
  --query "SELECT season_id, episode_id, title \
  FROM episodes \
  WHERE series_id = 1 AND season_id > 1 \
  ORDER BY season_id, episode_id \
  LIMIT 3"
```

Где:

* `--query` — текст запроса.

Результат:

```text
┌───────────┬────────────┬──────────────────────────────┐
| season_id | episode_id | title                        |
├───────────┼────────────┼──────────────────────────────┤
| 2         | 1          | "The Work Outing"            |
├───────────┼────────────┼──────────────────────────────┤
| 2         | 2          | "Return of the Golden Child" |
├───────────┼────────────┼──────────────────────────────┤
| 2         | 3          | "Moss and the German"        |
└───────────┴────────────┴──────────────────────────────┘
```
