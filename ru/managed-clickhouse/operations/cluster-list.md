---
title: "Информация о кластерах в {{ mch-short-name }}"
description: "Вы можете запросить детальную информацию о каждом созданном вами кластере {{ mch-short-name }}. Чтобы получить список кластеров БД в каталоге, перейдите на страницу каталога и выберите сервис {{ mch-name }}."
---

# Информация об имеющихся кластерах {{ CH }}

Вы можете запросить детальную информацию о каждом созданном вами кластере {{ mch-short-name }}.


## Получить список кластеров БД в каталоге {#list-clusters}

{% list tabs %}

- Консоль управления

  В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ mch-name }}**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы запросить список кластеров {{ CH }} в каталоге по умолчанию, выполните команду:

  ```
  {{ yc-mdb-ch }} cluster list

  +----------------------+---------------+-----------------------------+--------+---------+
  |          ID          |     NAME      |         CREATED AT          | HEALTH | STATUS  |
  +----------------------+---------------+-----------------------------+--------+---------+
  | c9wlk4v14uq79r9cgcku |     mych      | 2018-11-02T10:04:14.645214Z | ALIVE  | RUNNING |
  | ...                                                                                   |
  +----------------------+---------------+-----------------------------+--------+---------+
  ```

- API

    Чтобы получить список кластеров БД в каталоге, воспользуйтесь методом REST API [list](../api-ref/Cluster/list.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/List](../api-ref/grpc/cluster_service.md#List) и передайте в запросе идентификатор каталога в параметре `folderId`.

{% endlist %}


## Получить детальную информацию о кластере {#get-cluster}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ mch-name }}**.
  1. Нажмите на имя нужного кластера.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить информацию о кластере {{ CH }}, выполните команду:

  ```
  {{ yc-mdb-ch }} cluster get <имя или идентификатор кластера>
  ```

  Идентификатор и имя кластера можно запросить со [списком кластеров в каталоге](#list-clusters).

- API

    Чтобы получить детальную информацию о кластере, воспользуйтесь методом REST API [get](../api-ref/Cluster/get.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Get](../api-ref/grpc/cluster_service.md#Get) и передайте в запросе идентификатор кластера в параметре `clusterId`.

    Идентификатор кластера можно получить со [списком кластеров в каталоге](#list-clusters).

{% endlist %}

## Посмотреть список операций в кластере {#list-operations}

{% include [list-operations-about](../../_includes/mdb/list-operations-about.md) %}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ mch-name }}**.
  1. Нажмите на имя нужного кластера.
  1. Перейдите на вкладку **Операции**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить список операций, выполните команду:

  ```
  {{ yc-mdb-ch }} cluster list-operations <имя или идентификатор кластера>
  ```

  Идентификатор и имя кластера можно запросить со [списком кластеров в каталоге](#list-clusters).

- API

  Чтобы получить список операций, воспользуйтесь методом REST API [listOperations](../api-ref/Cluster/listOperations.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/ListOperations](../api-ref/grpc/cluster_service.md#ListOperations) и передайте в запросе идентификатор кластера в параметре `clusterId`.

  Идентификатор кластера можно получить со [списком кластеров в каталоге](#list-clusters).

{% endlist %}
