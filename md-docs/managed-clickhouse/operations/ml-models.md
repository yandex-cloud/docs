# Управление моделями машинного обучения в Managed Service for ClickHouse®

Managed Service for ClickHouse® позволяет анализировать данные с помощью моделей машинного обучения [CatBoost](https://catboost.ai/) без использования дополнительных инструментов.

Чтобы применить модель, подключите ее к кластеру и вызовите в SQL-запросе с помощью встроенной функции `catboostEvaluate()`. В результате выполнения такого запроса вы получите предсказания модели для каждой строки входных данных.

Подробнее о функции `catboostEvaluate()` читайте в [документации ClickHouse®](https://clickhouse.com/docs/ru/sql-reference/functions/other-functions#catboostevaluatepath_to_model-feature_1-feature_2--feature_n).

## Перед подключением модели {#prereq}

Managed Service for ClickHouse® работает только с моделями, которые загружены в Yandex Object Storage и к которым предоставлен доступ на чтение:


1. Для привязки [сервисного аккаунта](../../iam/concepts/users/service-accounts.md) к кластеру [назначьте](../../iam/operations/roles/grant.md) вашему аккаунту в Yandex Cloud роль [iam.serviceAccounts.user](../../iam/security/index.md#iam-serviceAccounts-user) или выше.
1. [Загрузите](../../storage/operations/objects/upload.md) файл обученной модели в Yandex Object Storage.
1. [Подключите сервисный аккаунт к кластеру](s3-access.md#connect-service-account). С помощью [сервисного аккаунта](../../iam/concepts/users/service-accounts.md) вы настроите доступ к файлу модели.
1. [Назначьте роль](s3-access.md#configure-acl) `storage.viewer` сервисному аккаунту.
1. В ACL бакета [добавьте разрешение](../../storage/operations/buckets/edit-acl.md) `READ` сервисному аккаунту.
1. [Получите ссылку](s3-access.md#get-link-to-object) на файл модели.


## Получить список моделей в кластере {#list}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится кластер.
    1. Перейдите в сервис **Managed Service for&nbsp;ClickHouse**.
    1. Нажмите на имя нужного кластера и выберите вкладку **Машинное обучение** на панели слева.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы получить список моделей в кластере, выполните команду:

    ```bash
    yc managed-clickhouse ml-model list --cluster-name=<имя_кластера>
    ```

    Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Воспользуйтесь методом [MlModel.List](../api-ref/MlModel/list.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/clusters/<идентификатор_кластера>/mlModels'
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/MlModel/list.md#yandex.cloud.mdb.clickhouse.v1.ListMlModelsResponse).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
       
       ```bash
       cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
       ```
       
       Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.
    1. Воспользуйтесь вызовом [MlModelService.List](../api-ref/grpc/MlModel/list.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

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
            mdb.api.cloud.yandex.net:443 \
            yandex.cloud.mdb.clickhouse.v1.MlModelService.List
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/MlModel/list.md#yandex.cloud.mdb.clickhouse.v1.ListMlModelsResponse).

{% endlist %}

## Получить детальную информацию о модели {#get}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится кластер.
    1. Перейдите в сервис **Managed Service for&nbsp;ClickHouse**.
    1. Нажмите на имя нужного кластера и выберите вкладку **Машинное обучение** на панели слева.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы получить детальную информацию о модели, выполните команду:

    ```bash
    yc managed-clickhouse ml-model get <имя_модели> \
      --cluster-name=<имя_кластера>
    ```

    Имя модели можно запросить со [списком моделей в кластере](#list), имя кластера — со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Воспользуйтесь методом [MlModel.Get](../api-ref/MlModel/get.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/clusters/<идентификатор_кластера>/mlModels/<название_модели>'
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), название модели — со [списком моделей](#list) в кластере.

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/MlModel/get.md#yandex.cloud.mdb.clickhouse.v1.MlModel).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
       
       ```bash
       cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
       ```
       
       Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.
    1. Воспользуйтесь вызовом [MlModelService.Get](../api-ref/grpc/MlModel/get.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

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
            mdb.api.cloud.yandex.net:443 \
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

        1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится кластер.
        1. Перейдите в сервис **Managed Service for&nbsp;ClickHouse**.
        1. Нажмите на имя нужного кластера и выберите вкладку **Машинное обучение** на панели слева.
        1. Нажмите **Создать модель**.

    1. Настройте параметры модели:

        * **Тип** — `ML_MODEL_TYPE_CATBOOST`.
        * **Имя** — имя модели. Имя модели — один из аргументов функции `catboostEvaluate()`, которая нужна для вызова модели в ClickHouse®.
        * **URL** — адрес модели в Yandex Object Storage.

    1. Нажмите **Создать** и дождитесь окончания создания модели.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы создать модель, выполните команду:

    ```bash
    yc managed-clickhouse ml-model create <имя_модели> \
      --cluster-name=<имя_кластера> \
      --type=ML_MODEL_TYPE_CATBOOST \
      --uri=<ссылка_на_файл_модели_в_Object_Storage>
    ```

    Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).


- Terraform {#tf}

    1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Добавьте к описанию кластера Managed Service for ClickHouse® блок `ml_model` с описанием подключаемой модели машинного обучения:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster_v2" "<имя_кластера>" {
          ...
          ml_model {
            name = "<имя_модели>"
            type = "ML_MODEL_TYPE_CATBOOST"
            uri  = "<ссылка_на_файл_модели_в_Object_Storage>"
          }
        }
        ```

    1. Проверьте корректность настроек.

        1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
        1. Выполните команду:
        
           ```bash
           terraform validate
           ```
        
           Если в файлах конфигурации есть ошибки, Terraform на них укажет.

    1. Подтвердите изменение ресурсов.

        1. Выполните команду для просмотра планируемых изменений:
        
           ```bash
           terraform plan
           ```
        
           Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
        
        1. Если вас устраивают планируемые изменения, внесите их:
           1. Выполните команду:
        
              ```bash
              terraform apply
              ```
        
           1. Подтвердите изменение ресурсов.
           1. Дождитесь завершения операции.

    Подробнее см. в [документации провайдера Terraform](../../terraform/resources/mdb_clickhouse_cluster.md).

    {% note warning "Ограничения по времени" %}
    
    Провайдер Terraform ограничивает время на выполнение операций с кластером Managed Service for ClickHouse®:
    
    * создание, в т. ч. путем восстановления из резервной копии, — 60 минут;
    * изменение — 90 минут;
    * удаление — 30 минут.
    
    Операции, длящиеся дольше указанного времени, прерываются.
    
    {% cut "Как изменить эти ограничения?" %}
    
    Добавьте к описанию кластера блок `timeouts`, например:
    
    ```hcl
    resource "yandex_mdb_clickhouse_cluster_v2" "<имя_кластера>" {
      ...
      timeouts = {
        create = "1h30m" # Полтора часа
        update = "2h"    # 2 часа
        delete = "30m"   # 30 минут
      }
    }
    ```
    
    {% endcut %}
    
    {% endnote %}


- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Воспользуйтесь методом [MlModel.Create](../api-ref/MlModel/create.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

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
        * `uri` — ссылка на файл с моделью в Object Storage.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/MlModel/create.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
       
       ```bash
       cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
       ```
       
       Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.
    1. Воспользуйтесь вызовом [MlModelService.Create](../api-ref/grpc/MlModel/create.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

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
            mdb.api.cloud.yandex.net:443 \
            yandex.cloud.mdb.clickhouse.v1.MlModelService.Create
        ```

        Где:

        * `ml_model_name` — имя модели;
        * `type` — тип модели, всегда принимает значение `ML_MODEL_TYPE_CATBOOST`;
        * `uri` — ссылка на файл с моделью в Object Storage.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/MlModel/create.md#yandex.cloud.operation.Operation).

{% endlist %}

## Применить модель {#apply}

Чтобы применить модель к данным, которые хранятся в кластере ClickHouse®:

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

Managed Service for ClickHouse® не отслеживает изменения в файле с моделью, который находится в бакете Yandex Object Storage.

Чтобы актуализировать содержимое модели, которая уже подключена к кластеру:


1. [Загрузите файл](../../storage/operations/objects/upload.md) с актуальной моделью в Yandex Object Storage.
1. [Получите ссылку](s3-access.md#get-link-to-object) на этот файл.
1. Измените параметры модели, подключенной к Managed Service for ClickHouse®, передав новую ссылку на файл с моделью.


{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится кластер.
    1. Перейдите в сервис **Managed Service for&nbsp;ClickHouse**.
    1. Нажмите на имя нужного кластера и выберите вкладку **Машинное обучение** на панели слева.
    1. Выберите нужную модель, нажмите на значок ![image](../../_assets/console-icons/ellipsis-vertical.svg) и выберите пункт **Изменить**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы изменить ссылку на файл с моделью в бакете Yandex Object Storage, выполните команду:

    ```bash
    yc managed-clickhouse ml-model update <имя_модели> \
      --cluster-name=<имя_кластера> \
      --uri=<новая_ссылка_на_файл_в_Object_Storage>
    ```

    Имя модели можно запросить со [списком моделей в кластере](#list), имя кластера — со [списком кластеров в каталоге](cluster-list.md#list-clusters).


- Terraform {#tf}

    1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Измените в описании кластера Managed Service for ClickHouse® значение параметра `uri` в блоке `ml_model`:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster_v2" "<имя_кластера>" {
        ...
          ml_model {
            name = "<имя_модели>"
            type = "ML_MODEL_TYPE_CATBOOST"
            uri  = "<новая_ссылка_на_файл_модели_в_Object_Storage>"
          }
        }
        ```

    1. Проверьте корректность настроек.

        1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
        1. Выполните команду:
        
           ```bash
           terraform validate
           ```
        
           Если в файлах конфигурации есть ошибки, Terraform на них укажет.

    1. Подтвердите изменение ресурсов.

        1. Выполните команду для просмотра планируемых изменений:
        
           ```bash
           terraform plan
           ```
        
           Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
        
        1. Если вас устраивают планируемые изменения, внесите их:
           1. Выполните команду:
        
              ```bash
              terraform apply
              ```
        
           1. Подтвердите изменение ресурсов.
           1. Дождитесь завершения операции.

    Подробнее см. в [документации провайдера Terraform](../../terraform/resources/mdb_clickhouse_cluster.md).

    {% note warning "Ограничения по времени" %}
    
    Провайдер Terraform ограничивает время на выполнение операций с кластером Managed Service for ClickHouse®:
    
    * создание, в т. ч. путем восстановления из резервной копии, — 60 минут;
    * изменение — 90 минут;
    * удаление — 30 минут.
    
    Операции, длящиеся дольше указанного времени, прерываются.
    
    {% cut "Как изменить эти ограничения?" %}
    
    Добавьте к описанию кластера блок `timeouts`, например:
    
    ```hcl
    resource "yandex_mdb_clickhouse_cluster_v2" "<имя_кластера>" {
      ...
      timeouts = {
        create = "1h30m" # Полтора часа
        update = "2h"    # 2 часа
        delete = "30m"   # 30 минут
      }
    }
    ```
    
    {% endcut %}
    
    {% endnote %}


- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Воспользуйтесь методом [MlModel.Update](../api-ref/MlModel/update.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

        {% note warning %}
        
        Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
        
        {% endnote %}

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

        * `uri` — ссылка на новый файл с моделью в Object Storage.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/MlModel/update.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
       
       ```bash
       cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
       ```
       
       Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.
    1. Воспользуйтесь вызовом [MlModelService.Update](../api-ref/grpc/MlModel/update.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

        {% note warning %}
        
        Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `update_mask` (в виде массива строк `paths[]`).
        
        {% cut "Формат перечисления настроек" %}
        
        ```yaml
        "update_mask": {
            "paths": [
                "<настройка_1>",
                "<настройка_2>",
                ...
                "<настройка_N>"
            ]
        }
        ```
        
        {% endcut %}
        
        {% endnote %}

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
            mdb.api.cloud.yandex.net:443 \
            yandex.cloud.mdb.clickhouse.v1.MlModelService.Create
        ```

        Где:

        * `ml_model_name` — имя модели.
        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

            В данном случае указан только один параметр: `uri`.

        * `uri` — ссылка на новый файл с моделью в Object Storage.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/MlModel/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Отключить модель {#disable}

{% note info %}


После отключения модели соответствующий объект остается в бакете Yandex Object Storage. Если этот объект модели больше не нужен, его можно [удалить](../../storage/operations/objects/delete.md).


{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится кластер.
    1. Перейдите в сервис **Managed Service for&nbsp;ClickHouse**.
    1. Нажмите на имя нужного кластера и выберите вкладку **Машинное обучение** на панели слева.
    1. Выберите нужную модель, нажмите на значок ![image](../../_assets/console-icons/ellipsis-vertical.svg) и выберите пункт **Удалить**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы отключить модель, выполните команду:

    ```bash
    yc managed-clickhouse ml-model delete <имя_модели> \
      --cluster-name=<имя_кластера>
    ```

    Имя модели можно запросить со [списком моделей в кластере](#list), имя кластера — со [списком кластеров в каталоге](cluster-list.md#list-clusters).


- Terraform {#tf}

    1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Удалите из описания кластера Managed Service for ClickHouse® блок описания нужной модели `ml_model`.

    1. Проверьте корректность настроек.

        1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
        1. Выполните команду:
        
           ```bash
           terraform validate
           ```
        
           Если в файлах конфигурации есть ошибки, Terraform на них укажет.

    1. Подтвердите изменение ресурсов.

        1. Выполните команду для просмотра планируемых изменений:
        
           ```bash
           terraform plan
           ```
        
           Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
        
        1. Если вас устраивают планируемые изменения, внесите их:
           1. Выполните команду:
        
              ```bash
              terraform apply
              ```
        
           1. Подтвердите изменение ресурсов.
           1. Дождитесь завершения операции.

    Подробнее см. в [документации провайдера Terraform](../../terraform/resources/mdb_clickhouse_cluster.md).

    {% note warning "Ограничения по времени" %}
    
    Провайдер Terraform ограничивает время на выполнение операций с кластером Managed Service for ClickHouse®:
    
    * создание, в т. ч. путем восстановления из резервной копии, — 60 минут;
    * изменение — 90 минут;
    * удаление — 30 минут.
    
    Операции, длящиеся дольше указанного времени, прерываются.
    
    {% cut "Как изменить эти ограничения?" %}
    
    Добавьте к описанию кластера блок `timeouts`, например:
    
    ```hcl
    resource "yandex_mdb_clickhouse_cluster_v2" "<имя_кластера>" {
      ...
      timeouts = {
        create = "1h30m" # Полтора часа
        update = "2h"    # 2 часа
        delete = "30m"   # 30 минут
      }
    }
    ```
    
    {% endcut %}
    
    {% endnote %}


- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Воспользуйтесь методом [MlModel.Delete](../api-ref/MlModel/delete.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

        ```bash
        curl \
            --request DELETE \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/clusters/<идентификатор_кластера>/mlModels/<название_модели>'
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), название модели — со [списком моделей](#list) в кластере.

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/MlModel/delete.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
       
       ```bash
       cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
       ```
       
       Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.
    1. Воспользуйтесь вызовом [MlModelService.Delete](../api-ref/grpc/MlModel/delete.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

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
            mdb.api.cloud.yandex.net:443 \
            yandex.cloud.mdb.clickhouse.v1.MlModelService.Delete
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/MlModel/delete.md#yandex.cloud.operation.Operation).

{% endlist %}

## Пример {#example-ml-model}

Если у вас еще нет подходящего набора данных и модели для его обработки, вы можете протестировать машинное обучение в Managed Service for ClickHouse® на этом примере. Для него мы подготовили файл с данными и обучили модель для их [анализа](../../glossary/data-analytics.md). Вы сможете загрузить данные в ClickHouse® и посмотреть на предсказания модели для разных строк таблицы.

{% note info %}

Для этого примера мы будем использовать открытые данные из [Amazon Employee Access Challenge](https://www.kaggle.com/c/amazon-employee-access-challenge). Модель обучена предсказывать значение столбца `ACTION`. Те же данные и модель используются на [GitHub](https://github.com/ClickHouse/clickhouse-presentations/blob/master/tutorials/catboost_with_clickhouse_ru.md).

{% endnote %}

Чтобы загрузить данные в ClickHouse® и протестировать модель:

1. В [консоли управления](https://console.yandex.cloud) подключите тестовую модель:

    * **Тип** — `ML_MODEL_TYPE_CATBOOST`.
    * **Имя** — `ml_test`.
    * **URL** — `https://storage.yandexcloud.net/managed-clickhouse/catboost_model.bin`.


1. [Скачайте файл с данными](https://storage.yandexcloud.net/doc-files/managed-clickhouse/train.csv) для анализа.


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

_ClickHouse® является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._