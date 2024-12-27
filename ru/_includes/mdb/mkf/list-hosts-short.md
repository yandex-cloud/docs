{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
   1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
   1. Нажмите на имя нужного кластера, затем выберите вкладку **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.

- CLI {#cli}

   ```bash
   {{ yc-mdb-kf }} cluster list-hosts <имя_или_идентификатор_кластера>
   ```

   FQDN указан в выводе команды, в столбце `NAME`.

- REST API {#api}

    1. Воспользуйтесь методом [Cluster.listHosts](../../../managed-kafka/api-ref/Cluster/listHosts.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<идентификатор_кластера>/hosts'
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](../../../managed-kafka/operations/cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../../managed-kafka/api-ref/Cluster/listHosts.md#yandex.cloud.mdb.kafka.v1.ListClusterHostsResponse). FQDN указан в ответе в поле `hosts[].name`.

- gRPC API {#grpc-api}

    1. Воспользуйтесь вызовом [ClusterService/ListHosts](../../../managed-kafka/api-ref/grpc/Cluster/listHosts.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

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
            yandex.cloud.mdb.kafka.v1.ClusterService.ListHosts
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](../../../managed-kafka/operations/cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../../managed-kafka/api-ref/grpc/Cluster/listHosts.md#yandex.cloud.mdb.kafka.v1.ListClusterHostsResponse). FQDN указан в ответе в поле `hosts[].name`.

{% endlist %}