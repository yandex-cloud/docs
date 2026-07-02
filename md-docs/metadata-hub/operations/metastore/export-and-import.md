[Документация Yandex Cloud](../../../index.md) > [Yandex MetaData Hub](../../index.md) > Apache Hive™ Metastore > Пошаговые инструкции > Экспорт и импорт кластера

# Экспорт и импорт метаданных Hive в кластере Apache Hive™ Metastore

## Перед началом работы {#before-you-begin}

1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md) `my-account` c ролями `storage.uploader` и `managed-metastore.integrationProvider`.
1. [Настройте сеть и создайте кластер](cluster-create.md) Apache Hive™ Metastore. При создании укажите сервисный аккаунт `my-account`.
1. [Создайте бакет](../../../storage/operations/buckets/create.md) в Yandex Object Storage. В нем будет храниться файл с метаданными для импорта и экспорта.
1. [Выдайте разрешение](../../../storage/operations/buckets/edit-acl.md) `READ и WRITE` сервисному аккаунту `my-account` на созданный бакет.

Подробнее о подключении к бакету, в котором настроены политики доступа, — [инструкции](s3-policy-connect.md).

## Экспорт данных {#export}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления](https://console.yandex.cloud) выберите нужный каталог.
   1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Yandex MetaData Hub**.
   1. На панели слева выберите ![image](../../../_assets/console-icons/database.svg) **Metastore-сервер**.
   1. Нажмите на значок ![image](../../../_assets/console-icons/ellipsis.svg) для нужного кластера и выберите пункт ![image](../../../_assets/console-icons/arrow-up-from-square.svg) **Экспорт**.
   1. В открывшемся окне укажите:

      * [Созданный ранее](#before-you-begin) бакет, куда будут экспортированы данные кластера.
      * Название файла `.sql`, куда будут записаны данные кластера. Если файл с таким названием уже существует, он будет перезаписан.

   1. Нажмите кнопку **Экспортировать**.

- CLI {#cli}

   Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

   По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

   Чтобы экспортировать метаданные из кластера Apache Hive™ Metastore, выполните команду:

   ```bash
   yc managed-metastore cluster export-data <имя_или_идентификатор_кластера> \
      --bucket <имя_бакета> \
      --filepath <файл_для_данных>
   ```

   Где:

   * `--bucket` — [cозданный ранее](#before-you-begin) бакет, куда будут экспортированы данные кластера.
   * `--filepath` — путь к файлу `.sql`, в который будут записаны данные кластера. Если файл с таким названием уже существует, он будет перезаписан.

   Идентификатор и имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Воспользуйтесь методом [Cluster.ExportData](../../api-ref/Cluster/exportData.md) и выполните запрос, например с помощью [cURL](https://curl.se/):

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://metastore.api.cloud.yandex.net/managed-metastore/v1/clusters/<идентификатор_кластера>:export' \
            --data '{
                       "bucket": "<имя_бакета>",
                       "filepath": "<файл_для_данных>"
                    }'
        ```

        Где:

         * `bucket` — [cозданный ранее](#before-you-begin) бакет, куда будут экспортированы данные кластера.
         * `filepath` — путь к файлу `.sql`, в который будут записаны данные кластера. Если файл с таким названием уже существует, он будет перезаписан.

         Идентификатор и имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../api-ref/Cluster/exportData.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
       
       ```bash
       cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
       ```
       
       Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.

    1. Воспользуйтесь вызовом [ClusterService.ExportData](../../api-ref/grpc/Cluster/exportData.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/metastore/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<идентификатор_кластера>",
                    "bucket": "<имя_бакета>",
                    "filepath": "<файл_для_данных>"
                }' \
            metastore.api.cloud.yandex.net:443 \
            yandex.cloud.metastore.v1.ClusterService.ExportData
        ```

        Где:

         * `bucket` — [cозданный ранее](#before-you-begin) бакет, куда будут экспортированы данные кластера.
         * `filepath` — путь к файлу `.sql`, в который будут записаны данные кластера. Если файл с таким названием уже существует, он будет перезаписан.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../api-ref/grpc/Cluster/exportData.md#yandex.cloud.operation.Operation).

{% endlist %}

## Импорт данных {#import}

Перед импортом [загрузите файл](../../../storage/operations/objects/upload.md#simple) `.sql` с метаданными в [cозданный ранее](#before-you-begin) бакет. О том, как подготовить файл и как устроен процесс импорта, читайте в разделе [Перенос метаданных между кластерами Yandex Data Processing с помощью Apache Hive™ Metastore](../../tutorials/metastore-import.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

   Чтобы импортировать данные в кластер Apache Hive™ Metastore:

   1. В [консоли управления](https://console.yandex.cloud) выберите нужный каталог.
   1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Yandex MetaData Hub**.
   1. На панели слева выберите ![image](../../../_assets/console-icons/database.svg) **Metastore-сервер**.
   1. Нажмите на значок ![image](../../../_assets/console-icons/ellipsis.svg) для нужного кластера и выберите пункт ![image](../../../_assets/console-icons/arrow-down-to-square.svg) **Импорт**.
   1. В открывшемся окне выберите [cозданный ранее](#before-you-begin) бакет и файл, откуда будут импортированы данные кластера.
   1. Нажмите кнопку **Импортировать**.

- CLI {#cli}

   Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

   По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

   Чтобы импортировать метаданные в кластер Apache Hive™ Metastore, выполните команду:

   ```bash
   yc managed-metastore cluster import-data <имя_или_идентификатор_кластера> \
      --bucket <имя_бакета> \
      --filepath <файл_c_данными>
   ```

   Где:

   * `--bucket` — [cозданный ранее](#before-you-begin) бакет, откуда будут импортированы данные кластера.
   * `--filepath` — путь к файлу `.sql`, из которого будут импортированы данные кластера.

   Идентификатор и имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Воспользуйтесь методом [Cluster.ImportData](../../api-ref/Cluster/importData.md) и выполните запрос, например с помощью [cURL](https://curl.se/):

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://metastore.api.cloud.yandex.net/managed-metastore/v1/clusters/<идентификатор_кластера>:import' \
            --data '{
                       "bucket": "<имя_бакета>",
                       "filepath": "<файл_c_данными>"
                    }'
        ```

        Где:

         * `bucket` — [cозданный ранее](#before-you-begin) бакет, откуда будут импортированы данные кластера.
         * `filepath` — путь к файлу `.sql`, из которого будут импортированы данные кластера.

         Идентификатор и имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../api-ref/Cluster/importData.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
       
       ```bash
       cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
       ```
       
       Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.

    1. Воспользуйтесь вызовом [ClusterService.ImportData](../../api-ref/grpc/Cluster/importData.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/metastore/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<идентификатор_кластера>",
                    "bucket": "<имя_бакета>",
                    "filepath": "<файл_c_данными>"
                }' \
            metastore.api.cloud.yandex.net:443 \
            yandex.cloud.metastore.v1.ClusterService.ImportData
        ```

        Где:

         * `bucket` — [cозданный ранее](#before-you-begin) бакет, куда будут экспортированы данные кластера.
         * `filepath` — путь к файлу `.sql`, в который будут записаны данные кластера. Если файл с таким названием уже существует, он будет перезаписан.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../api-ref/grpc/Cluster/importData.md#yandex.cloud.operation.Operation).

{% endlist %}

_Apache® и [Apache Hive™](https://hive.apache.org/) являются зарегистрированными товарными знаками или товарными знаками Apache Software Foundation в США и/или других странах._