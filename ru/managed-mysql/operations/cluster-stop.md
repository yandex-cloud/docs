---
title: "Остановка и запуск {{ MY }}-кластера в {{ mmy-name }}"
description: "При необходимости вы можете остановить {{ MY }}-кластер БД и запустить его заново. Время простоя кластера не тарифицируется: вы продолжаете платить только за размер хранилища и резервных копий."
---

# Остановка и запуск {{ MY }}-кластера

При необходимости вы можете остановить {{ MY }}-кластер БД и запустить его заново. Время простоя кластера не тарифицируется: вы продолжаете платить только за размер хранилища и резервных копий в соответствии с [тарифом](../pricing.md#prices-storage).

{% include [pricing-status-warning.md](../../_includes/mdb/pricing-status-warning.md) %}


## Остановить кластер {#stop-cluster}

{% include [cluster-stop](../../_includes/mdb/cluster-stop.md) %}

{% list tabs %}

- Консоль управления

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Выберите нужный кластер в списке, нажмите значок ![options](../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud.mdb.clusters.button_action-stop }}**.
  1. Подтвердите остановку кластера и нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.stop-dialog.popup-confirm_button }}**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    1. Посмотрите описание команды CLI для остановки кластера:

        ```bash
        {{ yc-mdb-my }} cluster stop --help
        ```

    1. Чтобы узнать идентификатор и имя кластера, запросите список кластеров в каталоге:

        ```bash
        {{ yc-mdb-my }} cluster list
        ```

    1. Чтобы остановить кластер, выполните команду:

        ```bash
        {{ yc-mdb-my }} cluster stop <имя_или_идентификатор_кластера>
        ```

- API

  Чтобы остановить кластер, воспользуйтесь методом REST API [stop](../api-ref/Cluster/stop.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Stop](../api-ref/grpc/cluster_service.md#Stop) и передайте в запросе идентификатор кластера в параметре `clusterId`.

  {% include [Получение идентификатора кластера](../../_includes/mdb/mmy/note-api-get-cluster-id.md) %}

{% endlist %}

## Запустить кластер {#start-cluster}

Кластер в статусе **STOPPED** можно запустить заново.

{% list tabs %}

- Консоль управления

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Выберите остановленный кластер в списке, нажмите значок ![options](../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud.mdb.clusters.button_action-start }}**.
  1. Подтвердите запуск кластера — нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.start-dialog.popup-confirm_button }}** в открывшемся диалоге.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    1. Посмотрите описание команды CLI для запуска кластера:

        ```bash
        {{ yc-mdb-my }} cluster start --help
        ```

    1. Чтобы узнать идентификатор и имя кластера, запросите список кластеров в каталоге:

        ```bash
        {{ yc-mdb-my }} cluster list
        ```

    1. Чтобы запустить кластер, выполните команду:

        ```bash
        {{ yc-mdb-my }} cluster start <имя_или_идентификатор_кластера>
        ```

- API

  Чтобы запустить кластер, воспользуйтесь методом REST API [start](../api-ref/Cluster/start.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Start](../api-ref/grpc/cluster_service.md#Start) и передайте в запросе идентификатор кластера в параметре `clusterId`.

  Чтобы узнать идентификатор кластера, [получите список кластеров в каталоге](cluster-list.md#list-clusters).

{% endlist %}
