# Остановка и запуск {{ MG }}-кластера

При необходимости вы можете остановить кластер БД и запустить его заново. Время простоя кластера не тарифицируется: вы продолжаете платить только за размер хранилища и резервных копий в соответствии с [тарифом](../pricing.md#prices-storage).

{% include [pricing-status-warning.md](../../_includes/mdb/pricing-status-warning.md) %}


## Остановить кластер {#stop-cluster}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. Выберите нужный кластер в списке, нажмите значок ![options](../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud.mdb.clusters.button_action-stop }}**.
  1. Подтвердите остановку кластера и нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.stop-dialog.popup-confirm_button }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы остановить работу кластера, выполните команду:

    ```bash
    {{ yc-mdb-mg }} cluster stop <имя_или_идентификатор_кластера>
    ```

    Идентификатор или имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- API {#api}

    Чтобы остановить кластер, воспользуйтесь методом REST API [stop](../api-ref/Cluster/stop.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Stop](../api-ref/grpc/cluster_service.md#Stop) и передайте в запросе идентификатор требуемого кластера в параметре `clusterId`.

    Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

{% endlist %}

## Запустить кластер {#start-cluster}

Кластер в статусе **STOPPED** можно запустить заново.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. Выберите остановленный кластер в списке, нажмите значок ![options](../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud.mdb.clusters.button_action-start }}**.
  1. Подтвердите запуск кластера — нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.start-dialog.popup-confirm_button }}** в открывшемся диалоге.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Для запуска остановленного кластера выполните команду:

    ```bash
    {{ yc-mdb-mg }} cluster start <имя_или_идентификатор_кластера>
    ```

    Идентификатор и имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- API {#api}

    Чтобы запустить кластер, воспользуйтесь методом REST API [start](../api-ref/Cluster/start.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Start](../api-ref/grpc/cluster_service.md#Start) и передайте в запросе идентификатор требуемого кластера в параметре `clusterId`.

    Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

{% endlist %}
