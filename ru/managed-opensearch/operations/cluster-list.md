---
title: "Информация об имеющихся кластерах {{ OS }}"
description: "Вы можете запросить детальную информацию о каждом созданном вами кластере {{ OS }}."
keywords:
  - информация о хостах OpenSearch
  - хосты OpenSearch
  - OpenSearch
---

# Информация об имеющихся кластерах {{ OS }}

Вы можете запросить детальную информацию о каждом созданном вами кластере {{ mos-name }}.

## Получить список кластеров в каталоге {#list-clusters}

{% list tabs group=instructions %}

- Консоль управления {#console}

  В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы запросить список {{ OS }}-кластеров в каталоге, заданном по умолчанию, выполните команду:

  ```bash
  {{ yc-mdb-os }} cluster list
  ```

  ```text
  +----------------------+------+-----------------------------+--------+---------+
  |          ID          | NAME |         CREATED AT          | HEALTH | STATUS  |
  +----------------------+------+-----------------------------+--------+---------+
  | c9wlk4v14uq7******** | myos | 2023-12-19T10:04:14.645214Z | ALIVE  | RUNNING |
  | ...                                                                          |
  +----------------------+------+-----------------------------+--------+---------+
  ```

- API {#api}

  Чтобы получить список кластеров в каталоге, воспользуйтесь методом REST API [list](../api-ref/Cluster/list.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/List](../api-ref/grpc/cluster_service.md#List) и передайте в запросе идентификатор требуемого каталога в параметре `folderId`.

  В ответе будут содержаться имена и идентификаторы кластеров.

{% endlist %}

## Получить детальную информацию о кластере {#get-cluster}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
  1. Нажмите на имя нужного кластера.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить информацию об {{ OS }}-кластере, выполните команду:

  ```bash
  {{ yc-mdb-os }} cluster get <имя_или_идентификатор_кластера>
  ```

  Имя и идентификатор кластера можно запросить со [списком кластеров в каталоге](#list-clusters).

- API {#api}

  Чтобы получить детальную информацию о кластере, воспользуйтесь методом REST API [get](../api-ref/Cluster/get.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Get](../api-ref/grpc/cluster_service.md#Get) и передайте в запросе идентификатор требуемого кластера в параметре `clusterId`.

  {% include [get-cluster-id](../../_includes/managed-opensearch/get-cluster-id.md) %}

{% endlist %}

## Посмотреть список операций в кластере {#list-operations}

В списке операций отображаются операции с кластерами и связанными ресурсами (хостами, шардами и т. д.).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку ![operations.svg](../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.common.operations-key-value }}**.

- API {#api}

  Чтобы посмотреть список операций в кластере, воспользуйтесь методом REST API [listOperations](../api-ref/Cluster/listOperations.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/ListOperations](../api-ref/grpc/cluster_service.md#ListOperations) и передайте в запросе идентификатор требуемого кластера в параметре `clusterId`.

  {% include [get-cluster-id](../../_includes/managed-opensearch/get-cluster-id.md) %}

{% endlist %}
