# Работа с базами данных {{ mch-name }}

В этом разделе описана основная информация про работу с [{{ mch-name }}](https://yandex.cloud/ru/services/managed-clickhouse).

Пример чтения данных из {{ mch-name }}:

```sql
SELECT * FROM clickhouse_mdb_connection.my_table
```

где:
* `clickhouse_mdb_connection` — название созданного подключения к БД.
* `my_table` — имя таблицы в базе данных.


Для работы с базой данных {{ mch-name }} необходимо выполнить следующие шаги:
1. Создать [соединение](../concepts/glossary.md#connection), содержащее реквизиты для подключения к базе данных.
1. [Выполнить запрос](#query) к базе данных.

## Настройка соединения {#create_connection}

Чтобы создать соединение с {{ mch-name }}:

1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать соединение.
1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
1. На панели слева перейдите на вкладку **{{ ui-key.yql.yq-ide-aside.connections.tab-text }}**.
1. Нажмите кнопку ![info](../../_assets/console-icons/plus.svg) **{{ ui-key.yql.yq-connection-form.action_create-new }}**.
1. Укажите параметры соединения:

   1. В блоке **{{ ui-key.yql.yq-connection-form.general-parameters.section-title }}**:

      * **{{ ui-key.yql.yq-connection-form.connection-name.input-label }}** — название соединения с {{ mch-name }}.
      * **{{ ui-key.yql.yq-connection-form.connection-type.input-label }}** — `{{ ui-key.yql.yq-connection.click-house.select-item }}`.
   1. В блоке **{{ ui-key.yql.yq-connection-form.connection-type-parameters.section-title }}**:
      * **{{ ui-key.yql.yq-connection-form.cluster.input-label }}** — выберите существующий кластер {{ mch-name }} или создайте новый.
      * **{{ ui-key.yql.yq-connection-form.service-account.input-label }}** — выберите существующий [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) {{ mch-name }} или создайте новый с [ролью `{{ roles.mch.viewer }}`](../../managed-clickhouse/security.md#managed-clickhouse-viewer), от имени которого будет выполняться подключение к кластерам `{{ mch-name }}`.
      *  **{{ ui-key.yql.yq-connection-info.database.label }}**  — выберите базу данных, которая будет использоваться при работе с кластером {{ CH }}.
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
* `<соединение>` — название созданного подключения к БД.
* `<имя_таблицы>` — имя таблицы в базе данных.

## Ограничения {#limits}

При работе с кластерами {{ CH }} существует ряд ограничений.

{% note warning %}

В настоящий момент независимо от указанных фильтров для чтения таблиц {{ CH }}, указанных в SQL-запросе, все данные из таблицы считываются в {{ yq-full-name }} и уже там происходит применение фильтров.

{% endnote %}

Ограничения:
1. Поддерживаются только запросы чтения данных - `SELECT`, остальные виды запросов не поддерживаются.
1. Максимальное поддерживаемое количество строк в таблице - 1000000. При превышении этого значения запрос завершается с ошибкой.
1. {% include [!](_includes/datetime_limits.md) %}

## Пушдаун фильтров {#predicate_pushdown}

{% include [!](_includes/predicate_pushdown.md) %}

## Поддерживаемые типы данных {#supported_types}

Ниже приведена таблица соответствия типов {{ CH }} и типов {{ yq-full-name }}.

|Тип данных {{ CH }}|Тип данных {{ yq-full-name }}|Примечания|
|---|----|------|
|`Bool`|`BOOL`||
|`Int8`|`INT8`||
|`UInt8`|`UINT8`||
|`Int16`|`INT16`||
|`UInt16`|`UINT16`||
|`Int32`|`INT32`||
|`UInt32`|`UINT32`||
|`Int64`|`INT64`||
|`UInt64`|`UINT64`||
|`Float32`|`FLOAT`||
|`Float64`|`DOUBLE`||
|`Date`|`DATE`||
|`DateTime`|`DATETIME`|Допустимый диапазон дат с 1970-01-01 00:00 и до 2105-12-31 23:59|
|`String`|`STRING`||
|`FixedString`|`STRING`|Нулевые байты `FixedString` переносятся в `STRING` без изменений|

Остальные типы данных не поддерживаются.

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
