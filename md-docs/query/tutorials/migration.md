[Документация Yandex Cloud](../../index.md) > [Yandex Query](../index.md) > [Практические руководства](index.md) > Миграция с Yandex Query

# Миграция с Yandex Query

{% note warning %}

С 13 октября 2026 года сервис Yandex Query будет недоступен для новых пользователей.

Текущие пользователи смогут создавать и изменять сущности до 10 ноября 2026 года. После этого сервис перейдет в режим read-only, а 14 декабря 2026 года прекратит работу. Подробнее о сроках и порядке закрытия читайте на странице [Закрытие сервиса Yandex Query](../sunset.md).

{% endnote %}

После закрытия Yandex Query вы можете работать с данными одним из следующих способов:

* **Прямое чтение из Object Storage.** Читайте данные из бакета S3-совместимыми утилитами, библиотеками или вашим приложением.
* **Yandex Managed Service for YDB.** Выполняйте федеративные запросы к файлам в Object Storage через внешние источники данных и внешние таблицы. Результаты можно записывать в выходной бакет.

{% note warning %}

Соединения, привязки к данным и запросы Yandex Query автоматически не переносятся. Создайте их заново по инструкции ниже. Закрытие Yandex Query не затрагивает данные в бакетах Object Storage.

Руководство описывает перенос аналитических запросов. Для потоковых запросов Yandex Query прямого аналога в Yandex Cloud нет.

{% endnote %}

## Как выбрать целевое решение {#choice}

В разделе приведено краткое сравнение способов работы с данными после закрытия Yandex Query.

