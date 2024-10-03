# Работа с базами данных {{ mmy-name }}

В этом разделе описана основная информация про работу с [{{ mmy-name }}](https://yandex.cloud/ru/services/managed-mysql).

Для работы с базой данных {{ mmy-name }} необходимо выполнить следующие шаги:
1. Создать [соединение](../concepts/glossary.md#connection), содержащее реквизиты для подключения к базе данных.
1. [Выполнить запрос](#query) к базе данных.

Пример запроса, выполняющего чтение данных из {{ mmy-name }}:

```sql
SELECT * FROM mysql_mdb_connection.my_table
```

Где:
* `mysql_mdb_connection` — название созданного соединения с базой данных.
* `my_table` — имя таблицы в базе данных.


## Настройка соединения {#create_connection}

Чтобы создать соединение с {{ mmy-name }}:
1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать соединение.
1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
1. На панели слева перейдите на вкладку **{{ ui-key.yql.yq-ide-aside.connections.tab-text }}**.
1. Нажмите кнопку ![info](../../_assets/console-icons/plus.svg) **{{ ui-key.yql.yq-connection-form.action_create-new }}**.
1. Укажите параметры соединения:

   1. В блоке **{{ ui-key.yql.yq-connection-form.general-parameters.section-title }}**:

      * **{{ ui-key.yql.yq-connection-form.connection-name.input-label }}** — название соединения с {{ mmy-name }}.
      * **{{ ui-key.yql.yq-connection-form.connection-type.input-label }}** — `{{ ui-key.yql.yq-connection.action_mysql }}`.

   1. В блоке **{{ ui-key.yql.yq-connection-form.connection-type-parameters.section-title }}**:

      * **{{ ui-key.yql.yq-connection-form.cluster.input-label }}** — выберите существующий кластер {{ mmy-name }} или создайте новый.
      * **{{ ui-key.yql.yq-connection-form.service-account.input-label }}** — выберите существующий [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) {{ mmy-name }} или создайте новый с ролью [`{{ roles.mmy.viewer }}`](../../managed-mysql/security/index.md#managed-mysql-viewer), от имени которого будет выполняться подключение к кластерам `{{ mmy-name }}`.

        {% include [service accounts role](../../_includes/query/service-accounts-role.md) %}

      * **{{ ui-key.yql.yq-connection-form.database.input-label }}**  — выберите базу данных, которая будет использоваться при работе с кластером {{ MY }}.
      * **{{ ui-key.yql.yq-connection-form.login.input-label }}**  — имя пользователя, которое будет использоваться для подключения к базам данных {{ MY }}.
      * **{{ ui-key.yql.yq-connection-form.password.input-label }}**  — пароль пользователя, который будет использоваться для подключения к базам данных {{ MY }}.


1. Нажмите кнопку **{{ ui-key.yql.yq-connection-form.create.button-text }}**.

Сервисный аккаунт необходим для обнаружения точек подключения к кластерам {{ mmy-name }} внутри {{ yandex-cloud }}, для работы с данными логин и пароль пользователя задаются отдельно.

{% note warning %}

Необходимо предварительно разрешить сетевой доступ от {{ yq-full-name }} до кластеров {{ mmy-name }}. Для этого в настройках базы данных, к которой осуществляется подключение, включите опцию **Доступ из {{ yq-full-name }}**.

{% endnote %}

## Синтаксис запросов {#query}
Для работы с {{ MY }} используется следующая форма SQL-запроса:

```sql
SELECT * FROM <соединение>.<имя_таблицы>
```

Где:
* `<соединение>` — название созданного соединения с базой данных.
* `<имя_таблицы>` — имя таблицы в базе данных.

## Ограничения {#limits}

При работе с кластерами {{ MY }} существует ряд ограничений:

* {% include [!](_includes/supported_requests.md) %}
* В {{ yq-short-name }} используется [система типов](https://ydb.tech/docs/ru/yql/reference/types/primitive) {{ ydb-full-name }}. Однако диапазоны допустимых значений для типов, использующихся в {{ ydb-short-name }} при работе с датой и временем (`Date`, `Datetime`, `Timestamp`), зачастую оказываются недостаточно широкими для того, чтобы вместить значения соответствующих типов {{ MY }} (`date`, `datetime`, `timestamp`). В связи с этим значения даты и времени, прочитанные из {{ MY }}, возвращаются {{ yq-short-name }} как обычные строки (тип `Optional<Utf8>`) в формате [ISO-8601](https://www.iso.org/iso-8601-date-and-time-format.html).

## Пушдаун фильтров {#predicate_pushdown}

{% include [!](_includes/predicate_pushdown.md) %}

## Поддерживаемые типы данных {#supported_types}

В базе данных MySQL признак опциональности значений колонки (разрешено или запрещено колонке содержать значения `NULL`) не является частью системы типов данных. Ограничение (constraint) `NOT NULL` для любой колонки любой таблицы хранится в виде значения столбца `IS_NULLABLE` системной таблицы [INFORMATION_SCHEMA.COLUMNS](https://dev.mysql.com/doc/refman/8.4/en/information-schema-columns-table.html), то есть на уровне метаданных таблицы. Следовательно, все базовые типы {{ MY }} по умолчанию могут содержать значения `NULL`, и в системе типов {{ yq-short-name }} они должны отображаться в [опциональные](https://ydb.tech/docs/ru/yql/reference/types/optional) типы. 

Ниже приведена таблица соответствия типов {{ MY }} и {{ yq-full-name }}. Все остальные типы данных, за исключением перечисленных, не поддерживаются.

| Тип данных {{ MY }} | Тип данных {{ yq-full-name }} |
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
