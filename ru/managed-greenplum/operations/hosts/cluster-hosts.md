# Управление хостами {{ GP }}-кластера

Вы можете получить список хостов (мастеров и сегментов) в кластере {{ mgp-name }}.


## Получить список хостов в кластере {#list-hosts}

{% list tabs %}

- Консоль управления

    1. Перейдите [на страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Нажмите на имя нужного кластера, затем выберите вкладку ![hosts.svg](../../../_assets/mdb/hosts.svg) **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.

    В списке хостов в колонке **{{ ui-key.yacloud.mdb.cluster.hosts.host_column_role }}** указывается роль каждого хоста:

    * `MASTER` — первичный хост-мастер (PRIMARY). Принимает пользовательские подключения.
    * `REPLICA` — резервный хост-мастер (STANDBY). Реплицирует данные первичного хоста-мастера.
    * `SEGMENT` — хост-сегмент. Хранит часть данных кластера.

- CLI

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

- API

    Чтобы получить список хостов в кластере, воспользуйтесь методами REST API [listMasterHosts](../../api-ref/Cluster/listMasterHosts.md) и [listSegmentHosts](../../api-ref/Cluster/listSegmentHosts.md) для ресурса [Cluster](../../api-ref/Cluster/index.md) или вызовами gRPC API [ClusterService/ListMasterHosts](../../api-ref/grpc/cluster_service.md#ListMasterHosts) и [ClusterService/ListSegmentHosts](../../api-ref/grpc/cluster_service.md#ListSegmentHosts) и передайте в запросе идентификатор кластера в параметре `clusterId`.

    Идентификатор кластера можно получить со [списком кластеров в каталоге](../cluster-list.md#list-clusters).

{% endlist %}


{% include [greenplum-trademark](../../../_includes/mdb/mgp/trademark.md) %}
