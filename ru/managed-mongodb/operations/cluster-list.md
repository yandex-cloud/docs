---
title: "Информация о кластерах в {{ mmg-short-name }}"
description: "Вы можете запросить детальную информацию о каждом созданном вами кластере {{ mmg-short-name }}. Чтобы получить список кластеров БД в каталоге, перейдите на страницу каталога и выберите сервис {{ mmg-name }}."
---

# Информация об имеющихся {{ MG }}-кластерах

Вы можете запросить детальную информацию о каждом созданном вами кластере {{ mmg-short-name }}.


## Получить список кластеров БД в каталоге {#list-clusters}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы запросить список {{ MG }}-кластеров в каталоге по умолчанию, выполните команду:

  ```
  yc managed-mongodb cluster list

  +----------------------+------------+-----------------------------+--------+---------+
  |          ID          |    NAME    |         CREATED AT          | HEALTH | STATUS  |
  +----------------------+------------+-----------------------------+--------+---------+
  | c9wlk4v14uq7******** | mymg       | 2018-11-02T10:04:14.645214Z | ALIVE  | RUNNING |
  | ...                                                                                |
  +----------------------+------------+-----------------------------+--------+---------+
  ```

- API {#api}

  Чтобы получить список кластеров БД в каталоге, воспользуйтесь методом REST API [list](../api-ref/Cluster/list.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/List](../api-ref/grpc/cluster_service.md#List) и передайте в запросе идентификатор каталога в параметре `folderId`.

{% endlist %}


## Получить детальную информацию о кластере {#get-cluster}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. Нажмите на имя нужного кластера.

  {% note tip %}

  
  Чтобы запросить доступ к технологии [Point-in-Time-Recovery](../concepts/backup.md) (PITR) в режиме [Preview](../../overview/concepts/launch-stages.md), нажмите на ссылку **Запросить доступ** в строке **{{ ui-key.yacloud.mdb.cluster.overview.label_mongodb-pitr }}** и заполните форму.


  {% endnote %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить информацию о {{ MG }}-кластере, выполните команду:

  ```
  {{ yc-mdb-mg }} cluster get <имя_или_идентификатор_кластера>
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

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. Нажмите на имя нужного кластера.
  1. На панели слева выберите ![image](../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.mongodb.cluster.switch_operations }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить список операций, выполните команду:

  ```
  {{ yc-mdb-mg }} cluster list-operations <имя_или_идентификатор_кластера>
  ```

  Идентификатор и имя кластера можно запросить со [списком кластеров в каталоге](#list-clusters).

- API {#api}

  Чтобы получить список операций, воспользуйтесь методом REST API [listOperations](../api-ref/Cluster/listOperations.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/ListOperations](../api-ref/grpc/cluster_service.md#ListOperations) и передайте в запросе идентификатор кластера в параметре `clusterId`.

Идентификатор кластера можно получить со [списком кластеров в каталоге](#list-clusters).

{% endlist %}
