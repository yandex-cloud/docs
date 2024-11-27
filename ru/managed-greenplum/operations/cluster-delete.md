---
title: Как удалить кластер в {{ mgp-full-name }}
description: Из статьи вы узнаете, как удалить кластер в {{ mgp-name }}.
---

# Удаление кластера {{ GP }}

## Перед удалением кластера {#before-you-delete}

[Отключите защиту от удаления](./update.md#change-additional-settings) для кластера, если она включена.

## Удалить кластер {#delete}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите [на страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
  1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) для нужного кластера и выберите пункт **{{ ui-key.yacloud.mdb.clusters.button_action-delete }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы удалить кластер, выполните команду:

    ```bash
    {{ yc-mdb-gp }} cluster delete <имя_или_идентификатор_кластера>
    ```

    Идентификатор и имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

  Чтобы удалить инфраструктуру, созданную с помощью {{ TF }}:

    1. В терминале перейдите в директорию с планом инфраструктуры.
    1. Удалите конфигурационный файл {{ TF }} нужного кластера.
    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

       Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Подтвердите изменение ресурсов.

       {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

       Все ресурсы, которые были описаны в конфигурационном файле, будут удалены.

  {% include [Terraform timeouts](../../_includes/mdb/mgp/terraform-timeouts.md) %}

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Cluster.Delete](../api-ref/Cluster/delete.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request DELETE \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/<идентификатор_кластера>'
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/delete.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Воспользуйтесь вызовом [ClusterService.Delete](../api-ref/grpc/Cluster/delete.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.greenplum.v1.ClusterService.Delete
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/delete.md#yandex.cloud.operation.Operation).

{% endlist %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
