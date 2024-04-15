---
title: "Остановка и запуск кластера Elasticsearch"
description: "При необходимости вы можете остановить кластер Elasticsearch и запустить его заново. При остановке кластера все данные в нем сохранятся. Они снова станут доступны, когда вы запустите кластер."
keywords:
  - остановка Elasticsearch
  - запуск Elasticsearch
  - Elasticsearch
---

# Остановка и запуск кластера {{ ES }}

{% include [Elasticsearch-end-of-service](../../_includes/mdb/mes/note-end-of-service.md) %}

При необходимости вы можете остановить кластер {{ ES }} и запустить его заново. При остановке кластера все данные в нем сохранятся: они снова станут доступны, когда вы запустите кластер.

Время работы остановленного кластера не тарифицируется: вы продолжаете платить только за объем хранилища в соответствии с [тарифом](../pricing.md#prices-storage).

{% include [pricing-status-warning.md](../../_includes/mdb/pricing-status-warning.md) %}

## Остановить кластер {#stop-cluster}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-elasticsearch }}**.
  1. Найдите нужный кластер в списке, нажмите значок ![options](../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud.mdb.cluster.overview.button_action-stop }}**.
  1. В открывшемся диалоге подтвердите остановку кластера и нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.stop-dialog.popup-confirm_button }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы остановить работу кластера, выполните команду:

    ```bash
    {{ yc-mdb-es }} cluster stop <имя_или_идентификатор_кластера>
    ```

    Имя и идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- API {#api}

  Чтобы остановить кластер, воспользуйтесь методом REST API [stop](../api-ref/Cluster/stop.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Stop](../api-ref/grpc/cluster_service.md#Stop) и передайте в запросе идентификатор кластера в параметре `clusterId`.

  {% include [get-cluster-id](../../_includes/managed-elasticsearch/get-cluster-id.md) %}

{% endlist %}

## Запустить кластер {#start-cluster}

Кластер в статусе **Stopped** можно запустить заново.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-elasticsearch }}**.
  1. Найдите нужный остановленный кластер в списке, нажмите значок ![options](../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud.mdb.cluster.overview.button_action-start }}**.
  1. В открывшемся диалоге подтвердите запуск кластера нажатием на кнопку **{{ ui-key.yacloud.mdb.cluster.start-dialog.popup-confirm_button }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Для запуска остановленного кластера выполните команду:

    ```bash
    {{ yc-mdb-es }} cluster start <имя_или_идентификатор_кластера>
    ```

    Имя и идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- API {#api}

  Чтобы запустить кластер, воспользуйтесь методом REST API [start](../api-ref/Cluster/start.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Start](../api-ref/grpc/cluster_service.md#Start) и передайте в запросе идентификатор кластера в параметре `clusterId`.

  {% include [get-cluster-id](../../_includes/managed-elasticsearch/get-cluster-id.md) %}

{% endlist %}
