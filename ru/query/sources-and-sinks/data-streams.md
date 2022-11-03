# Чтение данных из {{ yds-name }} с помощью подключений к {{ yq-full-name }}

При работе с {{ yds-full-name }} с помощью подключений удобно выполнять прототипирование, первоначальную настройку подключений к данным.

[{{ yds-full-name }}](../../data-streams/concepts/index.md) - это сервис, позволяющий передавать потоки данных сразу нескольким приложениям для обработки, при этом каждое приложение обрабатывает такие данные независимо от другого.

Пример чтения данных в формате `Json` из {{ yds-full-name }}.

```sql
SELECT
    JSON_VALUE(CAST(Data as Json), "$.action") as action
FROM yds.`input_stream`
WITH (
    format=raw,
    SCHEMA 
    (
        String as Data
    )
)
LIMIT 10;
```

 {% note info %}

 {% include [limit](../_includes/select-limit.md) %}

 {% endnote %}

## Настройка подключения { #create_connection }

Для чтения данных из {{ yds-full-name }} необходимо:

{% include [create-connection](../_includes/create-connection.md) %}

## Модель данных

Данные через {{yds-full-name }} передаются в бинарном виде. Чтение данных выполняется с помощью SQL-выражений. 

```sql
SELECT 
    <expression> 
FROM 
    <yds_connection_name>.`<stream_name>`
WITH
(
    format=raw,
    SCHEMA 
    (
        Data String
    )
)
WHERE <filter>;
```

Где:

- `yds_connection_name` — название подключения к потоку данных {{yds-short-name}}, созданного в предыдущем пункте.
- `stream_name` — название потока данных в {{yds-short-name}}.


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
    FROM yds.`input_stream`
    WITH 
    (
        format=raw,
        SCHEMA 
        (
            Data String
        )
    )
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
