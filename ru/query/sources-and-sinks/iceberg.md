---
title: Чтение данных из таблиц {{ yq-iceberg-name }}
description: Из статьи вы узнаете, как подключиться к каталогу {{ yq-iceberg-name }} и читать данные из таблиц с помощью {{ yq-full-name }}.
---

# Чтение данных из таблиц {{ yq-iceberg-name }}

В этом разделе описана основная информация о работе с таблицами {{ yq-iceberg-name }}.

Чтобы прочитать данные из таблицы {{ yq-iceberg-name }}, расположенной в {{ objstorage-full-name }}:

1. Создайте [соединение](../concepts/glossary.md#connection), содержащее реквизиты для подключения к каталогу {{ yq-iceberg-name }}.
1. [Выполните запрос](#query) к требуемой таблице из каталога.

Пример запроса для чтения данных из таблицы {{ yq-iceberg-name }}:

```sql
SELECT * FROM iceberg_connection.my_table
```
Где:

* `iceberg_connection` — название созданного соединения с каталогом {{ yq-iceberg-name }}.
* `my_table` — имя таблицы в каталоге {{ yq-iceberg-name }}.

## Настройка соединения {#create-connection}

Чтобы создать соединение с каталогом {{ yq-iceberg-name }}:

1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать соединение.
1. [Перейдите]({{ link-console-yq }}) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
1. На панели слева выберите **{{ ui-key.yql.yq-ide-aside.connections.tab-text }}**.
1. Нажмите кнопку ![info](../../_assets/console-icons/plus.svg) **{{ ui-key.yql.yq-connection-form.action_create-new }}**.
1. Укажите параметры соединения:

   1. В блоке **{{ ui-key.yql.yq-connection-form.general-parameters.section-title }}**:

      * **{{ ui-key.yql.yq-connection-form.connection-name.input-label }}** — название соединения с каталогом {{ yq-iceberg-name }}.
      * **{{ ui-key.yql.yq-connection-form.connection-type.input-label }}** — {{ yq-iceberg-name }}.
  
   1. В блоке **{{ ui-key.yql.yq-connection-form.connection-type-parameters.section-title }}**:

      * **{{ ui-key.yql.yq-connection-form.bucket-auth.input-label }}** — выберите `{{ ui-key.yql.yq-connection-form.public.button-text }}` или `{{ ui-key.yql.yq-connection-form.private.button-text }}` в зависимости от типа доступа к чтению объектов в бакете.

        Для публичного бакета введите имя в поле **{{ ui-key.yql.yq-connection-form.bucket.input-label }}**.
        Для приватного бакета:

        * Выберите **{{ ui-key.yql.yq-connection-form.cloud.input-label }}**, в котором находится источник данных.
        * Выберите или создайте бакет.
        * Выберите или создайте [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) с ролью [`storage.viewer`](../../storage/security/index.md#storage-viewer), от имени которого будет выполняться доступ к данным.

          {% include [service accounts role](../../_includes/query/service-accounts-role.md) %}
      * **{{ ui-key.yql.yq-connection-form.description_iceberg-directory }}** — директория с каталогом Hadoop в выбранном бакете.

1. Нажмите кнопку **{{ ui-key.yql.yq-connection-form.create.button-text }}**.

## Синтаксис запросов {#query}

Для работы с таблицами {{ yq-iceberg-name }} используется следующая форма SQL-запроса:

```sql
SELECT * FROM <соединение>.<имя_таблицы>
```

Где:

* `<соединение>` — название созданного соединения с каталогом.
* `<имя_таблицы>` — имя таблицы {{ yq-iceberg-name }} из каталога.

## Ограничения {#limits}

При работе с таблицами {{ yq-iceberg-name }} действуют следующие ограничения:

* Можно выполнять запросы только к таблицам, созданным в соответствии с [версией 1](https://iceberg.apache.org/spec/#version-1-analytic-data-tables) спецификации {{ yq-iceberg-name }}.
* Чтение таблиц возможно только из каталога Hadoop, размещенного в {{ objstorage-full-name }}.
* Не поддерживается чтение предыдущих состояний (снапшотов) таблицы (time travel).

## Поддерживаемые типы данных {#supported-types}

Ниже приведены поддерживаемые типы данных {{ yq-iceberg-name }} и соответствующие им типы {{ yql-short-name }}.

| Тип данных {{ yq-iceberg-name }} | Тип данных {{ yq-full-name }} |
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

## Выделение значимой части данных (pruning) {#pruning}

Запрос к таблице {{ yq-iceberg-name }} может содержать фильтры, которые строятся на основе WHERE-выражения. Эти фильтры используются для сокращения объема данных, требующих обработки. Процедура сокращения называется _выделение значимой части данных_ или _отсечение лишних данных_ (pruning).

Отсечение лишних данных выполняется как на этапе планирования операции чтения, так и на этапе чтения.

На этапе планирования выполняются следующие действия:

* считывается метаинформация таблицы {{ yq-iceberg-name }};
* определяется перечень файлов данных, требующих чтения (на основе статистики из метаданных);
* передаются отобранные файлы для чтения.

На этапе чтения выполняются следующие действия:

* файлы данных разбиваются на строковые группы (row groups);
* считывается статистика для строковых групп (row groups);
* определяется перечень групп, требующих чтения (на основе статистики);
* выполняется чтение данных из отобранных групп. 
