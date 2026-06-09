# Работа с базами данных Managed Service for ClickHouse®

В этом разделе описана основная информация про работу с [Managed Service for ClickHouse®](https://yandex.cloud/ru/services/managed-clickhouse).

Для работы с базой данных Managed Service for ClickHouse® необходимо выполнить следующие шаги:
1. Создать [соединение](../concepts/glossary.md#connection), содержащее реквизиты для подключения к базе данных.
1. [Выполнить запрос](#query) к базе данных.

Пример запроса, выполняющего чтение данных из Managed Service for ClickHouse®:

```sql
SELECT * FROM clickhouse_mdb_connection.my_table
```

где:
* `clickhouse_mdb_connection` — название созданного соединения с базой данных.
* `my_table` — имя таблицы в базе данных.


## Настройка соединения {#create_connection}

Чтобы создать соединение с Managed Service for ClickHouse®:

1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором нужно создать соединение.
1. Перейдите в сервис **Yandex Query**.
1. На панели слева перейдите на вкладку **Соединения**.
1. Нажмите кнопку ![info](../../_assets/console-icons/plus.svg) **Создать**.
1. Укажите параметры соединения:

   1. В блоке **Общие параметры**:

      * **Имя** — название соединения с Managed Service for ClickHouse®.
      * **Тип** — `Managed Service for ClickHouse`.
   1. В блоке **Параметры типа соединения**:
      * **Кластер** — выберите существующий кластер Managed Service for ClickHouse® или создайте новый.
      * **Сервисный аккаунт** — выберите существующий [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) Managed Service for ClickHouse® или создайте новый с [ролью `managed-clickhouse.viewer`](../../managed-clickhouse/security.md#managed-clickhouse-viewer), от имени которого будет выполняться подключение к кластерам `Managed Service for ClickHouse®`.

        Чтобы использовать сервисный аккаунт, пользователю нужна [роль](../../iam/security/index.md#iam-serviceAccounts-user) `iam.serviceAccounts.user`.

      * **База данных**  — выберите базу данных, которая будет использоваться при работе с кластером ClickHouse®.
      * **Логин**  — имя пользователя, которое будет использоваться для подключения к базам данных ClickHouse®.
      * **Пароль**  — пароль пользователя, который будет использоваться для подключения к базам данных ClickHouse®.


1. Нажмите кнопку **Создать**.

Сервисный аккаунт необходим для обнаружения точек подключения к кластерам Managed Service for ClickHouse® внутри Yandex Cloud, для работы с данными логин и пароль пользователя задаются отдельно.

{% note warning %}

Необходимо предварительно разрешить сетевой доступ от Yandex Query до кластеров Managed Service for ClickHouse®. Для этого в настройках базы данных, к которой осуществляется подключение, установите пункт **Доступ из Yandex Query**.

{% endnote %}


## Синтаксис запросов {#query}
Для работы с ClickHouse® используется следующая форма SQL-запроса:

```sql
SELECT * FROM <соединение>.<имя_таблицы>
```

где:
* `<соединение>` — название созданного соединения с базой данных.
* `<имя_таблицы>` — имя таблицы в базе данных.

## Ограничения {#limits}

При работе с кластерами ClickHouse® существует ряд ограничений.

Ограничения:
1. Внешние источники доступны только для чтения данных через запросы `SELECT`. Запросы, модифицирующие таблицы во внешних источниках, сервисом Yandex Query в настоящее время не поддерживаются.
1. В YQ используется [система типов](https://ydb.tech/docs/ru//yql/reference/types/primitive) Yandex Managed Service for YDB. Однако диапазоны допустимых значений для типов, использующихся в YDB при работе с датой и временем (`Date`, `Datetime`, `Timestamp`), зачастую оказываются недостаточно широкими для того, чтобы вместить значения соответствующих типов ClickHouse® (`Date`, `Date32`, `Datetime`, `Datetime64`). 
В связи с этим значения даты и времени, прочитанные из ClickHouse®, возвращаются YQ как обычные строки (тип `Utf8` для обычных колонок или тип `Optional<Utf8>` для [nullable](https://clickhouse.com/docs/ru/sql-reference/data-types/nullable) колонок) в формате [ISO-8601](https://www.iso.org/iso-8601-date-and-time-format.html).

## Пушдаун фильтров {#predicate_pushdown}

Yandex Query умеет передавать обработку частей запросов в систему-источник данных. Это означает, что фильтрующие выражения передаются сквозь Yandex Query непосредственно в базу данных для обработки, обычно это условия запросов, указанных в `WHERE`. Такой способ обработки называется `пушдаун фильтров`.

Пушдаун фильтров возможен при использовании:

|Описание|Пример|
|---|---|
|Проверка на `NULL`|`WHERE column1 IS NULL` или `WHERE column1 IS NOT NULL`|
|Логических условий `OR`, `NOT`, `AND` и круглых скобок для управления приоритетом вычислений. |`WHERE column1 IS NULL OR (column2 IS NOT NULL AND column3 > 10)`.|
|Операторов сравнения `=`, `==`, `!=`, `<>`, `>`, `<`, `>=`, `<=` с другими колонками или константами.|`WHERE column1 > column2 OR column3 <= 10`, `WHERE column1 + column2 > 10`, `WHERE column1 = (10 + 10)`|

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

## Поддерживаемые типы данных {#supported_types}

По умолчанию в ClickHouse® колонки физически не могут содержать значение `NULL`, однако пользователь имеет возможность создать таблицу с колонками опциональных, или [nullable](https://clickhouse.com/docs/ru/sql-reference/data-types/nullable) типов. Типы колонок, отображаемые Yandex Query при извлечении данных из внешнего источника ClickHouse®, будут зависеть от того, используются ли в таблице ClickHouse® примитивные или опциональные типы. 

Ниже приведены таблицы соответствия типов ClickHouse® и Yandex Query. Все остальные типы данных, за исключением перечисленных, не поддерживаются.

### Примитивные типы данных {#supported_types_default}

| Тип данных ClickHouse® | Тип данных Yandex Query | Примечания |
| :---: | :----: | :--- |
| `Bool` | `Bool` | |
| `Int8` | `Int8` | |
| `UInt8` | `Uint8` | |
| `Int16` | `Int16` | |
| `UInt16` | `Uint16` | |
| `Int32` | `Int32` | |
| `UInt32` | `Uint32` | |
| `Int64` | `Int64` | |
| `UInt64` | `Uint64` | |
| `Float32` | `Float` | |
| `Float64` | `Double` | |
| `Date` | `Utf8` | |
| `Date32` | `Utf8` | |
| `DateTime` | `Utf8` | |
| `DateTime64` | `Utf8` | |
| `String` | `String` | |
| `FixedString` | `String` | Нулевые байты `FixedString` переносятся в `String` без изменений. |

### Опциональные типы данных {#supported_types_nullable}

| Тип данных ClickHouse® | Тип данных Yandex Query | Примечания |
| :---: | :----: | :--- |
| `Nullable(Bool)` | `Optional<Bool>` | |
| `Nullable(Int8)` | `Optional<Int8>` | |
| `Nullable(UInt8)` | `Optional<Uint8>` | |
| `Nullable(Int16)` | `Optional<Int16>` | |
| `Nullable(UInt16)` | `Optional<Uint16>` | |
| `Nullable(Int32)` | `Optional<Int32>` | |
| `Nullable(UInt32)` | `Optional<Uint32>` | |
| `Nullable(Int64)` | `Optional<Int64>` | |
| `Nullable(UInt64)` | `Optional<Uint64>` | |
| `Nullable(Float32)` | `Optional<Float>` | |
| `Nullable(Float64)` | `Optional<Double>` | |
| `Nullable(Date)` | `Optional<Utf8>` | |
| `Nullable(Date32)` | `Optional<Utf8>` | |
| `Nullable(DateTime)` | `Optional<Utf8>` | |
| `Nullable(DateTime64)` | `Optional<Utf8>` | |
| `Nullable(String)` | `Optional<String>` | |
| `Nullable(FixedString)` | `Optional<String>` | Нулевые байты `FixedString` переносятся в `String` без изменений. |

_ClickHouse® является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._