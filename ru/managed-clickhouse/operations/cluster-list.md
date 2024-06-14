---
title: "Информация о кластерах в {{ mch-short-name }}"
description: "Вы можете запросить детальную информацию о каждом созданном вами кластере {{ mch-short-name }}. Чтобы получить список кластеров БД в каталоге, перейдите на страницу каталога и выберите сервис {{ mch-name }}."
---

# Информация об имеющихся кластерах {{ CH }}

Вы можете запросить детальную информацию о каждом созданном вами кластере {{ mch-short-name }}.


## Получить список кластеров БД в каталоге {#list-clusters}

{% list tabs group=instructions %}

- Консоль управления {#console}

  В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы запросить список кластеров {{ CH }} в каталоге по умолчанию, выполните команду:

  ```
  {{ yc-mdb-ch }} cluster list

  +----------------------+------+-------------+---------+---------------------+--------+---------+
  |          ID          | NAME | ENVIRONMENT | VERSION |     CREATED AT      | HEALTH | STATUS  |
  +----------------------+------+-------------+---------+---------------------+--------+---------+
  | c9qf1kmm0ebi******** | mych | PRODUCTION  |    23.8 | 2024-06-06 10:23:22 | ALIVE  | RUNNING |
  | ...                                                                                          |
  +----------------------+------+-------------+---------+---------------------+--------+---------+
  ```

- API {#api}

    Чтобы получить список кластеров БД в каталоге, воспользуйтесь методом REST API [list](../api-ref/Cluster/list.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/List](../api-ref/grpc/cluster_service.md#List) и передайте в запросе идентификатор каталога в параметре `folderId`.

{% endlist %}


## Получить детальную информацию о кластере {#get-cluster}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Нажмите на имя нужного кластера.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить информацию о кластере {{ CH }}, выполните команду:

  ```
  {{ yc-mdb-ch }} cluster get <имя_или_идентификатор_кластера>
  ```

  Идентификатор и имя кластера можно запросить со [списком кластеров в каталоге](#list-clusters).

- API {#api}

    Чтобы получить детальную информацию о кластере, воспользуйтесь методом REST API [get](../api-ref/Cluster/get.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Get](../api-ref/grpc/cluster_service.md#Get) и передайте в запросе идентификатор кластера в параметре `clusterId`.

    Идентификатор кластера можно получить со [списком кластеров в каталоге](#list-clusters).

{% endlist %}

## Посмотреть список операций в кластере {#list-operations}

{% include [list-operations-about](../../_includes/mdb/list-operations-about.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Нажмите на имя нужного кластера.
  1. Перейдите на вкладку **{{ ui-key.yacloud.clickhouse.cluster.switch_operations }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить список операций, выполните команду:

  ```
  {{ yc-mdb-ch }} cluster list-operations <имя_или_идентификатор_кластера>
  ```

  Идентификатор и имя кластера можно запросить со [списком кластеров в каталоге](#list-clusters).

- API {#api}

  Чтобы получить список операций, воспользуйтесь методом REST API [listOperations](../api-ref/Cluster/listOperations.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/ListOperations](../api-ref/grpc/cluster_service.md#ListOperations) и передайте в запросе идентификатор кластера в параметре `clusterId`.

  Идентификатор кластера можно получить со [списком кластеров в каталоге](#list-clusters).

{% endlist %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
