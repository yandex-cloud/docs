---
title: Как получить патч-версию {{ KF }} в {{ mkf-full-name }}
description: Следуя данной инструкции, вы сможете узнать патч-версию {{ KF }}, установленную в кластере {{ mkf-full-name }}.
---

# Получение патч-версии {{ KF }}

Чтобы узнать патч-версию {{ KF }}, установленную в кластере {{ mkf-name }}, выполните следующие действия:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
  1. Найдите поле **{{ ui-key.yacloud.mdb.cluster.overview.label_version }}** с информацией о версии и патч-версии {{ KF }}.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить информацию о кластере {{ KF }}, выполните команду:
  
    ```
    {{ yc-mdb-kf }} cluster get <имя_или_идентификатор_кластера>
    ```

    Результат:

    ```text
    id: c9q8d856r3nt********
    folder_id: b1gurba83v2i********
    created_at: "2025-06-16T10:57:42.582559Z"
    name: kafka947
    environment: PRODUCTION
    ...
    config:
      version: "3.6"
      kafka:
        resources:
          resource_preset_id: s3-c2-m8
          disk_size: "34359738368"
          disk_type_id: network-ssd
    ...
      rest_api_config:
        enabled: true
      kafka_ui_config:
        enabled: true
      patch_version: 3.6.1
    ...
    ```

    Где `patch_version` — патч-версия {{ KF }}.

    Идентификатор и имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [Cluster.get](../api-ref/Cluster/get.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

      ```bash
      curl \
          --request GET \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<идентификатор_кластера>'
      ```

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/get.md#yandex.cloud.mdb.kafka.v1.Cluster).

  1. В ответе сервера найдите поле `patchVersion`.

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
          -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                  "cluster_id": "<идентификатор_кластера>"
              }' \
          {{ api-host-mdb }}:443 \
          yandex.cloud.mdb.kafka.v1.ClusterService.Get
      ```

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/get.md#yandex.cloud.mdb.kafka.v1.Cluster).

  1. В ответе сервера найдите поле `patch_version`.

{% endlist %}