#|
|| **Сценарий** | **Как вы используете Yandex Query** ||
|| [Прямое чтение из Object Storage](#direct-read) | Читаете файлы, например детализацию биллинга в CSV-формате, и обрабатываете их в приложении. ||
|| [Федеративные запросы в Yandex Managed Service for YDB](#ydb-federated) | Регулярно выполняете аналитические запросы к файлам в бакете, храните тексты запросов в коде или используете привязки к данным. ||
|| [Колоночные таблицы в Yandex Managed Service for YDB](#ydb-column-tables) | Строите дашборды с частым обновлением или многократно читаете одни и те же данные. ||
|#

Выбирайте прямое чтение из Object Storage, если:

* обработка данных уже реализована в вашем приложении;
* запросы простые и не требуют SQL;
* вы читаете файлы нерегулярно или однократно.

Выбирайте федеративные запросы в Yandex Managed Service for YDB, если:

* данные должны оставаться в бакете;
* вы хотите сохранить SQL-запросы и привычную модель работы с внешними данными;
* одни и те же файлы не читаются многократно.

Выбирайте колоночные таблицы в Yandex Managed Service for YDB, если:

* одни и те же данные используются в регулярных запросах или дашбордах;
* важна скорость повторяющихся аналитических запросов;
* вы готовы загружать данные из бакета в базу данных.

{% note tip %}

Если вы использовали Yandex Query для SQL-запросов к файлам в Object Storage, начните с федеративных запросов в Yandex Managed Service for YDB. Этот вариант требует меньше изменений в запросах и не требует переносить исходные данные из бакета.

{% endnote %}

Модели оплаты отличаются. В Yandex Query оплачивается объем данных, прочитанных запросами. При прямом чтении из Object Storage оплачиваются операции и исходящий трафик. В Yandex Managed Service for YDB оплачиваются выделенные вычислительные ресурсы и хранилище базы данных независимо от числа запросов. Подробнее о стоимости ресурсов читайте в разделах [Правила тарификации Object Storage](../../storage/pricing.md) и [Правила тарификации Yandex Managed Service for YDB](../../ydb/pricing/index.md).

## Прямое чтение из Object Storage {#direct-read}

Сценарий подходит, если всю необходимую обработку данных вы выполняете на своей стороне.

### Перед началом работы {#direct-read-before-you-begin}

1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md), от имени которого будет выполняться чтение.

1. Назначьте сервисному аккаунту роль [`storage.viewer`](../../storage/security/index.md#storage-viewer) на бакет или каталог, в котором он находится.

1. [Создайте статический ключ доступа](../../iam/operations/authentication/manage-access-keys.md#create-access-key) для сервисного аккаунта.

   Сохраните значения `key_id` и `secret`: секретный ключ больше не будет показан.

### Прочитайте данные {#direct-read-query}

{% list tabs group=instructions %}

- AWS CLI {#aws-cli}

  1. [Настройте AWS CLI](../../storage/tools/aws-cli.md) с ключом сервисного аккаунта.

  1. Посмотрите список файлов:

     ```bash
     aws --endpoint-url=https://storage.yandexcloud.net \
       s3 ls s3://<имя_бакета>/<префикс>/
     ```

  1. Скачайте файлы:

     ```bash
     aws --endpoint-url=https://storage.yandexcloud.net \
       s3 cp s3://<имя_бакета>/<префикс>/ ./data/ --recursive
     ```

- Python {#python}

  Пример читает CSV-файлы с заданным префиксом и считает сумму по колонке, как это делал бы запрос `SELECT service_name, SUM(cost) ... GROUP BY service_name` в Yandex Query. Названия колонок сверьте с заголовком ваших файлов.

  ```python
  import boto3
  import pandas as pd

  s3 = boto3.client(
      "s3",
      endpoint_url="https://storage.yandexcloud.net",
      aws_access_key_id="<идентификатор_ключа>",
      aws_secret_access_key="<секретный_ключ>",
  )

  frames = []
  paginator = s3.get_paginator("list_objects_v2")
  for page in paginator.paginate(Bucket="<имя_бакета>", Prefix="<префикс>/"):
      for obj in page.get("Contents", []):
          if obj["Key"].endswith(".csv"):
              body = s3.get_object(Bucket="<имя_бакета>", Key=obj["Key"])["Body"]
              frames.append(pd.read_csv(body))

  df = pd.concat(frames)
  print(df.groupby("service_name")["cost"].sum().sort_values(ascending=False))
  ```

{% endlist %}

## Yandex Managed Service for YDB {#ydb}

### Соответствие сущностей {#ydb-mapping}

#|
|| **Yandex Query** | **Yandex Managed Service for YDB** ||
|| Соединение с Object Storage | [Внешний источник данных](https://ydb.tech/docs/ru/concepts/datamodel/external_data_source) `CREATE EXTERNAL DATA SOURCE` с `SOURCE_TYPE = "ObjectStorage"` ||
|| Привязка к данным | [Внешняя таблица](https://ydb.tech/docs/ru/concepts/datamodel/external_table) `CREATE EXTERNAL TABLE` ||
|| Обращение к привязке `bindings.<имя_привязки>` | Обращение к внешней таблице по имени: `<имя_таблицы>` ||
|| Аутентификация через сервисный аккаунт | Статический ключ доступа сервисного аккаунта, сохраненный в [секретах](https://ydb.tech/docs/ru/concepts/datamodel/secrets) базы данных ||
|| Чтение файлов по маске, партиционирование, `partition projection` | Поддерживаются с тем же синтаксисом ||
|| Форматы `csv_with_names`, `tsv_with_names`, `json_each_row`, `json_list`, `json_as_string`, `parquet`, `raw` | Поддерживаются ||
|| Запись результата в бакет `INSERT INTO <соединение>.<путь>` | Поддерживается с тем же синтаксисом ||
|| Соединения с Managed Service for PostgreSQL, Managed Service for ClickHouse®, Managed Service for MySQL® и Yandex MPP Analytics for PostgreSQL | [Федеративные запросы](https://ydb.tech/docs/ru/concepts/query_execution/federated_query/) к внешним базам данных ||
|| Потоковые запросы к Yandex Data Streams | Нет аналога ||
|| Соединение с Monitoring | Нет аналога ||
|| Сохраненные запросы | Храните тексты запросов в своем репозитории ||
|#

### Перед началом работы {#ydb-before-you-begin}

1. [Создайте базу данных](../../ydb/operations/manage-databases.md#create-db-dedicated) Yandex Managed Service for YDB с выделенными ресурсами в том же облаке, где находятся бакеты с данными.

   {% note info %}

   Внешние источники данных доступны только в базах данных с выделенными ресурсами. В базе данных в режиме Serverless запрос к внешнему источнику завершится ошибкой `External data sources are disabled`.

   {% endnote %}

1. Назначьте пользователю, который будет переносить запросы, роль [`ydb.editor`](../../ydb/security/index.md#ydb-editor) на базу данных.

1. Создайте сервисный аккаунт и статический ключ доступа, как описано в разделе [Прямое чтение из Object Storage](#direct-read-before-you-begin). Если запросы записывают результаты в бакет, дополнительно назначьте сервисному аккаунту роль [`storage.uploader`](../../storage/security/index.md#storage-uploader).

1. Сохраните тексты запросов, параметры соединений и привязок из Yandex Query: имена, пути в бакете, формат, сжатие, схему и настройки партиционирования.

### Федеративные запросы: чтение файлов из Object Storage {#ydb-federated}

Сценарий повторяет работу Yandex Query: данные остаются в бакете, база читает их при каждом запросе.

#### Создайте внешний источник данных {#ydb-data-source}

1. Сохраните статический ключ в секретах базы данных:

   ```yql
   CREATE SECRET s3_key_id WITH (value = "<идентификатор_ключа>");
   CREATE SECRET s3_secret_key WITH (value = "<секретный_ключ>");
   ```

1. Создайте внешний источник данных. Чтобы не менять тексты запросов, назовите его так же, как соединение в Yandex Query:

   ```yql
   CREATE EXTERNAL DATA SOURCE <имя_соединения> WITH (
       SOURCE_TYPE = "ObjectStorage",
       LOCATION = "https://storage.yandexcloud.net/<имя_бакета>/",
       AUTH_METHOD = "AWS",
       AWS_ACCESS_KEY_ID_SECRET_PATH = "s3_key_id",
       AWS_SECRET_ACCESS_KEY_SECRET_PATH = "s3_secret_key",
       AWS_REGION = "ru-central1"
   );
   ```

   Для публичного бакета секреты не нужны: укажите `AUTH_METHOD = "NONE"` и не указывайте параметры `AWS_*`.

1. Проверьте, что база читает бакет:

   ```yql
   SELECT *
   FROM <имя_соединения>.`<путь>/`
   WITH (
       FORMAT = "csv_with_names",
       WITH_INFER = "true"
   )
   LIMIT 10;
   ```

#### Перенесите привязки к данным {#ydb-bindings}

Для каждой привязки создайте внешнюю таблицу с теми же колонками, форматом и сжатием:

```yql
CREATE EXTERNAL TABLE <имя_привязки> (
    date Date NOT NULL,
    service_name Utf8,
    cost Double
) WITH (
    DATA_SOURCE = "<имя_соединения>",
    LOCATION = "<путь>/",
    FORMAT = "csv_with_names",
    COMPRESSION = "gzip"
);
```

Если в привязке настроено партиционирование или `partition projection`, перенесите параметры `PARTITIONED_BY` и `projection.*` без изменений.

#### Перенесите запросы {#ydb-queries}

Запросы к соединениям переносятся без изменений, если имя внешнего источника совпадает с именем соединения. В запросах к привязкам уберите префикс `bindings.`:

{% list tabs %}

- Yandex Query

  ```yql
  SELECT service_name, SUM(cost) AS total
  FROM bindings.`billing`
  WHERE date >= Date("2026-09-01")
  GROUP BY service_name
  ORDER BY total DESC;
  ```

- Yandex Managed Service for YDB

  ```yql
  SELECT service_name, SUM(cost) AS total
  FROM billing
  WHERE date >= Date("2026-09-01")
  GROUP BY service_name
  ORDER BY total DESC;
  ```

{% endlist %}

Запросы можно выполнять в консоли управления, с помощью [YDB CLI](https://ydb.tech/docs/ru/reference/ydb-cli/) или [SDK](https://ydb.tech/docs/ru/reference/ydb-sdk/). Например, чтобы сохранить результат в CSV-файл:

```bash
ydb \
  --endpoint <эндпоинт_базы_данных> \
  --database <путь_к_базе_данных> \
  sql -s 'SELECT service_name, SUM(cost) AS total FROM billing GROUP BY service_name' \
  --format csv > result.csv
```

#### Учтите производительность {#ydb-performance}

Скорость федеративного запроса ограничена пропускной способностью сети узлов базы данных при чтении из Object Storage. Yandex Query распределял чтение по общему пулу узлов, поэтому в базе с небольшим числом узлов тот же запрос может выполняться дольше. Если скорость важна, увеличьте число узлов базы данных или перенесите данные в [колоночные таблицы](#ydb-column-tables).

### Колоночные таблицы: загрузка данных в базу {#ydb-column-tables}

Если одни и те же файлы читаются много раз (например, дашбордом с автообновлением), загрузите их в колоночную таблицу. Запросы к колоночной таблице не читают бакет повторно.

1. Создайте колоночную таблицу:

   ```yql
   CREATE TABLE billing_data (
       date Date NOT NULL,
       resource_id Utf8 NOT NULL,
       service_name Utf8,
       cost Double,
       PRIMARY KEY (date, resource_id)
   )
   PARTITION BY HASH(date, resource_id)
   WITH (STORE = COLUMN);
   ```

1. Загрузите данные из внешней таблицы:

   ```yql
   INSERT INTO billing_data
   SELECT date, resource_id, service_name, cost
   FROM billing;
   ```

1. Чтобы догружать новые файлы, запускайте такой же запрос по расписанию с фильтром по дате или пути, например из [функции Cloud Functions с триггером-таймером](../../functions/operations/trigger/timer-create.md).

1. Переключите запросы и дашборды с внешней таблицы на `billing_data`.

### Соединения с базами данных {#ydb-databases}

Соединения Yandex Query с Managed Service for PostgreSQL, Managed Service for ClickHouse®, Managed Service for MySQL® и Yandex MPP Analytics for PostgreSQL переносятся во внешние источники данных соответствующего типа. Синтаксис запросов `SELECT * FROM <источник>.<таблица>` не меняется. Параметры подключения описаны в разделе [Федеративные запросы](https://ydb.tech/docs/ru/concepts/query_execution/federated_query/).

## Проверьте результат {#check}

1. Выполните каждый перенесенный запрос на одном и том же наборе файлов в Yandex Query и в новом решении.

1. Сравните число строк и контрольные суммы по ключевым колонкам:

   ```yql
   SELECT COUNT(*) AS rows, SUM(cost) AS total_cost
   FROM billing
   WHERE date BETWEEN Date("2026-09-01") AND Date("2026-09-30");
   ```

1. Переключите на новое решение дашборды, расписания и приложения, которые обращались к Yandex Query.

## Если что-то пошло не так {#troubleshooting}

#|
|| **Ошибка или симптом** | **Что проверить** ||
|| `External data sources are disabled` | База данных создана в режиме Serverless. Создайте базу данных с выделенными ресурсами. ||
|| `Access Denied` при чтении бакета | Роль `storage.viewer` у сервисного аккаунта, значения ключа в секретах и значение `LOCATION`. Оно должно заканчиваться на `/`. ||
|| Ошибка разбора данных | Типы и обязательность колонок в схеме. Если в файле нет колонки с `NOT NULL`, запрос завершится ошибкой. ||
|| Запрос выполняется дольше, чем в Yandex Query | Число узлов базы данных. Для повторяющихся запросов используйте [колоночные таблицы](#ydb-column-tables). ||
|#

Если решить проблему не удалось, обратитесь в [техническую поддержку](../../support/overview.md) и приложите:

* идентификатор базы данных;
* текст запроса и текст ошибки;
* время ошибки и идентификатор запроса, если он есть в выводе.