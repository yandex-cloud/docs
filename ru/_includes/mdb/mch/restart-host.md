# Перезагрузить хост

Перезагрузка хостов может понадобиться, если нужно экстренно устранить такие проблемы, как:

* перерасход ресурсов;
* утечка памяти;
* взаимоблокировка (deadlock) между запросами;
* зависание операций и внутренних процессов {{ CH }}.

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы перезагрузить один хост:

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
    1. Нажмите на имя нужного кластера и перейдите на вкладку **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
    1. В строке нужного хоста нажмите на значок ![icon](../../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud.mdb.cluster.hosts.action_restart-host }}**.
    1. В открывшемся окне включите опцию **Я перезагружаю хост** и нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.hosts.popup-confirm_button }}**.

  Чтобы перезагрузить несколько хостов сразу:

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
    1. Нажмите на имя нужного кластера и перейдите на вкладку **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
    1. Выберите хосты, которые хотите перезагрузить, и нажмите **{{ ui-key.yacloud.mdb.cluster.hosts.action_restart-host }}** в нижней части экрана.
    1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.hosts.popup-confirm_button }}**.

- CLI {#cli}

  {% include [cli-install](../../cli-install.md) %}

  {% include [default-catalogue](../../default-catalogue.md) %}

  Чтобы перезагрузить один или несколько хостов, выполните команду, передав их имена. Используйте пробел в качестве разделителя.

  Команда для перезагрузки одного хоста выглядит так:

  ```bash
  {{ yc-mdb-ch }} host restart <имя_хоста> \
     --cluster-name=<имя_кластера>
  ```

  Имя хоста можно запросить со списком хостов в кластере, имя кластера — со [списком кластеров в каталоге](../../../managed-clickhouse/operations/cluster-list.md#list-clusters).

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../../../managed-clickhouse/api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Cluster.RestartHosts](../../../managed-clickhouse/api-ref/Cluster/restartHosts.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

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

        Где `hostNames` — массив строк. Каждая строка — имя хоста, который нужно перезагрузить. Имена хостов можно запросить со [списком хостов в кластере](../../../managed-clickhouse/operations/hosts.md#list-hosts).

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](../../../managed-clickhouse/operations/cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../../managed-clickhouse/api-ref/Cluster/restartHosts.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../../../managed-clickhouse/api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../mdb/grpc-api-setup-repo.md) %}

    1. Воспользуйтесь вызовом [ClusterService.RestartHosts](../../../managed-clickhouse/api-ref/grpc/Cluster/restartHosts.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

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
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.clickhouse.v1.ClusterService.RestartHosts
        ```

        Где `host_names` — массив строк. Каждая строка — имя хоста, который нужно перезагрузить. Имена хостов можно запросить со [списком хостов в кластере](../../../managed-clickhouse/operations/hosts.md#list-hosts).

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](../../../managed-clickhouse/operations/cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../../managed-clickhouse/api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation).

{% endlist %}
