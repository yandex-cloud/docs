# Перезапустить хост

Перезапуск хостов может понадобиться, если нужно экстренно устранить такие проблемы, как:

* перерасход ресурсов;
* утечка памяти;
* взаимоблокировка (deadlock) между запросами;
* зависание операций и внутренних процессов {{ CH }}.

Чтобы перезапустить хост:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Нажмите на имя нужного кластера и перейдите на вкладку **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
  1. В строке нужного хоста нажмите на значок ![icon](../../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud.mdb.cluster.hosts.action_restart-host }}**.
  1. Подтвердите перезагрузку хоста.

- CLI {#cli}

  {% include [cli-install](../../cli-install.md) %}

  {% include [default-catalogue](../../default-catalogue.md) %}

  Чтобы перезапустить хост, выполните команду:

  ```bash
  {{ yc-mdb-ch }} host restart <имя_хоста> \
     --cluster-name=<имя_кластера>
  ```

  Имя хоста можно запросить со списком хостов в кластере, имя кластера — со [списком кластеров в каталоге](../../../managed-clickhouse/operations/cluster-list.md#list-clusters).

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../../../managed-clickhouse/api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Cluster.restartHosts](../../../managed-clickhouse/api-ref/Cluster/restartHosts.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<идентификатор_кластера>/hosts:restartHosts' \
            --data '{
                      "hostNames": [
                        <перечень_имен_хостов>
                      ]
                    }'
        ```

        Где `hostNames` — массив строк. Каждая строка — имя хоста, который нужно перезапустить. Имена хостов можно запросить со [списком хостов в кластере](../../../managed-clickhouse/operations/hosts.md#list-hosts).

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](../../../managed-clickhouse/operations/cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../../managed-clickhouse/api-ref/Cluster/restartHosts.md#responses).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../../../managed-clickhouse/api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../mdb/grpc-api-setup-repo.md) %}

    1. Воспользуйтесь вызовом [ClusterService/RestartHosts](../../../managed-clickhouse/api-ref/grpc/cluster_service.md#RestartHosts) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<идентификатор_кластера>",
                    "host_names": [
                      <перечень_имен_хостов>
                    ]
                }' \
            {{ api-host-mdb }}:443 \
            yandex.cloud.mdb.clickhouse.v1.ClusterService.RestartHosts
        ```

        Где `host_names` — массив строк. Каждая строка — имя хоста, который нужно перезапустить. Имена хостов можно запросить со [списком хостов в кластере](../../../managed-clickhouse/operations/hosts.md#list-hosts).

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](../../../managed-clickhouse/operations/cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../../managed-clickhouse/api-ref/grpc/cluster_service.md#Operation14).

{% endlist %}
