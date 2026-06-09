# Чтение данных из {{ yds-name }} с помощью соединений в {{ yq-name }}

При работе с {{ yds-full-name }} с помощью соединений удобно выполнять прототипирование, первоначальную настройку подключений к данным.

[{{ yds-full-name }}](../../data-streams/concepts/index.md) - это сервис, позволяющий передавать потоки данных сразу нескольким приложениям для обработки, при этом каждое приложение обрабатывает такие данные независимо от другого.

Пример чтения данных в формате `Json` из {{ yds-full-name }}.

```sql
SELECT
    JSON_VALUE(CAST(Data AS Json), "$.action") AS action
FROM yds.`input_stream`
WITH (
    format=raw,
    SCHEMA 
    (
        Data String
    )
)
LIMIT 10;
```

{% note info %}

Данные из потокового источника передаются в виде бесконечного потока. Чтобы остановить обработку и получить результат в консоли, данные в примере ограничены с помощь оператора `LIMIT`, который задает количество строк результата.

{% endnote %}

## Настройка соединения {#create_connection}

Для чтения данных из {{ yds-full-name }} необходимо:

1. [Перейти](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}** в раздел **{{ ui-key.yql.yq-ide-aside.connections.tab-text }}** и нажать кнопку **{{ ui-key.yql.yq-connection-form.action_create-new }}**.
1. В открывшемся окне в поле **{{ ui-key.yql.yq-connection-form.connection-name.input-label }}** указать название соединения с {{ yds-full-name }}.
1. В выпадающем поле **{{ ui-key.yql.yq-connection-form.connection-type.input-label }}** выбрать `{{ ui-key.yql.yq-connection.action_datastreams }}`.
1. В поле **{{ ui-key.yql.yq-connection-form.cloud.input-label }}** выберите расположение источника данных.
1. В выпадающем поле **{{ ui-key.yql.yq-connection-form.database.input-label }}** выбрать базу данных {{ ydb-full-name }}, где ранее был создан поток {{ yds-full-name }}.
1. В поле **{{ ui-key.yql.yq-connection-form.service-account.input-label }}** выбрать сервисный аккаунт, который будет использоваться для чтения данных, или создать новый, выдав ему права [`yds.editor`](../../data-streams/security/index.md#yds-editor).

   Чтобы использовать сервисный аккаунт, пользователю нужна [роль](../../iam/security/index.md#iam-serviceAccounts-user) `iam.serviceAccounts.user`.

1. Создать соединение, нажав кнопку **{{ ui-key.yql.yq-connection-form.create.button-text }}**.

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
|`yds`| |Название соединения с {{ yds-full-name }}|
|`input_stream`| |Название потока-источника данных в SQL-запросе|
|`host`|Строка|Строковый параметр запроса|
|`raw`|Строка|Формат данных. На данный поддерживается только формат `raw` - сырые данные|