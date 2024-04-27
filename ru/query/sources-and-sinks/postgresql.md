# Работа с базами данных {{ mpg-name }}

В этом разделе описана основная информация про работу с [{{ mpg-name }}](https://yandex.cloud/ru/services/managed-postgresql).

Пример чтения данных из {{ mpg-name }}:

```sql
SELECT * FROM postgresql_mdb_connection.my_table
```

где:
* `postgresql_mdb_connection` — название созданного подключения к БД.
* `my_table` — имя таблицы в базе данных.


Для работы с базой данных {{ mpg-name }} необходимо выполнить следующие шаги:
1. Создать [соединение](../concepts/glossary.md#connection), содержащее реквизиты для подключения к базе данных.
1. [Выполнить запрос](#query) к базе данных.

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
* `<соединение>` — название созданного подключения к БД.
* `<имя_таблицы>` — имя таблицы в базе данных.

## Ограничения {#limits}

При работе с кластерами {{ PG }} существует ряд ограничений.

Ограничения:
1. Поддерживаются только запросы чтения данных - `SELECT`, остальные виды запросов не поддерживаются.
1. Максимальное поддерживаемое количество строк в таблице - 1000000. При превышении этого значения запрос завершается с ошибкой.
1. {% include [!](_includes/datetime_limits.md) %}

## Пушдаун фильтров {#predicate_pushdown}

{% include [!](_includes/predicate_pushdown.md) %}

## Поддерживаемые типы данных {#supported_types}

Ниже приведена таблица соответствия типов {{ PG }} и типов {{ yq-full-name }}.

|Тип данных {{ PG }}|Тип данных {{ yq-full-name }}|Примечания|
|---|----|------|
|`boolean`|`BOOL`||
|`smallint`|`INT16`||
|`int2`|`INT16`||
|`integer`|`INT32`||
|`int`|`INT32`||
|`int4`|`INT32`||
|`serial`|`INT32`||
|`serial4`|`INT32`||
|`bigint`|`INT64`||
|`int8`|`INT64`||
|`bigserial`|`INT64`||
|`serial8`|`INT64`||
|`real`|`FLOAT`||
|`float4`|`FLOAT`||
|`double precision`|`DOUBLE`||
|`float8`|`DOUBLE`||
|`date`|`DATE`|Допустимый диапазон дат с 1970-01-01 и до 2105-12-31|
|`timestamp`|`TIMESTAMP`|Допустимый диапазон дат с 1970-01-01 00:00 и до 2105-12-31 23:59|
|`bytea`|`STRING`||
|`character`|`UTF8`|[Правила сортировки](https://www.postgresql.org/docs/current/collation.html) по умолчанию, строка дополняется пробелами до требуемой длины|
|`character varying`|`UTF8`|[Правила сортировки](https://www.postgresql.org/docs/current/collation.html) по умолчанию|
|`text`|`UTF8`|[Правила сортировки](https://www.postgresql.org/docs/current/collation.html) по умолчанию|

Остальные типы данных не поддерживаются.

