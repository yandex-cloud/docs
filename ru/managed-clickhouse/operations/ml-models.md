# Подключение моделей машинного обучения

{{ mch-short-name }} позволяет анализировать данные с помощью моделей машинного обучения [CatBoost](https://catboost.ai/) без использования дополнительных инструментов. Чтобы применить модель, подключите ее к кластеру и вызовите в SQL-запросе с помощью встроенной функции [`modelEvaluate()`](https://clickhouse.yandex/docs/ru/query_language/functions/other_functions/#function-modelevaluate). В результате выполнения такого запроса вы получите предсказания модели для каждой строки входных данных. Подробнее о машинном обучении в {{ CH }} читайте в [документации](https://clickhouse.yandex/docs/ru/guides/apply_catboost_model/).

## Перед подключением модели {#prereq}

{{ mch-short-name }} работает только с моделями, которые загружены в {{ objstorage-name }} и к которым предоставлен публичный доступ на чтение:

1. [Загрузите](../../storage/operations/objects/upload.md) файл обученной модели в {{ objstorage-name }}.

1. [Настройте публичный доступ](../../storage/operations/objects/edit-acl.md) на чтение к файлу модели.

1. [Получите](../../storage/operations/objects/link-for-download.md) публичную ссылку на модель.

## Подключить модель {#add-ml-model}

{% list tabs %}

- Консоль управления

  1. Выберите кластер:
  
     1. Перейдите на страницу каталога и выберите сервис **{{ mch-name }}**.
     1. Нажмите на имя нужного кластера и выберите вкладку **Машинное обучение** на панели слева.
     1. Нажмите на кнопку **Добавить модель**.

  1. Настройте параметры модели:
      
     * **Тип** — тип модели. Поддерживаются только модели CatBoost: `ML_MODEL_TYPE_CATBOOST`.
     * **Имя** — имя модели. Имя модели — один из аргументов функции `modelEvaluate()`, которая нужна для вызова модели в {{ CH }}.
     * **URL** — адрес модели в {{ objstorage-name }}.

  1. Нажмите кнопку **Добавить** и дождитесь окончания добавления модели.

- Terraform

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

    1. Добавьте к описанию кластера {{ mch-name }} блок `ml_model` с описанием подключаемой модели машинного обучения:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<имя кластера>" {
          ...
          ml_model {
            name = "<имя модели>"
            type = "<тип модели: ML_MODEL_TYPE_CATBOOST>"
            uri  = "<публичная ссылка на файл модели в {{ objstorage-name }}>"
          }
        }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_clickhouse_cluster).

{% endlist %}

## Применить модель {#apply-ml-model}

Чтобы применить модель к данным, которые хранятся в кластере {{ CH }}:

