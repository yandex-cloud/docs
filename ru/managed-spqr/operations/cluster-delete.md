---
title: Удаление кластера {{ SPQR }}
description: Вы можете удалить кластер {{ SPQR }}, если он вам больше не нужен.
keywords:
  - keyword: удаление кластера {{ SPQR }}
  - keyword: кластер {{ SPQR }}
  - keyword: '{{ SPQR }}'
---

# Удаление кластера {{ SPQR }}

{% include notitle [preview](../../_includes/note-preview.md) %}

Вы можете удалить кластер {{ SPQR }}, если он вам больше не нужен.

## Удалить кластер {#delete}

Перед удалением кластера отключите его защиту от удаления, если она включена.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, из которого нужно удалить кластер.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}**.
    1. Нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) для нужного кластера и выберите пункт **{{ ui-key.yacloud.mdb.cluster.overview.button_action-delete }}**.
    1. В открывшемся окне подтвердите удаление и нажмите кнопку **{{ ui-key.yacloud.mdb.dialogs.popup-confirm-delete-cluster_button }}**.

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [Cluster.Delete](../api-ref/Cluster/delete.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request DELETE \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-spqr/v1/clusters/<идентификатор_кластера>'
     ```

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/deleteShard.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Воспользуйтесь вызовом [ClusterService.Delete](../api-ref/grpc/Cluster/delete.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/spqr/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": <идентификатор_кластера>
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.spqr.v1.ClusterService.Delete
     ```

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/delete.md#yandex.cloud.operation.Operation).

{% endlist %}
