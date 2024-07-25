---
title: "Информация о кластерах в {{ mch-short-name }}"
description: "Вы можете запросить детальную информацию о каждом созданном вами кластере {{ mch-short-name }}. Чтобы получить список кластеров БД в каталоге, перейдите на страницу каталога и выберите сервис {{ mch-name }}."
---

# Информация об имеющихся кластерах {{ CH }}

Вы можете запросить детальную информацию о каждом созданном вами кластере {{ mch-short-name }}.

## Получить список кластеров БД в каталоге {#list-clusters}

{% list tabs group=instructions %}

- Консоль управления {#console}

  В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы запросить список кластеров {{ CH }} в каталоге по умолчанию, выполните команду:

  ```
  {{ yc-mdb-ch }} cluster list

  +----------------------+------+-------------+---------+---------------------+--------+---------+
  |          ID          | NAME | ENVIRONMENT | VERSION |     CREATED AT      | HEALTH | STATUS  |
  +----------------------+------+-------------+---------+---------------------+--------+---------+
  | c9qf1kmm0ebi******** | mych | PRODUCTION  |    23.8 | 2024-06-06 10:23:22 | ALIVE  | RUNNING |
  | ...                                                                                          |
  +----------------------+------+-------------+---------+---------------------+--------+---------+
  ```

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Cluster.list](../api-ref/Cluster/list.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters?folderId=<идентификатор_каталога>'
        ```

        
        Идентификатор каталога можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).


    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/list.md#responses).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Воспользуйтесь вызовом [ClusterService/List](../api-ref/grpc/cluster_service.md#List) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

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
            {{ api-host-mdb }}:443 \
            yandex.cloud.mdb.clickhouse.v1.ClusterService.List
        ```

        
        Идентификатор каталога можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).


    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/cluster_service.md#ListClustersResponse).

{% endlist %}

## Получить детальную информацию о кластере {#get-cluster}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Нажмите на имя нужного кластера.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить информацию о кластере {{ CH }}, выполните команду:

  ```
  {{ yc-mdb-ch }} cluster get <имя_или_идентификатор_кластера>
  ```

  Идентификатор и имя кластера можно запросить со [списком кластеров в каталоге](#list-clusters).

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Cluster.get](../api-ref/Cluster/get.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<идентификатор_кластера>'
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/get.md#responses).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Воспользуйтесь вызовом [ClusterService/Get](../api-ref/grpc/cluster_service.md#Get) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

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
            {{ api-host-mdb }}:443 \
            yandex.cloud.mdb.clickhouse.v1.ClusterService.Get
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/cluster_service.md#Cluster).

{% endlist %}

## Посмотреть список операций в кластере {#list-operations}

{% include [list-operations-about](../../_includes/mdb/list-operations-about.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Нажмите на имя нужного кластера.
  1. Перейдите на вкладку **{{ ui-key.yacloud.clickhouse.cluster.switch_operations }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить список операций, выполните команду:

  ```
  {{ yc-mdb-ch }} cluster list-operations <имя_или_идентификатор_кластера>
  ```

  Идентификатор и имя кластера можно запросить со [списком кластеров в каталоге](#list-clusters).

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Cluster.listOperations](../api-ref/Cluster/listOperations.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<идентификатор_кластера>/operations'
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/listOperations.md#responses).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Воспользуйтесь вызовом [ClusterService/ListOperations](../api-ref/grpc/cluster_service.md#ListOperations) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

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
            {{ api-host-mdb }}:443 \
            yandex.cloud.mdb.clickhouse.v1.ClusterService.ListOperations
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/cluster_service.md#ListClusterOperationsResponse).

{% endlist %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
