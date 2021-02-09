# Получение плана запроса и AST 

Чтобы получить план запроса и абстрактного синтаксического дерева (AST):

```bash
ydb -e <эндпоинт> -d <база данных> table query explain -q "SELECT season_id, episode_id, title FROM episodes WHERE series_id = 1 AND season_id > 1 ORDER BY season_id, episode_id LIMIT 3" --ast
```

Результат команды:

```bash
Query plan:
{
    meta : {
        version : "0.1",
        type : query
    },
    tables : [
        {
            name : "/ru-central1/b1g4ej5ju4rf5kelpk4b/etn01lrprvnlnhv8v5kj/episodes",
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

Query AST:
(
(let $1 '('"/ru-central1/b1g4ej5ju4rf5kelpk4b/etn01lrprvnlnhv8v5kj/episodes" '"1" '"72075186224811560:11"))
(let $2 (Uint64 '"1"))
(let $3 '('"series_id" $2 $2))
(let $4 '('"season_id" $2 (Void)))
(let $5 '('"episode_id" (Void) (Void)))
(let $6 '('"ExcFrom" '"IncTo" $3 $4 $5))
(let $7 '('"episode_id" '"season_id" '"title"))
(let $8 (KiSelectRange '"db" $1 $6 $7 '('('"SkipNullKeys" '('"series_id" '"season_id")))))
(let $9 (Bool 'true))
(let $10 '($9 $9))
(let $11 (lambda '($15) '((Member $15 '"season_id") (Member $15 '"episode_id"))))
(let $12 (KiPartialSort $8 $10 $11))
(let $13 (Uint64 '"3"))
(let $14 (Sort (KiPartialTake $12 $13) $10 $11))
(return '('((Take $14 $13)) (List (ListType (VoidType)))))
)

```

## Анализ плана запроса {#analysis}

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

## Пример модификации запроса {#examples} 

Допустим, необходимо получить только первые сезоны всех сериалов. Тогда команда запроса будет выглядеть так:

```bash
{{ ydb-cli }} -e <эндпоинт> -d <база данных> table query explain -q "SELECT sa.title AS season_title, sr.title AS series_title, sr.series_id, sa.season_id FROM seasons AS sa INNER JOIN series AS sr ON sa.series_id = sr.series_id WHERE sa.season_id = 1"
```

Результат команды:

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
