# Чтение данных с помощью привязок к данным в {{ yq-name }}

При работе с {{ yds-full-name }} с помощью привязок к данным удобно выполнять запросы к хранимым данным на регулярной основе без необходимости указывать все детали работы с этими данными.

Пример чтения данных из привязок к данным:

```sql
SELECT
    JSON_VALUE(CAST(Data AS Json), "$.action") AS action
FROM bindings.`input_stream`
LIMIT 10;
```

{% include [limit](../_includes/select-limit.md) %}

## Настройка привязки к данным

Для чтения данных из {{ yds-full-name }} c помощью привязок к данным необходимо:

1. [Настроить соединение с данными](./data-streams.md#create_connection).
1. В поле **{{ ui-key.yql.yq-binding-form.connection-type.title }}** выбрать `{{ ui-key.yql.yq-connection.datastreams.select-item }}`.
1. В выпадающем поле **{{ ui-key.yql.yq-binding-form.connection.title }}** выбрать соединение, созданное в первом пункте.
1. В поле **{{ ui-key.yql.yq-binding-form.binding-name.title }}** указать название привязки к данным.
1. В поле **{{ ui-key.yql.yq-binding-form.binding-stream.title }}** указать название потока данных {{ yds-full-name }}.
1. В поле **{{ ui-key.yql.yq-binding-info.compression.label-text }}** указать способ [сжатия данных](formats.md#compression).
1. В поле **{{ ui-key.yql.yq-binding-info.format.label-text }}** указать [формат передаваемых данных](formats.md#formats).
1. В полях **{{ ui-key.yql.yq-binding-form.binding-fields.title }}** указать список колонок в данных и их типы данных.
1. Для проверки данных нажать кнопку **{{ ui-key.yql.yq-binding-form.binding-preview.button-text }}**.
1. Создать привязку к данным, нажав кнопку **{{ ui-key.yql.yq-binding-form.binding-create.button-text }}**.

## Модель данных

Данные через {{ yds-full-name }} передаются в бинарном виде. Чтение данных выполняется с помощью SQL-выражений. 

```sql
SELECT 
    <выражение> 
FROM 
    <соединение>.<имя_потока>
WITH
(
    format=raw,
    SCHEMA 
    (
        Data String
    )
)
WHERE <фильтр>;
```

Где:

- `<соединение>` — название соединения с потоком данных {{ yds-short-name }}, созданного в предыдущем пункте.
- `<имя_потока>` — название потока данных в {{ yds-short-name }}.

## Пример чтения данных

Пример запроса для чтения данных из {{ yds-full-name }} и записи результатов в {{ yds-full-name }}.

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

|Поле|Тип|Описание|
|--|---|---|
|`binding_name`| |Название привязки данных к потоку-источнику данных в SQL-запросе|
|`host`|Строка|Строковый параметр запроса|
