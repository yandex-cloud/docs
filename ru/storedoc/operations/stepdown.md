# Переключение первичной реплики

Если в кластере есть [несколько реплик](../concepts/replication.md), то при необходимости можно переключить первичную реплику (мастер).

Переключение в среднем занимает менее одной минуты. Во время переключения кластер может быть недоступен для записи в течение нескольких секунд.

Подробнее о переключении первичной реплики см. в [документации {{ MG }}](https://docs.mongodb.com/manual/reference/method/rs.stepDown/).

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **Yandex StoreDoc**.
    1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mongodb.cluster.switch_hosts }}**.
    1. Нажмите на значок ![options](../../_assets/console-icons/ellipsis.svg) в строке `PRIMARY` хоста и выберите пункт **{{ ui-key.yacloud.mongodb.hosts.action_stepdown-host }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы переключить первичную реплику в кластере, выполните команду:

    ```bash
    {{ yc-mdb-mg }} hosts stepdown <имя_текущей_первичной_реплики> \
       --name=<имя_кластера>
    ```

    Имя первичной реплики для нужного шарда можно получить со [списком хостов в кластере](hosts.md#list), имя кластера — со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Cluster.StepdownHosts](../api-ref/Cluster/stepdownHosts.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/<идентификатор_кластера>:stepdownHosts' \
            --data '{
                     "hostNames": [
                        "<имя_текущей_первичной_реплики>"
                     ]
                    }'
        ```

        Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя первичной реплики для нужного шарда — со [списком хостов в кластере](hosts.md#list).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/stepdownHosts.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Воспользуйтесь вызовом [ClusterService.StepdownHosts](../api-ref/grpc/Cluster/stepdownHosts.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                 "cluster_id": "<идентификатор_кластера>",
                 "host_names": [
                    "<имя_текущей_первичной_реплики>"
                 ]
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.mongodb.v1.ClusterService.StepdownHosts
        ```    

        Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя первичной реплики для нужного шарда — со [списком хостов в кластере](hosts.md#list).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/stepdownHosts.md#yandex.cloud.operation.Operation).

{% endlist %}
