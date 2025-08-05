---
title: Получение информации о каталогах в кластере {{ mtr-name }}
description: Следуя этой инструкции, сможете получить список каталогов в кластере {{ mtr-name }} и запросить подробную информацию о каждом из них.
---

# Получение информации о каталогах в кластере {{ mtr-name }}

## Получить список каталогов в кластере {#list-catalogs}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. На странице [каталога ресурсов]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
    1. Нажмите на имя нужного кластера.
    1. На панели слева выберите ![image](../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.trino.title_catalogs }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы получить список каталогов {{ TR }} в кластере {{ mtr-name }}, выполните команду:

    ```bash
    {{ yc-mdb-tr }} catalog list \
        --cluster-id <идентификатор_кластера>
    ```

    Идентификатор кластера можно запросить со [списком кластеров](cluster-list.md#list-clusters).

    Результат:

    ```bash
    +----------------------+---------+----------------+---------------+
    |          ID          |  NAME   | CONNECTOR TYPE |  DESCRIPTION  |
    +----------------------+---------+----------------+---------------+
    | c9qimrjgi9os******** | catalog |   postgresql   | Trino catalog |
    +----------------------+---------+----------------+---------------+
    ```

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Catalog.List](../api-ref/Catalog/list.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-trino }}/managed-trino/v1/clusters/<идентификатор_кластера>/catalogs'
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Catalog/list.md#yandex.cloud.trino.v1.ListCatalogsResponse).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Воспользуйтесь вызовом [CatalogService.List](../api-ref/grpc/Catalog/list.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/trino/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<идентификатор_кластера>"
                }' \
            {{ api-host-trino }}:{{ port-https }} \
            yandex.cloud.trino.v1.CatalogService.List
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Catalog/list.md#yandex.cloud.trino.v1.ListCatalogsResponse).

{% endlist %}

## Получить детальную информацию о каталоге {#get-catalog}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. На странице [каталога ресурсов]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
    1. Нажмите на имя нужного кластера.
    1. На панели слева выберите ![image](../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.trino.title_catalogs }}**.
    1. Нажмите на имя нужного каталога {{ TR }}.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы получить информацию о каталоге {{ TR }}, выполните команду:

    ```bash
    {{ yc-mdb-tr }} catalog get <имя_или_идентификатор_каталога_{{ TR }}> \
        --cluster-id <идентификатор_кластера>
    ```

    Идентификатор и имя каталога {{ TR }} можно запросить со [списком каталогов {{ TR }} в кластере](#list-catalogs.md).

    Идентификатор кластера можно запросить со [списком кластеров](cluster-list.md#list-clusters).

    Результат:

    ```yml
    id: c9qimrjgi9os********
    name: my-catalog
    connector:
      postgresql:
        connection:
          connection_manager:
            connection_id: a5968k5e1cpn********
            database: my-db
    ```

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Catalog.Get](../api-ref/Catalog/get.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-trino }}/managed-trino/v1/clusters/<идентификатор_кластера>/catalogs/<идентификатор_каталога_{{ TR }}>'
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), идентификатор каталога — со [списком каталогов {{ TR }} в кластере](catalog-list.md).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Catalog/get.md#yandex.cloud.trino.v1.Catalog).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Воспользуйтесь вызовом [CatalogService.Get](../api-ref/grpc/Catalog/get.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/trino/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<идентификатор_кластера>",
                    "catalog_id": "<идентификатор_каталога_ {{ TR }}>"
                }' \
            {{ api-host-trino }}:{{ port-https }} \
            yandex.cloud.trino.v1.CatalogService.Get
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), идентификатор каталога — со [списком каталогов {{ TR }} в кластере](catalog-list.md).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Catalog/get.md#yandex.cloud.trino.v1.Catalog).

{% endlist %}