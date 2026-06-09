# Работа с базами данных {{ mch-name }}

В этом разделе описана основная информация про работу с [{{ mch-name }}](https://yandex.cloud/ru/services/managed-clickhouse).

Для работы с базой данных {{ mch-name }} необходимо выполнить следующие шаги:
1. Создать [соединение](../concepts/glossary.md#connection), содержащее реквизиты для подключения к базе данных.
1. [Выполнить запрос](#query) к базе данных.

Пример запроса, выполняющего чтение данных из {{ mch-name }}:

```sql
SELECT * FROM clickhouse_mdb_connection.my_table
```

где:
* `clickhouse_mdb_connection` — название созданного соединения с базой данных.
* `my_table` — имя таблицы в базе данных.


## Настройка соединения {#create_connection}

Чтобы создать соединение с {{ mch-name }}:

1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать соединение.
1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
1. На панели слева перейдите на вкладку **{{ ui-key.yql.yq-ide-aside.connections.tab-text }}**.
1. Нажмите кнопку ![info](../../_assets/console-icons/plus.svg) **{{ ui-key.yql.yq-connection-form.action_create-new }}**.
1. Укажите параметры соединения:

   1. В блоке **{{ ui-key.yql.yq-connection-form.general-parameters.section-title }}**:

      * **{{ ui-key.yql.yq-connection-form.connection-name.input-label }}** — название соединения с {{ mch-name }}.
      * **{{ ui-key.yql.yq-connection-form.connection-type.input-label }}** — `{{ ui-key.yql.yq-connection.action_clickhouse }}`.
   1. В блоке **{{ ui-key.yql.yq-connection-form.connection-type-parameters.section-title }}**:
      * **{{ ui-key.yql.yq-connection-form.cluster.input-label }}** — выберите существующий кластер {{ mch-name }} или создайте новый.
      * **{{ ui-key.yql.yq-connection-form.service-account.input-label }}** — выберите существующий [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) {{ mch-name }} или создайте новый с [ролью `{{ roles.mch.viewer }}`](../../managed-clickhouse/security.md#managed-clickhouse-viewer), от имени которого будет выполняться подключение к кластерам `{{ mch-name }}`.

        Чтобы использовать сервисный аккаунт, пользователю нужна [роль](../../iam/security/index.md#iam-serviceAccounts-user) `iam.serviceAccounts.user`.

      * **{{ ui-key.yql.yq-connection-info.database.label }}**  — выберите базу данных, которая будет использоваться при работе с кластером {{ CH }}.
      * **{{ ui-key.yql.yq-connection-form.login.input-label }}**  — имя пользователя, которое будет использоваться для подключения к базам данных {{ CH }}.
      * **{{ ui-key.yql.yq-connection-form.password.input-label }}**  — пароль пользователя, который будет использоваться для подключения к базам данных {{ CH }}.


1. Нажмите кнопку **{{ ui-key.yql.yq-connection-form.create.button-text }}**.

Сервисный аккаунт необходим для обнаружения точек подключения к кластерам {{ mch-name }} внутри {{ yandex-cloud }}, для работы с данными логин и пароль пользователя задаются отдельно.

{% note warning %}

Необходимо предварительно разрешить сетевой доступ от {{ yq-full-name }} до кластеров {{ mch-name }}. Для этого в настройках базы данных, к которой осуществляется подключение, установите пункт **{{ ui-key.yacloud.mdb.forms.additional-field-yandex-query_ru }}**.

{% endnote %}


## Синтаксис запросов {#query}
Для работы с {{ CH }} используется следующая форма SQL-запроса:

```sql
SELECT * FROM <соединение>.<имя_таблицы>
```

где:
* `<соединение>` — название созданного соединения с базой данных.
* `<имя_таблицы>` — имя таблицы в базе данных.

## Ограничения {#limits}

При работе с кластерами {{ CH }} существует ряд ограничений.

Ограничения:
1. Внешние источники доступны только для чтения данных через запросы `SELECT`. Запросы, модифицирующие таблицы во внешних источниках, сервисом {{ yq-full-name }} в настоящее время не поддерживаются.
1. В {{ yq-short-name }} используется [система типов]({{ ydb.docs }}/yql/reference/types/primitive) {{ ydb-full-name }}. Однако диапазоны допустимых значений для типов, использующихся в {{ ydb-short-name }} при работе с датой и временем (`Date`, `Datetime`, `Timestamp`), зачастую оказываются недостаточно широкими для того, чтобы вместить значения соответствующих типов {{ CH }} (`Date`, `Date32`, `Datetime`, `Datetime64`). 
В связи с этим значения даты и времени, прочитанные из {{ CH }}, возвращаются {{ yq-short-name }} как обычные строки (тип `Utf8` для обычных колонок или тип `Optional<Utf8>` для [nullable]({{ ch.docs }}{{ lang }}/sql-reference/data-types/nullable) колонок) в формате [ISO-8601](https://www.iso.org/iso-8601-date-and-time-format.html).

## Пушдаун фильтров {#predicate_pushdown}

{{ yq-full-name }} умеет передавать обработку частей запросов в систему-источник данных. Это означает, что фильтрующие выражения передаются сквозь {{ yq-full-name }} непосредственно в базу данных для обработки, обычно это условия запросов, указанных в `WHERE`. Такой способ обработки называется `пушдаун фильтров`.

Пушдаун фильтров возможен при использовании:

|Описание|Пример|
|---|---|
|Проверка на `NULL`|`WHERE column1 IS NULL` или `WHERE column1 IS NOT NULL`|
|Логических условий `OR`, `NOT`, `AND` и круглых скобок для управления приоритетом вычислений. |`WHERE column1 IS NULL OR (column2 IS NOT NULL AND column3 > 10)`.|
|Операторов сравнения `=`, `==`, `!=`, `<>`, `>`, `<`, `>=`, `<=` с другими колонками или константами.|`WHERE column1 > column2 OR column3 <= 10`, `WHERE column1 + column2 > 10`, `WHERE column1 = (10 + 10)`|

При использовании других видов фильтров пушдаун на источник не выполняется: фильтрация строк внешней таблицы будет выполнена на стороне федеративной {{ yq-full-name }}, что означает, что {{ yq-full-name }} выполнит полное чтение (full scan) внешней таблицы в момент обработки запроса.

Поддерживаемые типы данных для пушдауна фильтров:

|Тип данных {{ yq-full-name }}|
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

По умолчанию в {{ CH }} колонки физически не могут содержать значение `NULL`, однако пользователь имеет возможность создать таблицу с колонками опциональных, или [nullable]({{ ch.docs }}{{ lang }}/sql-reference/data-types/nullable) типов. Типы колонок, отображаемые {{ yq-full-name }} при извлечении данных из внешнего источника {{ CH }}, будут зависеть от того, используются ли в таблице {{ CH }} примитивные или опциональные типы. 

Ниже приведены таблицы соответствия типов {{ CH }} и {{ yq-full-name }}. Все остальные типы данных, за исключением перечисленных, не поддерживаются.

### Примитивные типы данных {#supported_types_default}

| Тип данных {{ CH }} | Тип данных {{ yq-full-name }} | Примечания |
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

| Тип данных {{ CH }} | Тип данных {{ yq-full-name }} | Примечания |
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

_{{ CH }} является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._