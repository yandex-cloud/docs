# Выполнение скан запросов

{% if audience == "external" %} Запуск запроса через [Scan Queries](../../oss/public/develop/concepts/scan_query.md) посредством {{ ydb-short-name }} CLI осуществляется добавлением флага `-t scan` в команду `{{ ydb-cli }} table query execute`. {% endif %}

Выполните запрос к данным:


```bash
{{ ydb-cli }} table query execute -t scan \
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
