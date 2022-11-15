# Управление моделями машинного обучения

{{ mch-short-name }} позволяет анализировать данные с помощью моделей машинного обучения [CatBoost](https://catboost.ai/) без использования дополнительных инструментов. Чтобы применить модель, подключите ее к кластеру и вызовите в SQL-запросе с помощью встроенной функции [`modelEvaluate()`]({{ ch.docs }}/sql-reference/functions/other-functions#function-modelevaluate). В результате выполнения такого запроса вы получите предсказания модели для каждой строки входных данных. Подробнее о машинном обучении в {{ CH }} читайте в [документации]({{ ch.docs }}/guides/apply-catboost-model).

## Перед подключением модели {#prereq}

{{ mch-short-name }} работает только с моделями, которые загружены в {{ objstorage-full-name }} и к которым предоставлен доступ на чтение:

{% if audience != "internal" %}

1. [Загрузите](../../storage/operations/objects/upload.md) файл обученной модели в {{ objstorage-full-name }}.

1. Настройте доступ к файлу модели одним из способов:

    * Используйте [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) (рекомендуется). Этот способ позволяет получить доступ к файлу без ввода учетных данных.

        1\. [Подключите сервисный аккаунт к кластеру](s3-access.md#connect-service-account).
        2\. [Назначьте аккаунту роль](s3-access.md#configure-acl) `storage.viewer`.
        3\. В ACL бакета [добавьте аккаунту разрешение](../../storage/operations/buckets/edit-acl.md) `READ`.

    * [Включите публичный доступ](../../storage/operations/objects/edit-acl.md) к бакету с файлом.

1. [Получите ссылку](s3-access.md#get-link-to-object) на файл модели.

{% else %}

1. Загрузите файл обученной модели в {{ objstorage-full-name }}.

1. Настройте публичный доступ на чтение к файлу модели.

1. Получите ссылку на файл модели.

{% endif %}

## Получить список моделей в кластере {#list}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ mch-name }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку **Машинное обучение** на панели слева.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы получить список моделей в кластере, выполните команду:

    ```bash
    {{ yc-mdb-ch }} ml-model list --cluster-name=<имя кластера>
    ```

    Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- API

    Воспользуйтесь методом API [list](../api-ref/MlModel/list.md) и передайте в запросе идентификатор кластера в параметре `clusterId`.

    Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

{% endlist %}

## Получить детальную информацию о модели {#get}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ mch-name }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку **Машинное обучение** на панели слева.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы получить детальную информацию о модели, выполните команду:

    ```bash
    {{ yc-mdb-ch }} ml-model get <имя модели> \
      --cluster-name=<имя кластера>
    ```

    Имя модели можно запросить со [списком моделей в кластере](#list), имя кластера — со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- API

    Воспользуйтесь методом API [get](../api-ref/MlModel/get.md) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`.
    * Имя модели в параметре `mlModelName`.

    Имя модели можно запросить со [списком моделей в кластере](#list), имя кластера — со [списком кластеров в каталоге](cluster-list.md#list-clusters).

{% endlist %}

## Подключить модель {#add}

{% note info %}

Поддерживаются только модели типа CatBoost: `ML_MODEL_TYPE_CATBOOST`.

{% endnote %}

{% list tabs %}

- Консоль управления

    1. Выберите кластер:

        1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ mch-name }}**.
        1. Нажмите на имя нужного кластера и выберите вкладку **Машинное обучение** на панели слева.
        1. Нажмите **Добавить модель**.

    1. Настройте параметры модели:

        * **Тип** — `ML_MODEL_TYPE_CATBOOST`.
        * **Имя** — имя модели. Имя модели — один из аргументов функции `modelEvaluate()`, которая нужна для вызова модели в {{ CH }}.
        * **URL** — адрес модели в {{ objstorage-full-name }}.

    1. Нажмите **Добавить** и дождитесь окончания добавления модели.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы подключить модель к кластеру, выполните команду:

    ```bash
    {{ yc-mdb-ch }} ml-model create <имя модели> \
      --cluster-name=<имя кластера> \
      --type=ML_MODEL_TYPE_CATBOOST \
      --uri=<ссылка на файл модели в {{ objstorage-full-name }}>
    ```

    Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

    1. Добавьте к описанию кластера {{ mch-name }} блок `ml_model` с описанием подключаемой модели машинного обучения:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<имя кластера>" {
          ...
          ml_model {
            name = "<имя модели>"
            type = "ML_MODEL_TYPE_CATBOOST"
            uri  = "<ссылка на файл модели в {{ objstorage-full-name }}>"
          }
        }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mch }}).

    {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- API

    Воспользуйтесь методом API [create](../api-ref/MlModel/create) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`.
    * Имя модели в параметре `mlModelName`.
    * Тип модели `ML_MODEL_TYPE_CATBOOST` в параметре `type`.
    * Cсылку на файл модели в {{ objstorage-full-name }} в параметре `uri`.

    Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

{% endlist %}

## Применить модель {#apply}

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

## Изменить модель {#update}

{{ mch-name }} не отслеживает изменения в файле с моделью, который находится в бакете {{ objstorage-full-name }}.

Чтобы актуализировать содержимое модели, которая уже подключена к кластеру:

{% if audience != "internal" %}

1. [Загрузите файл](../../storage/operations/objects/upload.md) с актуальной моделью в {{ objstorage-full-name }}.
1. [Получите ссылку](s3-access.md#get-link-to-object) на этот файл.
1. Измените параметры модели, подключенной к {{ mch-name }}, передав новую ссылку на файл с моделью.

{% else %}

1. Загрузите файл с актуальной моделью в {{ objstorage-full-name }}.
1. Получите ссылку на этот файл.
1. Измените параметры модели, подключенной к {{ mch-name }}, передав новую ссылку на файл с моделью.

{% endif %}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ mch-name }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку **Машинное обучение** на панели слева.
    1. Выберите нужную модель, нажмите на значок ![image](../../_assets/dots.svg) и выберите пункт **Изменить**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы изменить ссылку на файл с моделью в бакете {{ objstorage-full-name }}, выполните команду:

    ```bash
    {{ yc-mdb-ch }} ml-model update <имя модели> \
      --cluster-name=<имя кластера> \
      --uri=<новая ссылка на файл в {{ objstorage-full-name }}>
    ```

    Имя модели можно запросить со [списком моделей в кластере](#list), имя кластера — со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

    1. Измените в описании кластера {{ mch-name }} значение параметра `uri` в блоке `ml_model`:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<имя кластера>" {
        ...
          ml_model {
            name = "<имя модели>"
            type = "ML_MODEL_TYPE_CATBOOST"
            uri  = "<новая ссылка на файл модели в {{ objstorage-full-name }}>"
          }
        }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mch }}).

    {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- API

    Воспользуйтесь методом API [update](../api-ref/MlModel/update.md) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](./cluster-list.md#list-clusters).
    * Имя модели в параметре `mlModelName`.
    * Новую ссылку на файл модели в {{ objstorage-full-name }} в параметре `uri`.
    * Список изменяемых полей конфигурации кластера в параметре `updateMask`.

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Отключить модель {#disable}

{% note info %}

{% if audience != "internal" %}

После отключения модели соответствующий объект остается в бакете {{ objstorage-full-name }}. Если этот объект модели больше не нужен, его можно [удалить](../../storage/operations/objects/delete.md).

{% else %}

После отключения модели соответствующий объект остается в бакете {{ objstorage-full-name }}. Если этот объект модели больше не нужен, его можно удалить.

{% endif %}

{% endnote %}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ mch-name }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку **Машинное обучение** на панели слева.
    1. Выберите нужную модель, нажмите на значок ![image](../../_assets/dots.svg) и выберите пункт **Удалить**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы отключить модель, выполните команду:

    ```bash
    {{ yc-mdb-ch }} ml-model delete <имя модели> \
      --cluster-name=<имя кластера>
    ```

    Имя модели можно запросить со [списком моделей в кластере](#list), имя кластера — со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

    1. Удалите из описания кластера {{ mch-name }} блок описания нужной модели `ml_model`.

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mch }}).

    {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- API

    Воспользуйтесь методом API [delete](../api-ref/MlModel/delete.md) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`.
    * Имя модели в параметре `mlModelName`.

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), имя модели — со [списком моделей в кластере](#list-ml).

{% endlist %}

## Пример {#example-ml-model}

Если у вас еще нет подходящего набора данных и модели для его обработки, вы можете протестировать машинное обучение в {{ mch-short-name }} на этом примере. Для него мы подготовили файл с данными и обучили модель для их {% if lang == "ru" and audience != "internal" %}[анализа](../../glossary/data-analytics.md){% else %}анализа{% endif %}. Вы сможете загрузить данные в {{ CH }} и посмотреть на предсказания модели для разных строк таблицы.

{% note info %}

Для этого примера мы будем использовать открытые данные из [Amazon Employee Access Challenge](https://www.kaggle.com/c/amazon-employee-access-challenge). Модель обучена предсказывать значение столбца `ACTION`. Те же данные и модель используются в примерах в [документации {{ CH }}]({{ ch.docs }}/guides/apply-catboost-model) и на [GitHub](https://github.com/ClickHouse/clickhouse-presentations/blob/master/tutorials/catboost_with_clickhouse_ru.md).

{% endnote %}

Чтобы загрузить данные в {{ CH }} и протестировать модель:

1. Установите [{{ CH }} CLI]({{ ch.docs }}/interfaces/cli/) и настройте подключение к кластеру как описано в [документации](../../managed-clickhouse/operations/connect.md#cli).
1. Скачайте [файл с данными](https://{{ s3-storage-host }}/managed-clickhouse/train.csv) для анализа:

   ```bash
   wget https://{{ s3-storage-host }}/managed-clickhouse/train.csv
   ```

1. Создайте таблицу для данных:

   ```bash
   clickhouse-client --host <FQDN хоста> \
                     --database <имя базы данных>
                     --secure \
                     --user <имя пользователя БД> \
                     --password <пароль пользователя БД> \
                     --port 9440 \
                     -q 'CREATE TABLE ml_test_table (date Date MATERIALIZED today(), ACTION UInt8, RESOURCE UInt32, MGR_ID UInt32, ROLE_ROLLUP_1 UInt32, ROLE_ROLLUP_2 UInt32, ROLE_DEPTNAME UInt32, ROLE_TITLE UInt32, ROLE_FAMILY_DESC UInt32, ROLE_FAMILY UInt32, ROLE_CODE UInt32) ENGINE = MergeTree() PARTITION BY date ORDER BY date'
   ```

1. Загрузите данные в таблицу:

   ```bash
   clickhouse-client --host <FQDN хоста> \
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
    * **URL** — `https://{{ s3-storage-host }}/managed-clickhouse/catboost_model.bin`.
  
1. Протестируйте модель:
    1. Подключитесь к кластеру [с помощью клиента](../../managed-clickhouse/operations/connect.md#cli) {{ CH }} CLI или перейдите на вкладку [SQL](../../managed-clickhouse/operations/web-sql-query.md) в консоли управления кластером.
    1. Проверьте работу модели с помощью запросов:
        * Предсказания значения столбца `ACTION` для первых 10 строк таблицы:

            ```sql
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

            ```sql
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
