[Документация Yandex Cloud](../../index.md) > [Yandex Managed Service for ClickHouse®](../index.md) > [Пошаговые инструкции](index.md) > Кластеры > Информация об имеющихся кластерах

# Информация об имеющихся кластерах ClickHouse®

Вы можете запросить детальную информацию о каждом созданном вами кластере Managed Service for ClickHouse®.

## Получить список кластеров БД в каталоге {#list-clusters}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Перейдите в сервис **Managed Service for&nbsp;ClickHouse**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы запросить список кластеров ClickHouse® в каталоге по умолчанию, выполните команду:

  ```
  yc managed-clickhouse cluster list

  +----------------------+------+-------------+---------+---------------------+--------+---------+
  |          ID          | NAME | ENVIRONMENT | VERSION |     CREATED AT      | HEALTH | STATUS  |
  +----------------------+------+-------------+---------+---------------------+--------+---------+
  | c9qf1kmm0ebi******** | mych | PRODUCTION  |    23.8 | 2024-06-06 10:23:22 | ALIVE  | RUNNING |
  | ...                                                                                          |
  +----------------------+------+-------------+---------+---------------------+--------+---------+
  ```

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      ```bash
      export IAM_TOKEN="<IAM-токен>"
      ```

  1. Воспользуйтесь методом [Cluster.List](../api-ref/Cluster/list.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

      ```bash
      curl \
        --request GET \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --url 'https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/clusters' \
        --url-query folderId=<идентификатор_каталога>
      ```

      
      Идентификатор каталога можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).


  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/list.md#yandex.cloud.mdb.clickhouse.v1.ListClustersResponse).

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

  1. Воспользуйтесь вызовом [ClusterService.List](../api-ref/grpc/Cluster/list.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "folder_id": "<идентификатор_каталога>"
              }' \
          mdb.api.cloud.yandex.net:443 \
          yandex.cloud.mdb.clickhouse.v1.ClusterService.List
      ```

      
      Идентификатор каталога можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).


  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/list.md#yandex.cloud.mdb.clickhouse.v1.ListClustersResponse).

{% endlist %}

## Получить детальную информацию о кластере {#get-cluster}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится кластер.
  1. Перейдите в сервис **Managed Service for&nbsp;ClickHouse**.
  1. Нажмите на имя нужного кластера.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы получить информацию о кластере ClickHouse®, выполните команду:

  ```
  yc managed-clickhouse cluster get <имя_или_идентификатор_кластера>
  ```

  Идентификатор и имя кластера можно запросить со [списком кластеров в каталоге](#list-clusters).

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      ```bash
      export IAM_TOKEN="<IAM-токен>"
      ```

  1. Воспользуйтесь методом [Cluster.Get](../api-ref/Cluster/get.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

      ```bash
      curl \
          --request GET \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --url 'https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/clusters/<идентификатор_кластера>'
      ```

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/get.md#yandex.cloud.mdb.clickhouse.v1.Cluster).

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

  1. Воспользуйтесь вызовом [ClusterService.Get](../api-ref/grpc/Cluster/get.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<идентификатор_кластера>"
              }' \
          mdb.api.cloud.yandex.net:443 \
          yandex.cloud.mdb.clickhouse.v1.ClusterService.Get
      ```

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/get.md#yandex.cloud.mdb.clickhouse.v1.Cluster).

{% endlist %}

## Посмотреть операции с кластерами {#list-operations}

Все действия с кластерами Managed Service for ClickHouse® сохраняются в виде списка операций. Каждой операции присваивается уникальный идентификатор.

