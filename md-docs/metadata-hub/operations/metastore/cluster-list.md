[Документация Yandex Cloud](../../../index.md) > [Yandex MetaData Hub](../../index.md) > Apache Hive™ Metastore > Пошаговые инструкции > Получение информации о кластерах

# Получение информации о кластерах Apache Hive™ Metastore

## Получение списка кластеров в каталоге {#list-clusters}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в нужный каталог.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Yandex MetaData Hub**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/database.svg) **Metastore-сервер**.


- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы запросить список кластеров Apache Hive™ Metastore в каталоге по умолчанию, выполните команду:

  ```bash
  yc managed-metastore cluster list
  ```

  Результат:

  ```bash
  +----------------------+--------------+---------------------+--------+---------+
  |          ID          |     NAME     |     CREATED AT      | HEALTH | STATUS  |
  +----------------------+--------------+---------------------+--------+---------+
  | c9q76od34u8j******** | metastore1   | 2025-08-10 19:15:29 | ALIVE  | RUNNING |
  | c9qipdqpe0dt******** | metastore2   | 2025-05-09 15:03:56 | ALIVE  | RUNNING |
  +----------------------+--------------+---------------------+--------+---------+
  ```

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Воспользуйтесь методом [Cluster.List](../../api-ref/Cluster/list.md) и выполните запрос, например с помощью [cURL](https://curl.se/):

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://metastore.api.cloud.yandex.net/managed-metastore/v1/clusters' \
            --url-query folderId=<идентификатор_каталога>
        ```

        Идентификатор каталога можно запросить со [списком каталогов в облаке](../../../resource-manager/operations/folder/get-id.md).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../api-ref/Cluster/list.md#yandex.cloud.metastore.v1.ListClustersResponse).

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

    1. Воспользуйтесь вызовом [ClusterService.List](../../api-ref/grpc/Cluster/list.md) и выполните запрос, например с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/metastore/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "folder_id": "<идентификатор_каталога>"
                }' \
            metastore.api.cloud.yandex.net:443 \
            yandex.cloud.metastore.v1.ClusterService.List
        ```

        Идентификатор каталога можно запросить со [списком каталогов в облаке](../../../resource-manager/operations/folder/get-id.md).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../api-ref/grpc/Cluster/list.md#yandex.cloud.metastore.v1.ListClustersResponse).

{% endlist %}

## Получение детальной информации о кластере {#get-cluster}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, где находится нужный кластер.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Yandex MetaData Hub**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/database.svg) **Metastore-сервер**.
  1. Нажмите на имя нужного кластера.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы получить информацию о кластере Apache Hive™ Metastore, выполните команду:

  ```bash
  yc managed-metastore cluster get <имя_или_идентификатор_кластера>
  ```

  Идентификатор и имя кластера можно запросить со [списком кластеров в каталоге](#list-clusters).

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Воспользуйтесь методом [Cluster.Get](../../api-ref/Cluster/get.md) и выполните запрос, например с помощью [cURL](https://curl.se/):

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://metastore.api.cloud.yandex.net/managed-metastore/v1/clusters/<идентификатор_кластера>'
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../api-ref/Cluster/get.md#yandex.cloud.metastore.v1.Cluster).

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

    1. Воспользуйтесь вызовом [ClusterService.Get](../../api-ref/grpc/Cluster/get.md) и выполните запрос, например с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/metastore/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<идентификатор_кластера>"
                }' \
            metastore.api.cloud.yandex.net:443 \
            yandex.cloud.metastore.v1.ClusterService.Get
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../api-ref/grpc/Cluster/get.md#yandex.cloud.metastore.v1.Cluster).

{% endlist %}

## Просмотр операций с кластерами {#list-operations}

Все действия с кластерами Apache Hive™ Metastore сохраняются в виде списка операций. Каждой операции присваивается уникальный идентификатор.

### Получение списка операций {#get-operations}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, где находится нужный кластер.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Yandex MetaData Hub**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/database.svg) **Metastore-сервер**.
  1. Нажмите на имя нужного кластера.
  1. На панели слева выберите ![image](../../../_assets/console-icons/list-check.svg) **Операции**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.
  
  Чтобы получить список операций, выполните команду:

    ```bash
    yc managed-metastore cluster list-operations <имя_или_идентификатор_кластера>
    ```

  Идентификатор и имя кластера можно запросить со [списком кластеров в каталоге](#list-clusters).

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Воспользуйтесь методом [Cluster.ListOperations](../../api-ref/Cluster/listOperations.md) и выполните запрос, например с помощью [cURL](https://curl.se/):

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://metastore.api.cloud.yandex.net/managed-metastore/v1/clusters/<идентификатор_кластера>/operations'
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../api-ref/Cluster/listOperations.md#yandex.cloud.metastore.v1.ListClusterOperationsResponse).

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

    1. Воспользуйтесь вызовом [ClusterService.ListOperations](../../api-ref/grpc/Cluster/listOperations.md) и выполните запрос, например с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/metastore/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<идентификатор_кластера>"
                }' \
            metastore.api.cloud.yandex.net:443 \
            yandex.cloud.metastore.v1.ClusterService.ListOperations
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../api-ref/grpc/Cluster/listOperations.md#yandex.cloud.metastore.v1.ListClusterOperationsResponse).

{% endlist %}

### Получение подробной информации об операции {#get-operations-info}

1. [Получите список операций](#get-operations) для кластера.
1. Скопируйте идентификатор нужной операции.
1. Получите подробную информацию об операции:

    {% list tabs group=instructions %}
    
    - CLI {#cli}
    
      Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).
    
      По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.
    
      Выполните команду:
    
        ```bash
        yc operation get <идентификатор_операции>
        ```
    
      Результат:
    
        ```text
        id: fltpnb1a6llk********
        description: Create Metastore cluster
        created_at: "2025-08-10T19:15:29.794361Z"
        created_by: ajejut7dk2dp********
        modified_at: "2025-08-10T19:23:38.978798Z"
        done: true
        metadata:
          '@type': type.googleapis.com/yandex.cloud.metastore.v1.CreateClusterMetadata
          cluster_id: c9q76od34u8j********
        response:
          '@type': type.googleapis.com/yandex.cloud.metastore.v1.Cluster
          id: c9q76od34u8j********
          folder_id: b1gutjgdvq50********
          created_at: "2025-08-10T19:15:29.794361Z"
          name: metastore2
          ...
        ```

    - REST API {#api}

        1. [Получите IAM-токен для аутентификации в API](../../api-ref/authentication.md) и поместите токен в переменную среды окружения:

            ```bash
            export IAM_TOKEN="<IAM-токен>"
            ```

        1. Воспользуйтесь методом [Operation.Get](../../api-ref/Operation/get.md) и выполните запрос, например с помощью [cURL](https://curl.se/):

            ```bash
            curl \
                --request GET \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --url 'https://operation.api.cloud.yandex.net/operations/<идентификатор_операции>'
            ```

        1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../api-ref/Operation/get.md#yandex.cloud.operation.Operation).

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

        1. Воспользуйтесь вызовом [OperationService.Get](../../api-ref/grpc/Operation/get.md) и выполните запрос, например с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

            ```bash
            grpcurl \
                -format json \
                -import-path ~/cloudapi/ \
                -import-path ~/cloudapi/third_party/googleapis/ \
                -proto ~/cloudapi/yandex/cloud/operation/operation_service.proto \
                -rpc-header "Authorization: Bearer $IAM_TOKEN" \
                -d '{
                        "operation_id": "<идентификатор_операции>"
                    }' \
                operation.api.cloud.yandex.net:443 \
                yandex.cloud.operation.OperationService.Get
            ```

        1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../api-ref/grpc/Operation/get.md#yandex.cloud.operation.Operation).
    
    {% endlist %}

_Apache® и [Apache Hive™](https://hive.apache.org/) являются зарегистрированными товарными знаками или товарными знаками Apache Software Foundation в США и/или других странах._