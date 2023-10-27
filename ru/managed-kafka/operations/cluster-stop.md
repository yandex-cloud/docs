# Остановка и запуск кластера {{ KF }}

При необходимости вы можете остановить кластер {{ KF }} и запустить его заново. При остановке кластера все данные в нем сохранятся: они снова станут доступны, когда вы запустите кластер.

## Остановить кластер {#stop-cluster}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
  1. Найдите нужный кластер в списке, нажмите значок ![options](../../_assets/horizontal-ellipsis.svg) и выберите пункт **{{ ui-key.yacloud.mdb.cluster.overview.button_action-stop }}**.
  1. В открывшемся диалоге подтвердите остановку кластера и нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.stop-dialog.popup-confirm_button }}**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы остановить кластер, выполните команду:

  ```
  {{ yc-mdb-kf }} cluster stop <имя_или_идентификатор_кластера>
  ```


- API

  Чтобы остановить кластер, воспользуйтесь методом REST API [stop](../api-ref/Cluster/stop.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Stop](../api-ref/grpc/cluster_service.md#Stop) и передайте в запросе идентификатор требуемого кластера в параметре `clusterId`.

  Чтобы узнать идентификатор кластера, [получите список кластеров в каталоге](cluster-list.md#list-clusters).


{% endlist %}

## Запустить кластер {#start-cluster}

Кластер в статусе `Stopped` можно запустить заново.

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
  1. Найдите нужный остановленный кластер в списке, нажмите значок ![options](../../_assets/horizontal-ellipsis.svg) и выберите пункт **{{ ui-key.yacloud.mdb.cluster.overview.button_action-start }}**.
  1. В открывшемся диалоге нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.start-dialog.popup-confirm_button }}**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы запустить кластер, выполните команду:

  ```
  {{ yc-mdb-kf }} cluster start <имя_или_идентификатор_кластера>
  ```


- API

  Чтобы запустить кластер, воспользуйтесь методом REST API [start](../api-ref/Cluster/start.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Start](../api-ref/grpc/cluster_service.md#Start) и передайте в запросе идентификатор требуемого кластера в параметре `clusterId`.

  Чтобы узнать идентификатор кластера, [получите список кластеров в каталоге](cluster-list.md#list-clusters).


{% endlist %}
