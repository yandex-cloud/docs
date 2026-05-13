# Работа с базами данных Yandex MPP Analytics for PostgreSQL

В этом разделе описана основная информация про работу с [Yandex MPP Analytics for PostgreSQL](https://yandex.cloud/ru/services/managed-greenplum).

Для работы с базой данных Yandex MPP Analytics for PostgreSQL необходимо выполнить следующие шаги:
1. Создать [соединение](../concepts/glossary.md#connection), содержащее реквизиты для подключения к базе данных.
1. [Выполнить запрос](#query) к базе данных.

Пример запроса, выполняющего чтение данных из Yandex MPP Analytics for PostgreSQL:

```sql
SELECT * FROM greenplum_mdb_connection.my_table
```

где:
* `greenplum_mdb_connection` — название созданного соединения с базой данных.
* `my_table` — имя таблицы в базе данных.


## Настройка соединения {#create_connection}

Чтобы создать соединение с Yandex MPP Analytics for PostgreSQL:
1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором нужно создать соединение.
1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Yandex Query**.
1. На панели слева перейдите на вкладку **Соединения**.
1. Нажмите кнопку ![info](../../_assets/console-icons/plus.svg) **Создать**.
1. Укажите параметры соединения:

   1. В блоке **Общие параметры**:

      * **Имя** — название соединения с Yandex MPP Analytics for PostgreSQL.
      * **Тип** — `Managed Service for Greenplum`.

   1. В блоке **Параметры типа соединения**:

      * **Кластер** — выберите существующий кластер Yandex MPP Analytics for PostgreSQL или создайте новый.
      * **Сервисный аккаунт** — выберите существующий [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) Yandex MPP Analytics for PostgreSQL или создайте новый с ролью [`managed-greenplum.viewer`](../../managed-greenplum/security/index.md#mgp-viewer), от имени которого будет выполняться подключение к кластерам `Yandex MPP Analytics for PostgreSQL`.

        Чтобы использовать сервисный аккаунт, пользователю нужна [роль](../../iam/security/index.md#iam-serviceAccounts-user) `iam.serviceAccounts.user`.

      * **База данных**  — выберите базу данных, которая будет использоваться при работе с кластером Greenplum®.
      * **Схема**  — укажите [пространство имен](https://docs.vmware.com/en/VMware-Greenplum/7/greenplum-database/admin_guide-ddl-ddl-schema.html), которое будет использоваться при работе с базой данных Greenplum®.
      * **Логин**  — имя пользователя, которое будет использоваться для подключения к базам данных Greenplum®.
      * **Пароль**  — пароль пользователя, который будет использоваться для подключения к базам данных Greenplum®.


1. Нажмите кнопку **Создать**.

Сервисный аккаунт необходим для обнаружения точек подключения к кластерам Yandex MPP Analytics for PostgreSQL внутри Yandex Cloud, для работы с данными логин и пароль пользователя задаются отдельно.

{% note warning %}

Необходимо предварительно разрешить сетевой доступ от Yandex Query до кластеров Yandex MPP Analytics for PostgreSQL. Для этого в настройках базы данных, к которой осуществляется подключение, установите пункт "Доступ из Yandex Query".

{% endnote %}

## Синтаксис запросов {#query}
Для работы с Greenplum® используется следующая форма SQL-запроса:

```sql
SELECT * FROM <соединение>.<имя_таблицы>
```

где:
* `<соединение>` — название созданного соединения с базой данных.
* `<имя_таблицы>` — имя таблицы в базе данных.

## Ограничения {#limits}

При работе с кластерами Greenplum® существует ряд ограничений.

Ограничения:
1. Внешние источники доступны только для чтения данных через запросы `SELECT`. Запросы, модифицирующие таблицы во внешних источниках, сервисом Yandex Query в настоящее время не поддерживаются.
1. Чтение данных выполняется в один поток через мастер-хост, также известный как [хост-координатор](https://docs.vmware.com/en/VMware-Greenplum/7/greenplum-database/admin_guide-intro-arch_overview.html) кластера Greenplum®. Массивно-параллельное чтение в настоящее время не поддерживается.
1. В YQ используется [система типов](https://ydb.tech/docs/ru//yql/reference/types/primitive) Yandex Managed Service for YDB. Однако диапазоны допустимых значений для типов, использующихся в YDB при работе с датой и временем (`Date`, `Datetime`, `Timestamp`), зачастую оказываются недостаточно широкими для того, чтобы вместить значения соответствующих типов Greenplum® (`date`, `timestamp`). 
В связи с этим значения даты и времени, прочитанные из Greenplum®, возвращаются YQ как обычные строки (тип `Optional<Utf8>`) в формате [ISO-8601](https://www.iso.org/iso-8601-date-and-time-format.html).

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
|`Int16`|
|`Int32`|
|`Int64`|
|`Float`|
|`Double`|

## Поддерживаемые типы данных {#supported_types}

В базе данных Greenplum® признак опциональности значений колонки (разрешено или запрещено колонке содержать значения `NULL`) не является частью системы типов. Ограничение (constraint) `NOT NULL` для каждой колонки реализуется в виде атрибута `attnotnull` в системном каталоге [pg_attribute](https://docs.vmware.com/en/VMware-Greenplum/7/greenplum-database/ref_guide-system_catalogs-pg_attribute.html), то есть на уровне метаданных таблицы. Следовательно, все базовые типы Greenplum® по умолчанию могут содержать значения `NULL`, и в системе типов YQ они должны отображаться в [опциональные](https://ydb.tech/docs/ru//yql/reference/types/optional) типы. 

Ниже приведена таблица соответствия типов Greenplum® и Yandex Query. Все остальные типы данных, за исключением перечисленных, не поддерживаются.

| Тип данных Greenplum® | Тип данных Yandex Query | Примечания |
| :---: | :---: | :--- |
| `boolean` | `Optional<Bool>` | |
| `smallint` | `Optional<Int16>` | |
| `int2` | `Optional<Int16>` | |
| `integer` | `Optional<Int32>` | |
| `int` | `Optional<Int32>` | |
| `int4` | `Optional<Int32>` | |
| `serial` | `Optional<Int32>` | |
| `serial4` | `Optional<Int32>` | |
| `bigint` | `Optional<Int64>` | |
| `int8` | `Optional<Int64>` | |
| `bigserial` | `Optional<Int64>` | |
| `serial8` | `Optional<Int64>` | |
| `real` | `Optional<Float>` | |
| `float4` | `Optional<Float>` | |
| `double precision` | `Optional<Double>` | |
| `float8` | `Optional<Double>` | |
| `date` | `Optional<Utf8>` | |
| `timestamp` | `Optional<Utf8>` | |
| `bytea` | `Optional<String>` | |
| `character` | `Optional<Utf8>` | Правила сортировки по умолчанию, строка дополняется пробелами до требуемой длины. |
| `character varying` | `Optional<Utf8>` | Правила сортировки по умолчанию. |
| `text` | `Optional<Utf8>` | Правила сортировки по умолчанию. |
| `json` | `Optional<Json>` | |