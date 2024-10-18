---
title: Информация о кластерах в {{ mkf-name }}
description: Вы можете запросить детальную информацию о каждом созданном вами кластере {{ mkf-name }}. Чтобы получить список кластеров БД в каталоге, перейдите на страницу каталога и выберите сервис {{ mkf-name }}.
---

# Информация об имеющихся кластерах в {{ mkf-name }}

Вы можете запросить детальную информацию о каждом созданном вами кластере {{ mkf-name }}.

## Получить список кластеров в каталоге {#list-clusters}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.


- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы запросить список кластеров {{ KF }} в каталоге по умолчанию, выполните команду:

  ```
  {{ yc-mdb-kf }} cluster list
  ```

  Результат:

  ```
  +----------------------+----------+---------------------+--------+---------+
  |          ID          |   NAME   |     CREATED AT      | HEALTH | STATUS  |
  +----------------------+----------+---------------------+--------+---------+
  | c9qaruvk2mma******** | kafka750 | 2020-12-18 05:21:27 | ALIVE  | RUNNING |
  | ...                                                                      |
  +----------------------+----------+---------------------+--------+---------+
  ```

- API {#api}

  Чтобы получить список кластеров БД в каталоге, воспользуйтесь методом REST API [list](../api-ref/Cluster/list.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/List](../api-ref/grpc/Cluster/list.md) и передайте в запросе идентификатор требуемого каталога в параметре `folderId`.

  В ответе будут содержаться имена и идентификаторы кластеров.


{% endlist %}

## Получить детальную информацию о кластере {#get-cluster}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
  1. Нажмите на имя нужного кластера.


- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить информацию о кластере {{ KF }}, выполните команду:

  ```
  {{ yc-mdb-kf }} cluster get <имя_или_идентификатор_кластера>
  ```

  Идентификатор и имя кластера можно запросить со [списком кластеров в каталоге](#list-clusters).

- API {#api}

  Чтобы получить детальную информацию о кластере, воспользуйтесь методом REST API [get](../api-ref/Cluster/get.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Get](../api-ref/grpc/Cluster/get.md) и передайте в запросе идентификатор требуемого кластера.

  Чтобы узнать идентификатор кластера, [получите список кластеров в каталоге](#list-clusters).


{% endlist %}

## Посмотреть операции с кластерами {#list-operations}

Все действия с кластерами {{ mkf-name }} сохраняются в виде списка операций. Каждой операции присваивается уникальный идентификатор.

### Получить список операций {#get-operations}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы получить список операций для кластера:

  1. В [консоли управления]({{ link-console-main }}) откройте каталог, в котором находится кластер.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/cubes-3.svg) **{{ ui-key.yacloud.mdb.clusters.label_title }}**.
  1. Выберите нужный кластер.
  1. Перейдите на панель ![image](../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.common.operations-key-value }}** для выбранного кластера.

     В открывшемся списке отображаются операции с выбранным кластером.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить список операций для кластера {{ mkf-name }}, воспользуйтесь командой:

  ```bash
  yc managed-kafka cluster list-operations <имя_или_идентификатор_кластера>
  ```

  Результат:

  ```text
  +----------------------+---------------------+----------------------+---------------------+--------+-----------------------------+
  |          ID          |     CREATED AT      |      CREATED BY      |     MODIFIED AT     | STATUS |         DESCRIPTION         |
  +----------------------+---------------------+----------------------+---------------------+--------+-----------------------------+
  | dqh0ntf6batm******** | 2024-09-07 16:36:46 | aje9k8luj4qf******** | 2024-09-07 16:44:12 | DONE   | Create Apache Kafka cluster |
  +----------------------+---------------------+----------------------+---------------------+--------+-----------------------------+
  ```

  Идентификатор и имя кластера можно получить со [списком кластеров в каталоге](#list-clusters).

  По умолчанию информация об операциях выводится в текстовом формате. Чтобы получить более подробную информацию, укажите формат `yaml` или `json` для выводимых данных с помощью флага `--format`:

  ```bash
  yc managed-kafka cluster list-operations c9qk2926qqu9******** --format yaml
  ```

  Результат:

  ```text
  - id: dqh0ntf6batm********
    description: Create Apache Kafka cluster
    created_at: "2024-09-07T16:36:46.816682Z"
    created_by: aje9k8luj4qf********
    modified_at: "2024-09-07T16:44:12.944302Z"
    done: true
    metadata:
      '@type': type.googleapis.com/yandex.cloud.mdb.kafka.v1.CreateClusterMetadata
      cluster_id: c9q13q0acgv7********
    response:
      '@type': type.googleapis.com/google.rpc.Status
      message: OK
  ```

- API {#api}

  Воспользуйтесь методом REST API [listOperations](../api-ref/Cluster/listOperations.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/ListOperations](../api-ref/grpc/Cluster/listOperations.md) и передайте в запросе идентификатор кластера.

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
     id: dqh0ntf6batm********
     description: Create Apache Kafka cluster
     created_at: "2024-09-07T16:36:46.816682Z"
     created_by: aje9k8luj4qf********
     modified_at: "2024-09-07T16:44:12.944302Z"
     done: true
     metadata:
       '@type': type.googleapis.com/yandex.cloud.mdb.kafka.v1.CreateClusterMetadata
       cluster_id: c9q13q0acgv7********
     response:
       '@type': type.googleapis.com/yandex.cloud.mdb.kafka.v1.Cluster
     ...
     ```

   - API {#api}

     Воспользуйтесь методом REST API [get](../api-ref/Cluster/get.md) для ресурса [Operation](../api-ref/Operation/index.md) или вызовом gRPC API [OperationService/Get](../api-ref/grpc/Operation/get.md) и передайте в запросе идентификатор операции.

   {% endlist %}

### См. также {#see-also}

* [{#T}](../../api-design-guide/concepts/about-async.md)
