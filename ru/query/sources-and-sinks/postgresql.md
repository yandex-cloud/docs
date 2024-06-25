# Работа с базами данных {{ mpg-name }}

В этом разделе описана основная информация про работу с [{{ mpg-name }}](https://yandex.cloud/ru/services/managed-postgresql).

Для работы с базой данных {{ mpg-name }} необходимо выполнить следующие шаги:
1. Создать [соединение](../concepts/glossary.md#connection), содержащее реквизиты для подключения к базе данных.
1. [Выполнить запрос](#query) к базе данных.

Пример запроса, выполняющего чтение данных из {{ mpg-name }}:

```sql
SELECT * FROM postgresql_mdb_connection.my_table
```

где:
* `postgresql_mdb_connection` — название созданного соединения с базой данных.
* `my_table` — имя таблицы в базе данных.


## Настройка соединения {#create_connection}

Чтобы создать соединение с {{ mpg-name }}:
1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать соединение.
1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
1. На панели слева перейдите на вкладку **{{ ui-key.yql.yq-ide-aside.connections.tab-text }}**.
1. Нажмите кнопку ![info](../../_assets/console-icons/plus.svg) **{{ ui-key.yql.yq-connection-form.action_create-new }}**.
1. Укажите параметры соединения:

   1. В блоке **{{ ui-key.yql.yq-connection-form.general-parameters.section-title }}**:

      * **{{ ui-key.yql.yq-connection-form.connection-name.input-label }}** — название соединения с {{ mpg-name }}.
      * **{{ ui-key.yql.yq-connection-form.connection-type.input-label }}** — `{{ ui-key.yql.yq-connection.postgersql.select-item }}`.

   1. В блоке **{{ ui-key.yql.yq-connection-form.connection-type-parameters.section-title }}**:

      * **{{ ui-key.yql.yq-connection-form.cluster.input-label }}** — выберите существующий кластер {{ mpg-name }} или создайте новый.
      * **{{ ui-key.yql.yq-connection-form.service-account.input-label }}** — выберите существующий [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) {{ mpg-name }} или создайте новый с ролью [`{{ roles.mpg.viewer }}`](../../managed-postgresql/security/index.md#mpg-viewer), от имени которого будет выполняться подключение к кластерам `{{ mpg-name }}`.

        {% include [service accounts role](../../_includes/query/service-accounts-role.md) %}

      * **{{ ui-key.yql.yq-connection-form.database.input-label }}**  — выберите базу данных, которая будет использоваться при работе с кластером {{ PG }}.
      * **{{ ui-key.yql.yq-connection-form.schema.input-label }}**  — укажите [пространство имен](https://www.postgresql.org/docs/current/catalog-pg-namespace.html), которое будет использоваться при работе с базой данных {{ PG }}.
      * **{{ ui-key.yql.yq-connection-form.login.input-label }}**  — имя пользователя, которое будет использоваться для подключения к базам данных {{ PG }}.
      * **{{ ui-key.yql.yq-connection-form.password.input-label }}**  — пароль пользователя, который будет использоваться для подключения к базам данных {{ PG }}.


1. Нажмите кнопку **{{ ui-key.yql.yq-connection-form.create.button-text }}**.

Сервисный аккаунт необходим для обнаружения точек подключения к кластерам {{ mpg-name }} внутри {{ yandex-cloud }}, для работы с данными логин и пароль пользователя задаются отдельно.

{% note warning %}

Необходимо предварительно разрешить сетевой доступ от {{ yq-full-name }} до кластеров {{ mpg-name }}. Для этого в настройках базы данных, к которой осуществляется подключение, установите пункт "Доступ из {{ yq-full-name }}".

{% endnote %}

## Синтаксис запросов {#query}
Для работы с {{ PG }} используется следующая форма SQL-запроса:

```sql
SELECT * FROM <соединение>.<имя_таблицы>
```

где:
* `<соединение>` — название созданного соединения с базой данных.
* `<имя_таблицы>` — имя таблицы в базе данных.

## Ограничения {#limits}

При работе с кластерами {{ PG }} существует ряд ограничений.

Ограничения:
1. {% include [!](_includes/supported_requests.md) %}
1. В {{ yq-short-name }} используется [система типов](https://ydb.tech/docs/ru/yql/reference/types/primitive) {{ ydb-full-name }}. Однако диапазоны допустимых значений для типов, использующихся в {{ ydb-short-name }} при работе с датой и временем (`Date`, `Datetime`, `Timestamp`), зачастую оказываются недостаточно широкими для того, чтобы вместить значения соответствующих типов {{ PG }} (`date`, `timestamp`). 
В связи с этим значения даты и времени, прочитанные из {{ PG }}, возвращаются {{ yq-short-name }} как обычные строки (тип `Optional<Utf8>`) в формате [ISO-8601](https://www.iso.org/iso-8601-date-and-time-format.html).

## Пушдаун фильтров {#predicate_pushdown}

{% include [!](_includes/predicate_pushdown.md) %}

## Поддерживаемые типы данных {#supported_types}

В базе данных {{ PG }} признак опциональности значений колонки (разрешено или запрещено колонке содержать значения `NULL`) не является частью системы типов. Ограничение (constraint) `NOT NULL` для каждой колонки реализуется в виде атрибута `attnotnull` в системном каталоге [pg_attribute](https://www.postgresql.org/docs/current/catalog-pg-attribute.html), то есть на уровне метаданных таблицы. Следовательно, все базовые типы {{ PG }} по умолчанию могут содержать значения `NULL`, и в системе типов {{ yq-short-name }} они должны отображаться в [опциональные](https://ydb.tech/docs/ru/yql/reference/types/optional) типы. 

Ниже приведена таблица соответствия типов {{ PG }} и {{ yq-full-name }}. Все остальные типы данных, за исключением перечисленных, не поддерживаются.

| Тип данных {{ PG }} | Тип данных {{ yq-full-name }} | Примечания |
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
| `character` | `Optional<Utf8>` | [Правила сортировки](https://www.postgresql.org/docs/current/collation.html) по умолчанию, строка дополняется пробелами до требуемой длины. |
| `character varying` | `Utf8` | [Правила сортировки](https://www.postgresql.org/docs/current/collation.html) по умолчанию. |
| `text` | `Utf8` | [Правила сортировки](https://www.postgresql.org/docs/current/collation.html) по умолчанию. |
| `json` | `Json` | |

