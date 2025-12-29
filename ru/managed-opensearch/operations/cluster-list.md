---
title: Информация об имеющихся кластерах {{ OS }}
description: Вы можете запросить детальную информацию о каждом созданном вами кластере {{ OS }}.
keywords:
  - информация о хостах OpenSearch
  - хосты OpenSearch
  - OpenSearch
---

# Информация об имеющихся кластерах {{ OS }}

Вы можете запросить детальную информацию о каждом созданном вами кластере {{ mos-name }}.

## Получить список кластеров в каталоге {#list-clusters}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы запросить список кластеров {{ OS }} в каталоге, заданном по умолчанию, выполните команду:

  ```bash
  {{ yc-mdb-os }} cluster list
  ```

  ```text
  +----------------------+------+-----------------------------+--------+---------+
  |          ID          | NAME |         CREATED AT          | HEALTH | STATUS  |
  +----------------------+------+-----------------------------+--------+---------+
  | c9wlk4v14uq7******** | myos | 2023-12-19T10:04:14.645214Z | ALIVE  | RUNNING |
  | ...                                                                          |
  +----------------------+------+-----------------------------+--------+---------+
  ```

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [Cluster.List](../api-ref/Cluster/list.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

      ```bash
      curl \
          --request GET \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --url 'https://{{ api-host-mdb }}/managed-opensearch/v1/clusters' \
          --url-query folderId=<идентификатор_каталога>
      ```

      
      Идентификатор каталога можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).


  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/list.md#yandex.cloud.mdb.opensearch.v1.ListClustersResponse).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [ClusterService.List](../api-ref/grpc/Cluster/list.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/opensearch/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "folder_id": "<идентификатор_каталога>"
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.opensearch.v1.ClusterService.List
      ```

      
      Идентификатор каталога можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).


  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/list.md#yandex.cloud.mdb.opensearch.v1.ListClustersResponse).

{% endlist %}

## Получить детальную информацию о кластере {#get-cluster}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
  1. Нажмите на имя нужного кластера.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить информацию о кластере {{ OS }}, выполните команду:

  ```bash
  {{ yc-mdb-os }} cluster get <имя_или_идентификатор_кластера>
  ```

  Имя и идентификатор кластера можно запросить со [списком кластеров в каталоге](#list-clusters).

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [Cluster.Get](../api-ref/Cluster/get.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

      ```bash
      curl \
          --request GET \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --url 'https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/<идентификатор_кластера>'
      ```

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/get.md#yandex.cloud.mdb.opensearch.v1.Cluster).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [ClusterService.Get](../api-ref/grpc/Cluster/get.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/opensearch/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<идентификатор_кластера>"
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.opensearch.v1.ClusterService.Get
      ```

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/get.md#yandex.cloud.mdb.opensearch.v1.Cluster).

{% endlist %}

## Посмотреть операции с кластерами {#list-operations}

Все действия с кластерами {{ mos-name }} сохраняются в виде списка операций. Каждой операции присваивается уникальный идентификатор.

