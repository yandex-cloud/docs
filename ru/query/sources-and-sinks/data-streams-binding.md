---
title: Чтение данных с помощью привязок к данным
description: Из статьи вы узнаете, как создать привязку к данным и читать данные из {{ yds-full-name }} с помощью {{ yq-full-name }}.
---

# Чтение данных с помощью привязок к данным

Привязки к данным позволяют регулярно выполнять запросы к данным {{ yds-full-name }}, не указывая параметры подключения и формат данных в каждом запросе.

Пример чтения данных с помощью привязки к данным:

```sql
SELECT
    JSON_VALUE(CAST(Data AS Json), "$.action") AS action
FROM bindings.`input_stream`
LIMIT 10;
```

{% include [limit](../_includes/select-limit.md) %}

## Настройка привязки к данным {#binding-settings}

Чтобы создать привязку для чтения данных из {{ yds-full-name }}:

1. [Настройте соединение с данными](./data-streams.md#create_connection).
1. [Перейдите]({{ link-console-yq }}) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
1. На панели слева перейдите на вкладку **{{ ui-key.yql.yq-ide-aside.bindings.tab-text }}**.
1. Нажмите кнопку ![info](../../_assets/console-icons/plus.svg) **{{ ui-key.yql.yq-binding-add.create-binding.button-text }}**.
1. В блоке **{{ ui-key.yql.yq-binding-form.connection-parameters.title }}**:

   1. В поле **{{ ui-key.yql.yq-binding-form.connection-type.title }}** выберите `{{ ui-key.yql.yq-connection.action_datastreams }}`.
   1. В поле **{{ ui-key.yql.yq-binding-form.connection.title }}** выберите соединение, созданное на первом шаге.

1. В блоке **{{ ui-key.yql.yq-binding-form.binding-parameters.title }}**:

   1. В поле **{{ ui-key.yql.yq-binding-form.binding-name.title }}** укажите название привязки к данным.
   1. В поле **{{ ui-key.yql.yq-binding-form.binding-stream.title }}** укажите название потока данных {{ yds-full-name }}.
   1. В поле **{{ ui-key.yql.yq-binding-info.compression.label-text }}** укажите способ [сжатия данных](formats.md#compression).
   1. В поле **{{ ui-key.yql.yq-binding-info.format.label-text }}** укажите [формат передаваемых данных](formats.md#formats).
   1. В полях **{{ ui-key.yql.yq-binding-form.binding-fields.title }}** укажите список колонок и их типы данных.

1. Для проверки данных нажмите кнопку **{{ ui-key.yql.yq-binding-form.binding-preview.button-text }}**.
1. Нажмите кнопку **{{ ui-key.yql.yq-binding-form.binding-create.button-text }}**.

## Модель данных {#data-model}

Данные через {{ yds-full-name }} передаются в бинарном виде. Для чтения данных с помощью привязки используйте SQL-выражение следующего вида:

```sql
SELECT
    <выражение>
FROM bindings.`<имя_привязки>`
WHERE
    <фильтр>;
```

Где:

* `<выражение>` — выражение, определяющее результат запроса;
* `<имя_привязки>` — название ранее созданной привязки к данным;
* `<фильтр>` — условие фильтрации данных.

## Пример чтения данных {#binding-example}

Пример запроса для чтения данных из {{ yds-full-name }} с помощью привязки к данным:

```sql
$data =
SELECT
    JSON_VALUE(Data, "$.host") AS host,
    JSON_VALUE(Data, "$.count") AS count,
    JSON_VALUE(Data, "$.tag") AS tag,
FROM
(
    SELECT
        CAST(Data AS Json) AS Data
    FROM bindings.`binding_name`
)
WHERE
    JSON_VALUE(Data, "$.tag") = "my_tag";

SELECT
    *
FROM
    $data
LIMIT 10;
```

Где:

#|
|| **Поле** | **Тип** | **Описание** ||
|| `binding_name` |  | Название привязки к потоку-источнику данных. ||
|| `host` | Строка | Название хоста. ||
|| `count` | Строка | Количество событий. ||
|| `tag` | Строка | Тег события. ||
|#
