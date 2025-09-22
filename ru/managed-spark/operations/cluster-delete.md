---
title: Удаление кластера {{ SPRK }}
description: Вы можете удалить кластер {{ SPRK }}, если он вам больше не нужен.
keywords:
  - удаление кластера {{ SPRK }}
---

# Удаление кластера {{ SPRK }}

Вы можете удалить кластер {{ SPRK }}, если он вам больше не нужен.

## Удалить кластер {#delete}

Перед удалением кластера отключите защиту от удаления для кластера, если она включена.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, из которого нужно удалить кластер.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spark }}**.
  1. Нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) для нужного кластера и выберите пункт **{{ ui-key.yacloud.mdb.cluster.overview.button_action-delete }}**.
  1. В открывшемся окне подтвердите удаление и нажмите кнопку **{{ ui-key.yacloud.mdb.dialogs.popup-confirm-delete-cluster_button }}**.

- {{ TF }} {#tf}

  {% include [terraform-delete-mdb-cluster](../../_includes/mdb/terraform-delete-mdb-cluster.md) %}

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:
  
     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}
  
  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  
  1. Воспользуйтесь вызовом [ClusterService/Delete](../api-ref/grpc/Cluster/delete.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:
  
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
         yandex.cloud.spark.v1.ClusterService.Delete
     ```
  
     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
  
  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/delete.md#yandex.cloud.operation.Operation).

{% endlist %}
