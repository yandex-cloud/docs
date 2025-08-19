---
title: Getting information about catalogs in a {{ mtr-name }} cluster
description: Follow this guide to get a list of catalogs in a {{ mtr-name }} cluster and detailed information about each of them.
---

# Getting information about catalogs in a {{ mtr-name }} cluster

## Getting a list of catalogs in a cluster {#list-catalogs}

{% list tabs group=instructions %}

- Management console {#console}

    1. On the [resource folder]({{ link-console-main }}) page, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
    1. Click the cluster name.
    1. In the left-hand panel, select ![image](../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.trino.title_catalogs }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To get a list of {{ TR }} catalogs in a {{ mtr-name }} cluster, run this command:

    ```bash
    {{ yc-mdb-tr }} catalog list \
        --cluster-id <cluster_ID>
    ```

    You can request the cluster ID with a [list of clusters](cluster-list.md#list-clusters).

    Result:

    ```bash
    +----------------------+---------+----------------+---------------+
    |          ID          |  NAME   | CONNECTOR TYPE |  DESCRIPTION  |
    +----------------------+---------+----------------+---------------+
    | c9qimrjgi9os******** | catalog |   postgresql   | Trino catalog |
    +----------------------+---------+----------------+---------------+
    ```

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Catalog.List](../api-ref/Catalog/list.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-trino }}/managed-trino/v1/clusters/<cluster_ID>/catalogs'
        ```

        You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/Catalog/list.md#yandex.cloud.trino.v1.ListCatalogsResponse) to make sure the request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [CatalogService.List](../api-ref/grpc/Catalog/list.md) call and run the following request, e.g., via {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/trino/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<cluster_ID>"
                }' \
            {{ api-host-trino }}:{{ port-https }} \
            yandex.cloud.trino.v1.CatalogService.List
        ```

        You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/grpc/Catalog/list.md#yandex.cloud.trino.v1.ListCatalogsResponse) to make sure the request was successful.

{% endlist %}

## Getting detailed information about a catalog {#get-catalog}

{% list tabs group=instructions %}

- Management console {#console}

    1. On the [resource folder]({{ link-console-main }}) page, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
    1. Click the cluster name.
    1. In the left-hand panel, select ![image](../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.trino.title_catalogs }}**.
    1. Click the {{ TR }} catalog name.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To get detailed information about a {{ TR }} catalog, run this command:

    ```bash
    {{ yc-mdb-tr }} catalog get <{{ TR }}_catalog_name_or_ID> \
        --cluster-id <cluster_ID>
    ```

    You can get the {{ TR }} catalog ID and name together with the [list of {{ TR }} catalogs in the cluster](#list-catalogs.md).

    You can request the cluster ID with a [list of clusters](cluster-list.md#list-clusters).

    Result:

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

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Catalog.Get](../api-ref/Catalog/get.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-trino }}/managed-trino/v1/clusters/<cluster_ID>/catalogs/<{{ TR }}_catalog_ID>'
        ```

        You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters) and the folder ID with the [list of {{ TR }} catalogs in the cluster](catalog-list.md).

    1. View the [server response](../api-ref/Catalog/get.md#yandex.cloud.trino.v1.Catalog) to make sure the request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [CatalogService.Get](../api-ref/grpc/Catalog/get.md) call and run the following request, e.g., via {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/trino/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<cluster_ID>",
                    "catalog_id": "<{{ TR }}_folder_ID>"
                }' \
            {{ api-host-trino }}:{{ port-https }} \
            yandex.cloud.trino.v1.CatalogService.Get
        ```

        You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters) and the folder ID with the [list of {{ TR }} catalogs in the cluster](catalog-list.md).

    1. View the [server response](../api-ref/grpc/Catalog/get.md#yandex.cloud.trino.v1.Catalog) to make sure the request was successful.

{% endlist %}