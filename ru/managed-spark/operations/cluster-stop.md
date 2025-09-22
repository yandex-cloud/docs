---
title: Остановка и запуск кластера {{ SPRK }}
description: 'При необходимости вы можете остановить кластер {{ SPRK }} и запустить его заново. При остановке кластера все данные в нем сохранятся: они снова станут доступны, когда вы запустите кластер.'
---

# Остановка и запуск кластера {{ SPRK }}

При необходимости вы можете остановить кластер {{ SPRK }} и запустить его заново. При остановке кластера все данные в нем сохранятся: они снова станут доступны, когда вы запустите кластер.

## Остановить кластер {#stop-cluster}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
    1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spark }}**.
    1. Найдите нужный кластер в списке, нажмите значок ![options](../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud.mdb.clusters.button_action-stop }}**.
    1. В открывшемся диалоге подтвердите остановку кластера и нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.stop-dialog.popup-confirm_button }}**.

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

       {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Воспользуйтесь вызовом [ClusterService/Stop](../api-ref/grpc/Cluster/stop.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

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
           yandex.cloud.spark.v1.ClusterService.Stop
       ```

       Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/stop.md#yandex.cloud.operation.Operation).

{% endlist %}

## Запустить кластер {#start-cluster}

Кластер в статусе `Stopped` можно запустить заново.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
    1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spark }}**.
    1. Найдите нужный остановленный кластер в списке, нажмите значок ![options](../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud.mdb.clusters.button_action-start }}**.
    1. В открывшемся диалоге нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.start-dialog.popup-confirm_button }}**.

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Воспользуйтесь вызовом [ClusterService/Start](../api-ref/grpc/Cluster/start.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

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
           yandex.cloud.spark.v1.ClusterService.Start
       ```

       Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/start.md#yandex.cloud.operation.Operation).

{% endlist %}
