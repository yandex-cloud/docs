---
title: "Информация о кластерах в {{ mrd-short-name }}"
description: "Вы можете запросить детальную информацию о каждом созданном вами кластере {{ mrd-short-name }}. Чтобы получить список кластеров БД в каталоге, перейдите на страницу каталога и выберите сервис {{ mrd-name }}."
---

# Информация об имеющихся кластерах {{ RD }}

Вы можете запросить детальную информацию о каждом созданном вами кластере {{ mrd-short-name }}.

## Получить список кластеров БД в каталоге {#list-clusters}

{% list tabs group=instructions %}

- Консоль управления {#console}
  
  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, список кластеров которого нужно получить.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
  
- CLI {#cli}
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  Чтобы запросить список кластеров {{ RD }} в каталоге по умолчанию, выполните команду:
  
  ```bash
  {{ yc-mdb-rd }} cluster list
  ```

  Результат:

  ```text
  +----------------------+---------------+-----------------------------+--------+---------+
  |          ID          |     NAME      |         CREATED AT          | HEALTH | STATUS  |
  +----------------------+---------------+-----------------------------+--------+---------+
  | c9qp9beeg4ot******** | myredis       | 2018-11-02T10:04:14.645214Z | ALIVE  | RUNNING |
  | ...                                                                                   |
  +----------------------+---------------+-----------------------------+--------+---------+
  ```

- API {#api}

  Чтобы получить список кластеров БД в каталоге, воспользуйтесь методом REST API [list](../api-ref/Cluster/list.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/List](../api-ref/grpc/cluster_service.md#List).

{% endlist %}

## Получить детальную информацию о кластере {#get-cluster}

{% list tabs group=instructions %}

- Консоль управления {#console}
  
  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, информацию о кластере которого нужно получить.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
  1. Нажмите на имя нужного кластера.
  
- CLI {#cli}
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  Чтобы получить информацию о кластере {{ RD }}, выполните команду:
  
  ```bash
  {{ yc-mdb-rd }} cluster get <имя_или_идентификатор_кластера>
  ```

  Идентификатор и имя кластера можно запросить со [списком кластеров в каталоге](#list-clusters).

- API {#api}

  Чтобы получить детальную информацию о кластере, воспользуйтесь методом REST API [get](../api-ref/Cluster/get.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Get](../api-ref/grpc/cluster_service.md#Get).

{% endlist %}

## Посмотреть операции с кластерами {#list-operations}

Все действия с кластерами {{ mrd-name }} сохраняются в виде списка операций. Каждой операции присваивается уникальный идентификатор.

### Получить список операций {#get-operations}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы посмотреть операции со всеми кластерами {{ mrd-name }}, на панели слева выберите ![image](../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.redis.switch_operations }}**. В открывшемся списке также отображаются операции для ресурсов, которые были удалены.

  Можно получить список операций для кластера:

  1. В [консоли управления]({{ link-console-main }}) откройте каталог, в котором находится кластер.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/cubes-3.svg) **{{ ui-key.yacloud.redis.switch_list }}**.
  1. Выберите нужный кластер.
  1. Перейдите на панель ![image](../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.redis.switch_operations }}** для выбранного кластера.

     В открывшемся списке отображаются операции с выбранным кластером.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить список операций для кластера {{ mrd-name }}, воспользуйтесь командой:

  ```bash
  yc managed-redis cluster list-operations <имя_или_идентификатор_кластера>
  ```

  Результат:

  ```text
  +----------------------+---------------------+----------------------+---------------------+--------+----------------------+
  |          ID          |     CREATED AT      |      CREATED BY      |     MODIFIED AT     | STATUS |     DESCRIPTION      |
  +----------------------+---------------------+----------------------+---------------------+--------+----------------------+
  | c5m7ll6pq3j8******** | 2024-08-08 19:05:42 | mdb-maintainer       | 2024-08-15 19:20:05 | DONE   | Modify Redis cluster |
  | c5mb0no66172******** | 2024-06-19 12:48:40 | mdb-maintainer       | 2024-06-26 12:50:14 | DONE   | Modify Redis cluster |
  | c5m6of9he7op******** | 2023-11-13 19:25:21 | ajeef73j5iq9******** | 2023-11-13 19:32:00 | DONE   | Create Redis cluster |
  +----------------------+---------------------+----------------------+---------------------+---- ---+----------------------+
  ```

  Идентификатор кластера можно получить со [списком кластеров в каталоге](#list-clusters).

  По умолчанию информация об операциях выводится в текстовом формате. Чтобы получить более подробную информацию, укажите формат `yaml` или `json` для выводимых данных с помощью флага `--format`:

  ```bash
  yc managed-redis cluster list-operations epdplu8jn7sr******** --format yaml
  ```

  Результат:

  ```text
  - id: c5m7ll6pq3j8********
    description: Modify Redis cluster
    created_at: "2024-08-08T19:05:42.362668Z"
    created_by: mdb-maintainer
    modified_at: "2024-08-15T19:20:05.917268Z"
    done: true
    metadata:
      '@type': type.googleapis.com/yandex.cloud.mdb.redis.v1.UpdateClusterMetadata
      cluster_id: c9q7vuuoiqml********
    response:
      '@type': type.googleapis.com/google.rpc.Status
      message: OK
  ...
  ```

- API {#api}

  Воспользуйтесь методом REST API [listOperations](../api-ref/Cluster/listOperations.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/ListOperations](../api-ref/grpc/cluster_service.md#ListOperations) и передайте в запросе идентификатор кластера.

  Идентификатор кластера можно получить со [списком кластеров в каталоге](#list-clusters).

{% endlist %}

### Получить подробную информацию об операции {#get-operations-info}

1. [Получите список операций](#get-operations) для кластера.
1. Скопируйте идентификатор нужной операции.
1. Получите подробную информацию об операции:

   {% list tabs group=instructions %}

   - CLI {#cli}

     {% include [cli-install](../../_includes/cli-install.md) %}

     {% include [default-catalogue](../../_includes/default-catalogue.md) %}

     Выполните команду:

     ```bash
     yc operation get <идентификатор_операции>
     ```

     Результат:

     ```text
     id: c5m6of9he7op********
     description: Create Redis cluster
     created_at: "2023-11-13T19:25:21.762164Z"
     created_by: ajeef73j5iq9********
     modified_at: "2023-11-13T19:32:00.464591Z"
     done: true
     metadata:
       '@type': type.googleapis.com/yandex.cloud.mdb.redis.v1.CreateClusterMetadata
       cluster_id: c9q7vuuoiqml********
     response:
       '@type': type.googleapis.com/yandex.cloud.mdb.redis.v1.Cluster
     ...
     ```

   - API {#api}

     Воспользуйтесь методом REST API [get](../api-ref/Cluster/get.md) для ресурса [Operation](../api-ref/Operation/index.md) или вызовом gRPC API [OperationService/Get](../api-ref/grpc/operation_service.md#Get) и передайте в запросе идентификатор операции.

   {% endlist %}

### См. также {#see-also}

* [{#T}](../../api-design-guide/concepts/about-async.md)
