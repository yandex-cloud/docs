# Трансфер данных
В [dedicated режиме работы](serverless-and-dedicated.md#dedicated) базы данных {{ ydb-name }} вы можете использовать [трансфер]({{ ydb.docs }}/concepts/transfer) для поставки данных из [топика]({{ ydb.docs }}/concepts/glossary#topic) в [таблицу]({{ ydb.docs }}/concepts/glossary#table). Трансфер запускается внутри базы данных, работает в фоновом режиме.
Трансфер способен читать данные из топиков, расположенных как в [базе данных]({{ ydb.docs }}/concepts/glossary#database), где он создаётся, так и в другой базе {{ ydb-short-name }} или [кластере]({{ ydb.docs }}/concepts/glossary#cluster) {{ ydb-short-name }}. Для чтения топика из другой базы данных при создании трансфера необходимо указать параметры подключения к этой базе. Целевая таблица должна находиться в той же базе данных, где создаётся трансфер.
[Создание]({{ ydb.docs }}/yql/reference/syntax/create-transfer) экземпляра трансфера, его [изменение]({{ ydb.docs }}/yql/reference/syntax/alter-transfer) и [удаление]({{ ydb.docs }}/yql/reference/syntax/drop-transfer) осуществляется с использованием YQL.
Пример создания трансфера описан в  статье [Трансфер — быстрый старт]({{ ydb.docs }}/recipes/transfer/quickstart).
## Создание трансфера, читающего данные из другой базы данных {{ ydb-name }} в {{ yandex-cloud }} {#other-database}
Для чтения топика из другой базы данных {{ ydb-name }} в {{ yandex-cloud }} поддержана авторизация через [{{ iam-name }}](../../iam/index.yaml).
Для создания трансфера с топиком, находящимся в другой базе данных, понадобятся дополнительные действия:
1. [Создать сервисный аккаунт](../../iam/operations/sa/create), где находится топик.
1. [Назначить сервисному аккаунту роли](../../iam/operations/sa/assign-role-for-sa):
   * Для чтения из потока данных: `ydb.viewer`.
   * Для автоматического добавления [читателя]({{ ydb.docs }}/concepts/glossary#consumer), если применимо: `ydb.admin`.
1. [Создать API-ключ](../../iam/operations/authentication/manage-api-keys.md) c областью действия `yc.ydb.topics.manage`.
В базе данных {{ ydb-short-name }} в облаке, где будет создан трансфер, добавьте секрет:
```yql
CREATE OBJECT example_secret (TYPE SECRET) WITH value="ApiKey <your_api_key>";
```
Где:
* `<your_api_key>` — API-ключ, созданный выше.
Создайте трансфер как описано в статье [Трансфер — быстрый старт]({{ ydb.docs }}/recipes/transfer/quickstart), но укажите параметры подключения к базе данных:
```yql
$transformation_lambda = ($msg) -> {
    ...
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
* `<endpoint>` — эндпоинт подключения к базе, где находится топик. Имеет вид `grpcs://lb.etn952fh3eo2jd2mrIhK.ydb.mdb.yandexcloud.net:2135/?database=/global/b1gvcqr959dbmi0e5c1B/etn77atb9o1epqUsCGoY`. Эндпоинт отображается в [консоли управления]({{ link-console-main }}), на странице потока данных, на вкладке Обзор, в поле Эндпоинт.
* `example_secret` — секрет, созданный выше.
## Смотрите также
* [Трансфер]({{ ydb.docs }}/concepts/transfer).
* [Трансфер — быстрый старт]({{ ydb.docs }}/recipes/transfer/quickstart).
* [Трансфер — поставка access-логов NGINX в таблицу]({{ ydb.docs }}/recipes/transfer/nginx).
* [CREATE TRANSFER]({{ ydb.docs }}/yql/reference/syntax/create-transfer).
* [ALTER TRANSFER]({{ ydb.docs }}/yql/reference/syntax/alter-transfer).
* [DROP TRANSFER]({{ ydb.docs }}/yql/reference/syntax/drop-transfer).
