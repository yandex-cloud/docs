# Чтение данных из {{ yds-full-name }}

[{{ yds-full-name }}](../../data-streams/concepts/index.md) - это сервис, позволяющий передавать потоки данных сразу нескольким приложениям для обработки, при этом каждое приложение обрабатывает такие данные независимо от другого.

Пример чтения данных в формате `Json` из {{ yds-full-name }}.

```sql
SELECT
    JSON_VALUE(CAST(Data as Json), "$.action") as action
FROM yds.object(`input_stream`, raw)
    WITH SCHEMA (String as Data)
LIMIT 10;
```

 {% note info %}

 {% include [limit](../../_includes/query/select-limit.md) %}

 {% endnote %}

## Настройка подключения 

Для чтения данных из {{ yds-full-name }} необходимо:

{% include [create-connection](../../_includes/query/create-connection.md) %}

## Модель данных

Данные через {{yds-full-name }} передаются в бинарном виде. Чтение данных выполняется с помощью SQL-выражений. 

```sql
SELECT 
    <expression> 
FROM 
    <yds_connection_name>.object(<stream_name>, raw)
WITH SCHEMA (String as Data)
WHERE <filter>;
```

Где:

- `yds_connection_name` — название подключения к потоку данных {{yds-short-name}}, созданного в предыдущем пункте.
- `stream_name` — название потока данных в {{yds-short-name}}.

{% note info %}

Так как через {{yds-short-name}} передаются бинарные данные, то их нельзя схематизировать. Вместо этого необходимо использовать ключевую конструкцию `WITH SCHEMA (String as Data)`, которая присваивает тип `String` вводимым данным и дает им название `Data`.

{% endnote %}

## Пример чтения данных

Пример запроса для чтения данных из {{ yds-full-name }} и записи результатов в {{ yds-full-name }}.

```sql
$data = 
SELECT 
    JSON_VALUE(Data, "$.host") as host,
    JSON_VALUE(Data, "$.count") as count,
    JSON_VALUE(Data, "$.tag") as tag,    
FROM 
(
    SELECT
        CAST(Data as Json) as Data
    FROM yds.object(`input_stream`, raw)
        WITH SCHEMA (String as Data)
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
|`yds`| |Название подключения к {{ yds-full-name }}|
|`input_stream`| |Название потока-источника данных в SQL-запросе|
|`host`|Строка|Строковый параметр запроса|
|`raw`|Строка|Формат данных. На данный поддерживается только формат `raw` - сырые данные|

