---
title: Как получить патч-версию {{ CH }} в {{ mch-full-name }}
description: Следуя данной инструкции, вы сможете узнать патч-версию {{ CH }}, установленную в кластере {{ mch-full-name }}.
---

# Получение патч-версии {{ CH }}

Чтобы узнать патч-версию {{ CH }}, установленную в кластере {{ mch-name }}, выполните следующие действия:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Найдите поле **{{ ui-key.yacloud.mdb.cluster.overview.label_version }}** с информацией о версии и патч-версии {{ CH }}.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить информацию о кластере {{ CH }}, выполните команду:
  
    ```
    {{ yc-mdb-ch }} cluster get <имя_или_идентификатор_кластера>
    ```

    Результат:

    ```text
    id: c9qvtmpmm3tc********
    folder_id: b1gurba83v2i********
    created_at: "2026-01-28T10:34:21.456105Z"
    name: clickhouse677
    environment: PRODUCTION
    ...
    config:
      version: "25.11"
      clickhouse:
        config:
          user_config:
            merge_tree: {}
        resources:
          resource_preset_id: s3-c2-m8
          disk_size: "10737418240"
          disk_type_id: network-ssd
        disk_size_autoscaling: {}
      zookeeper:
        resources: {}
        disk_size_autoscaling: {}
      ...
      backup_retain_period_days: "7"
      full_version: 25.11.6.11
      ...
    ```

    Где `full_version` — полная версия {{ CH }} с указанием патч-версии.

    Идентификатор и имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

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

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/get.md#yandex.cloud.mdb.clickhouse.v1.Cluster).

  1. В ответе сервера найдите поле `fullVersion`.

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Воспользуйтесь вызовом [ClusterService/Get](../api-ref/grpc/Cluster/get.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

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
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.clickhouse.v1.ClusterService.Get
      ```

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/get.md#yandex.cloud.mdb.clickhouse.v1.Cluster).

  1. В ответе сервера найдите поле `full_version`.

{% endlist %}
