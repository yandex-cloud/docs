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

- API {#api}

   Воспользуйтесь методом REST API [listHosts](../../../managed-kafka/api-ref/Cluster/listHosts.md) для ресурса [Cluster](../../../managed-kafka/api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/ListHosts](../../../managed-kafka/api-ref/grpc/Cluster/listHosts.md) и передайте в запросе идентификатор требуемого кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](../../../managed-kafka/operations/cluster-list.md#list-clusters).

   FQDN указан в ответе в поле `hosts[].name`.

{% endlist %}