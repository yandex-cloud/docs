# Работа с базами данных {{ ydb-name }}

В этом разделе описана основная информация про работу с [{{ ydb-name }}](https://yandex.cloud/ru/services/ydb).

Для работы с базой данных {{ ydb-name }} из {{ yq-full-name }} необходимо выполнить следующие шаги:
1. Создать [соединение](../concepts/glossary.md#connection), содержащее реквизиты для подключения к базе данных.
1. [Выполнить запрос](#query) к базе данных.

Пример запроса, выполняющего чтение данных из {{ ydb-name }}:

```sql
SELECT * FROM ydb_connection.my_table
```

где:
* `ydb_connection` — название созданного соединения с базой данных.
* `my_table` — имя таблицы в базе данных.


## Настройка соединения {#create_connection}

Чтобы создать соединение с {{ ydb-name }}:

1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать соединение.
1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
1. На панели слева перейдите на вкладку **{{ ui-key.yql.yq-ide-aside.connections.tab-text }}**.
1. Нажмите кнопку ![info](../../_assets/console-icons/plus.svg) **{{ ui-key.yql.yq-connection-form.action_create-new }}**.
1. Укажите параметры соединения:

   1. В блоке **{{ ui-key.yql.yq-connection-form.general-parameters.section-title }}**:

      * **{{ ui-key.yql.yq-connection-form.connection-name.input-label }}** — название соединения с {{ ydb-name }}.
      * **{{ ui-key.yql.yq-connection-form.connection-type.input-label }}** — `{{ ui-key.yql.yq-connection.action_ydb }}`.
   1. В блоке **{{ ui-key.yql.yq-connection-form.connection-type-parameters.section-title }}**:
      * **{{ ui-key.yql.yq-connection-form.cluster.input-label }}** — выберите существующую базу данных {{ ydb-name }} или создайте новую.
      * **{{ ui-key.yql.yq-connection-form.service-account.input-label }}** — выберите [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) {{ ydb-name }}, от имени которого будет выполняться подключение к кластерам `{{ ydb-name }}` и аутентификация в базе данных. Если сервисного аккаунта нет, создайте его и назначьте ему [роль](../../ydb/security/index.md#ydb-viewer) `ydb.viewer`.

        {% include [service accounts role](../../_includes/query/service-accounts-role.md) %}


1. Нажмите кнопку **{{ ui-key.yql.yq-connection-form.create.button-text }}**.

## Синтаксис запросов {#query}

Для работы с {{ ydb-name }} используется следующая форма SQL-запроса:

```sql
SELECT * FROM <соединение>.<имя_таблицы>
```

где:
* `<соединение>` — название созданного соединения с базой данных.
* `<имя_таблицы>` — имя таблицы в базе данных.

## Ограничения {#limits}

{% include [!](_includes/supported_requests.md) %}

## Пушдаун фильтров {#predicate_pushdown}

{% include [!](_includes/predicate_pushdown.md) %}

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
|`Utf8`|

## Поддерживаемые типы данных {#supported_types}

Ниже приведены таблицы соответствия типов данных в {{ ydb-name }} и {{ yq-full-name }}. Типы данных, не указанные в таблицах, не поддерживаются.

### Примитивные типы данных {#supported_types_default}

| Тип данных {{ ydb-name }} | Тип данных {{ yq-full-name }} |
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

| Тип данных {{ ydb-name }} | Тип данных {{ yq-full-name }} |
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

