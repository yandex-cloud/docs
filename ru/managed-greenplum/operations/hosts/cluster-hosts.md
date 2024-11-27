# Информация о хостах кластера {{ GP }}

Вы можете получить список хостов (мастеров и сегментов) в кластере {{ mgp-name }}. Для этого:

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите [на страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Нажмите на имя нужного кластера, затем выберите вкладку ![hosts.svg](../../../_assets/console-icons/cube.svg) **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.

    В списке хостов в колонке **{{ ui-key.yacloud.mdb.cluster.hosts.host_column_role }}** указывается роль каждого хоста:

    * `MASTER` — первичный хост-мастер (PRIMARY). Принимает пользовательские подключения.
    * `REPLICA` — резервный хост-мастер (STANDBY). Реплицирует данные первичного хоста-мастера.
    * `SEGMENT` — хост-сегмент. Хранит часть данных кластера.

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Чтобы получить список хостов-мастеров в кластере, выполните команду:

    ```bash
    {{ yc-mdb-gp }} hosts list master \
       --cluster-name=<имя_кластера>
    ```

    Чтобы получить список хостов-сегментов в кластере, выполните команду:

    ```bash
    {{ yc-mdb-gp }} hosts list segment \
       --cluster-name=<имя_кластера>
    ```

    Имя кластера можно запросить со [списком кластеров в каталоге](../cluster-list.md#list-clusters).

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../../api-ref/authentication.md) и поместите токен в переменную среды окружения:

       {% include [api-auth-token](../../../_includes/mdb/api-auth-token.md) %}

    1. Чтобы получить список хостов-мастеров в кластере:

        1. Воспользуйтесь методом [Cluster.ListMasterHosts](../../api-ref/Cluster/listMasterHosts.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

            ```bash
            curl \
                --request GET \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --url 'https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/<идентификатор_кластера>/master-hosts'
            ```

            Идентификатор кластера можно запросить со [списком кластеров в каталоге](../cluster-list.md#list-clusters).

        1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../api-ref/Cluster/listMasterHosts.md#yandex.cloud.mdb.greenplum.v1.ListClusterHostsResponse).

    1. Чтобы получить список хостов-сегментов в кластере:

        1. Воспользуйтесь методом [Cluster.ListSegmentHosts](../../api-ref/Cluster/listSegmentHosts.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

            ```bash
            curl \
                --request GET \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --url 'https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/<идентификатор_кластера>/segment-hosts'
            ```

            Идентификатор кластера можно запросить со [списком кластеров в каталоге](../cluster-list.md#list-clusters).

        1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../api-ref/Cluster/listSegmentHosts.md#yandex.cloud.mdb.greenplum.v1.ListClusterHostsResponse).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Чтобы получить список хостов-мастеров в кластере:

        1. Воспользуйтесь вызовом [ClusterService.ListMasterHosts](../../api-ref/grpc/Cluster/listMasterHosts.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

            ```bash
            grpcurl \
                -format json \
                -import-path ~/cloudapi/ \
                -import-path ~/cloudapi/third_party/googleapis/ \
                -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/cluster_service.proto \
                -rpc-header "Authorization: Bearer $IAM_TOKEN" \
                -d '{
                      "cluster_id": "<идентификатор_кластера>"
                    }' \
                {{ api-host-mdb }}:{{ port-https }} \
                yandex.cloud.mdb.greenplum.v1.ClusterService.ListMasterHosts
            ```

            Идентификатор кластера можно запросить со [списком кластеров в каталоге](../cluster-list.md#list-clusters).

        1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../api-ref/grpc/Cluster/listMasterHosts.md#yandex.cloud.mdb.greenplum.v1.ListClusterHostsResponse).

    1. Чтобы получить список хостов-сегментов в кластере:

        1. Воспользуйтесь вызовом [ClusterService.ListSegmentHosts](../../api-ref/grpc/Cluster/listSegmentHosts.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

            ```bash
            grpcurl \
                -format json \
                -import-path ~/cloudapi/ \
                -import-path ~/cloudapi/third_party/googleapis/ \
                -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/cluster_service.proto \
                -rpc-header "Authorization: Bearer $IAM_TOKEN" \
                -d '{
                      "cluster_id": "<идентификатор_кластера>"
                    }' \
                {{ api-host-mdb }}:{{ port-https }} \
                yandex.cloud.mdb.greenplum.v1.ClusterService.ListSegmentHosts
            ```

            Идентификатор кластера можно запросить со [списком кластеров в каталоге](../cluster-list.md#list-clusters).

        1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../api-ref/grpc/Cluster/listSegmentHosts.md#yandex.cloud.mdb.greenplum.v1.ListClusterHostsResponse).

{% endlist %}


{% include [greenplum-trademark](../../../_includes/mdb/mgp/trademark.md) %}
