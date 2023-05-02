---
title: "Остановка и запуск кластера {{ CH }}"
description: "При необходимости вы можете остановить кластер БД {{ CH }} и запустить его заново. Время простоя кластера не тарифицируется: вы продолжаете платить только за размер хранилища и резервных копий."
---

# Остановка и запуск кластера {{ CH }}

При необходимости вы можете остановить кластер БД {{ CH }} и запустить его заново. Время простоя кластера не тарифицируется: вы продолжаете платить только за размер хранилища и резервных копий в соответствии с [тарифом](../pricing.md#prices-storage).

{% include [pricing-status-warning.md](../../_includes/mdb/pricing-status-warning.md) %}


## Остановить кластер {#stop-cluster}

{% include [cluster-stop](../../_includes/mdb/cluster-stop.md) %}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ mch-name }}**.
  1. Выберите нужный кластер в списке, нажмите на значок ![options](../../_assets/horizontal-ellipsis.svg) и выберите пункт **Остановить**.
  1. Подтвердите остановку кластера и нажмите кнопку **Остановить**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы остановить кластер, выполните команду:

    ```bash
    {{ yc-mdb-ch }} cluster stop <идентификатор или имя кластера>
    ```

    Идентификатор и имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- API

  Чтобы остановить кластер, воспользуйтесь методом REST API [stop](../api-ref/Cluster/stop.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Stop](../api-ref/grpc/cluster_service.md#Stop) и передайте в запросе идентификатор кластера в параметре `clusterId`. 
  
  Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).

{% endlist %}


## Запустить кластер {#start-cluster}

Кластер в статусе **STOPPED** можно запустить заново.

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ mch-name }}**.
  1. Выберите остановленный кластер в списке, нажмите на значок ![options](../../_assets/horizontal-ellipsis.svg) и выберите пункт **Запустить**.
  1. Подтвердите запуск кластера — нажмите кнопку **Запустить** в открывшемся диалоге.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы запустить кластер, выполните команду:

    ```bash
    {{ yc-mdb-ch }} cluster start <идентификатор или имя кластера>
    ```

    Идентификатор и имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- API

    Чтобы запустить кластер, воспользуйтесь методом REST API [start](../api-ref/Cluster/start.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Start](../api-ref/grpc/cluster_service.md#Start) и передайте в запросе идентификатор кластера в параметре `clusterId`. 
    
    Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).

{% endlist %}
