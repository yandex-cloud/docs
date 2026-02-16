# Посмотреть операции с кластером {{ managed-k8s-name }}

Все действия с ресурсами сервиса {{ managed-k8s-name }} сохраняются в виде списка операций. Каждой операции присваивается уникальный [идентификатор](../../../api-design-guide/concepts/about-async.md).

Операции предназначены для оперативного контроля действий с кластером. Это может быть важно для автоматизации создания инфраструктуры, когда от состояния операции зависят дальнейшие действия. Например, перед созданием группы узлов необходимо отслеживать состояние операции создания кластера.

 Срок хранения записей об операциях в сервисе ограничен. Чтобы вести мониторинг состояния кластера и логировать действия с ним, используйте сервисы [{{ monitoring-full-name }}](../../metrics.md), [{{ cloud-logging-full-name }}](../../tutorials/k8s-fluent-bit-logging.md) и [{{ at-full-name }}](../../at-ref.md).

## Получить список операций {#get-operations}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы посмотреть операции со всеми [кластерами {{ k8s }}](../../concepts/index.md#kubernetes-cluster), на панели слева выберите ![image](../../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.k8s.switch_operations }}**. В открывшемся списке также отображаются операции для кластеров, которые были удалены.

  Можно получить список операций для конкретного кластера:

  1. В [консоли управления]({{ link-console-main }}) откройте каталог, в котором находится кластер.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Выберите нужный кластер.
  1. Перейдите на панель ![image](../../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.common.operations-key-value }}** для выбранного кластера.

     В открывшемся списке отображаются операции с выбранным кластером.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Чтобы получить список операций для кластера {{ managed-k8s-name }}, воспользуйтесь командой:

  ```bash
  yc managed-kubernetes cluster list-operations <имя_или_идентификатор_кластера>
  ```

  Результат:

  ```text
  +----------------------+---------------------+----------------------+---------------------+--------+----------------+
  |          ID          |     CREATED AT      |      CREATED BY      |     MODIFIED AT     | STATUS |  DESCRIPTION   |
  +----------------------+---------------------+----------------------+---------------------+--------+----------------+
  | cat5g6mqaccn******** | 2024-05-14 18:40:02 | aje9k8luj4qf******** | 2024-05-14 18:40:03 | DONE   | Update cluster |
  | cati1flsiarv******** | 2024-05-14 18:29:13 | aje9k8luj4qf******** | 2024-05-14 18:36:17 | DONE   | Create cluster |
  +----------------------+---------------------+----------------------+---------------------+--------+----------------+
  ```

  По умолчанию информация об операциях выводится в текстовом формате. Чтобы получить более подробную информацию, укажите формат `yaml` или `json` для выводимых данных с помощью параметра `--format`:

  ```bash
  yc managed-kubernetes cluster list-operations <имя_или_идентификатор_кластера> --format yaml
  ```

  Результат:

  ```text
  - id: cat5g6mqaccn********
    description: Update cluster
    created_at: "2024-05-14T18:40:02Z"
    created_by: aje9k8luj4qf********
    modified_at: "2024-05-14T18:40:03Z"
    done: true
    metadata:
      '@type': type.googleapis.com/yandex.cloud.k8s.v1.UpdateClusterMetadata
      cluster_id: cathr91hiupd********
    response:
      '@type': type.googleapis.com/yandex.cloud.k8s.v1.Cluster
      id: cathr91hiupd********
      folder_id: b1g681qpemb4********
      created_at: "2024-05-14T18:29:13Z"
      name: my-k8s-logs
      status: RUNNING
      health: HEALTHY
      network_id: enpphqi8uvcm********
      ...
      service_account_id: ajeevjv1lv01********
      node_service_account_id: ajeevjv1lv01********
      release_channel: REGULAR
  - id: cati1flsiarv********
    description: Create cluster
    created_at: "2024-05-14T18:29:13Z"
    created_by: aje9k8luj4qf********
    modified_at: "2024-05-14T18:36:17Z"
    done: true
    metadata:
      '@type': type.googleapis.com/yandex.cloud.k8s.v1.CreateClusterMetadata
      cluster_id: cathr91hiupd********
    response:
      '@type': type.googleapis.com/yandex.cloud.k8s.v1.Cluster
      id: cathr91hiupd********
      folder_id: b1g681qpemb4********
      created_at: "2024-05-14T18:29:13Z"
      name: my-k8s
      status: RUNNING
      health: HEALTHY
      network_id: enpphqi8uvcm********
      ...
      node_service_account_id: ajeevjv1lv01********
      release_channel: REGULAR
  ```

- API {#api}

  Воспользуйтесь методом REST API [listOperations](../../managed-kubernetes/api-ref/Cluster/listOperations.md) для ресурса [Cluster](../../managed-kubernetes/api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/ListOperations](../../managed-kubernetes/api-ref/grpc/Cluster/listOperations.md).

{% endlist %}

## Получить подробную информацию об операции {#get-operations-info}

1. [Получите список операций](#get-operations) для кластера {{ managed-k8s-name }}.
1. Скопируйте идентификатор нужной операции.
1. Получите подробную информацию об операции:

   {% list tabs group=instructions %}

   - CLI {#cli}

     {% include [cli-install](../../../_includes/cli-install.md) %}

     {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

     Выполните команду:

     ```bash
     yc operation get <идентификатор_операции>
     ```

     Результат:

     ```text
     id: cat5g6mqaccn********
     description: Update cluster
     created_at: "2024-05-14T18:40:02Z"
     created_by: aje9k8luj4qf********
     modified_at: "2024-05-14T18:40:03Z"
     done: true
     metadata:
       '@type': type.googleapis.com/yandex.cloud.k8s.v1.UpdateClusterMetadata
       cluster_id: cathr91hiupd********
     response:
       '@type': type.googleapis.com/yandex.cloud.k8s.v1.Cluster
       id: cathr91hiupd********
       folder_id: b1g681qpemb4********
       created_at: "2024-05-14T18:29:13Z"
       name: my-k8s-logs
       status: RUNNING
       health: HEALTHY
       network_id: enpphqi8uvcm********
       ...
       service_account_id: ajeevjv1lv01********
       node_service_account_id: ajeevjv1lv01********
       release_channel: REGULAR
     ```

   - API {#api}

     Воспользуйтесь вызовом gRPC API [OperationService/Get](../../managed-kubernetes/api-ref/grpc/Operation/get.md).

   {% endlist %}

#### См. также {#see-also}

* [{#T}](../../../api-design-guide/concepts/about-async.md)
