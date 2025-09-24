# Трансфер данных
Трансфер в YDB — асинхронный механизм переноса данных из [топика]({{ ydb.docs }}/concepts/glossary#topic) в [таблицу]({{ ydb.docs }}/concepts/glossary#table). [Создание]({{ ydb.docs }}/yql/reference/syntax/create-transfer) экземпляра трансфера, его [изменение]({{ ydb.docs }}/yql/reference/syntax/alter-transfer) и [удаление]({{ ydb.docs }}/yql/reference/syntax/drop-transfer) осуществляется с использованием YQL. Трансфер запускается внутри базы данных и работает в фоновом режиме. Трансфер используется для решения задачи поставки данных из топика в таблицу.

В {{ ydb-name }} трансфер доступен только в [dedicated](serverless-and-dedicated.md#dedicated) режиме работы базы данных. Пример создания трансфера, который переносит данные внутри одной базы данных описан в  статье [Трансфер — быстрый старт]({{ ydb.docs }}/recipes/transfer/quickstart).

Трансфер может читать данные из топиков, которые находятся как в той же [базе данных]({{ ydb.docs }}/concepts/glossary#database), где он создаётся , так и в другой базе {{ ydb-short-name }} или [кластере]({{ ydb.docs }}/concepts/glossary#cluster) {{ ydb-short-name }}. Если нужно читать топик из другой базы, при создании трансфера нужно указать параметры подключения к ней. При этом целевая таблица всегда должна находиться в базе данных, где создаётся сам трансфер.

Для чтения топика из другой базы данных {{ ydb-name }} в {{ yandex-cloud }} поддержана авторизация через [{{ iam-name }}](../../iam/index.yaml).

## Создание трансфера, читающего данные из другой базы данных {{ ydb-name }} в {{ yandex-cloud }} {#other-database}

### Подготовьте API-ключ для доступа к топику

{% note info %}

Действия по подготовке API-ключа нужно выполнять в том облаке, где находится база данных с исходным топиком.

{% endnote %}

1. [Создать сервисный аккаунт](../../iam/operations/sa/create), где находится топик.
1. [Назначить сервисному аккаунту роли](../../iam/operations/sa/assign-role-for-sa):
   * Для чтения из потока данных: `ydb.viewer`.
   * Для автоматического добавления [читателя]({{ ydb.docs }}/concepts/glossary#consumer), если применимо: `ydb.admin`.
1. [Создать API-ключ](../../iam/operations/authentication/manage-api-keys.md) c областью действия `yc.ydb.topics.manage`.

### Создайте секрет для доступа к топику в базе источнике

В облаке, где будет создан трансфер, добавьте секрет:
```yql
CREATE OBJECT example_secret (TYPE SECRET) WITH value="ApiKey <your_api_key>";
```

Где:
* `<your_api_key>` — API-ключ, созданный выше.

### Создайте топик

Создайте топик, из которого трансфер будет читать данные. Это можно сделать с помощью SQL-запроса:

```yql
CREATE TOPIC `transfer_recipe/source_topic`;
```

Топик `transfer_recipe/source_topic` позволяет передавать любые неструктурированные данные.

### Создайте таблицу

После создания топика следует создать таблицу, в которую будут поступать данные из топика `source_topic`. Это можно сделать с помощью SQL-запроса:

```yql
CREATE TABLE `transfer_recipe/target_table` (
  partition Uint32 NOT NULL,
  offset Uint64 NOT NULL,
  data String,
  PRIMARY KEY (partition, offset)
);
```

Таблица `transfer_recipe/target_table` имеет три столбца:

* `partition` — идентификатор [партиции]({{ ydb.docs }}/concepts/glossary.md#partition) топика, из которой получено сообщение;
* `offset` — [порядковый номер]({{ ydb.docs }}/concepts/glossary.md#offset), идентифицирующий сообщение внутри партиции;
* `data` — тело сообщения.

### Создайте трансфер

После создания топика и таблицы нужно добавить трансфер данных, который будет переносить сообщения из топика в таблицу. Это можно сделать с помощью SQL-запроса:

```yql
$transformation_lambda = ($msg) -> {
    return [
        <|
            partition: $msg._partition,
            offset: $msg._offset,
            data: $msg._data
        |>
    ];
};
CREATE TRANSFER `transfer_recipe/example_transfer`
  FROM `transfer_recipe/source_topic` TO `transfer_recipe/target_table`
  USING $transformation_lambda
WITH (
    CONNECTION_STRING = '<endpoint>',
    TOKEN_SECRET_NAME = 'example_secret'
)
```

Где:
* `<endpoint>` — эндпоинт подключения к базе источнику, где находится топик. Имеет вид `grpcs://lb.etn952fh3eo2jd2mrIhK.ydb.mdb.yandexcloud.net:2135/?database=/global/b1gvcqr959dbmi0e5c1B/etn77atb9o1epqUsCGoY`. Эндпоинт отображается в [консоли управления]({{ link-console-main }}), на странице потока данных, на вкладке Обзор, в поле Эндпоинт.
* `example_secret` — секрет, созданный выше.

### Проверьте работу трансфера
Для проверки правильной работы трансфера можно записать в топик несколько сообщений.

Через некоторое время после того, как сообщения будут добавлены в топик source_topic, соответствующие записи появятся в таблице transfer_recipe/target_table. Чтобы убедиться в этом, выполните следующий SQL-запрос:

```yql
SELECT *
FROM `transfer_recipe/target_table`;
```


## Смотрите также
* [Трансфер]({{ ydb.docs }}/concepts/transfer).
* [Трансфер — быстрый старт]({{ ydb.docs }}/recipes/transfer/quickstart).
* [Трансфер — поставка access-логов NGINX в таблицу]({{ ydb.docs }}/recipes/transfer/nginx).
* [CREATE TRANSFER]({{ ydb.docs }}/yql/reference/syntax/create-transfer).
* [ALTER TRANSFER]({{ ydb.docs }}/yql/reference/syntax/alter-transfer).
* [DROP TRANSFER]({{ ydb.docs }}/yql/reference/syntax/drop-transfer).