### Получить список операций {#get-operations}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы получить список операций для кластера:

  1. В [консоли управления]({{ link-console-main }}) откройте каталог, в котором находится кластер.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/cubes-3.svg) **{{ ui-key.yacloud.mdb.clusters.label_title }}**.
  1. Выберите нужный кластер.
  1. Перейдите на панель ![image](../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.common.operations-key-value }}** для выбранного кластера.

      В открывшемся списке отображаются операции с выбранным кластером.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить список операций для кластера {{ mos-name }}, воспользуйтесь командой:

  ```bash
  yc managed-opensearch cluster list-operations <имя_или_идентификатор_кластера>
  ```

  Результат:

  ```text
  +----------------------+---------------------+----------------------+---------------------+--------+---------------------------+
  |          ID          |     CREATED AT      |      CREATED BY      |     MODIFIED AT     | STATUS |        DESCRIPTION        |
  +----------------------+---------------------+----------------------+---------------------+--------+---------------------------+
  | dqh0ntf6batm******** | 2024-09-07 16:36:46 | aje9k8luj4qf******** | 2024-09-07 16:44:12 | DONE   | Create OpenSearch cluster |
  +----------------------+---------------------+----------------------+---------------------+--------+---------------------------+
  ```

  Идентификатор кластера можно запросить со [списком кластеров в каталоге](#list-clusters).

  По умолчанию информация об операциях выводится в текстовом формате. Чтобы получить более подробную информацию, укажите формат `yaml` или `json` для выводимых данных с помощью параметра `--format`:

  ```bash
  yc managed-opensearch cluster list-operations c9qk2926qqu9******** --format yaml
  ```

  Результат:

  ```text
  - id: dqh0ntf6batm********
    description: Create OpenSearch cluster
    created_at: "2024-09-07T16:36:46.816682Z"
    created_by: aje9k8luj4qf********
    modified_at: "2024-09-07T16:44:12.944302Z"
    done: true
    metadata:
      '@type': type.googleapis.com/yandex.cloud.mdb.opensearch.v1.CreateClusterMetadata
      cluster_id: c9q13q0acgv7********
    response:
      '@type': type.googleapis.com/google.rpc.Status
      message: OK
  ```

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [Cluster.ListOperations](../api-ref/Cluster/listOperations.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

      ```bash
      curl \
          --request GET \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --url 'https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/<идентификатор_кластера>/operations'
      ```

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/listOperations.md#yandex.cloud.mdb.opensearch.v1.ListClusterOperationsResponse).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [ClusterService.ListOperations](../api-ref/grpc/Cluster/listOperations.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/opensearch/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<идентификатор_кластера>"
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.opensearch.v1.ClusterService.ListOperations
      ```

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/listOperations.md#yandex.cloud.mdb.opensearch.v1.ListClusterOperationsResponse).

{% endlist %}

### Получить подробную информацию об операции {#get-operations-info}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. [Перейдите в список операций для нужного кластера](#get-operations).
    1. Нажмите на идентификатор операции, которую вы хотите посмотреть.

    {% include [operation-details](../../_includes/mdb/console/operation-details.md) %}

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы получить подробную информацию об операции, выполните команду:

    ```bash
    yc operation get <идентификатор_операции>
    ```

    Идентификатор операции можно получить со [списком операций](#get-operations) для кластера.

    Пример выдачи для завершенной операции по созданию кластера:

    ```text
    id: mos05eskhu9c********
    description: Create OpenSearch cluster
    created_at: "2025-12-29T02:29:51.793062Z"
    created_by: ajefhe0o8uas********
    modified_at: "2025-12-29T02:43:23.309182Z"
    done: true
    metadata:
      '@type': type.googleapis.com/yandex.cloud.mdb.opensearch.v1.CreateClusterMetadata
      cluster_id: c9q4g9irv5mc********
      operation_log:
        entities:
          - cluster_id: c9q4g9irv5mc********
            action: Preparing metadata
            started_at: "2025-12-29T02:29:53.865371Z"
          - cluster_id: c9q4g9irv5mc********
            action: Preparing backup storage
            started_at: "2025-12-29T02:29:56.453900Z"
          - cluster_id: c9q4g9irv5mc********
            action: Creating cluster
            started_at: "2025-12-29T02:30:15.668070Z"
            hosts:
              - fqdn: rc1a-r74k9d6q********.mdb.yandexcloud.net
                action: Reserving resources
                started_at: "2025-12-29T02:30:18.033652Z"
              - fqdn: rc1b-dpb2qtc7********.mdb.yandexcloud.net
                action: Reserving resources
                started_at: "2025-12-29T02:30:21.229073Z"
              - fqdn: rc1d-h86ujdc3********.mdb.yandexcloud.net
                action: Reserving resources
                started_at: "2025-12-29T02:30:25.193509Z"
              - fqdn: rc1a-fohc5nvj********.mdb.yandexcloud.net
                action: Reserving resources
                started_at: "2025-12-29T02:30:32.402818Z"
              - fqdn: rc1a-r74k9d6q********.mdb.yandexcloud.net
                action: Creating host
                started_at: "2025-12-29T02:30:38.915704Z"
              - fqdn: rc1b-dpb2qtc7********.mdb.yandexcloud.net
                action: Creating host
                started_at: "2025-12-29T02:30:40.253821Z"
              - fqdn: rc1d-h86ujdc3********.mdb.yandexcloud.net
                action: Creating host
                started_at: "2025-12-29T02:30:41.492932Z"
              - fqdn: rc1a-fohc5nvj********.mdb.yandexcloud.net
                action: Creating host
                started_at: "2025-12-29T02:30:42.740551Z"
          - cluster_id: c9q4g9irv5mc********
            action: Installing software
            started_at: "2025-12-29T02:33:15.769930Z"
            hosts:
              - fqdn: rc1d-h86ujdc3********.mdb.yandexcloud.net
                action: Launching host
                started_at: "2025-12-29T02:33:15.962886Z"
              - fqdn: rc1a-fohc5nvj********.mdb.yandexcloud.net
                action: Launching host
                started_at: "2025-12-29T02:33:16.190931Z"
              - fqdn: rc1a-r74k9d6q********.mdb.yandexcloud.net
                action: Launching host
                started_at: "2025-12-29T02:33:16.397641Z"
              - fqdn: rc1b-dpb2qtc7********.mdb.yandexcloud.net
                action: Launching host
                started_at: "2025-12-29T02:33:26.602596Z"
              - fqdn: rc1a-r74k9d6q********.mdb.yandexcloud.net
                action: Updating database software
                started_at: "2025-12-29T02:33:26.955555Z"
              - fqdn: rc1b-dpb2qtc7********.mdb.yandexcloud.net
                action: Updating database software
                started_at: "2025-12-29T02:33:27.164688Z"
              - fqdn: rc1d-h86ujdc3********.mdb.yandexcloud.net
                action: Updating database software
                started_at: "2025-12-29T02:33:27.372229Z"
              - fqdn: rc1a-fohc5nvj********.mdb.yandexcloud.net
                action: Updating database software
                started_at: "2025-12-29T02:33:27.584061Z"
          - cluster_id: c9q4g9irv5mc********
            action: Initializing database
            started_at: "2025-12-29T02:35:52.445284Z"
          - cluster_id: c9q4g9irv5mc********
            action: Infrastructure integration
            started_at: "2025-12-29T02:41:14.794423Z"
            hosts:
              - fqdn: rc1a-r74k9d6q********.mdb.yandexcloud.net
                action: Creating DNS records
                started_at: "2025-12-29T02:41:15.073269Z"
              - fqdn: rc1b-dpb2qtc7********.mdb.yandexcloud.net
                action: Creating DNS records
                started_at: "2025-12-29T02:41:15.328852Z"
              - fqdn: rc1d-h86ujdc3********.mdb.yandexcloud.net
                action: Creating DNS records
                started_at: "2025-12-29T02:41:15.578930Z"
              - fqdn: rc1a-fohc5nvj********.mdb.yandexcloud.net
                action: Creating DNS records
                started_at: "2025-12-29T02:41:15.837808Z"
              - fqdn: rc1a-r74k9d6q********.mdb.yandexcloud.net
                action: Updating database software
                started_at: "2025-12-29T02:41:24.297788Z"
              - fqdn: rc1b-dpb2qtc7********.mdb.yandexcloud.net
                action: Updating database software
                started_at: "2025-12-29T02:41:24.514965Z"
              - fqdn: rc1d-h86ujdc3********.mdb.yandexcloud.net
                action: Updating database software
                started_at: "2025-12-29T02:41:24.724648Z"
    response:
      '@type': type.googleapis.com/yandex.cloud.mdb.opensearch.v1.Cluster
      id: c9q4g9irv5mc********
      ...
    ```

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Operation.Get](../api-ref/Operation/get.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-operation }}/operations/<идентификатор_операции>'
        ```

        Идентификатор операции можно получить со [списком операций](#get-operations) для кластера.

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Operation/get.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
    1. Воспользуйтесь вызовом [OperationService.Get](../api-ref/grpc/Operation/get.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

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
            {{ api-host-operation }}:{{ port-https }} \
            yandex.cloud.operation.OperationService.Get
        ```

        Идентификатор операции можно получить со [списком операций](#get-operations) для кластера.

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Operation/get.md#yandex.cloud.operation.Operation).

{% endlist %}

#### См. также {#see-also}

* [{#T}](../../api-design-guide/concepts/about-async.md)
