# Использование консольного клиента YDB

В этом разделе описана работа с базой при помощи консольного клиента YDB (YDB CLI).

Вы узнаете, что нужно для начала работы с консольным клиентом, как его установить, а также как с его помощью выполнить ряд основных запросов.

## Предварительные требования {#requirements}
Чтобы успешно выполнить команду через YDB CLI, потребуется:

* Сам консольный клиент `{{ ydb-cli }}`. Процесс установки описан чуть ниже, в разделе ["Установка YDB CLI"](#how-to-install).
* Заранее созданная база данных (подробно о создании базы данных написано в разделе ["Начало работы - Создание базы данных"](create-db.md)).
* Эндпоинт и полный путь к базе данных в {{ ydb-full-name }}. Чтобы узнать эндпоинт и путь для своей базы данных:
    1. Перейдите в [консоль {{ yandex-cloud }}](https://console.cloud.yandex.ru/).
    1. Выберите нужный каталог и в нём перейдите в сервис {{ ydb-full-name }}.
    1. Выберите базу данных, к которой планируете сделать запрос.
    1. В меню слева перейдите в раздел "Обзор".
    1. Значение эндпоинта указано в строке **Эндпоинт**. Пример значения параметра для Dedicated базы: `lb.etn01lrprvnlnhv8v5kj.ydb.mdb.yandexcloud.net:2135`. Пример значения параметра для Serverless базы: `ydb.serverless.yandexcloud.net:2135`. Порт для эндпоинта по умолчанию 2135, так что `:2135` указывать не обязательно.
    1. Полный путь к базе указан в строке **База данных**.  Пример значения параметра: `/ru-central1/b1g4ej5ju4rf5kelpk4b/etn01lrprvnlnhv8v5kj`.
* Возможность аутентификации одним из способов, представленных в разделе ["Аутентификация в YDB CLI"](#authentication).

## Установка YDB CLI {#how-to-install}

{% list tabs %}

- Linux

  1. Выполните команду:

     ```
     curl https://storage.yandexcloud.net/yandexcloud-ydb/install.sh | bash
     ```

     Скрипт установит CLI и добавит путь до исполняемого файла в переменную окружения PATH.

     {% note info %}

     Скрипт дополнит переменную PATH только если его запустить в командных оболочках bash или zsh.
     Если Вы запустили скрипт в другой оболочке, добавьте путь до CLI в переменную PATH самостоятельно.

     {% endnote %}

  1. Перезапустите командную оболочку.

- macOS

  1. Выполните команду:

     ```
     curl https://storage.yandexcloud.net/yandexcloud-ydb/install.sh | bash
     ```

     Скрипт установит CLI и добавит путь до исполняемого файла в переменную окружения PATH.

  1. Перезапустите командную оболочку, чтобы перезагрузить переменные окружения.

- Windows

    Для Windows CLI можно установить с помощью PowerShell и `cmd`:

    - Для установки с помощью PowerShell:

        1. Выполните команду:
            ```
            iex (New-Object System.Net.WebClient).DownloadString('https://storage.yandexcloud.net/yandexcloud-ydb/install.ps1')
            ```

        1. Скрипт установки спросит, нужно ли добавить путь до `{{ ydb-cli }}` в переменную PATH:
            ```
            Add ydb installation dir to your PATH? [Y/n]
            ```

        1. Введите `Y`. После этого YDB CLI можно пользоваться, командную оболочку перезапускать не обязательно.
    - Для установки с помощью `cmd`:

        1. Выполните команду:
            ```
            @"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://storage.yandexcloud.net/yandexcloud-ydb/install.ps1'))"
            ```

        1. Скрипт установки спросит, нужно ли добавить путь до `{{ ydb-cli }}` в переменную PATH:
            ```
            Add ydb installation dir to your PATH? [Y/n]
            ```

        1. Введите `Y`.
        1. Перезапустите командную оболочку, чтобы перезагрузить переменные окружения.

    {% note info %}

    YDB CLI использует символы юникода в выводе некоторых команд. Скорее всего, для корректного отображения таких символов в консоли Windows потребуется переключить кодировку на UTF-8, выполнив команду:
    ```
    chcp 65001
    ```

    {% endnote %}

{% endlist %}

### Аутентификация в YDB CLI {#authentication}

Для выполнения запросов к {{ ydb-full-name }} в {{ yandex-cloud }}, консольному клиенту требуется аутентифицироваться от имени [IAM-пользователя](https://cloud.yandex.ru/docs/iam/concepts/). Консольный клиент может сам получать действующий [IAM-токен](https://cloud.yandex.ru/docs/iam/concepts/authorization/iam-token) несколькими способами, а также ему можно явно передать [IAM-токен](https://cloud.yandex.ru/docs/iam/concepts/authorization/iam-token), полученный самостоятельно. Далее представлены все 4 возможных способа аутентификации в YDB CLI:

* Через опцию `--yc-token-file` можно указать путь к файлу, в котором лежит [OAuth-токен пользователя](https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token). Это самый простой способ. Чтобы не указывать эту опцию каждый раз при вызовах команд `{{ ydb-cli }}`, вместо этого **значение** OAuth-токена можно сохранить в переменную окружения `YC_TOKEN`.
* Через опцию `--iam-token-file` можно указать путь к файлу, в котором лежит [IAM-токен](https://cloud.yandex.ru/docs/iam/concepts/authorization/iam-token), полученный самостоятельно. Также вместо указания опции, **значение** [IAM-токена](https://cloud.yandex.ru/docs/iam/concepts/authorization/iam-token) можно сохранить в переменную окружения `IAM_TOKEN`.
* При указании опции `--use-metadata-credentials` (без значения), YDB CLI попытается получить [IAM-токен](https://cloud.yandex.ru/docs/iam/concepts/authorization/iam-token) с помощью [сервиса метаданных](https://cloud.yandex.ru/docs/compute/operations/vm-connect/auth-inside-vm#auth-inside-vm) при работе из виртуальной машины в {{ yandex-cloud }}. Также вместо указания опции можно установить значение в переменную окружения `USE_METADATA_CREDENTIALS=1`.
* Через опцию `--sa-key-file` можно указать путь к файлу с [авторизованными ключами доступа](https://cloud.yandex.ru/docs/iam/operations/authorized-key/create) сервисного аккаунта. Как альтернатива, можно сохранить этот **путь к файлу** в переменную окружения `SA_KEY_FILE`.

## Примеры использования

### Проверка корректности аутентификации {#whoami}
Часто бывает полезно узнать, как Вы представляетесь базе данных.
```bash
$ {{ ydb-cli }} -e <эндпоинт> -d <база данных> --yc-token-file <путь к файлу с токеном> discovery whoami -g
User SID: aje6o75au36h5d0tnr8k@as

User has no groups
```

Параметры `-e` и `-d` -- это **Эндпоинт** и **База данных**. В разделе ["Предварительные требования"](#requirements) подробно описано, как их можно получить.
Опция `-g` также добавляет в вывод список групп, в которых состоит пользователь.

{% note info %}

В этом примере токен передается через опцию `--yc-token-file`. Сохраним **значение** самого токена в переменную окружения YC_TOKEN, чтобы уменьшить объем вводимого текста. Например, на linux для этого можно выполнить команду `export YC_TOKEN=<значение токена>`.

{% endnote %}

### Получение списка эндпоинтов для базы данных {#discovery_list}
```bash
$ {{ ydb-cli }} -e <эндпоинт> -d <база данных> discovery list
grpcs://vm-etn01lrprvnlnhv8v5kj-ru-central1-a-abod.etn01lrprvnlnhv8v5kj.ydb.mdb.yandexcloud.net:2135 #table_service #scripting #discovery #rate_limiter #locking #kesus
```

`#table_service`, `#scripting` и другие — это сервисы, доступные на данном эндпоинте.

### Листинг объектов по указанному пути
Если не указать путь, то будет произведен листинг корня базы данных:

```bash
$ {{ ydb-cli }} -e <эндпоинт> -d <база данных> scheme ls
episodes  seasons  series  some_directory  .sys
```

Можно посмотреть подробную информацию, добавив флаг `-l`:

```bash
$ {{ ydb-cli }} -e <эндпоинт> -d <база данных> scheme ls -l
┌───────┬─────────────────────────┬─────────┬───────────────────────────────┬───────────────────────────────┬────────────────┐
| Type  | Owner                   | Size    | Created                       | Modified                      | Name           |
├───────┼─────────────────────────┼─────────┼───────────────────────────────┼───────────────────────────────┼────────────────┤
| table | aje6o75au36h5d0tnr8k@as | 1.13 Kb | Thu, 17 Sep 2020 09:17:44 UTC | Thu, 17 Sep 2020 09:24:31 UTC | episodes       |
| table | aje6o75au36h5d0tnr8k@as | 1.45 Kb | Thu, 17 Sep 2020 09:17:44 UTC | Thu, 17 Sep 2020 09:20:07 UTC | seasons        |
| table | aje6o75au36h5d0tnr8k@as | 1.12 Kb | Thu, 17 Sep 2020 09:17:44 UTC | Thu, 17 Sep 2020 09:19:46 UTC | series         |
| dir   | aje6o75au36h5d0tnr8k@as |         |                               |                               | some_directory |
| dir   |                         |         |                               |                               | .sys           |
└───────┴─────────────────────────┴─────────┴───────────────────────────────┴───────────────────────────────┴────────────────┘
```

Создадим такое дерево из директорий:

```bash
$ {{ ydb-cli }} -e <эндпоинт> -d <база данных> scheme mkdir some_directory
$ {{ ydb-cli }} -e <эндпоинт> -d <база данных> scheme mkdir some_directory/sub-directory1
$ {{ ydb-cli }} -e <эндпоинт> -d <база данных> scheme mkdir some_directory/sub-directory1/sub-directory1-1
$ {{ ydb-cli }} -e <эндпоинт> -d <база данных> scheme mkdir some_directory/sub-directory2
```

Теперь при помощи опции `-R` для команды `scheme ls` можно посмотреть рекурсивный листинг всех поддиректорий и объектов в них по указанному пути:

```bash
$ {{ ydb-cli }} -e <эндпоинт> -d <база данных> scheme ls some_directory  -lR
┌──────┬─────────────────────────┬──────┬─────────┬──────────┬─────────────────────────────────┐
| Type | Owner                   | Size | Created | Modified | Name                            |
├──────┼─────────────────────────┼──────┼─────────┼──────────┼─────────────────────────────────┤
| dir  | aje6o75au36h5d0tnr8k@as |      |         |          | sub-directory1                  |
| dir  | aje6o75au36h5d0tnr8k@as |      |         |          | sub-directory1/sub-directory1-1 |
| dir  | aje6o75au36h5d0tnr8k@as |      |         |          | sub-directory2                  |
└──────┴─────────────────────────┴──────┴─────────┴──────────┴─────────────────────────────────┘
```

### Получение подробной информации об объектах схемы
На примере таблицы `episodes`.

```bash
$ {{ ydb-cli }} -e <эндпоинт> -d <база данных> scheme describe episodes --stats
┌────────────┬─────────┬────────┬─────┐
| Name       | Type    | Family | Key |
├────────────┼─────────┼────────┼─────┤
| air_date   | Uint64? |        |     |
| episode_id | Uint64? |        | K2  |
| season_id  | Uint64? |        | K1  |
| series_id  | Uint64? |        | K0  |
| title      | Utf8?   |        |     |
└────────────┴─────────┴────────┴─────┘

Storage settings:
Internal channel 0 commit log storage pool: ssd
Internal channel 1 commit log storage pool: ssd
Store large values in "external blobs": false

Column families:
┌─────────┬──────┬─────────────┬────────────────┐
| Name    | Data | Compression | Keep in memory |
├─────────┼──────┼─────────────┼────────────────┤
| default | ssd  | None        |                |
└─────────┴──────┴─────────────┴────────────────┘

Auto partitioning settings:
Partitioning by size: true
Partitioning by load: false
Preferred partition size (Mb): 2048

Table stats:
Partitions count: 1
Approximate number of rows: 70
Approximate size of table: 11.05 Kb
Last modified: Thu, 17 Sep 2020 10:02:41 UTC
Created: Thu, 17 Sep 2020 09:17:44 UTC
```

{% note info %}

Таблицы `episodes`, `series` и `seasons` из приводимых примеров можно создать самостоятельно.
В разделе ["Начало работы - Примеры YQL-запросов"](../quickstart/examples-yql.md) описано, как можно выполнять запросы к {{ ydb-full-name }} в [консоли {{ yandex-cloud }}](https://console.cloud.yandex.ru/).
Создание всех таблиц из приводимых примеров описано в разделе ["Туториал YQL - Создание таблицы"](../yql/tutorial/create_demo_tables.md).
А наполнение их данными — в разделе ["Туториал YQL - Добавление данных в таблицу"](../yql/tutorial/fill_tables_with_data.md).

{% endnote %}

### Выполнение запроса к базе
```bash
$ {{ ydb-cli }} -e <эндпоинт> -d <база данных> table query execute -q "SELECT season_id, episode_id, title FROM episodes WHERE series_id = 1 AND season_id > 1 ORDER BY season_id, episode_id LIMIT 3"
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
$ {{ ydb-cli }} -e <эндпоинт> -d <база данных> table readtable episodes --ordered --limit 5 --columns series_id,season_id,episode_id,title
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

`--limit` — ограничить количество читаемых записей;
`--ordered` — упорядочить читаемые записи по ключу;
`--columns` — колонки, значения которых следует читать (по умолчанию читаются все колонки) в формате csv.

Если нужно получить только количество прочитанных записей, следует использовать параметр `--count-only`:

```bash
$ {{ ydb-cli }} -e <эндпоинт> -d <база данных> table readtable episodes --columns series_id --count-only
70
```

### Получение плана запроса и AST {#explain_plan}
```bash
$ {{ ydb-cli }} -e <эндпоинт> -d <база данных> table query explain -q "SELECT season_id, episode_id, title FROM episodes WHERE series_id = 1 AND season_id > 1 ORDER BY season_id, episode_id LIMIT 3" --ast
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

##### Анализ плана запроса
Основная секция плана запроса, `tables`, содержит информацию об обращениях к таблицам. Чтения описаны в разделе `reads`, а записи — в разделе `writes`. Ключевой характеристикой любого обращения к таблице является его тип. Типы чтения:

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

Расмотрим еще один пример. Допустим, необходимо получить только первые сезоны всех сериалов.

```bash
$ {{ ydb-cli }} -e <эндпоинт> -d <база данных> table query explain -q "SELECT sa.title AS season_title, sr.title AS series_title, sr.series_id, sa.season_id FROM seasons AS sa INNER JOIN series AS sr ON sa.series_id = sr.series_id WHERE sa.season_id = 1"
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

Из данного плана запроса следует, что для таблицы `seasons` будет выполнен `FullScan`, а для таблицы `series` - множественные чтения (тип обращения `MultiLookup`) по ключу `series_id` (lookup_by). А тип чтения `MultiLookup` и раздел `lookup_by` говорят о том, что для таблицы `series` будут выполнены множественные чтения по ключу `series_id`.

##### Запуск операции добавления вторичного индекса

В YDB имеется механизм операций для процессов которые занимают долгое время, не требуют для своей работы участия пользователя, но должны переживать разрыв связанности с клиентом.

```bash
$ {{ ydb-cli }} -e <эндпоинт> -d <база данных> table index add global --index-name title_index --columns title series
┌────────────────────────────────────────┬───────┬────────┐
| id                                     | ready | status |
├────────────────────────────────────────┼───────┼────────┤
| ydb://buildindex/7?id=1407375091598308 | false |        |
└────────────────────────────────────────┴───────┴────────┘
```

Команда вернула идентификатор операции построения индекса. Для того, чтобы получить информацию о ходе операции, ее необходимо периодически опрашивать, в ходе чего мы получим прогресс и статус.
Прогресс (поле progress) считается как процент шардов исходной таблицы, завершивших трансфер данных.
Статус (поле status) отображается, когда операция уже завершена и говорит о результате выполнения всей операции построения.

Команда опроса операции выглядит так:

```bash
$ {{ ydb-cli }} -e <эндпоинт> -d <база данных> operation get ydb://buildindex/7?id=1407375091598308
┌────────────────────────────────────────┬───────┬─────────┬───────┬──────────┬───────────────────────────────────────────────────────────────┬─────────────┐
| id                                     | ready | status  | state | progress | table                                                         | index       |
├────────────────────────────────────────┼───────┼─────────┼───────┼──────────┼───────────────────────────────────────────────────────────────┼─────────────┤
| ydb://buildindex/7?id=1407375091598308 | true  | SUCCESS | Done  | 100.00%  | /ru-central1/b1g4ej5ju4rf5kelpk4b/etn01lrprvnlnhv8v5kj/series | title_index |
└────────────────────────────────────────┴───────┴─────────┴───────┴──────────┴───────────────────────────────────────────────────────────────┴─────────────┘
```

Просмотреть все операции построения индекса для базы:

```bash
$ {{ ydb-cli }} -e <эндпоинт> -d <база данных> operation list buildindex
┌────────────────────────────────────────┬───────┬─────────┬───────┬──────────┬───────────────────────────────────────────────────────────────┬─────────────┐
| id                                     | ready | status  | state | progress | table                                                         | index       |
├────────────────────────────────────────┼───────┼─────────┼───────┼──────────┼───────────────────────────────────────────────────────────────┼─────────────┤
| ydb://buildindex/7?id=1407375091598308 | true  | SUCCESS | Done  | 100.00%  | /ru-central1/b1g4ej5ju4rf5kelpk4b/etn01lrprvnlnhv8v5kj/series | title_index |
└────────────────────────────────────────┴───────┴─────────┴───────┴──────────┴───────────────────────────────────────────────────────────────┴─────────────┘

Next page token: 0

```

Операцию построения можно отменить:
```bash
$ {{ ydb-cli }} -e <эндпоинт> -d <база данных> operation cancel ydb://buildindex/7?id=1407375091598308
```

После того как операция завершена или отменена, ее следует удалить из базы:
```bash
$ {{ ydb-cli }} -e <эндпоинт> -d <база данных> operation forget ydb://buildindex/7?id=1407375091598308
```


#### Удаление индекса

Если индекс не нужен, то его можно удалить. Удаление индекса - обычный синхронный запрос. Результат возвращается сразу по исполнению запроса.

```bash
$ {{ ydb-cli }} -e <эндпоинт> -d <база данных> table index drop --index-name title_index series
```

## Структура команд YDB CLI
Список всех доступных команд YDB CLI с кратким описанием каждой из них всегда можно увидеть, выполнив команду:
```bash
$ {{ ydb-cli }} --help
YDB client

Usage: ydb [options...] <subcommand>

Subcommands:
ydb
├─ discovery                Discovery service operations
│  ├─ list                  List endpoints
│  └─ whoami                Who am I?
├─ export                   Export service operations
│  └─ s3                    Create export to S3
├─ operation                Operation service operations
│  ├─ cancel                Start cancellation of a long-running operation
│  ├─ forget                Forget long-running operation
│  ├─ get                   Check status for a given operation
│  └─ list                  List operations of specified kind
├─ scheme                   Scheme service operations
│  ├─ describe              Show information about object at given object
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
│  ├─ attribute             Attribute operations (aliases: attr)
│  │  ├─ add                Add attributes to the specified table
│  │  └─ drop               Drop attributes from the specified table
│  ├─ drop                  Drop a table
│  ├─ index                 Index operations
│  │  ├─ add                Add index in to the specified table
│  │  │  └─ global          Add global index. The command returns operation
│  │  └─ drop               Drop index from the specified table
│  ├─ query                 Query operations
│  │  ├─ execute            Execute query (aliases: exec)
│  │  └─ explain            Explain query
│  ├─ readtable             Stream read table
│  └─ ttl                   Ttl operations
│     ├─ drop               Drop ttl settings from the specified table
│     └─ set                Set ttl settings for the specified table
├─ tools                    YDB tools service
│  ├─ copy                  Copy table(s)
│  ├─ dump                  Dump specified database directory or table into local directory
│  └─ restore               Restore database from local dump into specified directory
├─ update                   Update current YDB CLI binary if there is a newer version available
└─ version                  Print Yandex.Cloud YDB CLI version


Options:
  {-?|-h|--help}        print usage
  {-e|--endpoint} [PROTOCOL://]HOST[:PORT]
                        [Required] Endpoint to connect. Protocols: grpc, grpcs (Default: grpcs).
  {-d|--database} PATH  [Required] Database to work with
  {-v|--verbose}        Increase verbosity of operations (default: 0)
  --ca-file PATH        Path to a file containing the PEM encoding of the server root certificates for tls connections.
                        If this parameter is empty, the default roots will be used.
  --iam-token-file PATH IAM token file
                          For more info go to: cloud.yandex.ru/docs/iam/concepts/authorization/iam-token
                          Token search order:
                            1. This option
                            2. "IAM_TOKEN" environment variable
  --yc-token-file PATH  YC token file. It should contain OAuth token of a Yandex Passport user to get IAM token with.
                          For more info go to: cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token
                          Token search order:
                            1. This option
                            2. "YC_TOKEN" environment variable
  --use-metadata-credentials
                        Use metadata service on a virtual machine to get credentials
                          For more info go to: cloud.yandex.ru/docs/compute/operations/vm-connect/auth-inside-vm
                          Definition priority:
                            1. This option
                            2. "USE_METADATA_CREDENTIALS" environment variable (default: 0)
  --sa-key-file PATH    Security account key file
                          For more info go to: cloud.yandex.ru/docs/iam/operations/iam-token/create-for-sa
                          Definition priority:
                            1. This option
                            2. "SA_KEY_FILE" environment variable
```

Также для любой из подкоманд можно получить более подробное описание со списком доступных параметров:

```bash
$ {{ ydb-cli }} discovery whoami --help
Usage: ydb [global options...] discovery whoami [options...]

Description: Who am I?

Global options:
  {-e|--endpoint} [PROTOCOL://]HOST[:PORT]
                            [Required] Endpoint to connect. Protocols: grpc, grpcs (Default: grpcs).
  {-d|--database} PATH      [Required] Database to work with
  {-v|--verbose}            Increase verbosity of operations (default: 0)
  --ca-file PATH            Path to a file containing the PEM encoding of the server root certificates for tls connections.
                            If this parameter is empty, the default roots will be used.
  --iam-token-file PATH     IAM token file
                              For more info go to: cloud.yandex.ru/docs/iam/concepts/authorization/iam-token
                              Token search order:
                                1. This option
                                2. "IAM_TOKEN" environment variable
  --yc-token-file PATH      YC token file. It should contain OAuth token of a Yandex Passport user to get IAM token with.
                              For more info go to: cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token
                              Token search order:
                                1. This option
                                2. "YC_TOKEN" environment variable
  --use-metadata-credentials
                            Use metadata service on a virtual machine to get credentials
                              For more info go to: cloud.yandex.ru/docs/compute/operations/vm-connect/auth-inside-vm
                              Definition priority:
                                1. This option
                                2. "USE_METADATA_CREDENTIALS" environment variable
                            Default: 0
  --sa-key-file PATH        Security account key file
                              For more info go to: cloud.yandex.ru/docs/iam/operations/iam-token/create-for-sa
                              Definition priority:
                                1. This option
                                2. "SA_KEY_FILE" environment variable

Options:
  {-?|-h|--help}      print usage
  --client-timeout ms Operation client timeout
  {-g|--groups}       With groups (default: 0)
```

Передаваемые параметры делятся на два типа:

* глобальные — указываются в "корне", т.е. после `{{ ydb-cli }}`;
* опции самой подкоманды - указываются в конце.
