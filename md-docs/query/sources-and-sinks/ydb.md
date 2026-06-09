# Работа с базами данных Managed Service for YDB

В этом разделе описана основная информация про работу с [Managed Service for YDB](https://yandex.cloud/ru/services/ydb).

Для работы с базой данных Managed Service for YDB из Yandex Query необходимо выполнить следующие шаги:
1. Создать [соединение](../concepts/glossary.md#connection), содержащее реквизиты для подключения к базе данных.
1. [Выполнить запрос](#query) к базе данных.

Пример запроса, выполняющего чтение данных из Managed Service for YDB:

```sql
SELECT * FROM ydb_connection.my_table
```

где:
* `ydb_connection` — название созданного соединения с базой данных.
* `my_table` — имя таблицы в базе данных.


## Настройка соединения {#create_connection}

Чтобы создать соединение с Managed Service for YDB:

1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором нужно создать соединение.
1. Перейдите в сервис **Yandex Query**.
1. На панели слева перейдите на вкладку **Соединения**.
1. Нажмите кнопку ![info](../../_assets/console-icons/plus.svg) **Создать**.
1. Укажите параметры соединения:

   1. В блоке **Общие параметры**:

      * **Имя** — название соединения с Managed Service for YDB.
      * **Тип** — `Managed Service for YDB`.
   1. В блоке **Параметры типа соединения**:
      * **Кластер** — выберите существующую базу данных Managed Service for YDB или создайте новую.
      * **Сервисный аккаунт** — выберите [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) Managed Service for YDB, от имени которого будет выполняться подключение к кластерам `Managed Service for YDB` и аутентификация в базе данных. Если сервисного аккаунта нет, создайте его и назначьте ему [роль](../../ydb/security/index.md#ydb-viewer) `ydb.viewer`.

        Чтобы использовать сервисный аккаунт, пользователю нужна [роль](../../iam/security/index.md#iam-serviceAccounts-user) `iam.serviceAccounts.user`.


1. Нажмите кнопку **Создать**.

## Синтаксис запросов {#query}

Для работы с Managed Service for YDB используется следующая форма SQL-запроса:

```sql
SELECT * FROM <соединение>.<имя_таблицы>
```

где:
* `<соединение>` — название созданного соединения с базой данных.
* `<имя_таблицы>` — имя таблицы в базе данных.

## Ограничения {#limits}

Внешние источники доступны только для чтения данных через запросы `SELECT`. Запросы, модифицирующие таблицы во внешних источниках, сервисом Yandex Query в настоящее время не поддерживаются.

## Пушдаун фильтров {#predicate_pushdown}

Yandex Query умеет передавать обработку частей запросов в систему-источник данных. Это означает, что фильтрующие выражения передаются сквозь Yandex Query непосредственно в базу данных для обработки, обычно это условия запросов, указанных в `WHERE`. Такой способ обработки называется `пушдаун фильтров`.

Пушдаун фильтров возможен при использовании:

|Описание|Пример|Ограничение|
|---|---|---|
|Фильтров вида `IS NULL`/`IS NOT NULL`|`WHERE column1 IS NULL` или `WHERE column1 IS NOT NULL`||
|Логических условий `OR`, `NOT`, `AND` и круглых скобок для управления приоритетом вычислений. |`WHERE column1 IS NULL OR (column2 IS NOT NULL AND column3 > 10)`.||
|Операторов сравнения `=`, `==`, `!=`, `<>`, `>`, `<`, `>=`, `<=` с другими колонками или константами.|`WHERE column1 > column2 OR column3 <= 10`.||
|Оператора сопоставления строк с образцом `LIKE`.|`WHERE column1 LIKE '_abc%'`|В настоящее время поддерживается пушдаун только простых паттернов, основанных на префиксах (`'abc_'`, `'abc%'`), суффиксах (`'_abc'`, `'%abc'`) или поиске подстроки в строке (`'_abc_'`, `'%abc%'`, `'_abc%'`, `'%abc_'`). При необходимости пушдауна более сложных паттернов рекомендуется воспользоваться `REGEXP`.|
|Оператора сопоставления строк с образцом `REGEXP`.|`WHERE column1 REGEXP '.*abc.*'`||

При использовании других видов фильтров пушдаун на источник не выполняется: фильтрация строк внешней таблицы будет выполнена на стороне федеративной Yandex Query, что означает, что Yandex Query выполнит полное чтение (full scan) внешней таблицы в момент обработки запроса.

Поддерживаемые типы данных для пушдауна фильтров:

|Тип данных Yandex Query|
|----|
|`Bool`|
|`Int8`|
|`Uint8`|
|`Int16`|
|`Uint16`|
|`Int32`|
|`Uint32`|
|`Int64`|
|`Uint64`|
|`Float`|
|`Double`|
|`String`|
|`Utf8`|

## Поддерживаемые типы данных {#supported_types}

Ниже приведены таблицы соответствия типов данных в Managed Service for YDB и Yandex Query. Типы данных, не указанные в таблицах, не поддерживаются.

### Примитивные типы данных {#supported_types_default}

| Тип данных Managed Service for YDB | Тип данных Yandex Query |
| :---: | :----: |
| `Bool` | `Bool` |
| `Int8` | `Int8` |
| `Uint8` | `Uint8` |
| `Int16` | `Int16` |
| `Uint16` | `Uint16` |
| `Int32` | `Int32` |
| `Uint32` | `Uint32` |
| `Int64` | `Int64` |
| `Uint64` | `Uint64` |
| `Float` | `Float` |
| `Double` | `Double` |
| `Date` | `Date` |
| `Datetime` | `Datetime` |
| `Timestamp` | `Timestamp` |
| `String` | `String` |
| `Utf8` | `Utf8` |
| `Json` | `Json` |
| `JsonDocument` | `Json` |

### Опциональные типы данных {#supported_types_nullable}

| Тип данных Managed Service for YDB | Тип данных Yandex Query |
| :---: | :----: |
| `Optional<Bool>` | `Optional<Bool>` |
| `Optional<Int8>` | `Optional<Int8>` |
| `Optional<Uint8>` | `Optional<Uint8>` |
| `Optional<Int16>` | `Optional<Int16>` |
| `Optional<Uint16>` | `Optional<Uint16>` |
| `Optional<Int32>` | `Optional<Int32>` |
| `Optional<Uint32>` | `Optional<Uint32>` |
| `Optional<Int64>` | `Optional<Int64>` |
| `Optional<Uint64>` | `Optional<Uint64>` |
| `Optional<Float>` | `Optional<Float>` |
| `Optional<Double>` | `Optional<Double>` |
| `Optional<Date>` | `Optional<Date>` |
| `Optional<Datetime>` | `Optional<Datetime>` |
| `Optional<Timestamp>` | `Optional<Timestamp>` |
| `Optional<String>` | `Optional<String>` |
| `Optional<Utf8>` | `Optional<Utf8>` |
| `Optional<Json>` | `Optional<Json>` |
| `Optional<JsonDocument>` | `Optional<Json>` |