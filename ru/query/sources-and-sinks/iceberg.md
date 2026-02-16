# Чтение данных из таблиц {{yq-iceberg-name}}

В этом разделе описана основная информация о работе с таблицами {{yq-iceberg-name}}.

Для чтения данных из таблицы {{yq-iceberg-name}}, расположенной в {{objstorage-full-name}}, необходимо выполнить следующие шаги:
1. Создать [соединение](../concepts/glossary.md#connection), содержащее реквизиты для подключения к каталогу {{yq-iceberg-name}}.
1. [Выполнить запрос](#query) к требуемой таблице из каталога.

Пример запроса, выполняющего чтение данных из таблицы {{yq-iceberg-name}}:

```
SELECT * FROM iceberg_connection.my_table
```
Где:

* `iceberg_connection` — название созданного соединения с каталогом {{yq-iceberg-name}}.
* `my_table` — имя таблицы в каталоге {{yq-iceberg-name}}.

## Настройка соединения {#create_connection}

Чтобы создать соединение с каталогом {{yq-iceberg-name}}:

1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать соединение.
1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
1. На панели слева перейдите на вкладку **{{ ui-key.yql.yq-ide-aside.connections.tab-text }}**.
1. Нажмите кнопку ![info](../../_assets/console-icons/plus.svg) **{{ ui-key.yql.yq-connection-form.action_create-new }}**.
1. Укажите параметры соединения:

   1. В блоке **{{ ui-key.yql.yq-connection-form.general-parameters.section-title }}**:

      * **{{ ui-key.yql.yq-connection-form.connection-name.input-label }}** — название соединения с каталогом {{yq-iceberg-name}}.
      * **{{ ui-key.yql.yq-connection-form.connection-type.input-label }}** — {{yq-iceberg-name}}.
  
   1. В блоке **{{ ui-key.yql.yq-connection-form.connection-type-parameters.section-title }}**:

      * **{{ ui-key.yql.yq-connection-form.bucket-auth.input-label }}** — выберите `{{ ui-key.yql.yq-connection-form.public.button-text }}` или `{{ ui-key.yql.yq-connection-form.private.button-text }}` в зависимости от типа доступа к чтению объектов в бакете.

        Для публичного бакета введите имя в поле **{{ ui-key.yql.yq-connection-form.bucket.input-label }}**.
        Для приватного бакета:
        * Выберите **{{ ui-key.yql.yq-connection-form.cloud.input-label }}**, в котором находится источник данных.
        * Выберите или создайте новый бакет.
        * Выберите или создайте новый [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) с ролью [`storage.viewer`](../../storage/security/index.md#storage-viewer), от имени которого будет осуществляться доступ к данным.

          {% include [service accounts role](../../_includes/query/service-accounts-role.md) %}
      * **{{ ui-key.yql.yq-connection-form.description_iceberg-directory }}** — директория с каталогом Hadoop в выбранном бакете.

1. Нажмите кнопку **{{ ui-key.yql.yq-connection-form.create.button-text }}**.

## Синтаксис запросов {#query}

Для работы с таблицами {{yq-iceberg-name}} используется следующая форма SQL-запроса:

```
SELECT * FROM <соединение>.<имя_таблицы>
```

Где:
* `<соединение>` — название созданного соединения с каталогом.
* `<имя_таблицы>` — имя таблицы {{yq-iceberg-name}} из каталога.

## Ограничения

При работе с таблицами {{yq-iceberg-name}} существует ряд ограничений:
* Можно выполнять запросы только к таблицам, созданным в соответствии с [версией 1](https://iceberg.apache.org/spec/#version-1-analytic-data-tables) спецификации {{yq-iceberg-name}}.
* Чтение таблиц возможно только из каталога Hadoop, размещенного в {{objstorage-full-name}}.
* Не поддерживается чтение предыдущих состояний (снапшотов) таблицы (time travel).

## Поддерживаемые типы данных

Перечень поддерживаемых типов данных {{yq-iceberg-name}} и соответствующие им типы {{ yql-short-name }}.

| Тип данных {{yq-iceberg-name}} | Тип данных {{yq-full-name}} |
| :---: | :---: | 
| `boolean` | `Bool` |
| `int` | `Int32` |
| `long` | `Int64` |
| `float` | `Float` |
| `double` | `Double` |
| `date` | `Date` |
| `time` | `Utf8` |
| `timestamp` | `Utf8` |
| `string` | `Utf8` |
| `binary` | `String` |

## Выделение значимой части данных (pruning)

Запрос к таблице {{yq-iceberg-name}} может содержать фильтры, которые строятся на основе WHERE-выражения. Эти фильтры используются для сокращения объема данных, требующих обработки. Процедура сокращения называется _выделение значимой части данных_ или _отсечение лишних данных_ (pruning).

Отсечение лишних данных выполняется как на этапе планирования операции чтения, так и на этапе чтения.

На этапе планирования:
* считывается метаинформация таблицы {{yq-iceberg-name}};
* определяется перечень файлов данных, требующих чтения (на основе статистики из метаданных);
* передаются отобранные файлы для чтения.

На этапе чтения: 
* файлы данных разбиваются на строковые группы (row groups);
* считывается статистика для строковых групп (row groups);
* определяется перечень групп, требующих чтения (на основе статистики);
* выполняется чтение данных из отобранных групп. 
