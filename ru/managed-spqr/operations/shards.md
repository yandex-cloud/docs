---
title: Управление шардами {{ SPQR }}
description: Следуя данной инструкции, вы сможете создать шарды в кластере {{ mspqr-name }}.
keywords:
  - keyword: управлять шардами в {{ SPQR }}
  - keyword: создать шард в {{ SPQR }}
  - '{{ SPQR }}'
---

# Управление шардами {{ SPQR }}

{% include [preview](../../_includes/note-service-preview.md) %}

## Создать шард {#create-shard}

Шарды {{ SPQR }} создаются на основе существующих кластеров {{ mpg-full-name }}, расположенных в том же каталоге и в той же облачной сети, что и кластер {{ SPQR }}.


{% include [note-sg](../../_includes/managed-spqr/note-sg.md) %}


{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mdb.cluster.shards.label_title }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.shards.action_add-shard }}**.
    1. Укажите имя шарда и выберите кластер {{ PG }}, хосты которого будут использоваться в качестве хостов с данными в кластере {{ SPQR }}.
    1. Нажмите кнопку **Создать**.

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [Cluster.AddShard](../api-ref/Cluster/addShard.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request POST \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-spqr/v1/clusters/<идентификатор_кластера>/shards' \
       --data '{
                 "shardSpec": {
                   "shardName": "<имя_шарда>",
                   "mdbPostgresql": {
                     "clusterId": "<идентификатор_кластера_{{ PG }}>"
                   }
                 }
               }'
     ```

     Где `mdbPostgresql.clusterId` — идентификатор кластера {{ mpg-name }} в составе шарда.

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/addShard.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Воспользуйтесь вызовом [ClusterService.AddShard](../api-ref/grpc/Cluster/addShard.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/spqr/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": <идентификатор_кластера>
             "shard_spec": {
               "shard_name": "<имя_шарда>",
               "mdb_postgresql": {
                 "cluster_id": "<идентификатор_кластера_{{ PG }}>"
               }
             }
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.spqr.v1.ClusterService.AddShard
     ```

     Где `mdb_postgresql.cluster_id` — идентификатор кластера {{ mpg-name }} в составе шарда.

{% endlist %}

## Удалить шард {#delete-shard}

При удалении шарда {{ SPQR }} кластер {{ mpg-name }} не удаляется.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mdb.cluster.shards.label_title }}**.
    1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) в строке нужного шарда и выберите пункт **{{ ui-key.yacloud.mdb.clusters.button_action-delete }}**.
    1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.common.delete }}**.

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [Cluster.DeleteShard](../api-ref/Cluster/deleteShard.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request DELETE \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-spqr/v1/clusters/<идентификатор_кластера>/shards/<имя_шарда>'
     ```

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/deleteShard.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Воспользуйтесь вызовом [ClusterService.DeleteShard](../api-ref/grpc/Cluster/deleteShard.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/spqr/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": <идентификатор_кластера>,
             "shard_name": "<имя_шарда>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.spqr.v1.ClusterService.DeleteShard
     ```

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/deleteShard.md#yandex.cloud.operation.Operation).

{% endlist %}
