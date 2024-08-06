# Управление моделями машинного обучения в {{ mch-name }}

{{ mch-short-name }} позволяет анализировать данные с помощью моделей машинного обучения [CatBoost](https://catboost.ai/) без использования дополнительных инструментов.

Чтобы применить модель, подключите ее к кластеру и вызовите в SQL-запросе с помощью встроенной функции `catboostEvaluate()`. В результате выполнения такого запроса вы получите предсказания модели для каждой строки входных данных.

Подробнее о функции `catboostEvaluate()` читайте в [документации {{ CH }}]({{ ch.docs }}/sql-reference/functions/other-functions/#catboostevaluatepath_to_model-feature_1-feature_2--feature_n).

## Перед подключением модели {#prereq}

{{ mch-short-name }} работает только с моделями, которые загружены в {{ objstorage-full-name }} и к которым предоставлен доступ на чтение:


1. [Загрузите](../../storage/operations/objects/upload.md) файл обученной модели в {{ objstorage-full-name }}.

1. Настройте доступ к файлу модели, используя [сервисный аккаунт](../../iam/concepts/users/service-accounts.md):

    1. [Подключите сервисный аккаунт к кластеру](s3-access.md#connect-service-account).
    1. [Назначьте аккаунту роль](s3-access.md#configure-acl) `storage.viewer`.
    1. В ACL бакета [добавьте аккаунту разрешение](../../storage/operations/buckets/edit-acl.md) `READ`.

1. [Получите ссылку](s3-access.md#get-link-to-object) на файл модели.


## Получить список моделей в кластере {#list}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.clickhouse.cluster.switch_ml-models }}** на панели слева.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы получить список моделей в кластере, выполните команду:

    ```bash
    {{ yc-mdb-ch }} ml-model list --cluster-name=<имя_кластера>
    ```

    Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- API {#api}

    Чтобы получить список моделей в кластере, воспользуйтесь методом REST API [list](../api-ref/MlModel/list.md) для ресурса [MlModel](../api-ref/MlModel/index.md) или вызовом gRPC API [MlModelService/List](../api-ref/grpc/ml_model_service.md#List) и передайте в запросе идентификатор кластера в параметре `clusterId`.

    Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

{% endlist %}

## Получить детальную информацию о модели {#get}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.clickhouse.cluster.switch_ml-models }}** на панели слева.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы получить детальную информацию о модели, выполните команду:

    ```bash
    {{ yc-mdb-ch }} ml-model get <имя_модели> \
      --cluster-name=<имя_кластера>
    ```

    Имя модели можно запросить со [списком моделей в кластере](#list), имя кластера — со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- API {#api}

    Чтобы получить детальную информацию о модели, воспользуйтесь методом REST API [get](../api-ref/MlModel/get.md) для ресурса [MlModel](../api-ref/MlModel/index.md) или вызовом gRPC API [MlModelService/Get](../api-ref/grpc/ml_model_service.md#Get) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`.
    * Имя модели в параметре `mlModelName`.

    Имя модели можно запросить со [списком моделей в кластере](#list), имя кластера — со [списком кластеров в каталоге](cluster-list.md#list-clusters).

{% endlist %}

## Создать модель {#add}

{% note info %}

Поддерживаются только модели типа CatBoost: `ML_MODEL_TYPE_CATBOOST`.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Выберите кластер:

        1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
        1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.clickhouse.cluster.switch_ml-models }}** на панели слева.
        1. Нажмите **{{ ui-key.yacloud.clickhouse.cluster.ml-models.button-action_add-ml-model }}**.

    1. Настройте параметры модели:

        * **{{ ui-key.yacloud.clickhouse.cluster.ml-models.field_ml-model-type }}** — `ML_MODEL_TYPE_CATBOOST`.
        * **{{ ui-key.yacloud.clickhouse.cluster.ml-models.field_ml-model-name }}** — имя модели. Имя модели — один из аргументов функции `catboostEvaluate()`, которая нужна для вызова модели в {{ CH }}.
        * **{{ ui-key.yacloud.clickhouse.cluster.ml-models.field_ml-model-uri }}** — адрес модели в {{ objstorage-full-name }}.

    1. Нажмите **{{ ui-key.yacloud.clickhouse.cluster.ml-models.label_add-ml-model }}** и дождитесь окончания создания модели.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы создать модель, выполните команду:

    ```bash
    {{ yc-mdb-ch }} ml-model create <имя_модели> \
      --cluster-name=<имя_кластера> \
      --type=ML_MODEL_TYPE_CATBOOST \
      --uri=<ссылка_на_файл_модели_в_Object_Storage>
    ```

    Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Добавьте к описанию кластера {{ mch-name }} блок `ml_model` с описанием подключаемой модели машинного обучения:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<имя_кластера>" {
          ...
          ml_model {
            name = "<имя_модели>"
            type = "ML_MODEL_TYPE_CATBOOST"
            uri  = "<ссылка_на_файл_модели_в_Object_Storage>"
          }
        }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mch }}).

    {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- API {#api}

    Чтобы создать модель, воспользуйтесь методом REST API [create](../api-ref/MlModel/create.md) для ресурса [MlModel](../api-ref/MlModel/index.md) или вызовом gRPC API [MlModelService/Create](../api-ref/grpc/ml_model_service.md#Create) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`.
    * Имя модели в параметре `mlModelName`.
    * Тип модели `ML_MODEL_TYPE_CATBOOST` в параметре `type`.
    * Ссылку на файл модели в {{ objstorage-full-name }} в параметре `uri`.

    Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

{% endlist %}

## Применить модель {#apply}

Чтобы применить модель к данным, которые хранятся в кластере {{ CH }}:

1. [Подключитесь к кластеру](connect/clients.md).
1. Выполните SQL-запрос вида:

   ```
   SELECT 
       catboostEvaluate('<путь_к_файлу_модели>', 
                     <имя_столбца_1>,
                     <имя_столбца_2>,
                     ...
                     <имя_столбца_N>)
   FROM <имя_таблицы>
   ```

В качестве аргументов функции `catboostEvaluate()` укажите:

   * Путь к файлу модели в формате `/var/lib/clickhouse/models/<имя_модели>.bin`.
   * Имена столбцов, содержащих входные данные.

Результатом выполнения запроса станет столбец с предсказаниями модели для каждой строки исходной таблицы.

## Изменить модель {#update}

{{ mch-name }} не отслеживает изменения в файле с моделью, который находится в бакете {{ objstorage-full-name }}.

Чтобы актуализировать содержимое модели, которая уже подключена к кластеру:


1. [Загрузите файл](../../storage/operations/objects/upload.md) с актуальной моделью в {{ objstorage-full-name }}.
1. [Получите ссылку](s3-access.md#get-link-to-object) на этот файл.
1. Измените параметры модели, подключенной к {{ mch-name }}, передав новую ссылку на файл с моделью.


{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.clickhouse.cluster.switch_ml-models }}** на панели слева.
    1. Выберите нужную модель, нажмите на значок ![image](../../_assets/console-icons/ellipsis-vertical.svg) и выберите пункт **{{ ui-key.yacloud.clickhouse.cluster.ml-models.button_action-edit-ml-model }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы изменить ссылку на файл с моделью в бакете {{ objstorage-full-name }}, выполните команду:

    ```bash
    {{ yc-mdb-ch }} ml-model update <имя_модели> \
      --cluster-name=<имя_кластера> \
      --uri=<новая_ссылка_на_файл_в_Object_Storage>
    ```

    Имя модели можно запросить со [списком моделей в кластере](#list), имя кластера — со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Измените в описании кластера {{ mch-name }} значение параметра `uri` в блоке `ml_model`:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<имя_кластера>" {
        ...
          ml_model {
            name = "<имя_модели>"
            type = "ML_MODEL_TYPE_CATBOOST"
            uri  = "<новая_ссылка_на_файл_модели_в_Object_Storage>"
          }
        }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mch }}).

    {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- API {#api}

    Чтобы изменить модель, воспользуйтесь методом REST API [update](../api-ref/MlModel/update.md) для ресурса [MlModel](../api-ref/MlModel/index.md) или вызовом gRPC API [MlModelService/Update](../api-ref/grpc/ml_model_service.md#Update) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](./cluster-list.md#list-clusters).
    * Имя модели в параметре `mlModelName`.
    * Новую ссылку на файл модели в {{ objstorage-full-name }} в параметре `uri`.
    * Список изменяемых полей конфигурации кластера в параметре `updateMask`.

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Отключить модель {#disable}

{% note info %}


После отключения модели соответствующий объект остается в бакете {{ objstorage-full-name }}. Если этот объект модели больше не нужен, его можно [удалить](../../storage/operations/objects/delete.md).


{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.clickhouse.cluster.switch_ml-models }}** на панели слева.
    1. Выберите нужную модель, нажмите на значок ![image](../../_assets/console-icons/ellipsis-vertical.svg) и выберите пункт **{{ ui-key.yacloud.mdb.clusters.button_action-delete }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы отключить модель, выполните команду:

    ```bash
    {{ yc-mdb-ch }} ml-model delete <имя_модели> \
      --cluster-name=<имя_кластера>
    ```

    Имя модели можно запросить со [списком моделей в кластере](#list), имя кластера — со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Удалите из описания кластера {{ mch-name }} блок описания нужной модели `ml_model`.

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mch }}).

    {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- API {#api}

    Чтобы удалить модель, воспользуйтесь методом REST API [delete](../api-ref/MlModel/delete.md) для ресурса [MlModel](../api-ref/MlModel/index.md) или вызовом gRPC API [MlModelService/Delete](../api-ref/grpc/ml_model_service.md#Delete) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`.
    * Имя модели в параметре `mlModelName`.

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), имя модели — со [списком моделей в кластере](#list-ml).

{% endlist %}

## Пример {#example-ml-model}

Если у вас еще нет подходящего набора данных и модели для его обработки, вы можете протестировать машинное обучение в {{ mch-short-name }} на этом примере. Для него мы подготовили файл с данными и обучили модель для их [анализа](../../glossary/data-analytics.md). Вы сможете загрузить данные в {{ CH }} и посмотреть на предсказания модели для разных строк таблицы.

{% note info %}

Для этого примера мы будем использовать открытые данные из [Amazon Employee Access Challenge](https://www.kaggle.com/c/amazon-employee-access-challenge). Модель обучена предсказывать значение столбца `ACTION`. Те же данные и модель используются на [GitHub](https://github.com/ClickHouse/clickhouse-presentations/blob/master/tutorials/catboost_with_clickhouse_ru.md).

{% endnote %}

Чтобы загрузить данные в {{ CH }} и протестировать модель:

1. В [консоли управления]({{ link-console-main }}) подключите тестовую модель:

    * **{{ ui-key.yacloud.clickhouse.cluster.ml-models.field_ml-model-type }}** — `ML_MODEL_TYPE_CATBOOST`.
    * **{{ ui-key.yacloud.clickhouse.cluster.ml-models.field_ml-model-name }}** — `ml_test`.
    * **{{ ui-key.yacloud.clickhouse.cluster.ml-models.field_ml-model-uri }}** — `https://{{ s3-storage-host-mch }}/catboost_model.bin`.


1. [Скачайте файл с данными](https://{{ s3-storage-host }}/doc-files/managed-clickhouse/train.csv) для анализа.


1. [Подключитесь к кластеру](connect/clients.md).

1. Создайте тестовую таблицу:

    ```sql
    CREATE TABLE
                ml_test_table (date Date MATERIALIZED today(), 
                              ACTION UInt8, 
                              RESOURCE UInt32, 
                              MGR_ID UInt32, 
                              ROLE_ROLLUP_1 UInt32, 
                              ROLE_ROLLUP_2 UInt32, 
                              ROLE_DEPTNAME UInt32, 
                              ROLE_TITLE UInt32, 
                              ROLE_FAMILY_DESC UInt32, 
                              ROLE_FAMILY UInt32, 
                              ROLE_CODE UInt32) 
                ENGINE = MergeTree() 
    PARTITION BY date 
    ORDER BY date;
    ```

1. Загрузите данные в таблицу:

    ```sql
    INSERT INTO ml_test_table FROM INFILE '<путь_к_файлу>/train.csv' FORMAT CSVWithNames;
    ```

1. Протестируйте модель:

    * Получите предсказание значений столбца `ACTION` для первых 10 строк таблицы:

        ```sql
        SELECT
            catboostEvaluate('/var/lib/clickhouse/models/ml_test.bin',
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
        LIMIT 10;
        ```

    * Получите предсказанную вероятность для первых 10 строк таблицы:

        ```sql
        SELECT
            catboostEvaluate('/var/lib/clickhouse/models/ml_test.bin',
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
        LIMIT 10;
        ```

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
