# Получение информации об имеющихся кластерах PostgreSQL

Вы можете запросить детальную информацию о каждом созданном вами кластере Managed Service for PostgreSQL.

## Получить список кластеров БД в каталоге {#list-clusters}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Перейдите в сервис **Managed Service for&nbsp;PostgreSQL**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы запросить список кластеров PostgreSQL в каталоге по умолчанию, выполните команду:

  ```bash
  yc managed-postgresql cluster list
  ```

  ```text
  +----------------------+---------------+-----------------------------+--------+---------+
  |          ID          |     NAME      |         CREATED AT          | HEALTH | STATUS  |
  +----------------------+---------------+-----------------------------+--------+---------+
  | c9wlk4v14uq7******** | mypg          | 2018-11-02T10:04:14.645214Z | ALIVE  | RUNNING |
  | ...                                                                                   |
  +----------------------+---------------+-----------------------------+--------+---------+
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
       --url 'https://mdb.api.cloud.yandex.net/managed-postgresql/v1/clusters' \
       --url-query folderId=<идентификатор_каталога>
     ```

     
     Идентификатор каталога можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).


  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/list.md#yandex.cloud.mdb.postgresql.v1.ListClustersResponse).

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
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "folder_id": "<идентификатор_каталога>"
           }' \
       mdb.api.cloud.yandex.net:443 \
       yandex.cloud.mdb.postgresql.v1.ClusterService.List
     ```

     
     Идентификатор каталога можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).


  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/list.md#yandex.cloud.mdb.postgresql.v1.ListClustersResponse).

{% endlist %}

## Получить детальную информацию о кластере {#get-cluster}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите в сервис **Managed Service for&nbsp;PostgreSQL**.
  1. Нажмите на имя нужного кластера.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы получить информацию о кластере PostgreSQL, выполните команду:

  ```bash
  yc managed-postgresql cluster get <имя_или_идентификатор_кластера>
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
       --url 'https://mdb.api.cloud.yandex.net/managed-postgresql/v1/clusters/<идентификатор_кластера>'
     ```

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/get.md#yandex.cloud.mdb.postgresql.v1.Cluster).

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
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>"
           }' \
       mdb.api.cloud.yandex.net:443 \
       yandex.cloud.mdb.postgresql.v1.ClusterService.Get
     ```

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/create.md#yandex.cloud.mdb.postgresql.v1.Cluster).

{% endlist %}

## Посмотреть операции с кластерами {#list-operations}

Все действия с кластерами Managed Service for PostgreSQL сохраняются в виде списка операций. Каждой операции присваивается уникальный идентификатор.

