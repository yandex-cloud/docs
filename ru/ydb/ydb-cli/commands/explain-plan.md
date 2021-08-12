# Получение плана запроса

Получите план запроса:

```bash
{{ ydb-cli }} table query explain \
  -q "SELECT season_id, episode_id, title
  FROM episodes
  WHERE series_id = 1
  AND season_id > 1
  ORDER BY season_id, episode_id
  LIMIT 3"
```

Результат:

```text
Query plan:
{
    meta : {
        version : "0.1",
        type : query
    },
    tables : [
        {
            name : "/ru-central1/b1gia87mbaomkfvsleds/etn02j1mlm4vgjhij03e/episodes",
            reads : [
                {
                    type : Lookup,
                    lookup_by : [
                        "series_id (\"1\")"
                    ],
                    scan_by : [
                        "season_id (\"1\", +inf]",
                        episode_id
                    ],
                    columns : [
                        episode_id,
                        season_id,
                        title
                    ]
                }
            ]
        }
    ]
}
```

Основная секция плана запроса, `tables`, содержит информацию об обращениях к таблицам. Чтения описаны в разделе `reads`, а записи — в разделе `writes`. Ключевой характеристикой любого обращения к таблице является его тип.

Типы чтения:

* `FullScan` — полное сканирование таблицы. Читаются все записи на всех шардах.
* `Scan` — чтение определенного диапазона записей.
* `Lookup` — чтение по ключу или префиксу ключа.
* `MultiLookup` — множественные чтения по ключу или префиксу ключа. Данный тип обращения возможен, например, в JOIN'ах.

Типы записи:

* `Upsert` — добавление одной записи.
* `MultiUpsert` — добавление нескольких записей.
* `Erase` — единичное удаление по ключу.
* `MultiErase` — множественное удаление.

Рассмотрим план запроса из примера выше.
Параметр `lookup_by` показывает, по каким колонкам (ключу или префиксу ключа) выполняется чтение.
Параметр `scan_by` показывает, по каким колонкам выполняется чтение всех записей в определенном диапазоне значений.
В `columns` перечислены колонки, значения которых будут вычитываться из таблицы.

## Пример модификации запроса {#examples}

Измените запрос так, чтобы получить только первые сезоны всех сериалов:

```bash
{{ ydb-cli }} table query explain \
  -q "SELECT sa.title AS season_title, sr.title AS series_title, sr.series_id, sa.season_id 
  FROM seasons AS sa 
  INNER JOIN series AS sr ON sa.series_id = sr.series_id 
  WHERE sa.season_id = 1"
```

Результат:

```text
Query plan:
{
    meta : {
        version : "0.1",
        type : query
    },
    tables : [
        {
            name : "/ru-central1/b1gia87mbaomkfvsleds/etn02j1mlm4vgjhij03e/seasons",
            reads : [
                {
                    type : FullScan,
                    scan_by : [
                        series_id,
                        season_id
                    ],
                    columns : [
                        season_id,
                        series_id,
                        title
                    ]
                }
            ]
        },
        {
            name : "/ru-central1/b1gia87mbaomkfvsleds/etn02j1mlm4vgjhij03e/series",
            reads : [
                {
                    type : MultiLookup,
                    lookup_by : [
                        "series_id (expr)"
                    ],
                    columns : [
                        series_id,
                        title
                    ]
                }
            ]
        }
    ]
}
```

Из данного плана запроса следует, что для таблицы `seasons` будет выполнен `FullScan`, а для таблицы `series` — множественные чтения (тип обращения `MultiLookup`) по ключу `series_id` (lookup_by). А тип чтения `MultiLookup` и раздел `lookup_by` говорят о том, что для таблицы `series` будут выполнены множественные чтения по ключу `series_id`.
