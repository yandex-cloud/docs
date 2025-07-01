---
title: Информация об имеющихся кластерах Elasticsearch
description: Вы можете запросить детальную информацию о каждом созданном вами кластере {{ mes-name }}.
keywords:
  - информация о хостах Elasticsearch
  - хосты Elasticsearch
  - Elasticsearch
---

# Информация об имеющихся кластерах {{ ES }}

{% include [Elasticsearch-end-of-service](../../_includes/mdb/mes/note-end-of-service.md) %}

Вы можете запросить детальную информацию о каждом созданном вами кластере {{ mes-name }}.

## Получить список кластеров в каталоге {#list-clusters}

{% list tabs group=instructions %}

- Консоль управления {#console}

  В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **Managed Service for&nbsp;Elasticsearch**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы получить список кластеров, выполните команду:

    ```bash
    {{ yc-mdb-es }} cluster list
    ```

- API {#api}

  Чтобы получить список кластеров в каталоге, воспользуйтесь методом REST API [list](../api-ref/Cluster/list.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/List](../api-ref/grpc/Cluster/list.md) и передайте в запросе идентификатор каталога в параметре `folderId`.

{% endlist %}

## Получить детальную информацию о кластере {#get-cluster}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **Managed Service for&nbsp;Elasticsearch**.
  1. Нажмите на имя нужного кластера.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы получить детальную информацию о кластере, выполните команду:

    ```bash
    {{ yc-mdb-es }} cluster get <имя_или_идентификатор_кластера>
    ```

    Имя и идентификатор кластера можно запросить со [списком кластеров в каталоге](#list-clusters).

- API {#api}

  Чтобы получить детальную информацию о кластере, воспользуйтесь методом REST API [get](../api-ref/Cluster/get.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Get](../api-ref/grpc/Cluster/get.md) и передайте в запросе идентификатор кластера в параметре `clusterId`.

  {% include [get-cluster-id](../../_includes/managed-elasticsearch/get-cluster-id.md) %}

{% endlist %}

## Посмотреть список операций в кластере {#list-operations}

В списке операций отображаются операции с кластерами и связанными ресурсами (хостами, шардами и т. д.).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **Managed Service for&nbsp;Elasticsearch**.
  1. Нажмите на имя нужного кластера.
  1. Перейдите на вкладку **{{ ui-key.yacloud.common.operations-key-value }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы получить список операций в кластере, выполните команду:

    ```bash
    {{ yc-mdb-es }} cluster list-operations <имя_или_идентификатор_кластера>
    ```

    Имя и идентификатор кластера можно запросить со [списком кластеров в каталоге](#list-clusters).

- API {#api}

  Чтобы получить список операций, воспользуйтесь методом REST API [listOperations](../api-ref/Cluster/listOperations.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/ListOperations](../api-ref/grpc/Cluster/listOperations.md) и передайте в запросе идентификатор кластера в параметре `clusterId`.

  {% include [get-cluster-id](../../_includes/managed-elasticsearch/get-cluster-id.md) %}

{% endlist %}