### Получить список операций {#get-operations}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы посмотреть операции со всеми кластерами Managed Service for PostgreSQL, на панели слева выберите ![image](../../_assets/console-icons/list-check.svg) **Операции**. В открывшемся списке также отображаются операции для ресурсов, которые были удалены.

  Можно получить список операций для кластера:

  1. В [консоли управления](https://console.yandex.cloud) откройте каталог, в котором находится кластер.
  1. Перейдите в сервис **Managed Service for&nbsp;PostgreSQL**.
  1. На панели слева выберите ![image](../../_assets/console-icons/cubes-3.svg) **Кластеры**.
  1. Выберите нужный кластер и перейдите на вкладку ![image](../../_assets/console-icons/list-check.svg) **Операции**.

     В открывшемся списке отображаются операции с выбранным кластером.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы получить список операций для кластера Managed Service for PostgreSQL, воспользуйтесь командой:

  ```bash
  yc managed-postgresql cluster list-operations <имя_или_идентификатор_кластера>
  ```

  Результат:

  ```text
  +----------------------+---------------------+----------------------+---------------------+--------+--------------------------------+
  |          ID          |     CREATED AT      |      CREATED BY      |     MODIFIED AT     | STATUS |          DESCRIPTION           |
  +----------------------+---------------------+----------------------+---------------------+--------+--------------------------------+
  | c5m7ll6pq3j8******** | 2024-08-08 19:05:42 | mdb-maintainer       | 2024-08-15 19:20:05 | DONE   | Modify PostgreSQL cluster      |
  | c5mb0no66172******** | 2024-06-19 12:48:40 | mdb-maintainer       | 2024-06-26 12:50:14 | DONE   | Modify PostgreSQL cluster      |
  | c5m6of9he7op******** | 2023-11-13 19:25:21 | ajeef73j5iq9******** | 2023-11-13 19:32:00 | DONE   | Create PostgreSQL cluster      |
  +----------------------+---------------------+----------------------+---------------------+---- ---+--------------------------------+
  ```

  Идентификатор кластера можно получить со [списком кластеров в каталоге](#list-clusters).

  По умолчанию информация об операциях выводится в текстовом формате. Чтобы получить более подробную информацию, укажите формат `yaml` или `json` для выводимых данных с помощью параметра `--format`:

  ```bash
  yc managed-postgresql cluster list-operations c9qk2926qqu9******** --format yaml
  ```

  Результат:

  ```text
  - id: c9q2m9jrootm********
    description: Create PostgreSQL cluster
    created_at: "2024-08-06T06:38:13.724389Z"
    created_by: ajej2i98kcjd********
    modified_at: "2024-08-06T06:46:33.101402Z"
    done: true
    metadata:
      '@type': type.googleapis.com/yandex.cloud.mdb.postgresql.v1.CreateClusterMetadata
      cluster_id: c9qk2926qqu9********
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
       --url 'https://mdb.api.cloud.yandex.net/managed-postgresql/v1/clusters/<идентификатор_кластера>/operations'
     ```

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/listOperations.md#yandex.cloud.mdb.postgresql.v1.ListClusterOperationsResponse).

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
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
               "cluster_id": "<идентификатор_кластера>"
           }' \
       mdb.api.cloud.yandex.net:443 \
       yandex.cloud.mdb.postgresql.v1.ClusterService.ListOperations
     ```

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/listOperations.md#yandex.cloud.mdb.postgresql.v1.ListClusterOperationsResponse).

{% endlist %}

### Получить подробную информацию об операции {#get-operations-info}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. [Перейдите в список всех операций или операций для нужного кластера](#get-operations).
    1. Нажмите на идентификатор операции, которую вы хотите посмотреть.

    {% note info %}
    
    Операции, для которых доступна детальная информация, отмечены значком ![image](../../_assets/mdb/info.svg) рядом с идентификатором.
    
    {% endnote %}
    
    В детальной информации приводится иерархический список шагов операции. На первом уровне — действия с кластером, на втором — действия с хостами. Список может различаться для разных операций:
      * Если шаг выполняется или уже завершен, для него отображается дата и время начала выполнения. 
      * Если выполнение шага еще не началось, для него отображается статус **В очереди**.
    
    В списке отображаются следующие действия:
    
    * **Preparing metadata** — подготовка информации и данных для выполнения операции.
    * **Preparing backup storage** — подготовка хранилища для резервных копий.
    * **Creating cluster** — создание кластера.
    * **Installing software** — установка программного обеспечения (например, создается база данных, устанавливаются вспомогательные пакеты-плагины).
    * **Initializing database** — инициализация базы данных.
    * **Infrastructure integration** — создание связей новых объектов с инфраструктурой Yandex Cloud (например, распространяется DNS, выпускаются сертификаты, хосты включаются в систему мониторинга).
    * **Updating host groups** — обновление группы хостов.
    * **Updating hosts** — обновление хостов.
    * **Completing** — завершение операции.
    
    Действия с хостами:
    
    * **Reserving resources** — резервирование ресурсов для хоста.
    * **Creating host** — создание хоста.
    * **Launching host** — запуск хоста.
    * **Preparing host** — подготовка хоста к работе.
    * **Updating database software** — обновление программного обеспечения.
    * **Updating database services** — обновление сервисов базы данных.
    * **Creating DNS records** — создание DNS-записи.
    * **Restarting database** — перезапуск базы данных.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы получить подробную информацию об операции, выполните команду:

    ```bash
    yc operation get <идентификатор_операции>
    ```

    Идентификатор операции можно получить со [списком операций](#get-operations) для кластера.

    Пример выдачи для завершенной операции по созданию кластера:

    ```text
    id: c9qvtaeael629vooobjn
    description: Create PostgreSQL cluster
    created_at: "2025-12-29T01:00:10.342661Z"
    created_by: ajefhe0o8uas********
    modified_at: "2025-12-29T01:10:42.927393Z"
    done: true
    metadata:
      '@type': type.googleapis.com/yandex.cloud.mdb.postgresql.v1.CreateClusterMetadata
      cluster_id: c9qheabu83os********
      operation_log:
        entities:
          - cluster_id: c9qheabu83os********
            action: Preparing metadata
            started_at: "2025-12-29T01:00:12.962815Z"
            hosts:
              - fqdn: rc1b-3mrj18nj********.mdb.yandexcloud.net
                action: Preparing host
                started_at: "2025-12-29T01:00:14.133616Z"
              - fqdn: rc1d-qsor0ftm********.mdb.yandexcloud.net
                action: Preparing host
                started_at: "2025-12-29T01:00:14.355756Z"
          - cluster_id: c9qheabu83os********
            action: Preparing backup storage
            started_at: "2025-12-29T01:00:16.219396Z"
          - cluster_id: c9qheabu83os********
            action: Creating cluster
            started_at: "2025-12-29T01:00:29.106594Z"
            hosts:
              - fqdn: rc1b-3mrj18nj********.mdb.yandexcloud.net
                action: Reserving resources
                started_at: "2025-12-29T01:00:31.926872Z"
              - fqdn: rc1d-qsor0ftm********.mdb.yandexcloud.net
                action: Reserving resources
                started_at: "2025-12-29T01:00:40.139058Z"
              - fqdn: rc1b-3mrj18nj********.mdb.yandexcloud.net
                action: Creating host
                started_at: "2025-12-29T01:00:46.710067Z"
              - fqdn: rc1d-qsor0ftm********.mdb.yandexcloud.net
                action: Creating host
                started_at: "2025-12-29T01:00:48.757701Z"
          - cluster_id: c9qheabu83os********
            action: Installing software
            started_at: "2025-12-29T01:01:48.454943Z"
            hosts:
              - fqdn: rc1b-3mrj18nj********.mdb.yandexcloud.net
                action: Launching host
                started_at: "2025-12-29T01:02:08.738499Z"
              - fqdn: rc1d-qsor0ftm********.mdb.yandexcloud.net
                action: Launching host
                started_at: "2025-12-29T01:02:18.973229Z"
              - fqdn: rc1b-3mrj18nj********.mdb.yandexcloud.net
                action: Updating database software
                started_at: "2025-12-29T01:02:19.329133Z"
              - fqdn: rc1d-qsor0ftm********.mdb.yandexcloud.net
                action: Updating database software
                started_at: "2025-12-29T01:02:19.557436Z"
          - cluster_id: c9qheabu83os********
            action: Initializing database
            started_at: "2025-12-29T01:05:20.261791Z"
          - cluster_id: c9qheabu83os********
            action: Infrastructure integration
            started_at: "2025-12-29T01:10:33.044048Z"
            hosts:
              - fqdn: rc1b-3mrj18nj********.mdb.yandexcloud.net
                action: Creating DNS records
                started_at: "2025-12-29T01:10:33.306624Z"
              - fqdn: rc1d-qsor0ftm********.mdb.yandexcloud.net
                action: Creating DNS records
                started_at: "2025-12-29T01:10:33.595051Z"
    response:
      '@type': type.googleapis.com/yandex.cloud.mdb.postgresql.v1.Cluster
      id: c9qheabu83os********
      ...
    ```

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Воспользуйтесь методом [Operation.Get](../api-ref/Operation/get.md) и выполните запрос, например с помощью [cURL](https://curl.se/):

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://operation.api.cloud.yandex.net/operations/<идентификатор_операции>'
        ```

        Идентификатор операции можно получить со [списком операций](#get-operations) для кластера.

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
    1. Воспользуйтесь вызовом [OperationService.Get](../api-ref/grpc/Operation/get.md) и выполните запрос, например с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

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

        Идентификатор операции можно получить со [списком операций](#get-operations) для кластера.

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Operation/get.md#yandex.cloud.operation.Operation).

{% endlist %}

### Полезные ссылки {#see-also}

* [Работа с операциями](../../api-design-guide/concepts/about-async.md)