---
title: Остановка и запуск кластера {{ OS }}
description: При необходимости вы можете остановить кластер {{ OS }} и запустить его заново. При остановке кластера все данные в нем сохранятся. Они снова станут доступны, когда вы запустите кластер.
keywords:
  - остановка OpenSearch
  - запуск OpenSearch
  - OpenSearch
---

# Остановка и запуск кластера {{ OS }}

При необходимости вы можете остановить кластер {{ OS }} и запустить его заново. При остановке кластера все данные в нем сохранятся: они снова станут доступны, когда вы запустите кластер.


Время работы остановленного кластера не тарифицируется: вы продолжаете платить только за объем хранилища в соответствии с [тарифом](../pricing.md).

{% include [pricing-status-warning.md](../../_includes/mdb/pricing-status-warning.md) %}


## Остановить кластер {#stop}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
    1. Найдите нужный кластер в списке, нажмите на значок ![options](../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud.mdb.clusters.button_action-stop }}**.
    1. В открывшемся диалоге подтвердите остановку кластера и нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.stop-dialog.popup-confirm_button }}**.

- API {#api}

    Чтобы остановить кластер, воспользуйтесь методом REST API [stop](../api-ref/Cluster/stop.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Stop](../api-ref/grpc/cluster_service.md#Stop) и передайте в запросе идентификатор нужного кластера в параметре `clusterId`.

    {% include [get-cluster-id](../../_includes/managed-opensearch/get-cluster-id.md) %}

{% endlist %}

## Запустить кластер {#start}

Кластер в статусе **Stopped** можно запустить заново.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
    1. Найдите нужный остановленный кластер в списке, нажмите на значок ![options](../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud.mdb.clusters.button_action-start }}**.
    1. В открывшемся диалоге подтвердите запуск кластера нажатием на кнопку **{{ ui-key.yacloud.mdb.cluster.start-dialog.popup-confirm_button }}**.

- API {#api}

    Чтобы запустить кластер, воспользуйтесь методом REST API [start](../api-ref/Cluster/start.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Start](../api-ref/grpc/cluster_service.md#Start) и передайте в запросе идентификатор нужного кластера в параметре `clusterId`.

    {% include [get-cluster-id](../../_includes/managed-opensearch/get-cluster-id.md) %}

{% endlist %}
