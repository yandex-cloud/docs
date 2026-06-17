# Информация об имеющихся кластерах

Вы можете запросить детальную информацию о каждом созданном вами кластере Apache Spark™.

## Получить список кластеров в каталоге {#list-clusters}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) перейдите в нужный каталог.
    1. Перейдите в сервис **Managed Service for Apache Spark**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы запросить список кластеров Apache Spark™ в каталоге по умолчанию, выполните команду:

    ```bash
    yc managed-spark cluster list
    ```

    Результат:

    ```bash
    +----------------------+----------+---------------------+--------+---------+
    |          ID          |   NAME   |     CREATED AT      | HEALTH | STATUS  |
    +----------------------+----------+---------------------+--------+---------+
    | c9qmm2mrse2g******** | my-spark | 2026-01-22 13:23:32 | ALIVE  | RUNNING |
    +----------------------+----------+---------------------+--------+---------+
    ```

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

    1. Воспользуйтесь вызовом [ClusterService/List](../api-ref/grpc/Cluster/list.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

       ```bash
       grpcurl \
           -format json \
           -import-path ~/cloudapi/ \
           -import-path ~/cloudapi/third_party/googleapis/ \
           -proto ~/cloudapi/yandex/cloud/spark/v1/cluster_service.proto \
           -rpc-header "Authorization: Bearer $IAM_TOKEN" \
           -d '{
                  "folder_id": "<идентификатор_каталога>"
              }' \
           spark.api.cloud.yandex.net:443 \
           yandex.cloud.spark.v1.ClusterService.List
           ```
       
       Идентификатор каталога можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).
       
    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/list.md#yandex.cloud.spark.v1.ListClustersResponse).

{% endlist %}

## Получить детальную информацию о кластере {#get-cluster}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) перейдите в нужный каталог.
    1. Перейдите в сервис **Managed Service for Apache Spark**.
    1. Нажмите на имя нужного кластера.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы получить информацию о кластере Apache Spark™, выполните команду:

    ```bash
    yc managed-spark cluster get <имя_или_идентификатор_кластера>
    ```

    Имя и идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

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

    1. Воспользуйтесь вызовом [ClusterService/Get](../api-ref/grpc/Cluster/get.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

       ```bash
       grpcurl \
           -format json \
           -import-path ~/cloudapi/ \
           -import-path ~/cloudapi/third_party/googleapis/ \
           -proto ~/cloudapi/yandex/cloud/spark/v1/cluster_service.proto \
           -rpc-header "Authorization: Bearer $IAM_TOKEN" \
           -d '{
                   "cluster_id": "<идентификатор_кластера>"
               }' \
           spark.api.cloud.yandex.net:443 \
           yandex.cloud.spark.v1.ClusterService.Get
       ```

       Идентификатор кластера можно запросить со [списком кластеров в каталоге](#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/get.md#yandex.cloud.spark.v1.Cluster).

{% endlist %}

## Посмотреть операции с кластерами {#list-operations}

Все действия с кластерами Apache Spark™ сохраняются в виде списка операций. Каждой операции присваивается уникальный идентификатор.

### Получить список операций {#get-operations}

{% list tabs group=instructions %}

- Консоль управления {#console}

    Чтобы получить список операций для кластера Apache Spark™:

    1. В [консоли управления](https://console.yandex.cloud) откройте каталог, в котором находится кластер.
    1. Перейдите в сервис **Managed Service for Apache Spark**.
    1. На панели слева выберите ![image](../../_assets/console-icons/cubes-3.svg) **Кластеры**.
    1. Выберите нужный кластер.
    1. Перейдите на панель ![image](../../_assets/console-icons/list-check.svg) **Операции** для выбранного кластера.

        В открывшемся списке отображаются операции с выбранным кластером.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы получить список операций для кластера Apache Spark™, выполните команду:

    ```bash
    yc managed-spark cluster list-operations <имя_или_идентификатор_кластера>
    ```

    Результат:

    ```bash
    +----------------------+---------------------+----------------------+---------------------+--------+-----------------------------+
    |          ID          |     CREATED AT      |      CREATED BY      |     MODIFIED AT     | STATUS |         DESCRIPTION         |
    +----------------------+---------------------+----------------------+---------------------+--------+-----------------------------+
    | msc53bmphhmc******** | 2026-01-22 13:23:32 | ajegrmkclceh******** | 2026-01-22 13:27:22 | DONE   | Create Apache Spark cluster |
    +----------------------+---------------------+----------------------+---------------------+--------+-----------------------------+
    ```

    Имя и идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    По умолчанию информация об операциях выводится в текстовом формате. Чтобы получить более подробную информацию, укажите формат `yaml` или `json` для выводимых данных с помощью параметра `--format`. Например:

    ```bash
    yc managed-spark cluster list-operations <имя_или_идентификатор_кластера> --format yaml
    ```

    Результат:

    ```yaml
    - id: msc53bmphhmc********
      description: Create Apache Spark cluster
      created_at: "2026-01-22T13:23:32.748783Z"
      created_by: ajegrmkclceh********
      modified_at: "2026-01-22T13:27:22.336712Z"
      done: true
      metadata:
        '@type': type.googleapis.com/yandex.cloud.spark.v1.CreateClusterMetadata
        cluster_id: c9qmm2mrse2g********
        ...
    ```

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

    1. Воспользуйтесь вызовом [ClusterService/ListOperations](../api-ref/grpc/Cluster/listOperations.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

       ```bash
       grpcurl \
           -format json \
           -import-path ~/cloudapi/ \
           -import-path ~/cloudapi/third_party/googleapis/ \
           -proto ~/cloudapi/yandex/cloud/spark/v1/cluster_service.proto \
           -rpc-header "Authorization: Bearer $IAM_TOKEN" \
           -d '{
                   "cluster_id": "<идентификатор_кластера>"
               }' \
           spark.api.cloud.yandex.net:443 \
           yandex.cloud.spark.v1.ClusterService.ListOperations
       ```

       Идентификатор кластера можно запросить со [списком кластеров в каталоге](#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/listOperations.md#yandex.cloud.spark.v1.ListClusterOperationsResponse).

{% endlist %}

## Полезные ссылки {#see-also}

* [Работа с операциями](../../api-design-guide/concepts/about-async.md)