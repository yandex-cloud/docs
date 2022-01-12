---
sourcePath: overlay/getting_started/ydb_cli.md
---
# Использование консольного клиента YDB

В этом разделе описана работа с базой при помощи YDB CLI.

Вы узнаете, что нужно, чтобы приступить, а также как выполнять основные запросы при работе с базой через консольный клиент YDB.

## Предварительные требования
Чтобы успешно выполнить команду через YDB CLI, потребуется:

* база данных (подробно о создании и управлении базой данных написано в разделе ["Базы данных - создание и управление"](create_manage_database.md)).
Можно воспользоваться базой данных из примера - "/ru/tutorial/home/testdb/cli_demo" - она уже создана и доступна всем сотрудникам Яндекса;
* endpoint базы данных (информация об endpoint доступна на странице Info [web-интерфейса](https://ydb.yandex-team.ru) вашей БД);
* [токен для аутентификации](start_auth.md);
* [утилита ya](https://wiki.yandex-team.ru/yatool/distrib).

Есть 3 способа передачи токена в YDB CLI:

1. через опцию `--token-file` можно указать путь к файлу, в котором лежит токен;
2. хранить токен в переменной окружения YDB_TOKEN;
3. хранить токен в файле по умолчанию "~/.ydb/token".

## Примеры использования

### Проверка корректности аутентификации {#whoami}
Часто бывает полезно узнать, как вы представляетесь базе данных.
```bash
$ ydb -e ydb-ru.yandex.net:2135 -d /ru/tutorial/home/testdb --token-file ~/my_token discovery whoami -g
User SID: pnv1@staff

Group SIDs:
yandex@staff
allstaff@staff
...
```

В этом примере токен передается через опцию `--token-file`. Далее будем хранить его в переменной окружения YDB_TOKEN, чтобы уменьшить объем вводимого текста.

### Получение списка ендпоинтов для базы данных {#discovery_list}
```bash
$ ydb -e ydb-ru.yandex.net:2135 -d /ru/tutorial/home/testdb discovery list
grpc://ydb-ru-myt-1076.search.yandex.net:31061 [MYT]
```

### Листинг объектов по указанному пути
```bash
$ ydb -e ydb-ru.yandex.net:2135 -d /ru/tutorial/home/testdb scheme ls /ru/tutorial/home/testdb/cli_demo
episodes  seasons  series  some_directory
```

Посмотреть подробную информацию можно, добавив флаг `-l`:

```bash
$ ydb -e ydb-ru.yandex.net:2135 -d /ru/tutorial/home/testdb scheme ls cli_demo -l
┌───────┬────────────┬──────────┬───────────────────────────────┬───────────────────────────────┬────────────────┐
| Type  | Owner      | Size     | Created                       | Modified                      | Name           |
├───────┼────────────┼──────────┼───────────────────────────────┼───────────────────────────────┼────────────────┤
| table | pnv1@staff | 12.00 Kb | Mon, 03 Feb 2020 13:02:14 MSK | Mon, 03 Feb 2020 13:02:28 MSK | episodes       |
| table | pnv1@staff | 4.00 Kb  | Mon, 03 Feb 2020 13:02:13 MSK | Mon, 03 Feb 2020 13:02:28 MSK | seasons        |
| table | pnv1@staff | 4.00 Kb  | Mon, 03 Feb 2020 13:02:13 MSK | Mon, 03 Feb 2020 13:02:28 MSK | series         |
| dir   | pnv1@staff |          |                               |                               | some_directory |
└───────┴────────────┴──────────┴───────────────────────────────┴───────────────────────────────┴────────────────┘
```

Обратите внимание, что на этот раз был указан относительный путь от корня базы `cli_demo` вместо абсолютного путя от корня домена `/ru/tutorial/home/testdb/cli_demo`.
Также можно использовать опцию `-R` для рекурсивного листинга всех поддиректорий и объектов в них по указанному пути:

```bash
$ ydb -e ydb-ru.yandex.net:2135 -d /ru/tutorial/home/testdb scheme ls cli_demo -lR
┌───────┬────────────┬──────────┬───────────────────────────────┬───────────────────────────────┬───────────────────────────────┐
| Type  | Owner      | Size     | Created                       | Modified                      | Name                          |
├───────┼────────────┼──────────┼───────────────────────────────┼───────────────────────────────┼───────────────────────────────┤
| table | pnv1@staff | 12.00 Kb | Mon, 03 Feb 2020 13:02:14 MSK | Mon, 03 Feb 2020 13:02:28 MSK | episodes                      |
| table | pnv1@staff | 4.00 Kb  | Mon, 03 Feb 2020 13:02:13 MSK | Mon, 03 Feb 2020 13:02:28 MSK | seasons                       |
| table | pnv1@staff | 4.00 Kb  | Mon, 03 Feb 2020 13:02:13 MSK | Mon, 03 Feb 2020 13:02:28 MSK | series                        |
| dir   | pnv1@staff |          |                               |                               | some_directory                |
| dir   | pnv1@staff |          |                               |                               | some_directory/sub-directory1 |
| dir   | pnv1@staff |          |                               |                               | some_directory/sub-directory2 |
└───────┴────────────┴──────────┴───────────────────────────────┴───────────────────────────────┴───────────────────────────────┘
```

### Получение подробной информации об объектах схемы
На примере таблицы

```bash
$ ydb -e ydb-ru.yandex.net:2135 -d /ru/tutorial/home/testdb scheme describe cli_demo/episodes --stats
┌────────────┬─────────┬────────┬─────┐
| Name       | Type    | Family | Key |
├────────────┼─────────┼────────┼─────┤
| air_date   | Uint64? |        |     |
| episode_id | Uint64? |        | K2  |
| season_id  | Uint64? |        | K1  |
| series_id  | Uint64? |        | K0  |
| title      | Utf8?   |        |     |
└────────────┴─────────┴────────┴─────┘

Table stats:
Partitions count: 1
Approximate number of rows: 70
Approximate size of table: 12.00 Kb
Last modified: Mon, 03 Feb 2020 13:02:28 MSK
Created: Mon, 19 Jan 1970 10:05:24 MSK
```

### Выполнение запроса к базе
```bash
$ ydb -e ydb-ru.yandex.net:2135 -d /ru/tutorial/home/testdb table query execute -q "SELECT season_id, episode_id, title FROM `/ru/tutorial/home/testdb/cli_demo/episodes` WHERE series_id = 1 AND season_id > 1 ORDER BY season_id, episode_id LIMIT 3"
┌───────────┬────────────┬────────────────────────────────┐
| season_id | episode_id | title                          |
├───────────┼────────────┼────────────────────────────────┤
| [2u]      | [1u]       | ["The Work Outing"]            |
├───────────┼────────────┼────────────────────────────────┤
| [2u]      | [2u]       | ["Return of the Golden Child"] |
├───────────┼────────────┼────────────────────────────────┤
| [2u]      | [3u]       | ["Moss and the German"]        |
└───────────┴────────────┴────────────────────────────────┘
```

### Потоковое чтение таблицы
```bash
$ ydb -e ydb-ru.yandex.net:2135 -d /ru/tutorial/home/testdb table readtable cli_demo/episodes --ordered --limit 5 --columns series_id,season_id,episode_id,title
┌───────────┬───────────┬────────────┬─────────────────────────────────┐
| series_id | season_id | episode_id | title                           |
├───────────┼───────────┼────────────┼─────────────────────────────────┤
| [1u]      | [1u]      | [1u]       | ["Yesterday's Jam"]             |
├───────────┼───────────┼────────────┼─────────────────────────────────┤
| [1u]      | [1u]      | [2u]       | ["Calamity Jen"]                |
├───────────┼───────────┼────────────┼─────────────────────────────────┤
| [1u]      | [1u]      | [3u]       | ["Fifty-Fifty"]                 |
├───────────┼───────────┼────────────┼─────────────────────────────────┤
| [1u]      | [1u]      | [4u]       | ["The Red Door"]                |
├───────────┼───────────┼────────────┼─────────────────────────────────┤
| [1u]      | [1u]      | [5u]       | ["The Haunting of Bill Crouse"] |
└───────────┴───────────┴────────────┴─────────────────────────────────┘
```

`--limit` - ограничить количество читаемых записей;
`--ordered` - упорядочить читаемые записи по ключу;
`--columns` - колонки, значения которых следует читать (по умолчанию читаются все колонки) в формате csv.

Если нужно получить только количество прочитанных записей, следует использовать параметр `--count-only`:

```bash
$ ydb -e ydb-ru.yandex.net:2135 -d /ru/tutorial/home/testdb table readtable cli_demo/episodes --columns series_id --count-only
70
```

### Получение плана запроса и AST {#explain_plan}
```bash
$ ydb -e ydb-ru.yandex.net:2135 -d /ru/tutorial/home/testdb table query explain -q "SELECT season_id, episode_id, title FROM `/ru/tutorial/home/testdb/cli_demo/episodes` WHERE series_id = 1 AND season_id > 1 ORDER BY season_id, episode_id LIMIT 3" --ast
Query plan:
{
    meta : {
        version : "0.1",
        type : query
    },
    tables : [
        {
            name : "/ru/tutorial/home/testdb/cli_demo/episodes",
            reads : [
                {
                    type : Lookup,
                    lookup_by : [
                        "series_id (\"1\")",
                        "episode_id (expr)"
                    ],
                    scan_by : [
                        "season_id (\"1\", +inf)"
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
(let $1 (Uint64 '"1"))
(let $2 '('"series_id" $1 $1))
(let $3 '('"season_id" $1 (Void)))
(let $4 '('"episode_id" (Void) (Void)))
(let $5 '('"ExcFrom" '"IncTo" $2 $3 $4))
(let $6 '('"episode_id" '"season_id" '"title"))
(let $7 (KiSelectRange '"db" '"/ru/tutorial/home/testdb/cli_demo/episodes" $5 $6 '('('"SkipNullKeys" '('"series_id" '"season_id")))))
(let $8 (Bool 'true))
(let $9 '($8 $8))
(let $10 (lambda '($14) '((Member $14 '"season_id") (Member $14 '"episode_id"))))
(let $11 (KiPartialSort $7 $9 $10))
(let $12 (Uint64 '"3"))
(let $13 (Sort (KiPartialTake $11 $12) $9 $10))
(return '('((Take $13 $12)) (List (ListType (VoidType)))))
)
```

##### Анализ плана запроса
Основная секция плана запроса, `tables`, содержит информацию об обращениях к таблицам. Чтения описаны в разделе `reads`, а записи - в разделе `writes`. Ключевой характеристикой любого обращения к таблице является его тип. Типы чтения:

1. **FullScan**. Полное сканирование таблицы. Читаются все записи на всех шардах.
2. **Scan**. Читается определенный диапазон записей.
3. **Lookup**. Чтение по ключу или префиксу ключа.
4. **MultiLookup**. Множественные чтения по ключу или префиксу ключа. Данный тип обращения возможен, например, в JOIN'ах.

Типы записи:

1. **Upsert**. Добавление одной записи.
2. **MultiUpsert**. Добавление нескольких записей.
3. **Erase**. Единичное удаление по ключу.
4. **MultiErase**. Множественные удаления.

Рассмотрим план запроса из примера выше. Параметр `lookup_by` показывает, по каким колонкам (ключу или префиксу ключа) выполняется чтение. Параметр `scan_by` показывает, по каким колонкам выполняется scan, т.е. чтение всех записей в определенном диапазоне значений. В `columns` перечислены колонки, значения которых будут вычитываться из таблицы. Раздел `Query AST` содержит представление на внутреннем языке miniKQL. Эта информация нужна разработчикам YDB для диагностики запроса.

Рассмотрим еще один пример. Допустим, необходимо получить только первые сезоны всех сериалов.

```bash
$ ydb -e ydb-ru.yandex.net:2135 -d /ru/tutorial/home/testdb table query explain -q "SELECT sa.title AS season_title, sr.title AS series_title, sr.series_id, sa.season_id FROM `/ru/tutorial/home/testdb/cli_demo/seasons` AS sa INNER JOIN `/ru/tutorial/home/testdb/cli_demo/series` AS sr ON sa.series_id = sr.series_id WHERE sa.season_id = 1"
Query plan:
{
    meta : {
        version : "0.1",
        type : query
    },
    tables : [
        {
            name : "/ru/tutorial/home/testdb/cli_demo/series",
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
        },
        {
            name : "/ru/tutorial/home/testdb/cli_demo/seasons",
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
        }
    ]
}
```

Из данного плана запроса следует, что для таблицы `seasons` будет выполнен `FullScan`, а для таблицы `series` - множественные чтения (тип обращения `MultiLookup`) по ключу `series_id` (lookup_by). А тип чтения `MultiLookup` и раздел `lookup_by` говорят о том, что для таблицы `series` будут выполнены множественные чтения по ключу `series_id`.

##### Запуск операции добавления вторичного индекса

В YDB имеется механизм операций для процессов которые занимают долгое время, не требуют для своей работы учатия пользователя, но должны переживать разрыв связанности с клиентом.

```bash
$ ydb -e ydb-ru.yandex.net:2135 -d /ru/tutorial/home/testdb table index add global --index-name owner_index --columns Owner cli_demo
┌───────────────────────────────────────┬───────┐
| id                                    | ready |
├───────────────────────────────────────┼───────┤
| ydb://buildindex/7?id=562949992705115 | false |
└───────────────────────────────────────┴───────┘
```

Команда вернула идентификатор операции построения индекса. Для того что бы получить информацию о ходе операции ее необходимо периодически опрашивать, в ходе чего мы получим прогресс и статус.
Прогресс (поле progress) считается как процент шардов исходной таблицы завершивших трансфер данных.
Статус (поле status) отображается когда операция уже завершена и говорит о результате выполнения всей операции построения.

Команда опроса операции выглядит так:

```bash
$ ydb -e ydb-ru.yandex.net:2135 -d /ru/tutorial/home/testdb operation get ydb://buildindex/7?id=562949992705115
┌───────────────────────────────────────┬───────┬────────┬──────────────┬──────────┬───────────────────────────────────────┬────────────┐
| id                                    | ready | status | state        | progress | table                                 | index      |
├───────────────────────────────────────┼───────┼────────┼──────────────┼──────────┼───────────────────────────────────────┼────────────┤
| ydb://buildindex/7?id=562949992705115 | false |        | transferdata | 23.43    | /ru/tutorial/home/testdb/cli_demo     | owner_index|
└───────────────────────────────────────┴───────┴────────┴──────────────┴──────────┴───────────────────────────────────────┴────────────┘
```

Просмотреть все операции построения индекса для базы:

```bash
$ ydb -e ydb-ru.yandex.net:2135 -d /ru/tutorial/home/testdb operation list buildindex
┌───────────────────────────────────────┬───────┬────────┬──────────────┬──────────┬───────────────────────────────────────┬────────────┐
| id                                    | ready | status | state        | progress | table                                 | index      |
├───────────────────────────────────────┼───────┼────────┼──────────────┼──────────┼───────────────────────────────────────┼────────────┤
| ydb://buildindex/7?id=562949992705115 | false |        | transferdata | 23.43    | /ru/tutorial/home/testdb/cli_demo     | owner_index|
└───────────────────────────────────────┴───────┴────────┴──────────────┴──────────┴───────────────────────────────────────┴────────────┘

Next page token: 0

```

Операцию построения можно отменить:
```bash
$ ydb -e ydb-ru.yandex.net:2135 -d /ru/tutorial/home/testdb operation cancel ydb://buildindex/7?id=562949996325696
```

После того как операция завершена или отменена, ее следует удалить из базы:
```bash
$ ydb -e ydb-ru.yandex.net:2135 -d /ru/tutorial/home/testdb operation forget ydb://buildindex/7?id=562949996325696
```


#### Удаление индекса

Если индекс не нужен, то его можно удалить. Удаление индекса - обычный синхронный запрос. Результат возвращается сразу по исполнению запроса.

```bash
$ ydb -e ydb-ru.yandex.net:2135 -d /ru/tutorial/home/testdb table index drop --index-name owner_index cli_demo
```

## Структура команд YDB CLI
Список всех доступных команд YDB CLI с кратким описанием каждой из них всегда можно увидеть, выполнив команду:
```bash
$ ydb --help
YDB client

Usage: /home/pnv1/.ydb/bin/ydb [options...] <subcommand>

Subcommands:
ydb
├─ discovery                Discovery service operations
│  ├─ list                  List endpoints
│  └─ whoami                Who am I?
├─ export                   Export service operations
│  └─ yt                    Create export to YT
├─ operation                Operation service operations
│  ├─ cancel                Start cancellation of a long-running operation
│  ├─ forget                Forget long-running operation
│  ├─ get                   Check status for a given operation
│  └─ list                  List operations of specified kind
├─ scheme                   Scheme service operations
│  ├─ describe              Show information about object at given path
│  ├─ ls                    Show information about objects inside given directory
│  ├─ mkdir                 Make directory
│  ├─ permissions           Modify permissions
│  │  ├─ chown              Change owner
│  │  ├─ clear              Clear permissions
│  │  ├─ grant              Grant permission (aliases: add)
│  │  ├─ revoke             Revoke permission (aliases: remove)
│  │  └─ set                Set permissions
│  └─ rmdir                 Remove directory
├─ scripting                Scripting service operations
│  └─ yql                   Execute YQL script
├─ table                    Table service operations
│  ├─ describe              Show information about given table
│  ├─ drop                  Drop a table
│  └─ query                 Query operations
│     ├─ execute            Execute query (aliases: exec)
│     └─ explain            Explain query
└─ tools                    YDB tools service
   ├─ copy                  Copy table(s)
   ├─ dump                  Dump specified database directory or table into local directory
   └─ restore               Restore database from local dump into specified directory


Options:
  {-?|-h|--help}            print usage
  {-e|--endpoint} [PROTOCOL://]HOST[:PORT]
                            [Required] Endpoint to connect. Protocols: grpc, grpcs.
  {-d|--database} PATH      [Required] Database to work with
  {-v|--verbose}            Increase verbosity of operations (default: 0)
  --ca-file PATH            Path to a file containing the PEM encoding of the server root certificates for tls connections.
                            If this parameter is empty, the default roots will be used.
  --token-file PATH         Security token file
                              Token search order:
                                1. This option
                                2. "YDB_TOKEN" environment variable
                                3. Default token file "~/.ydb/token"

Free args: min: 1, max: unlimited (listed described args only)
  <subcommand>  discovery,export,operation,scheme,scripting,table,tools
```

Также для любой из подкоманд можно получить более подробное описание со списком доступных параметров:

```bash
$ ydb discovery whoami --help
Usage: ydb [global options...] discovery whoami [options...]

Description: Who am I?

Global options:
  {-e|--endpoint} [PROTOCOL://]HOST[:PORT]
                            [Required] Endpoint to connect. Protocols: grpc, grpcs.
  {-d|--database} PATH      [Required] Database to work with
  {-v|--verbose}            Increase verbosity of operations (default: 0)
  --ca-file PATH            Path to a file containing the PEM encoding of the server root certificates for tls connections.
                            If this parameter is empty, the default roots will be used.
  --token-file PATH         Security token file
                              Token search order:
                                1. This option
                                2. "YDB_TOKEN" environment variable
                                3. Default token file "~/.ydb/token"

Options:
  {-?|-h|--help}      print usage
  --client-timeout ms Operation client timeout
  {-g|--groups}       With groups (default: 0)
```

Передаваемые параметры делятся на два типа:

* глобальные — указываются в "корне", т.е. после `ydb`;
* опции самой подкоманды - указываются в конце.
