# Остановка и запуск {{ RD }}-кластера

При необходимости вы можете остановить кластер БД и запустить его заново. Время простоя кластера не тарифицируется: вы продолжаете платить только за размер хранилища и резервных копий в соответствии с [тарифом](../pricing.md#prices-storage).

## Остановить кластер {#stop-cluster}

{% include [cluster-stop](../../_includes/mdb/cluster-stop.md) %}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог с кластером, который нужно остановить.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
  1. В строке с нужным кластером нажмите значок ![options](../../_assets/horizontal-ellipsis.svg) и выберите пункт **{{ ui-key.yacloud.mdb.cluster.overview.button_action-stop }}**.
  1. Подтвердите остановку кластера — нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.stop-dialog.popup-confirm_button }}**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы остановить кластер, выполните команду:

    ```bash
    {{ yc-mdb-rd }} cluster stop <идентификатор или имя кластера>
    ```

    Идентификатор и имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- API

    Чтобы остановить кластер, воспользуйтесь методом REST API [stop](../api-ref/Cluster/stop.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Stop](../api-ref/grpc/cluster_service.md#Stop) и передайте в запросе идентификатор кластера в параметре `clusterId`.

    Чтобы узнать идентификатор кластера, [получите список кластеров в каталоге](cluster-list.md#list-clusters).

{% endlist %}

## Запустить кластер {#start-cluster}

Кластер в статусе **STOPPED** можно запустить заново.

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог с кластером, который нужно запустить.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
  1. В строке с нужным кластером нажмите значок ![options](../../_assets/horizontal-ellipsis.svg) и выберите пункт **{{ ui-key.yacloud.mdb.cluster.overview.button_action-start }}**.
  1. Подтвердите запуск кластера — нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.start-dialog.popup-confirm_button }}** в открывшемся диалоге.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы запустить кластер, выполните команду:

    ```bash
    {{ yc-mdb-rd }} cluster start <идентификатор или имя кластера>
    ```

    Идентификатор и имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- API

    Чтобы запустить кластер, воспользуйтесь методом REST API [start](../api-ref/Cluster/start.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Start](../api-ref/grpc/cluster_service.md#Start) и передайте в запросе идентификатор кластера в параметре `clusterId`.

    Чтобы узнать идентификатор кластера, [получите список кластеров в каталоге](cluster-list.md#list-clusters).

{% endlist %}
