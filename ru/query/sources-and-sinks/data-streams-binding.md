# Чтение данных с помощью привязок к данным в {{ yq-name }}

При работе с {{ yds-full-name }} с помощью привязок к данным удобно выполнять запросы к хранимым данным на регулярной основе без необходимости указывать все детали работы с этими данными.


Пример чтения данных из привязок к данным:

```sql
SELECT
    JSON_VALUE(CAST(Data as Json), "$.action") as action
FROM bindings.`input_stream`
LIMIT 10;
```

 {% note info %}

 {% include [limit](../_includes/select-limit.md) %}

 {% endnote %}


## Настройка привязки к данным

Для чтения данных из {{ yds-full-name }} c помощью привязок к данным необходимо:
1. [Настроить подключение к данным](./data-streams.md#create_connection).
1. В поле тип выбрать `Data Streams`.
1. В выпадающем поле `Соединение` выбрать соединение, созданное в первом пункте.
1. В поле `Name` указать название привязки к данным.
1. В поле `Поток` указать название потока данных {{ yds-full-name }}. 
1. В поле `Сжатие` указать способ [сжатия данных](formats.md#compression).
1. В поле `Формат` указать [формат передаваемых данных](formats.md#formats).
1. В полях `Колонки` указать список колонок в данных и их типы данных. 
1.  Для проверки данных нажать кнопку `Предпросмотр`.
1. Создать привязку к данным, нажав кнопку `Create`.

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
