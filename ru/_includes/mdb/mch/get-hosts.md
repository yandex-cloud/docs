# Получить список хостов в кластере

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Нажмите на имя нужного кластера, затем выберите вкладку **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.

- CLI {#cli}

  {% include [cli-install](../../cli-install.md) %}

  {% include [default-catalogue](../../default-catalogue.md) %}

  Чтобы получить список хостов в кластере, выполните команду:

  ```bash
  {{ yc-mdb-ch }} host list \
     --cluster-name=<имя_кластера>
  ```

  ```text
  +----------------------------+--------------+---------+--------+---------------+
  |            NAME            |  CLUSTER ID  |  ROLE   | HEALTH |    ZONE ID    |
  +----------------------------+--------------+---------+--------+---------------+
  | rc1b...{{ dns-zone }} | c9qp71dk1... | MASTER  | ALIVE  | {{ region-id }}-b |
  | rc1a...{{ dns-zone }} | c9qp71dk1... | REPLICA | ALIVE  | {{ region-id }}-a |
  +----------------------------+--------------+---------+--------+---------------+
  ```

  Имя кластера можно запросить со [списком кластеров в каталоге](../../../managed-clickhouse/operations/cluster-list.md#list-clusters).

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../../../managed-clickhouse/api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Cluster.listHosts](../../../managed-clickhouse/api-ref/Cluster/listHosts.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<идентификатор_кластера>/hosts'
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](../../../managed-clickhouse/operations/cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../../managed-clickhouse/api-ref/Cluster/listHosts.md#responses).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../../../managed-clickhouse/api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../mdb/grpc-api-setup-repo.md) %}

    1. Воспользуйтесь вызовом [ClusterService/ListHosts](../../../managed-clickhouse/api-ref/grpc/cluster_service.md#ListHosts) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

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
            {{ api-host-mdb }}:443 \
            yandex.cloud.mdb.clickhouse.v1.ClusterService.ListHosts
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](../../../managed-clickhouse/operations/cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../../managed-clickhouse/api-ref/grpc/cluster_service.md#ListClusterHostsResponse).

{% endlist %}
