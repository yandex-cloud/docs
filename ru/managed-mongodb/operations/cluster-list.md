---
title: Информация о кластерах в {{ mmg-short-name }}
description: Вы можете запросить детальную информацию о каждом созданном вами кластере {{ mmg-short-name }}. Чтобы получить список кластеров БД в каталоге, перейдите на страницу каталога и выберите сервис {{ mmg-name }}.
---

# Информация об имеющихся кластерах {{ MG }}

Вы можете запросить детальную информацию о каждом созданном вами кластере {{ mmg-short-name }}.

## Получить список кластеров БД в каталоге {#list-clusters}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы запросить список кластеров {{ MG }} в каталоге по умолчанию, выполните команду:

  ```bash
  yc managed-mongodb cluster list
  ```

  Результат:

  ```text
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

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить информацию о кластере {{ MG }}, выполните команду:

  ```bash
  {{ yc-mdb-mg }} cluster get <имя_или_идентификатор_кластера>
  ```

  Идентификатор и имя кластера можно запросить со [списком кластеров в каталоге](#list-clusters).

- API {#api}

  Чтобы получить детальную информацию о кластере, воспользуйтесь методом REST API [get](../api-ref/Cluster/get.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Get](../api-ref/grpc/cluster_service.md#Get) и передайте в запросе идентификатор кластера.

Идентификатор кластера можно получить со [списком кластеров в каталоге](#list-clusters).

{% endlist %}

## Посмотреть операции с кластерами {#list-operations}

Все действия с кластерами {{ mmg-name }} сохраняются в виде списка операций. Каждой операции присваивается уникальный идентификатор.

### Получить список операций {#get-operations}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы посмотреть операции со всеми кластерами {{ mmg-name }}, на панели слева выберите ![image](../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.mongodb.switch_operations }}**. В открывшемся списке также отображаются операции для ресурсов, которые были удалены.

  Можно получить список операций для кластера:

  1. В [консоли управления]({{ link-console-main }}) откройте каталог, в котором находится кластер.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/cubes-3.svg) **{{ ui-key.yacloud.mongodb.switch_list }}**.
  1. Выберите нужный кластер.
  1. Перейдите на панель ![image](../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.mongodb.switch_operations }}** для выбранного кластера.

     В открывшемся списке отображаются операции с выбранным кластером.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить список операций для кластера {{ mmg-name }}, воспользуйтесь командой:

  ```bash
  yc managed-mongodb cluster list-operations <имя_или_идентификатор_кластера>
  ```

  Результат:

  ```text
  +----------------------+---------------------+----------------------+---------------------+--------+------------------------+
  |          ID          |     CREATED AT      |      CREATED BY      |     MODIFIED AT     | STATUS |      DESCRIPTION       |
  +----------------------+---------------------+----------------------+---------------------+--------+------------------------+
  | c9ql1rfrqk4u******** | 2024-09-07 16:37:10 | aje9k8luj4qf******** | 2024-09-07 16:44:28 | DONE   | Create MongoDB cluster |
  +----------------------+---------------------+----------------------+---------------------+--------+------------------------+
  ```

  Идентификатор и имя кластера можно получить со [списком кластеров в каталоге](#list-clusters).

  По умолчанию информация об операциях выводится в текстовом формате. Чтобы получить более подробную информацию, укажите формат `yaml` или `json` для выводимых данных с помощью флага `--format`:

  ```bash
  yc managed-mongodb cluster list-operations c9qk2926qqu9******** --format yaml
  ```

  Результат:

  ```text
  - id: c9ql1rfrqk4u********
    description: Create MongoDB cluster
    created_at: "2024-09-07T16:37:10.533508Z"
    created_by: aje9k8luj4qf********
    modified_at: "2024-09-07T16:44:28.147771Z"
    done: true
    metadata:
      '@type': type.googleapis.com/yandex.cloud.mdb.mongodb.v1.CreateClusterMetadata
      cluster_id: c9q8tmbam8co********
    response:
      '@type': type.googleapis.com/google.rpc.Status
      message: OK
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
     id: c9ql1rfrqk4u********
     description: Create MongoDB cluster
     created_at: "2024-09-07T16:37:10.533508Z"
     created_by: aje9k8luj4qf********
     modified_at: "2024-09-07T16:44:28.147771Z"
     done: true
     metadata:
       '@type': type.googleapis.com/yandex.cloud.mdb.mongodb.v1.CreateClusterMetadata
       cluster_id: c9q8tmbam8co********
     response:
       '@type': type.googleapis.com/yandex.cloud.mdb.mongodb.v1.Cluster
     ...
     ```

   - API {#api}

     Воспользуйтесь методом REST API [get](../api-ref/Cluster/get.md) для ресурса [Operation](../api-ref/Operation/index.md) или вызовом gRPC API [OperationService/Get](../api-ref/grpc/operation_service.md#Get) и передайте в запросе идентификатор операции.

   {% endlist %}

### См. также {#see-also}

* [{#T}](../../api-design-guide/concepts/about-async.md)
