# Работа с базами данных Managed Service for MySQL®

В этом разделе описана основная информация про работу с [Managed Service for MySQL®](https://yandex.cloud/ru/services/managed-mysql).

Для работы с базой данных Managed Service for MySQL® необходимо выполнить следующие шаги:
1. Создать [соединение](../concepts/glossary.md#connection), содержащее реквизиты для подключения к базе данных.
1. [Выполнить запрос](#query) к базе данных.

Пример запроса, выполняющего чтение данных из Managed Service for MySQL®:

```sql
SELECT * FROM mysql_mdb_connection.my_table
```

Где:
* `mysql_mdb_connection` — название созданного соединения с базой данных.
* `my_table` — имя таблицы в базе данных.


## Настройка соединения {#create_connection}

Чтобы создать соединение с Managed Service for MySQL®:
1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором нужно создать соединение.
1. Перейдите в сервис **Yandex Query**.
1. На панели слева перейдите на вкладку **Соединения**.
1. Нажмите кнопку ![info](../../_assets/console-icons/plus.svg) **Создать**.
1. Укажите параметры соединения:

   1. В блоке **Общие параметры**:

      * **Имя** — название соединения с Managed Service for MySQL®.
      * **Тип** — `Managed Service for MySQL`.

   1. В блоке **Параметры типа соединения**:

      * **Кластер** — выберите существующий кластер Managed Service for MySQL® или создайте новый.
      * **Сервисный аккаунт** — выберите существующий [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) Managed Service for MySQL® или создайте новый с ролью [`managed-mysql.viewer`](../../managed-mysql/security/index.md#managed-mysql-viewer), от имени которого будет выполняться подключение к кластерам `Managed Service for MySQL®`.

        Чтобы использовать сервисный аккаунт, пользователю нужна [роль](../../iam/security/index.md#iam-serviceAccounts-user) `iam.serviceAccounts.user`.

      * **База данных**  — выберите базу данных, которая будет использоваться при работе с кластером MySQL®.
      * **Логин**  — имя пользователя, которое будет использоваться для подключения к базам данных MySQL®.
      * **Пароль**  — пароль пользователя, который будет использоваться для подключения к базам данных MySQL®.


1. Нажмите кнопку **Создать**.

Сервисный аккаунт необходим для обнаружения точек подключения к кластерам Managed Service for MySQL® внутри Yandex Cloud, для работы с данными логин и пароль пользователя задаются отдельно.

{% note warning %}

Необходимо предварительно разрешить сетевой доступ от Yandex Query до кластеров Managed Service for MySQL®. Для этого в настройках базы данных, к которой осуществляется подключение, включите опцию **Доступ из Yandex Query**.

{% endnote %}

## Синтаксис запросов {#query}
Для работы с MySQL® используется следующая форма SQL-запроса:

```sql
SELECT * FROM <соединение>.<имя_таблицы>
```

Где:
* `<соединение>` — название созданного соединения с базой данных.
* `<имя_таблицы>` — имя таблицы в базе данных.

## Ограничения {#limits}

При работе с кластерами MySQL® существует ряд ограничений:

* Внешние источники доступны только для чтения данных через запросы `SELECT`. Запросы, модифицирующие таблицы во внешних источниках, сервисом Yandex Query в настоящее время не поддерживаются.
* В YQ используется [система типов](https://ydb.tech/docs/ru//yql/reference/types/primitive) Yandex Managed Service for YDB. Однако диапазоны допустимых значений для типов, использующихся в YDB при работе с датой и временем (`Date`, `Datetime`, `Timestamp`), зачастую оказываются недостаточно широкими для того, чтобы вместить значения соответствующих типов MySQL® (`date`, `datetime`, `timestamp`). В связи с этим значения даты и времени, прочитанные из MySQL®, возвращаются YQ как обычные строки (тип `Optional<Utf8>`) в формате [ISO-8601](https://www.iso.org/iso-8601-date-and-time-format.html).

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

## Поддерживаемые типы данных {#supported_types}

В базе данных MySQL признак опциональности значений колонки (разрешено или запрещено колонке содержать значения `NULL`) не является частью системы типов данных. Ограничение (constraint) `NOT NULL` для любой колонки любой таблицы хранится в виде значения столбца `IS_NULLABLE` системной таблицы [INFORMATION_SCHEMA.COLUMNS](https://dev.mysql.com/doc/refman/8.4/en/information-schema-columns-table.html), то есть на уровне метаданных таблицы. Следовательно, все базовые типы MySQL® по умолчанию могут содержать значения `NULL`, и в системе типов YQ они должны отображаться в [опциональные](https://ydb.tech/docs/ru//yql/reference/types/optional) типы. 

Ниже приведена таблица соответствия типов MySQL® и Yandex Query. Все остальные типы данных, за исключением перечисленных, не поддерживаются.

| Тип данных MySQL® | Тип данных Yandex Query |
| :---: | :---: |
|`bool`|`Optional<Bool>`|
|`tinyint`|`Optional<Int8>`|
|`tinyint unsigned`|`Optional<Uint8>`|
|`smallint`|`Optional<Int16>`|
|`smallint unsigned`|`Optional<Uint16>`|
|`mediumint`|`Optional<Int32>`|
|`mediumint unsigned`|`Optional<Uint32>`|
|`int`|`Optional<Int32>`|
|`int unsigned`|`Optional<Uint32>`|
|`bigint`|`Optional<Int64>`|
|`bigint unsigned`|`Optional<Uint64>`|
|`float`|`Optional<Float>`|
|`real`|`Optional<Float>`|
|`double`|`Optional<Double>`|
|`date`|`Optional<Utf8>`|
|`datetime`|`Optional<Utf8>`|
|`timestamp`|`Optional<Utf8>`|
|`tinyblob`|`Optional<String>`|
|`blob`|`Optional<String>`|
|`mediumblob`|`Optional<String>`|
|`longblob`|`Optional<String>`|
|`tinytext`|`Optional<String>`|
|`text`|`Optional<String>`|
|`mediumtext`|`Optional<String>`|
|`longtext`|`Optional<String>`|
|`char`|`Optional<Utf8>`|
|`varchar`|`Optional<Utf8>`|
|`binary`|`Optional<String>`|
|`varbinary`|`Optional<String>`|
|`json`|`Optional<Json>`|