---
title: Deleting a {{ TR }} catalog
description: Follow this guide to delete a catalog from a {{ mtr-name }} cluster.
---

# Deleting a {{ TR }} catalog

{% list tabs group=instructions %}

- Management console {#console}

  1. On the [resource folder]({{ link-console-main }}) page, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
  1. Click the cluster name.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.trino.title_catalogs }}**.
  1. Next to the {{ TR }} catalog, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.delete }}**.
  1. In the window that opens, click **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To delete the {{ TR }} catalog, run this command:

    ```bash
    {{ yc-mdb-tr }} catalog delete <{{ TR }}_catalog_name_or_ID> \
      --cluster-id <cluster_ID>
    ```

    You can get the {{ TR }} catalog ID and name together with the [list of {{ TR }} catalogs in the cluster](catalog-list.md#list-catalogs).

    You can request the cluster ID with a [list of clusters](cluster-list.md#list-clusters).

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Catalog.Delete](../api-ref/Catalog/delete.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request DELETE \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-trino }}/managed-trino/v1/clusters/<cluster_ID>/catalogs/<{{ TR }}_catalog_ID>'
        ```

        You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters) and the folder ID with the [list of {{ TR }} catalogs in the cluster](catalog-list.md).

    1. View the [server response](../api-ref/Catalog/delete.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [CatalogService.Delete](../api-ref/grpc/Catalog/delete.md) call and run the following request, e.g., via {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/trino/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<cluster_ID>",
                    "catalog_id": "<{{ TR }}_catalog_ID>"
                }' \
            {{ api-host-trino }}:{{ port-https }} \
            yandex.cloud.trino.v1.ClusterService.Delete
        ```

        You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters) and the folder ID with the [list of {{ TR }} catalogs in the cluster](catalog-list.md).

    1. View the [server response](../api-ref/grpc/Catalog/delete.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}