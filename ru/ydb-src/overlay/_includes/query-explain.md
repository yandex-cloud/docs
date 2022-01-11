Основная секция плана запроса, `tables`, содержит информацию об обращениях к таблицам. Чтения описаны в разделе `reads`, а записи — в разделе `writes`. Ключевой характеристикой любого обращения к таблице является его тип. 

Типы чтения:

* **FullScan**. Полное сканирование таблицы. Читаются все записи на всех шардах.
* **Scan**. Читается определенный диапазон записей.
* **Lookup**. Чтение по ключу или префиксу ключа.
* **MultiLookup**. Множественные чтения по ключу или префиксу ключа. Данный тип обращения возможен, например, в JOIN'ах.

Типы записи:

* **Upsert**. Добавление одной записи.
* **MultiUpsert**. Добавление нескольких записей.
* **Erase**. Единичное удаление по ключу.
* **MultiErase**. Множественные удаления.

Рассмотрим план запроса из примера выше.
Параметр `lookup_by` показывает, по каким колонкам (ключу или префиксу ключа) выполняется чтение. 
Параметр `scan_by` показывает, по каким колонкам выполняется scan, то есть чтение всех записей в определенном диапазоне значений.
В `columns` перечислены колонки, значения которых будут вычитываться из таблицы. 
Раздел `Query AST` содержит представление на внутреннем языке miniKQL. Эта информация нужна разработчикам YDB для диагностики запроса.

##### Еще один пример 

Допустим, необходимо получить только первые сезоны всех сериалов. Тогда запрос будет выглядеть так:

```sql
SELECT sa.title AS season_title, sr.title AS series_title, sr.series_id, sa.season_id
FROM seasons AS sa INNER JOIN series AS sr ON sa.series_id = sr.series_id
WHERE sa.season_id = 1"
```

План запроса:

```bash
Query plan:
{
    meta : {
        version : "0.1",
        type : query
    },
    tables : [
        {
            name : "/ru-central1/b1g4ej5ju4rf5kelpk4b/etn01lrprvnlnhv8v5kj/seasons",
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
            name : "/ru-central1/b1g4ej5ju4rf5kelpk4b/etn01lrprvnlnhv8v5kj/series",
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