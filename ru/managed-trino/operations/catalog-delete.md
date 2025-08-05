---
title: Удаление каталога {{ TR }}
description: Следуя этой инструкции, вы удалите каталог из кластера {{ mtr-name }}.
---

# Удаление каталога {{ TR }}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На странице [каталога ресурсов]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
  1. Нажмите на имя нужного кластера.
  1. На панели слева выберите ![image](../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.trino.title_catalogs }}**.
  1. В строке с нужным каталогом {{ TR }} нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud.common.delete }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы удалить каталог {{ TR }}, выполните команду:

    ```bash
    {{ yc-mdb-tr }} catalog delete <имя_или_идентификатор_каталога_{{ TR }}> \
      --cluster-id <идентификатор_кластера>
    ```

    Идентификатор и имя каталога {{ TR }} можно запросить со [списком каталогов {{ TR }} в кластере](catalog-list.md#list-catalogs).

    Идентификатор кластера можно запросить со [списком кластеров](cluster-list.md#list-clusters).

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Catalog.Delete](../api-ref/Catalog/delete.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request DELETE \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-trino }}/managed-trino/v1/clusters/<идентификатор_кластера>/catalogs/<идентификатор_каталога_{{ TR }}>'
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), идентификатор каталога — со [списком каталогов {{ TR }} в кластере](catalog-list.md).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Catalog/delete.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Воспользуйтесь вызовом [CatalogService.Delete](../api-ref/grpc/Catalog/delete.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/trino/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<идентификатор_кластера>",
                    "catalog_id": "<идентификатор_каталога_{{ TR }}>"
                }' \
            {{ api-host-trino }}:{{ port-https }} \
            yandex.cloud.trino.v1.ClusterService.Delete
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), идентификатор каталога — со [списком каталогов {{ TR }} в кластере](catalog-list.md).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Catalog/delete.md#yandex.cloud.operation.Operation).

{% endlist %}