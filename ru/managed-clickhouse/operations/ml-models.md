# Управление моделями машинного обучения в {{ mch-name }}

{{ mch-short-name }} позволяет анализировать данные с помощью моделей машинного обучения [CatBoost](https://catboost.ai/) без использования дополнительных инструментов.

Чтобы применить модель, подключите ее к кластеру и вызовите в SQL-запросе с помощью встроенной функции `catboostEvaluate()`. В результате выполнения такого запроса вы получите предсказания модели для каждой строки входных данных.

Подробнее о функции `catboostEvaluate()` читайте в [документации {{ CH }}]({{ ch.docs }}/sql-reference/functions/other-functions/#catboostevaluatepath_to_model-feature_1-feature_2--feature_n).

## Перед подключением модели {#prereq}

{{ mch-short-name }} работает только с моделями, которые загружены в {{ objstorage-full-name }} и к которым предоставлен доступ на чтение:


1. Для привязки [сервисного аккаунта](../../iam/concepts/users/service-accounts.md) к кластеру [назначьте](../../iam/operations/roles/grant.md) вашему аккаунту в {{ yandex-cloud }} роль [iam.serviceAccounts.user](../../iam/security/index.md#iam-serviceAccounts-user) или выше.
1. [Загрузите](../../storage/operations/objects/upload.md) файл обученной модели в {{ objstorage-full-name }}.
1. [Подключите сервисный аккаунт к кластеру](s3-access.md#connect-service-account). С помощью [сервисного аккаунта](../../iam/concepts/users/service-accounts.md) вы настроите доступ к файлу модели.
1. [Назначьте роль](s3-access.md#configure-acl) `storage.viewer` сервисному аккаунту.
1. В ACL бакета [добавьте разрешение](../../storage/operations/buckets/edit-acl.md) `READ` сервисному аккаунту.
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

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [MlModel.List](../api-ref/MlModel/list.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<идентификатор_кластера>/mlModels'
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/MlModel/list.md#yandex.cloud.mdb.clickhouse.v1.ListMlModelsResponse).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
    1. Воспользуйтесь вызовом [MlModelService.List](../api-ref/grpc/MlModel/list.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/ml_model_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<идентификатор_кластера>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.clickhouse.v1.MlModelService.List
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/MlModel/list.md#yandex.cloud.mdb.clickhouse.v1.ListMlModelsResponse).

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

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [MlModel.Get](../api-ref/MlModel/get.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<идентификатор_кластера>/mlModels/<название_модели>'
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), название модели — со [списком моделей](#list) в кластере.

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/MlModel/get.md#yandex.cloud.mdb.clickhouse.v1.MlModel).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
    1. Воспользуйтесь вызовом [MlModelService.Get](../api-ref/grpc/MlModel/get.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/ml_model_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<идентификатор_кластера>",
                    "ml_model_name": "<название_модели>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.clickhouse.v1.MlModelService.Get
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), название модели — со [списком моделей](#list) в кластере.

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/MlModel/get.md#yandex.cloud.mdb.clickhouse.v1.MlModel).

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

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [MlModel.Create](../api-ref/MlModel/create.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }/managed-clickhouse/v1/clusters/<идентификатор_кластера>/mlModels' \
            --data '{
                      "mlModelName": "<название_модели>",
                      "type": "ML_MODEL_TYPE_CATBOOST",
                      "uri": "<ссылка_на_файл>"
                    }'
        ```

        Где:

        * `mlModelName` — имя модели;
        * `type` — тип модели, всегда принимает значение `ML_MODEL_TYPE_CATBOOST`;
        * `uri` — ссылка на файл с моделью в {{ objstorage-name }}.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/MlModel/create.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
    1. Воспользуйтесь вызовом [MlModelService.Create](../api-ref/grpc/MlModel/create.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/ml_model_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<идентификатор_кластера>",
                    "ml_model_name": "<название_модели>",
                    "type": "ML_MODEL_TYPE_CATBOOST",
                    "uri": "<ссылка_на_файл>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.clickhouse.v1.MlModelService.Create
        ```

        Где:

        * `ml_model_name` — имя модели;
        * `type` — тип модели, всегда принимает значение `ML_MODEL_TYPE_CATBOOST`;
        * `uri` — ссылка на файл с моделью в {{ objstorage-name }}.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/MlModel/create.md#yandex.cloud.operation.Operation).

{% endlist %}

## Применить модель {#apply}

Чтобы применить модель к данным, которые хранятся в кластере {{ CH }}:

1. [Подключитесь к кластеру](connect/clients.md).
1. Выполните SQL-запрос вида:

   ```sql
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

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [MlModel.Update](../api-ref/MlModel/update.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }/managed-clickhouse/v1/clusters/<идентификатор_кластера>/mlModels/<название_модели>' \
            --data '{
                      "updateMask": "uri",
                      "uri": "<ссылка_на_файл>"
                    }'
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

            В данном случае указан только один параметр: `uri`.

        * `uri` — ссылка на новый файл с моделью в {{ objstorage-name }}.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/MlModel/update.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
    1. Воспользуйтесь вызовом [MlModelService.Update](../api-ref/grpc/MlModel/update.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

        {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/ml_model_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<идентификатор_кластера>",
                    "ml_model_name": "<название_схемы>",
                    "update_mask": {
                      "paths": ["uri"]
                    },
                    "uri": "<ссылка_на_файл>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.clickhouse.v1.MlModelService.Create
        ```

        Где:

        * `ml_model_name` — имя модели.
        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

            В данном случае указан только один параметр: `uri`.

        * `uri` — ссылка на новый файл с моделью в {{ objstorage-name }}.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/MlModel/update.md#yandex.cloud.operation.Operation).

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

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [MlModel.Delete](../api-ref/MlModel/delete.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request DELETE \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<идентификатор_кластера>/mlModels/<название_модели>'
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), название модели — со [списком моделей](#list) в кластере.

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/MlModel/delete.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
    1. Воспользуйтесь вызовом [MlModelService.Delete](../api-ref/grpc/MlModel/delete.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/ml_model_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<идентификатор_кластера>",
                    "ml_model_name": "<название_схемы>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.clickhouse.v1.MlModelService.Delete
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/MlModel/delete.md#yandex.cloud.operation.Operation).

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