1. Подключитесь к кластеру [с помощью клиента](../../managed-clickhouse/operations/connect.md#cli) {{ CH }} CLI или перейдите на вкладку [SQL](../../managed-clickhouse/operations/web-sql-query.md) в консоли управления кластером.
1. Выполните SQL-запрос вида:

   ```
   SELECT 
       modelEvaluate('<имя модели>', 
                     <имя столбца 1>,
                     <имя столбца 2>,
                     ...
                     <имя столбца N>)
   FROM <имя таблицы>
   ```

В качестве аргументов функции `modelEvaluate()` укажите имя модели и имена столбцов, содержащих входные данные. В результате выполнения запроса вы получите столбец с предсказаниями модели для каждой строки исходной таблицы.

## Пример {#example-ml-model}

Если у вас еще нет подходящего набора данных и модели для его обработки, вы можете протестировать машинное обучение в {{ mch-short-name }} на этом примере. Для него мы подготовили файл с данными и обучили модель для их анализа. Вы сможете загрузить данные в {{ CH }} и посмотреть на предсказания модели для разных строк таблицы.

{% note info %}

Для этого примера мы будем использовать открытые данные из [Amazon Employee Access Challenge](https://www.kaggle.com/c/amazon-employee-access-challenge). Модель обучена предсказывать значение столбца `ACTION`. Те же данные и модель используются в примерах в [документации {{ CH }}](https://clickhouse.yandex/docs/ru/guides/apply_catboost_model/) и на [GitHub](https://github.com/ClickHouse/clickhouse-presentations/blob/master/tutorials/catboost_with_clickhouse_ru.md).

{% endnote %}

Чтобы загрузить данные в {{ CH }} и протестировать модель:

1. Установите [{{ CH }} CLI](https://clickhouse.yandex/docs/ru/interfaces/cli/) и настройте подключение к кластеру как описано в [документации](../../managed-clickhouse/operations/connect.md#cli).
1. Скачайте [файл с данными](https://storage.yandexcloud.net/managed-clickhouse/train.csv) для анализа:
   ```bash
   $ wget https://storage.yandexcloud.net/managed-clickhouse/train.csv  
   ```
1. Создайте таблицу для данных:
   ```bash
   $ clickhouse-client --host <FQDN хоста> \
                     --database <имя базы данных>
                     --secure \
                     --user <имя пользователя БД> \
                     --password <пароль пользователя БД> \
                     --port 9440 \
                     -q 'CREATE TABLE ml_test_table (date Date MATERIALIZED today(), ACTION UInt8, RESOURCE UInt32, MGR_ID UInt32, ROLE_ROLLUP_1 UInt32, ROLE_ROLLUP_2 UInt32, ROLE_DEPTNAME UInt32, ROLE_TITLE UInt32, ROLE_FAMILY_DESC UInt32, ROLE_FAMILY UInt32, ROLE_CODE UInt32) ENGINE = MergeTree() PARTITION BY date ORDER BY date'
   ```
1. Загрузите данные в таблицу:
   ```bash
   $ clickhouse-client --host <FQDN хоста> \
                     --database <имя базы данных>
                     --secure \
                     --user <имя пользователя БД> \
                     --password <пароль пользователя БД> \
                     --port 9440 \
                     -q 'INSERT INTO ml_test_table FORMAT CSVWithNames' \
                     < train.csv
   ```
1. В [консоли управления]({{ link-console-main }}) подключите тестовую модель:
  * **Тип** — `ML_MODEL_TYPE_CATBOOST`.
  * **Имя** — `ml_test`.
  * **URL** — `https://storage.yandexcloud.net/managed-clickhouse/catboost_model.bin`.
  
1. Протестируйте модель:
  1. Подключитесь к кластеру [с помощью клиента](../../managed-clickhouse/operations/connect.md#cli) {{ CH }} CLI или перейдите на вкладку [SQL](../../managed-clickhouse/operations/web-sql-query.md) в консоли управления кластером.
  1. Проверьте работу модели с помощью запросов:
     * Предсказания значения столбца `ACTION` для первых 10 строк таблицы:
         ```
         SELECT 
             modelEvaluate('ml_test', 
                           RESOURCE,
                           MGR_ID,
                           ROLE_ROLLUP_1,
                           ROLE_ROLLUP_2,
                           ROLE_DEPTNAME,
                           ROLE_TITLE,
                           ROLE_FAMILY_DESC,
                           ROLE_FAMILY,
                           ROLE_CODE) > 0 AS prediction, 
             ACTION AS target
         FROM ml_test_table
         LIMIT 10
         ```
     * Предсказанная вероятность для первых 10 строк таблицы:
        ```
        SELECT 
            modelEvaluate('ml_test', 
                          RESOURCE,
                          MGR_ID,
                          ROLE_ROLLUP_1,
                          ROLE_ROLLUP_2,
                          ROLE_DEPTNAME,
                          ROLE_TITLE,
                          ROLE_FAMILY_DESC,
                          ROLE_FAMILY,
                          ROLE_CODE) AS prediction,
            1. / (1 + exp(-prediction)) AS probability, 
            ACTION AS target
        FROM ml_test_table
        LIMIT 10
        ```
