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

{% list tabs %}

- Консоль управления

  В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.

- API

  Чтобы получить список кластеров в каталоге, воспользуйтесь методом REST API [list](../api-ref/Cluster/list.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/List](../api-ref/grpc/cluster_service.md#List) и передайте в запросе идентификатор требуемого каталога в параметре `folderId`.

  В ответе будут содержаться имена и идентификаторы кластеров.

{% endlist %}

## Получить детальную информацию о кластере {#get-cluster}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
  1. Нажмите на имя нужного кластера.

- API

  Чтобы получить детальную информацию о кластере, воспользуйтесь методом REST API [get](../api-ref/Cluster/get.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Get](../api-ref/grpc/cluster_service.md#Get) и передайте в запросе идентификатор требуемого кластера в параметре `clusterId`.

  {% include [get-cluster-id](../../_includes/managed-opensearch/get-cluster-id.md) %}

{% endlist %}

## Посмотреть список операций в кластере {#list-operations}

В списке операций отображаются операции с кластерами и связанными ресурсами (хостами, шардами и т. д.).

{% list tabs %}

- Консоль управления

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку ![operations.svg](../../_assets/mdb/operations.svg) **{{ ui-key.yacloud.common.operations-key-value }}**.

- API

  Чтобы посмотреть список операций в кластере, воспользуйтесь методом REST API [listOperations](../api-ref/Cluster/listOperations.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/ListOperations](../api-ref/grpc/cluster_service.md#ListOperations) и передайте в запросе идентификатор требуемого кластера в параметре `clusterId`.

  {% include [get-cluster-id](../../_includes/managed-opensearch/get-cluster-id.md) %}

{% endlist %}
