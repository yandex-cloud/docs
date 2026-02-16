---
title: Информация о кластерах в {{ msp-full-name }}
description: Вы можете запросить детальную информацию о каждом созданном вами кластере {{ SPRK }}. Чтобы получить список кластеров в каталоге, перейдите на страницу каталога и выберите сервис {{ msp-full-name }}.
---

# Информация об имеющихся кластерах

Вы можете запросить детальную информацию о каждом созданном вами кластере {{ SPRK }}.

## Получить список кластеров в каталоге {#list-clusters}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spark }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы запросить список кластеров {{ SPRK }} в каталоге по умолчанию, выполните команду:

    ```bash
    {{ yc-mdb-sp }} cluster list
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

       {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Воспользуйтесь вызовом [ClusterService/List](../api-ref/grpc/Cluster/list.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

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
           {{ api-host-spark }}:{{ port-https }} \
           yandex.cloud.spark.v1.ClusterService.List
           ```
       
       Идентификатор каталога можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).
       
    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/list.md#yandex.cloud.spark.v1.ListClustersResponse).

{% endlist %}

## Получить детальную информацию о кластере {#get-cluster}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spark }}**.
    1. Нажмите на имя нужного кластера.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы получить информацию о кластере {{ SPRK }}, выполните команду:

    ```bash
    {{ yc-mdb-sp }} cluster get <имя_или_идентификатор_кластера>
    ```

    Имя и идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

       {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Воспользуйтесь вызовом [ClusterService/Get](../api-ref/grpc/Cluster/get.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

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
           {{ api-host-spark }}:{{ port-https }} \
           yandex.cloud.spark.v1.ClusterService.Get
       ```

       Идентификатор кластера можно запросить со [списком кластеров в каталоге](#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/get.md#yandex.cloud.spark.v1.Cluster).

{% endlist %}

## Посмотреть операции с кластерами {#list-operations}

Все действия с кластерами {{ SPRK }} сохраняются в виде списка операций. Каждой операции присваивается уникальный идентификатор.

### Получить список операций {#get-operations}

{% list tabs group=instructions %}

- Консоль управления {#console}

    Чтобы получить список операций для кластера {{ SPRK }}:

    1. В [консоли управления]({{ link-console-main }}) откройте каталог, в котором находится кластер.
    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spark }}**.
    1. На панели слева выберите ![image](../../_assets/console-icons/cubes-3.svg) **{{ ui-key.yacloud.mdb.clusters.label_title }}**.
    1. Выберите нужный кластер.
    1. Перейдите на панель ![image](../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.common.operations-key-value }}** для выбранного кластера.

        В открывшемся списке отображаются операции с выбранным кластером.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы получить список операций для кластера {{ SPRK }}, выполните команду:

    ```bash
    {{ yc-mdb-sp }} cluster list-operations <имя_или_идентификатор_кластера>
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
    {{ yc-mdb-sp }} cluster list-operations <имя_или_идентификатор_кластера> --format yaml
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

       {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Воспользуйтесь вызовом [ClusterService/ListOperations](../api-ref/grpc/Cluster/listOperations.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

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
           {{ api-host-spark }}:{{ port-https }} \
           yandex.cloud.spark.v1.ClusterService.ListOperations
       ```

       Идентификатор кластера можно запросить со [списком кластеров в каталоге](#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/listOperations.md#yandex.cloud.spark.v1.ListClusterOperationsResponse).

{% endlist %}

## См. также {#see-also}

* [{#T}](../../api-design-guide/concepts/about-async.md)
