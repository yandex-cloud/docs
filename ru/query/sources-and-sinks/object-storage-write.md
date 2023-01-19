# Запись данных в {{ objstorage-full-name }}

Пример записи данных в формате `JSON` в {{ objstorage-full-name }}.

```sql
INSERT INTO bindings.`my_binding` 
SELECT
    "value" as value, "name" as name
FROM 
    $data;
```

Список поддерживаемых форматов и алгоритмов сжатия данных приведен в разделе [Форматы записи](formats.md#write).

## Запись данных через подключения

Запись данных выполняется с помощью SQL-выражений и в общем случае выглядит следующим образом:

```sql
INSERT INTO `<connection_name>`.`<bucket_path>`
    WITH
    (
        format='<format>',
        compression='<compression>'
    )
    <expression> 
FROM 
   <query>
```

Где:

- `connection_name` — название подключения к {{objstorage-full-name}}.
- `bucket_path` — путь в бакете, где будут сохранены.
- `query` — запрос-источник данных {{ yq-full-name }}.

Запись данные с помощью подключений удобно использовать для прототипирования, первоначальную настройку работы с записью данных.

Для записи данных в бакеты {{objstorage-full-name}} необходимо предварительно создать [подключение](object-storage.md) к {{objstorage-full-name}}. 


### Пример

Пример запроса записи данных в {{ yds-full-name }} с использованием подключений.

```sql
INSERT INTO `connection`.`test/` 
    WITH
    (
        format='csv_with_names'
    )
SELECT
    "value" as value, "name" as name
```

Где:

|Поле|Тип|Описание|
|--|---|---|
|`connection`| |Название подключения к {{ objstorage-full-name }}|
|`test/`| |Путь внутри бакета {{objstorage-full-name}}, куда будут записаны данные|



## Запись данных через привязки к данными

Запись данных выполняется с помощью SQL-выражений и в общем случае выглядит следующим образом:

```sql
INSERT INTO bindings.`<binding_name>`
    WITH
    (
        format='<format>',
        compression='<compression>'
    )
    <expression> 
FROM 
   <query>
```

Где:

- `binding_name` — название привязки к данным в {{objstorage-full-name}}.
- `query` — запрос-источник данных {{ yq-full-name }}.

Запись данные с помощью привязок к данным удобно использовать для регулярных процессов без необходимости указывать все детали работы с этими данными. 

Для записи данных в бакеты {{objstorage-full-name}} необходимо предварительно создать [привязку к данным](object-storage-binding.md) к {{objstorage-full-name}}. 


### Пример

Пример запроса записи данных в {{ yds-full-name }} с помощью привязок к данным.

```sql
INSERT INTO bindings.`test` 
SELECT
    "value" as value, "name" as name
```

Где:

|Поле|Тип|Описание|
|--|---|---|
|bindings| |Ключевое слово, означающее, что запись выполняется через привязки к данным|
|`test`| |Название привязки к данным в {{ objstorage-full-name }}|

## Поддерживаемые форматы записи

{% include [!](../_includes/supported-objstorage-write-formats.md) %}