### Получить список операций {#get-operations}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы посмотреть операции со всеми кластерами Managed Service for ClickHouse®, на панели слева выберите ![image](../../_assets/console-icons/list-check.svg) **Операции**. В открывшемся списке также отображаются операции для ресурсов, которые были удалены.

  Можно получить список операций для кластера:

  1. В [консоли управления](https://console.yandex.cloud) откройте каталог, в котором находится кластер.
  1. Перейдите в сервис **Managed Service for&nbsp;ClickHouse**.
  1. На панели слева выберите ![image](../../_assets/console-icons/cubes-3.svg) **Кластеры**.
  1. Выберите нужный кластер и перейдите на вкладку ![image](../../_assets/console-icons/list-check.svg) **Операции**.

     В открывшемся списке отображаются операции с выбранным кластером.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы получить список операций для кластера Managed Service for ClickHouse®, воспользуйтесь командой:

  ```bash
  yc managed-clickhouse cluster list-operations <имя_или_идентификатор_кластера>
  ```

  Результат:

  ```text
  +----------------------+---------------------+----------------------+---------------------+--------+--------------------------------+
  |          ID          |     CREATED AT      |      CREATED BY      |     MODIFIED AT     | STATUS |          DESCRIPTION           |
  +----------------------+---------------------+----------------------+---------------------+--------+--------------------------------+
  | c5m7ll6pq3j8******** | 2024-08-08 19:05:42 | mdb-maintainer       | 2024-08-15 19:20:05 | DONE   | Modify ClickHouse cluster      |
  | c5mb0no66172******** | 2024-06-19 12:48:40 | mdb-maintainer       | 2024-06-26 12:50:14 | DONE   | Modify ClickHouse cluster      |
  | c5m9hvmb3lg9******** | 2024-01-17 08:05:16 | ajeef73j5iq9******** | 2024-01-17 08:14:59 | DONE   | Add ZooKeeper to ClickHouse    |
  |                      |                     |                      |                     |        | cluster                        |
  | c5mniao7leml******** | 2023-11-13 19:34:54 | ajeef73j5iq9******** | 2023-11-13 19:35:10 | DONE   | Update user in ClickHouse      |
  |                      |                     |                      |                     |        | cluster                        |
  | c5m6of9he7op******** | 2023-11-13 19:25:21 | ajeef73j5iq9******** | 2023-11-13 19:32:00 | DONE   | Create ClickHouse cluster      |
  +----------------------+---------------------+----------------------+---------------------+---- ---+--------------------------------+
  ```

  Идентификатор и имя кластера можно получить, запросив [список кластеров в каталоге](#list).

  По умолчанию информация об операциях выводится в текстовом формате. Чтобы получить более подробную информацию, укажите формат `yaml` или `json` для выводимых данных с помощью параметра `--format`:

  ```bash
  yc managed-clickhouse cluster list-operations epdplu8jn7sr******** --format yaml
  ```

  Результат:

  ```text
  - id: c5m7ll6pq3j8********
    description: Modify ClickHouse cluster
    created_at: "2024-08-08T19:05:42.362668Z"
    created_by: mdb-maintainer
    modified_at: "2024-08-15T19:20:05.917268Z"
    done: true
    metadata:
      '@type': type.googleapis.com/yandex.cloud.mdb.clickhouse.v1.UpdateClusterMetadata
      cluster_id: c9q7vuuoiqml********
    response:
      '@type': type.googleapis.com/google.rpc.Status
      message: OK
  ...
  ```

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     ```bash
     export IAM_TOKEN="<IAM-токен>"
     ```

  1. Воспользуйтесь методом [Cluster.ListOperations](../api-ref/Cluster/listOperations.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

      ```bash
      curl \
          --request GET \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --url 'https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/clusters/<идентификатор_кластера>/operations'
      ```

      Идентификатор кластера можно получить со [списком кластеров в каталоге](#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/listOperations.md#yandex.cloud.mdb.clickhouse.v1.ListClusterOperationsResponse).

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

  1. Воспользуйтесь вызовом [ClusterService.ListOperations](../api-ref/grpc/Cluster/listOperations.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<идентификатор_кластера>"
              }' \
          mdb.api.cloud.yandex.net:443 \
          yandex.cloud.mdb.clickhouse.v1.ClusterService.ListOperations
      ```

      Идентификатор кластера можно получить со [списком кластеров в каталоге](#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/listOperations.md#yandex.cloud.mdb.clickhouse.v1.ListClusterOperationsResponse).

{% endlist %}

### Получить подробную информацию об операции {#get-operations-info}

1. [Получите список операций](#get-operations) для кластера.
1. Скопируйте идентификатор нужной операции.
1. Получите подробную информацию об операции:

    {% list tabs group=instructions %}

    - CLI {#cli}

      Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

      По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

      Выполните команду:

      ```bash
      yc operation get <идентификатор_операции>
      ```

      Результат:

      ```text
      id: c5m6of9he7op********
      description: Create ClickHouse cluster
      created_at: "2023-11-13T19:25:21.762164Z"
      created_by: ajeef73j5iq9********
      modified_at: "2023-11-13T19:32:00.464591Z"
      done: true
      metadata:
        '@type': type.googleapis.com/yandex.cloud.mdb.clickhouse.v1.CreateClusterMetadata
        cluster_id: c9q7vuuoiqml********
      response:
        '@type': type.googleapis.com/yandex.cloud.mdb.clickhouse.v1.Cluster
      ...
      ```

    - REST API {#api}

      1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

          ```bash
          export IAM_TOKEN="<IAM-токен>"
          ```

      1. Воспользуйтесь методом [Operation.Get](../api-ref/Operation/get.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

          ```bash
          curl \
              --request GET \
              --header "Authorization: Bearer $IAM_TOKEN" \
              --url 'https://operation.api.cloud.yandex.net/operations/<идентификатор_операции>'
          ```

      1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Operation/get.md#yandex.cloud.operation.Operation).

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
      1. Воспользуйтесь вызовом [OperationService.Get](../api-ref/grpc/Operation/get.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

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

      1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Operation/get.md#yandex.cloud.operation.Operation).

    {% endlist %}

### Полезные ссылки {#see-also}

* [Работа с операциями](../../api-design-guide/concepts/about-async.md)

_ClickHouse® является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._